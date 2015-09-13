<%-- 
    Document   : notifiche
    Created on : 13-set-2015, 22.12.40
    Author     : alessandro
--%>

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
            String ricevute = "SELECT p.email_richiedente, l.titolo, l.nome_autore, "
                    + "l.cognome_autore, date_part('Year', p.data_richiesta), date_part('Month', p.data_richiesta), "
                    + "date_part('Day', p.data_richiesta), l.id "
                    + "FROM prestito p JOIN libro l ON (p.id_libro=l.id) "
                    + "WHERE p.stato ilike 'p' and "
                    + "p.email_proprietario = '" + session.getAttribute("userEmail") + "'";

            Connection conn = Connessione.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(ricevute);
            int col = 0;

        %>
        <form method="get" action="OperazioniPrestito">
            <table>
                <th>RICHIESTE DI PRESTITO RICEVUTE</th>
                    <%while (rs.next()) {%>
                <tr style="background-color: <%if (col % 2 == 0) {
                        out.print("background");
                    } else {
                        out.print("appwoekspase");
                    }%>">
                    <td>In data <%= rs.getInt(7)%>/<%= rs.getInt(6)%>/<%= rs.getInt(5)%>, l'utente <%= rs.getString(1)%> ha chiesto in prestito il libro <%= rs.getString(2)%> di <%= rs.getString(3)%> <%= rs.getString(4)%></td><td></td>
                    <td><button type="submit" name="delete" value="<%= rs.getString(1)%>/<%= rs.getString(8)%>/a">Accetta</button></td>
                    <td><button type="submit" name="delete" value="<%= rs.getString(1)%>/<%= rs.getString(8)%>/r">Rifiuta</button></td>
                </tr>
                <%col++;
                    }%>
            </table>
        </form>
        <% conn.close();
            String effettuate = "SELECT p.email_proprietario, l.titolo, l.nome_autore, "
                    + "l.cognome_autore, date_part('Year', p.data_richiesta), date_part('Month', p.data_richiesta), "
                    + "date_part('Day', p.data_richiesta), p.stato "
                    + "FROM prestito p JOIN libro l ON (p.id_libro=l.id) "
                    + "WHERE p.email_richiedente = '" + session.getAttribute("userEmail") + "'";

            conn = Connessione.getConnection();
            Statement stmt1 = conn.createStatement();
            ResultSet rs1 = stmt1.executeQuery(effettuate);
            String accettato = "&egrave stata accettata";
            String rifiutato = "&egrave stata rifiutata";
            String pendente = "non ha ancora ricevuto una risposta";
        %>
        <table>
            <th>RICHIESTE DI PRESTITO EFFETTUATE</th>
                <%while (rs1.next()) {%>
            <tr style="background-color:  <%
                    switch (rs1.getString(8).charAt(0)) {
                        case 'P':
                        case 'p':
                            out.print("orange");
                            break;
                        case 'A':
                        case 'a':
                            out.print("greenyellow");
                            break;
                        case 'R':
                        case 'r':
                            out.print("coral");
                            break;
                    }
                %>">
                <td>Il prestito del libro <%= rs1.getString(2)%> di <%= rs1.getString(3)%> <%= rs1.getString(4)%> richiesto a <%= rs1.getString(1)%> il <%= rs1.getInt(7)%>/<%= rs1.getInt(6)%>/<%= rs1.getInt(5)%> <%
                    switch (rs1.getString(8).charAt(0)) {
                        case 'P':
                        case 'p':
                            out.print(pendente);
                            break;
                        case 'A':
                        case 'a':
                            out.print(accettato);
                            break;
                        case 'R':
                        case 'r':
                            out.print(rifiutato);
                            break;
                    }%></td>
            </tr>
            <%}%>
        </table>
        <a href="main.jsp">Vai al main</a>
    </body>
</html>
