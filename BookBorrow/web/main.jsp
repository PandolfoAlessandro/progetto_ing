<%-- 
    Document   : main
    Created on : 5-set-2015, 18.42.08
    Author     : insan3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Main Page</title>
    </head>
    <body>
        <h1>Ciao <%out.print((String)session.getAttribute("userEmail"));%>! Sei nella mainpage di bookborrow!</h1> 
        
        <table>
            <tr>
                <td>
                    <button onclick="window.location = 'manageBooks.jsp'">Modifica libro</button>
                </td>
            </tr>
            <tr>
                <td>
                    <button onclick="window.location = 'logout.jsp'">Logout</button>
                </td>
            </tr>
        </table>




    </body>
</html>