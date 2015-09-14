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
        <% session.setAttribute("Operazione", "disiscrizione"); %>
        <form method="POST" action="OperazioniUser">
            <table>
                <tr>
                    <td>
                        <button type="Submit" name="confermaDisiscrizione" value="si">SI</button>
                    </td>
                </tr>
                <tr>
                    <td>
                        <button type="Submit" name="confermaDisiscrizione" value="no">NO</button>
                    </td>       
                </tr>
            </table>
        </form>
    </body>
</html>
