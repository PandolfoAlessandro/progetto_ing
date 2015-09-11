<%-- 
    Document   : manageBookAdmin
    Created on : 9-set-2015, 14.08.05
    Author     : alessandro
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
        <%  String bookList = "SELECT l.id, l.titolo, l.nome_autore, l.cognome_autore, l.casa_ed, b.nome,"
                + " b.cognome, b.email FROM libro l JOIN book_user b ON (l.proprietario=b.email);";

            Connection con = new Connessione().getConnection();

            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();

            ResultSet rs;
            // Verifico che le credenziali inserite siano di un utente "normale"
            rs = stmt.executeQuery(bookList);
        %>    

        <a href="admin.jsp">Indietro</a>
        <% session.setAttribute("Operazione", "gestisci"); %>
        <form method="POST" action="OperazioniAdmin"  >
            <TABLE BORDER="1">
                <TR>
                    <TH>Titolo</TH>
                    <TH>Autore</TH>
                    <TH>Casa Editrice</TH>
                    <TH>Proprietario</TH>            
                </TR>
                <% while (rs.next()) {%>

                <TR>

                    <TD> <%= rs.getString(2)%> </TD>
                    <TD> <%= rs.getString(3)%> <%= rs.getString(4)%> </TD>
                    <TD> <%= rs.getString(5)%> </TD>
                    <TD> <%= rs.getString(6)%> <%= rs.getString(7)%> (<%= rs.getString(8)%>)</TD>
                    <TD>
                    <button type="submit" onclick="return confirm('sicuro di voler eliminare il libro?');" name="manage" value="elimina/<%= rs.getString(1)%>">Elimina Libro</button>
                    <button type="submit" name="manage" value="gestisci/<%= rs.getString(1)%>">Modifica dati libro</button>
                    </TD>
                </TR>

                <% }%>
            </TABLE>
        </form>
    </body>
</html>
