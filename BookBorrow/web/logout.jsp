<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%
            session.removeAttribute("userEmail");
            session.removeAttribute("isAdmin");
            response.sendRedirect("index.jsp");
        %>
    </body>
</html>
