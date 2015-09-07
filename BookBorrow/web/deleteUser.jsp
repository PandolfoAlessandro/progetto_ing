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
            String selectUsers = "SELECT DISTINCT email, nome, cognome, citta, provincia "
                    + "FROM book_user join residenza ON (email=utente) JOIN indirizzo ON (coordinate_geografiche = coordinate_geografiche)";

            Connection con = new Connessione().getConnection();

            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();

            ResultSet rs;
            // Verifico che le credenziali inserite siano di un utente "normale"
            rs = stmt.executeQuery(selectUsers);
        %>
        
    </body>
</html>
