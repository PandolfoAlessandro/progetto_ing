<%-- 
    Document   : errorRegistration
    Created on : 6-set-2015, 16.24.18
    Author     : Leo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pagina di errore in fase di registrazione</title>
    </head>
    <body>
        <%
            if (exception != null) {

                PrintWriter writer = new PrintWriter(out);

                exception.printStackTrace(writer);
            }

        %>
    </body>
</html>