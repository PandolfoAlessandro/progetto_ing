<%-- 
    Document   : serchBook
    Created on : 13-set-2015, 16.38.11
    Author     : alessandro
--%>

<%@page import="it.functions.Geolocalizzazione"%>
<%@page import="java.util.ArrayList"%>
<%@page import="it.database.Connessione"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // Set to expire far in the past.
            response.setHeader("Expires", "Sat, 6 May 1971 12:00:00 GMT");
            // Set standard HTTP/1.1 no-cache headers.
            response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
            // Set IE extended HTTP/1.1 no-cache headers (use addHeader).
            response.addHeader("Cache-Control", "post-check=0, pre-check=0");
            // Set standard HTTP/1.0 no-cache header.
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
        %>
        <%
            if (session.getAttribute("userEmail") == null) {
                response.sendRedirect("index.jsp");
            } else {
                if ((boolean) session.getAttribute("isAdmin")) {
                    response.sendRedirect("admin.jsp");
                }
            }

        %>
        <script type="text/javascript">
            function CercaLibro() {
                window.location.replace("searchBook.jsp?lS=" + document.getElementById("libroSel").value+"&lg="+ document.getElementById("genereSel").value);
            }
        </script>
        <div style="background-color: burlywood">
            <table>
                <tr>
                    <td>Inserisci titolo oppure nome o cognome dell'autore:</td>
                    <td><input type="text" id="libroSel" value="" ></td>
                    <td> </td>
                    <td> </td>
                    <td>Ricerca per Genere:</td>
                    <td><select id="genereSel">
                                    <option value=""> 
                                    Tutti i generi
                                    </option>
                                    <%
                                        String generi = "SELECT DISTINCT genere FROM libro Where disponibilita=1 ";
                                        Connection conGen = Connessione.getConnection();
                                        Statement stmtGen = conGen.createStatement();
                                        ResultSet rsGen = stmtGen.executeQuery(generi);

                                        while (rsGen.next()) {
                                        
                                    %>    

                                    <option value="<%= rsGen.getString(1)%> "> 
                                        <%out.print( rsGen.getString(1));%> 
                                    </option>                    
                                    <%}
                                        conGen.close();
                                    %>
                                </select></td>
                    <td><button onclick="CercaLibro()">Cerca</button></td>
                </tr>
            </table>
        </div>
        <%  session.setAttribute("trovato", false);
            String cord = null;
            String provincia = null;
            String qCord = "SELECT coordinate_geografiche, provincia FROM indirizzo "
                    + "WHERE BOOK_USER='" + session.getAttribute("userEmail") + "' "
                    + "and Principale=1 ";

            Connection con = Connessione.getConnection();

            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt1 = con.createStatement();

            ResultSet rs1;
            rs1 = stmt1.executeQuery(qCord);

            if (rs1.next()) {
                cord = rs1.getString(1);
                provincia = rs1.getString(2);
            }
            con.close();
            Connection con1 = Connessione.getConnection();

            String listaLibri = "SELECT 1, l.id, l.titolo, l.nome_autore, l.cognome_autore, "
                    + "l.casa_ed, l.n_pagine, l.anno_pubblicazione, l.genere, "
                    + "i.coordinate_geografiche, i.citta, i.provincia, i.paese, i.principale, l.Book_User "
                    + "FROM Indirizzo i JOIN libro l "
                    + "on (i.coordinate_geografiche=l.coordinate_geografiche and i.Book_User=l.Book_User) "
                    + "WHERE l.disponibilita=1 and "
                    + "l.Book_User != '" + session.getAttribute("userEmail") + "' ";

            if (request.getParameter("lS") != null && !(request.getParameter("lS").equals(""))) {
                listaLibri += " and (l.titolo ilike '%" + request.getParameter("lS") + "%' or "
                        + "l.nome_autore ilike '%" + request.getParameter("lS") + "%' or "
                        + "l.cognome_autore ilike '%" + request.getParameter("lS") + "%') ";
                if (request.getParameter("lg") != null && !(request.getParameter("lg").equals(""))) {
                    listaLibri += " and l.genere ilike '" + request.getParameter("lg") + "' ";
                }
            } else {
                if (request.getParameter("lg") != null && !(request.getParameter("lg").equals(""))) {
                    listaLibri += " and l.genere ilike '" + request.getParameter("lg") + "' ";
                } else {
                    listaLibri += "and i.provincia ilike '" + provincia + "' ";
                }
            }

            Statement stmt = con1.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ResultSet rslu = stmt.executeQuery(listaLibri);
            int size = 0;
            while (rslu.next()) {
                size++;
            }

            ArrayList<Object[]> listaUtenti = new ArrayList<Object[]>();
            Object[] utenteCorrente;
            Object[][] distanze = null;
            rslu.beforeFirst();
            distanze = new Object[2][size];
            int i = 0;
            while (rslu.next()) {
                session.setAttribute("trovato", true);
                utenteCorrente = new Object[13];
                utenteCorrente[0] = rslu.getString(3);
                utenteCorrente[1] = rslu.getString(4);
                utenteCorrente[2] = rslu.getString(5);
                utenteCorrente[3] = rslu.getString(6);
                utenteCorrente[4] = rslu.getInt(7);
                utenteCorrente[5] = rslu.getInt(8);
                utenteCorrente[6] = rslu.getString(9);
                utenteCorrente[7] = rslu.getString(11);
                utenteCorrente[8] = rslu.getString(12);
                utenteCorrente[9] = rslu.getString(13);
                utenteCorrente[10] = rslu.getInt(14);
                utenteCorrente[11] = rslu.getString(2);
                utenteCorrente[12] = rslu.getString(15);
                listaUtenti.add(utenteCorrente);
                distanze[0][i] = (int) i;
                distanze[1][i] = Geolocalizzazione.getDistance(cord, rslu.getString(10));
                i++;
            }

            if (distanze instanceof Object[][]) {
                if (distanze[0].length > 1) {
                    for (int j = 0; j < distanze[0].length; j++) {
                        boolean flag = false;
                        for (int k = 0; k < distanze[0].length - 1; k++) {
                            if (Double.compare((Double) distanze[1][k], (Double) distanze[1][k + 1]) > 0) {
                                Double temp1 = (Double) distanze[1][k];
                                int temp2 = (int) distanze[0][k];
                                distanze[0][k] = distanze[0][k + 1];
                                distanze[1][k] = distanze[1][k + 1];
                                distanze[0][k + 1] = temp2;
                                distanze[1][k + 1] = temp1;
                                flag = true;
                            }
                            if (!flag) {
                                break;
                            }
                        }
                    }
                }
        %>
        <% session.setAttribute("ritornoPres", "searchBook.jsp");
          if ((Boolean) session.getAttribute("trovato")) {%>
        <div id="infoLibri">
            <form method="POST" action="OperazioniPrestito" onsubmit="window.alert('Richiesta effettata! Controlla le tue notifiche')">
                <center>
                    <table border="1" width="30%" cellpadding="5">
                        <tbody>
                            <tr>
                                <th>Copertina:</th>
                                <th>Titolo:</th>
                                <th>Autore:</th>
                                <th>Casa editrice:</th>
                                <th>Numero di pagine:</th> 
                                <th>Anno di pubblicazione:</th>
                                <th>Genere:</th>
                                <th>Indirizzo:</th>
                                <th>Distanza:</th>
                            </tr>
                            <% int p;
                                for (int pos = 0; pos < distanze[0].length; pos++) {
                                    p = (int) distanze[0][pos];
                            %>
                            <tr>

                                <td><img src="PrintImage?id_img=<%= listaUtenti.get(p)[11]%>&amp;what=libro" 
                                         width="50" height="50"
                                         alt="Immagine non Disponibile"/>

                                <td> <p><%= listaUtenti.get(p)[0]%> </p></td>

                                <td> <p><%= listaUtenti.get(p)[1]%>,<%= listaUtenti.get(p)[2]%> </p></td>    

                                <td> <p><%= listaUtenti.get(p)[3]%> </p></td>

                                <td> <p><%= listaUtenti.get(p)[4]%> </p></td>

                                <td> <p><%= listaUtenti.get(p)[5]%> </p></td>

                                <td> <p><%= listaUtenti.get(p)[6]%> </p></td>

                                <td> <p><%= listaUtenti.get(p)[7]%>(<%= listaUtenti.get(p)[8]%>),<%= listaUtenti.get(p)[9]%> </p><p
                                        ><%if ((int) listaUtenti.get(p)[10] == 1) {%><p>[Residenza]</p><%}%></td>

                                <td> <p> <%= distanze[1][pos]%> Km </p></td>

                                <td><button type="submit" name="prestito" value="<%= listaUtenti.get(p)[12]%>/<%= session.getAttribute("userEmail")%>/<%= listaUtenti.get(p)[11]%>">Borrow me!</button></td>
                            </tr>

                            <%}%>

                        </tbody>
                    </table>
                </center>
            </form>
            <%} %>
            
        </div>    

        <%}%>
        <%con.close();%>

        <a href="main.jsp">Vai al main</a>
    </body>
</html>

