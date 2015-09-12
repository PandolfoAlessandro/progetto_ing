<%-- 
    Document   : profile
    Created on : 12-set-2015, 11.11.26
    Author     : insan3
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.database.Connessione"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="META-INF/stile.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
        String utentePagina="SELECT * FROM book_user WHERE email='"+request.getParameter("email")+"'";
        Connection con=Connessione.getConnection();
        Statement stmt=con.createStatement();
        ResultSet rs=stmt.executeQuery(utentePagina);
        if(rs.next()){
        %>
        <div id="fotoProfilo">
        
            <p>foto profilo</p>
            
        </div>
        
        <div id="infoProfilo">
        
            <p>info profilo</p>
            
        </div>
        
        <%}
        con.close();%>
    </body>
</html>
