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
        <link href="Resources/css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            String utentePagina = "SELECT * FROM book_user WHERE email='" + request.getParameter("emailSel") + "'";
            String libriUtentePagina = "SELECT * from libro WHERE disponibilita=1 AND book_user='" + request.getParameter("emailSel") + "'";
            Connection con = Connessione.getConnection();
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery(utentePagina);

            ResultSet lib = stmt.executeQuery(libriUtentePagina);

            if (rs.next()) {
        %>
        <div id="fotoProfilo">
            <img src="PrintImage?id_img=<%=request.getParameter("emailSel")%>&amp;what=utente" 
                 width="200" height="200" 
                 alt="Immagine non Disponibile"/>


        </div>

        <div id="infoProfilo">

            <h1><%= rs.getString("nome")%> <%= rs.getString("cognome")%></h1>
            <p>email: <%= rs.getString("email")%></p>

        </div>

        <div id="infoLibri">
            <form method="POST" action="OperazioniPrestito" >
                <center>
                    <table border="1" width="30%" cellpadding="5">
                        
                        <tbody>
                            <%while(lib.next()){%>
                            <tr>
                
                                <td><img src="PrintImage?id_L=<% lib.getString("copertina");%>" 
                                         width="50" height="50"
                                         alt="Immagine non Disponibile"/></td>
                                
                                
                            
                                <td> <p>Titolo:<%= lib.getString(7)%> </p></td>
                                    
                                <td> <p>Autore:<%= lib.getString(4)%>,<%= rs.getString(3)%> </p></td>    
                                
                                <td> <p>Casa editrice:<%= lib.getString(6)%> </p></td>
                               
                                <td> <p>Numero di pagine:<%= lib.getInt(2)%> </p></td>
                                
                                <td> <p>Anno di pubblicazione:<%= lib.getInt(1)%> </p></td>
                                
                                <td> <p>Genere:<%= lib.getString(5)%> </p></td>
                            </tr>
                    
                            <%}%>
                           
                        </tbody>
                    </table>
                </center>
            </form>


        </div>    

        <%}%>
        <%con.close();%>
    </body>
</html>
