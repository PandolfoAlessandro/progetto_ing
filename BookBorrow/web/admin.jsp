
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMIN LOGIN</title>
    </head>
    <body>
        Benvenuto nella pagina di amministrazione di Book Borrow
        <% session.setAttribute("Operazione", "null"); %>
        <div>
            
         <table>
                <tr>					
                    <td> 
                        <a href="deleteUser.jsp" >Elimina Utenti</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="manageBookAdmin.jsp" >Gestisci Libri</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="statistiche.jsp" >Visualizza Statistiche</a>
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="logout.jsp" >Logout</a>
                    </td>
                </tr>
            </table>

        </div>
    </body>
</html>
