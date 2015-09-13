<%-- 
    Document   : dataBookChangeUser
    Created on : 11-set-2015, 12.50.25
    Author     : insan3
--%>
<%@page import="java.sql.*"%>
<%@page import="it.database.Connessione"%>
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
      
        <script type="text/javascript">
            function openPopUp()
            {
                window.open("changeImg.jsp?libro_sel=<%= request.getParameter("id_l")%>", "Cambia coperina", "scrollbars=1,resizable=0,height=200,width=550,left=450,top=200");
            }
        </script>
        
        <%
            String datiLibro = "SELECT anno_pubblicazione, n_pagine, "
                    + "nome_autore, cognome_autore, genere, casa_ed, titolo, disponibilita "
                    + "FROM libro l "
                    + "WHERE l.id='" + request.getParameter("id_l") 
                    + "' AND l.book_user='"+(String)(session.getAttribute("userEmail"))+"'";

            Connection con = Connessione.getConnection();

            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();

            ResultSet rs;
            // Verifico che le credenziali inserite siano di un utente "normale"
            rs = stmt.executeQuery(datiLibro);
            if (rs.next()) {

        %>
        <% session.setAttribute("Operazione", "gestisciLibro"); %>
        <% session.setAttribute("id_lib", request.getParameter("id_l")); %>
        <form method="POST" action="OperazioniUser" onsubmit="return confirm('sicuro di voler modificare i dati del libro?');">
            <center>
                <table border="1" width="30%" cellpadding="5">
                    <thead>
                        <tr>
                            <th colspan="2">
                    <p>Dati libro(id libro: <% out.print(request.getParameter("id_l"));%>)</p>
                    </th>
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="2"><p style="color: red">Nella modifica dei dati rispettare rigorosamente i formati indicati</p></td>
                        </tr>
                        <tr>
                            <td>Titolo:</td>
                            <td><input type="text" name="libroTitolo" value="<%= rs.getString(7)%>" ></td>
                        </tr>
                        <tr>
                            <td>Autore:
                                (Cognome,Nome)</td>
                            <td><input type="text" name="libroAutore" value="<%= rs.getString(4)%>,<%= rs.getString(3)%>" ></td>
                        </tr>
                        <tr>
                            <td>Casa Editrice</td>
                            <td><input type="text" name="casaEd" value="<%= rs.getString(6)%>" ></td>
                        </tr>
                        <tr>
                            <td>Numero di pagine</td>
                            <td><input type="text" name="nPag" value="<%= rs.getString(2)%>" ></td>
                        </tr>
                        <tr>
                            <td>Anno di pubblicazione:</td>
                            <td><input type="text" name="annoPub" value="<%= rs.getString(1)%>" ></td>
                        </tr>
                        <tr>
                            <td>Genere:</td>
                            <td><input type="text" name="gen" value="<%= rs.getString(5)%>" ></td>
                        </tr>
                        <tr>
                            <td>Disponibilita:</td>
                            <td><input type="text" name="disp" value="<%= rs.getString(8)%>" ></td>
                        </tr>
                        <tr>
                            <td>Copertina:</td>
                            <td><img src="PrintImage?id_img=<% out.print(request.getParameter("id_l"));%>&amp;what=libro" 
                                     width="200" height="200"
                                     alt="Immagine non Disponibile"/></td>
                            <td>
                                <button type="button" name="changeImg" onclick="openPopUp()">Modifica immagine</button>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="Submit" value="Conferma" ></td>
                        </tr>
                    </tbody>
                </table>
            </center>
        </form>
        <%} else { %>
        <p>Errore caricamento dati</p>
        <%}%>
        <a href="main.jsp">Indietro</a>
    </body>
</html>