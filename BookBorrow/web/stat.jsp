<%-- 
    Document   : stat
    Created on : 13-set-2015, 23.49.42
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
        <%
                if (session.getAttribute("userEmail") == null) {
                    response.sendRedirect("index.jsp");
                } else {
                    if (!((boolean) session.getAttribute("isAdmin"))) {
                        response.sendRedirect("main.jsp");
                    }
                }

            
        %>
        <%
            String numUtenti = "SELECT count(*) FROM book_user";
            String numLibri = "SELECT count(*) FROM libro";
            String numPrestAcc = "SELECT count(*) FROM prestito WHERE stato='a'";
            String numMaschi = "SELECT count(*) FROM book_user WHERE sesso='m'";

            int numUt = 0;
            int maschi = 0;

            Connection con = Connessione.getConnection();
            Statement stmt = con.createStatement();


        %>


        <form>
            <center>
                <table border="1" width="30%" cellpadding="5">
                    <thead>
                        <tr>
                            <th colspan="2">
                    <p>Statistiche globali di utilizzo:</p>
                    </th>
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <%
                                ResultSet rs1 = stmt.executeQuery(numUtenti);
                                if (rs1.next()) {
                                    numUt = Integer.parseInt(rs1.getString(1));
                                }
                            %>
                            <td>Numero utenti iscritti:</td>
                            <td><%=numUt%></td>
                        </tr>
                        <tr>
                            <%
                                ResultSet rs2 = stmt.executeQuery(numLibri);
                                if (rs2.next()) {
                            %>
                            <td>Numero libri inseriti:</td>
                            <td><%=rs2.getString(1)%></td>
                            <%}%>
                        </tr>
                        <tr>
                            <%
                                ResultSet rs3 = stmt.executeQuery(numPrestAcc);
                                if (rs3.next()) {
                            %>

                            <td>Numero di prestiti accettati:</td>
                            <td><%=rs3.getString(1)%></td>
                            <%}%>
                        </tr>
                        <tr>
                            <%
                                ResultSet rs4 = stmt.executeQuery(numMaschi);
                                if (rs4.next()) {
                                    maschi = Integer.parseInt(rs4.getString(1));
                                }
                            %>
                            <td>Percentuale utenti di sesso maschile:</td>
                            <td><%=(int) (maschi / numUt * 100)%>% </td>

                        </tr>
                        <tr>
                            <td>Percentuale utenti di sesso femminile:</td>
                            <td><%=(int) ((numUt - maschi) / numUt * 100)%>% </td>
                        </tr>
                    </tbody>
                </table>
            </center>
        </form>
        <%con.close();%>
        <a href="admin.jsp">indietro</a>                
    </body>
</html>
