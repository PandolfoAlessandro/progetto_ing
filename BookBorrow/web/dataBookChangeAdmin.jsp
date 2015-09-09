<%-- 
    Document   : dataBookChangeAdmin
    Created on : 9-set-2015, 16.58.37
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
        <form method="GET" action="LoginAndRegistration">
            <center>
                <table border="1" width="30%" cellpadding="5">
                    <thead>
                        <tr>
                            <th colspan="2">Inserisci le informazioni per iscriverti</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Email:</td>
                            <td><input type="text" name="userEmail" value="" ></td>
                        </tr>
                        <tr>
                            <td>Password:</td>
                            <td><input type="password" name="userPwd" value="" ></td>
                        </tr>
                        <tr>
                            <td>Nome</td>
                            <td><input type="text" name="userName" value="" ></td>
                        </tr>
                        <tr>
                            <td>Cognome</td>
                            <td><input type="text" name="userSurname" value="" ></td>
                        </tr>
                        <tr>
                            <td>Sesso:</td>
                            <td>
                                <fieldset>
                                    Maschio <input type="radio" name="sesso" value="m" > 
                                    Femmina <input type="radio" name="sesso" value="f" >
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>Data di nascita (GG/MM/AAAA)</td>
                            <td><input type="date" name="userBirthDate" value="" ></td>
                        </tr>
                        <tr>
                        <tr>
                            <td>Via: </td>
                            <td><input type="text" name="userVia" value="" ></td>
                            <td>Numero civico: </td>
                            <td><input type="text" name="userNumCiv" value="" ></td>
                        </tr>
                        <tr>
                            <td>CAP: </td>
                            <td><input type="text" name="userCAP" value="" ></td>
                        </tr>	
                        <tr>
                            <td>Citt&agrave</td>
                            <td><input type="text" name="userCity" value="" ></td>
                        </tr>	
                        <tr>
                            <td>Provincia: </td>
                            <td><input type="text" name="userProv" value="" ></td>
                        </tr>
                        <tr>
                            <td>Paese: </td>
                            <td><input type="text" name="userState" value="" ></td>
                        </tr>		
                        <tr>
                            <td><input type="Submit" value="Conferma" ></td>
                        </tr>
                    </tbody>
                </table>
            </center>
        </form>

        <a href="Admin.jsp">Indietro</a>
    </body>
</html>
