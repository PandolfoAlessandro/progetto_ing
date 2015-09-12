<%-- 
    Document   : main
    Created on : 5-set-2015, 18.42.08
    Author     : insan3
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
        <title>Main Page</title>
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
        <h1>Ciao <%out.print((String) session.getAttribute("userEmail"));%>! Sei nella mainpage di bookborrow!</h1> 

        <div style="background-color: aquamarine">
            <table>
                <tr>
                    <td>
                        <button onclick="window.location = 'dataProfileChangeUser.jsp'">Modifica profilo</button>
                    </td>
                    <td>
                        <button onclick="window.location = 'manageBooks.jsp'">Gestisci libri</button>
                    </td>
                    <td>
                        <button onclick="window.location = 'logout.jsp'">Logout</button>
                    </td>
                </tr>
            </table>
        </div>

        <div style="background-color: burlywood">
            <table>
                <tr>
                    <td>Inserisci nome, cognome o mail dell'utente:</td>
                    <td><input type="text" name=utenteSel value="" ></td>
                    <td><button onclick="">Cerca</button></td>
                </tr>
            </table>
        </div>
        <%
            String cord = null;
            String qCord = "SELECT coordinate_geografiche FROM indirizzo "
                    + "WHERE BOOK_USER='" + session.getAttribute("userEmail") + "' "
                    + "and Principale=1 ";

            Connection con = Connessione.getConnection();

            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt1 = con.createStatement();

            ResultSet rs1;
            rs1 = stmt1.executeQuery(qCord);

            if (rs1.next()) {
                cord = rs1.getString(1);
            }

            String selectUsers = "SELECT count(*), u.email, u.nome, u.cognome, date_part('Year', u.data_nascita),i.coordinate_geografiche, i.citta, i.provincia, "
                    + "count(distinct l.id), count(distinct l.coordinate_geografiche) "
                    + "FROM Book_User u JOIN Indirizzo i on (u.email=i.Book_User) "
                    + "JOIN libro l "
                    + "on (i.coordinate_geografiche=l.coordinate_geografiche and i.Book_User=l.Book_User) "
                    + "Where u.tipologia = 1 "
                    + "group by u.email, i.provincia, i.citta,i.coordinate_geografiche";

            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();

            ResultSet rs;

            // Verifico che le credenziali inserite siano di un utente "normale"
            rs = stmt.executeQuery(selectUsers);

            ArrayList<Object[]> listaUtenti = new ArrayList<Object[]>();
            Object[] utenteCorrente;
            Object[][] distanze = null;
            if (rs.next()) {
                distanze = new Object[2][rs.getInt(1)];
                int i = 0;
                do {
                    utenteCorrente = new Object[8];
                    utenteCorrente[0] = rs.getString(2);
                    utenteCorrente[1] = rs.getString(3);
                    utenteCorrente[2] = rs.getString(4);
                    utenteCorrente[3] = rs.getInt(5);
                    utenteCorrente[4] = rs.getString(7);
                    utenteCorrente[5] = rs.getString(8);
                    utenteCorrente[6] = rs.getInt(9);
                    utenteCorrente[7] = rs.getInt(10);
                    listaUtenti.add(utenteCorrente);
                    distanze[0][i] = i;
                    distanze[1][i] = Geolocalizzazione.getDistance(cord, rs.getString(6));
                } while (rs.next());
            } else {
                throw new Exception();
            }
            for (int j = 0; j < distanze[0].length; j++) {
                boolean flag = false;
                for (int k = 0; k < distanze[0].length - 1; k++) {
                    if (Double.compare((Double) distanze[1][j], (Double) distanze[1][j + 1]) > 0) {
                        Double temp1 = (Double) distanze[1][j];
                        int temp2 = (int) distanze[0][j];
                        distanze[0][j] = distanze[0][j + 1];
                        distanze[1][j] = distanze[1][j + 1];
                        distanze[0][j + 1] = temp2;
                        distanze[1][j + 1] = temp1;
                        flag = true;
                    }
                    if (!flag) {
                        break;
                    }
                }
            }


        %>    


        <TABLE BORDER="1" style="border-color: orangered">
            <TR>
                <TH>Foto Profilo</TH>
                <TH>Dettaglio</TH>
                <TH>Distanza</TH>
            </TR>
            <% for (int pos = 0; pos < distanze[0].length; pos++) {%>
            <TR>
                <TD> non adesso</TD>
                <TD> 
                    <table>
                        <tr>
                            <td>
                                <%= listaUtenti.get((int) distanze[0][pos])[1]%> <%= listaUtenti.get((int) distanze[0][pos])[2]%> (<%= listaUtenti.get((int) distanze[0][pos])[3]%>)
                            </td>       
                        </tr>
                        <tr>
                            <td><%= listaUtenti.get((int) distanze[0][pos])[0]%></td>
                        </tr>
                        <tr>
                            <td><%= listaUtenti.get((int) distanze[0][pos])[4]%>(<%= listaUtenti.get((int) distanze[0][pos])[5]%>)</td>
                        </tr>
                        <tr>
                            <td>Libri nel sistema:<%= listaUtenti.get((int) distanze[0][pos])[6]%><%
                                int ind = (int) listaUtenti.get((int) distanze[0][pos])[7];
                                if (ind - 1 > 0) {
                                %>(Alcuni libri non sono all'indirizzo di residenza)<%}%>
                            </td>
                        </tr>
                    </table> 
                </TD>
            </TR>
            <TR>
                <TD> <%= distanze[1][pos]%></TD>
            </TR>
            <% }%>
        </TABLE>
        <%con.close();%>



    </body>
</html>