<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="it.database.Connessione"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Lista utenti</title>
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
                    if (!((boolean) session.getAttribute("isAdmin"))) {
                        response.sendRedirect("main.jsp");
                    }
                }

            
        %>
        <%
            String selectUsers = "SELECT DISTINCT b.email, b.nome, b.cognome, i.citta, i.provincia "
                    + "FROM book_user b join residenza r ON (b.email=r.utente) JOIN indirizzo i ON (r.coordinate_geografiche = i.coordinate_geografiche)";

            Connection con = Connessione.getConnection();

            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();

            ResultSet rs;
            // Verifico che le credenziali inserite siano di un utente "normale"
            rs = stmt.executeQuery(selectUsers);

        %>    

        <a href="admin.jsp">Indietro</a>
        <% session.setAttribute("Operazione", "elimina"); %>
        <form name="mio_form" method="POST" action="OperazioniAdmin" onsubmit="return confirm('sicuro di voler rimuovere l\'utente?');">
            <TABLE BORDER="1">
                <TR>
                    <TH>Email</TH>
                    <TH>Nome</TH>
                    <TH>Cognome</TH>
                    <TH>Citt&agrave;</TH>
                    <TH>Provincia</TH>
                </TR>
                <% while (rs.next()) {%>
                <TR>
                    <TD> <%= rs.getString(1)%></TD>
                    <TD> <%= rs.getString(2)%></TD>
                    <TD> <%= rs.getString(3)%></TD>
                    <TD> <%= rs.getString(4)%></TD>
                    <TD> <%= rs.getString(5)%></TD>
                    <TD><button type="submit" name="delete" value="<%= rs.getString(1)%>">Elimina utente</button></TD>
                </TR>

                <% }%>
            </TABLE>
        </form>
        <%con.close();%>
    </body>
</html>
