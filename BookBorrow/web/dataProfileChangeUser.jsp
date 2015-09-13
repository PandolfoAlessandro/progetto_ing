<%-- 
    Document   : dataProfileChangeUser
    Created on : 11-set-2015, 14.16.59
    Author     : insan3
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Statement"%>
<%@page import="it.database.Connessione"%>
<%@page import="java.sql.Connection"%>
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
                if ((boolean) session.getAttribute("isAdmin")) {
                    response.sendRedirect("admin.jsp");
                }
            }

        %>
        

        <%
            String datiLibro = "SELECT nome,cognome,sesso,data_nascita,foto_profilo "
                    + "FROM book_user "
                    + "WHERE email='" + (String)(session.getAttribute("userEmail"))+"'";

            Connection con = Connessione.getConnection();

            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();

            ResultSet rs;
            // Verifico che le credenziali inserite siano di un utente "normale"
            rs = stmt.executeQuery(datiLibro);
            if (rs.next()) {

        %>
        <% session.setAttribute("Operazione", "modificaUser"); %>
        <form method="POST" action="OperazioniUser" onsubmit="return confirm('sicuro di voler modificare i dati del profilo?' );">
            <center>
                <table border="1" width="30%" cellpadding="5">
                    <thead>
                        <tr>
                            <th colspan="2">
                    <p>Dati utente(email: <% out.print((String)(session.getAttribute("userEmail")));%>)</p>
                    </th>
                    </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="2"><p style="color: red">Nella modifica dei dati rispettare rigorosamente i formati indicati</p></td>
                        </tr>
                        <tr>
                            <td>Nome:</td>
                            <td><input type="text" name="nome" value="<%= rs.getString(1)%>" ></td>
                        </tr>
                        <tr>
                            <td>Cognome:</td>
                            <td><input type="text" name="cognome" value="<%= rs.getString(2)%>" ></td>
                        </tr>
                        <tr>
                            <td>Sesso:</td>
                            <td>
                                <fieldset>
                                    Maschio <input type="radio" <%=(rs.getString(3).equals("m"))?"checked = \"checked\"":""%> name="sesso" value="m" > 
                                    Femmina <input type="radio" <%=(rs.getString(3).equals("f"))?"checked = \"checked\"":""%> name="sesso" value="f" >
                                </fieldset>
                            </td>
                        </tr>
                        <tr>
                            <td>data di nascita (GG/MM/AAAA)</td>
                            <td><input type="text" name="data_nascita" value="<%=rs.getDate(4).toString().split("-")[2]+"/"+rs.getDate(4).toString().split("-")[1]+"/"+rs.getDate(4).toString().split("-")[0] %>" ></td>
                        </tr>
                        <tr>
                            <td>Foto profilo:</td>
                            <td><img src="PrintImage?id_img=<%=session.getAttribute("userEmail")%>&amp;what=utente" 
                                     width="200" height="200"
                                     alt="Immagine non Disponibile"/>
                            </td>
                            <td>
                                <button type="button" name="changeImg" onclick="openPopUp()">Modifica immagine</button>
                            </td>
                        </tr>
                        <tr>
                            <td><input type="Submit" value="Conferma" ></td>
                        </tr>
                    </tbody>
                </table>
            </center>
        </form>
        
        
        <%}else{%>
        <p>Errore caricamento dati</p>
        <%}%>
        <a href="main.jsp">Main page</a>
        
    </body>
</html>
