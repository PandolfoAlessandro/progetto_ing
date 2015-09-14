<%-- 
    Document   : disiscrizione
    Created on : 14-set-2015, 23.58.58
    Author     : insan3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form method="POST" action="OperazioniUser" onsubmit="return confirm('sicuro di voler modificare i dati del libro?');">
            <table>
                <tr>
                    <td>
                        <button type="Submit" value="Conferma">SI</button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <button onclick="window.location = 'main.jsp'">NO</button>
                    </td>       
                </tr>
            </table>
        </form>
    </body>
</html>
