
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration</title>
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
                            <td colspan="2"><b>Dati utente</b></td>
                        </tr>
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
                            <td colspan="2"><b>Dati indirizzo</b></td>
                        </tr>
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
                            <td><input type="Submit" value="Registrati!" ></td>
                        </tr>
                    </tbody>
                </table>
            </center>
        </form>

        <a href="index.jsp">Torna alla pagina di login!</a>
    </body>
</html>