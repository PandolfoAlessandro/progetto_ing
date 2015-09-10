<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="it.database.Conferma" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMIN LOGIN</title>
    </head>
    <body>
        <jsp:useBean id="confermeAdmin" class="Conferma" scope="session"/>
        Benvenuto nella pagina di amministrazione di Book Borrow
        <% session.setAttribute("Operazione", "null"); %>
        <div>
            
         <table>
                <tr>					
                    <td> 
                        <button onclick="window.location='deleteUser.jsp'">Elimina utente</button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <button onclick="window.location='manageBookAdmin.jsp'">Gestisci Libri</button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <p>Visualizza statistiche globali<button onclick="window.location='stat.jsp'">qui</button>
                        </p>
                    </td>
                </tr>
                <tr>
                    <td>
                        <button onclick="window.location='logout.jsp'">Logout</button>
                    </td>
                </tr>
            </table>

        </div>
    </body>
</html>
