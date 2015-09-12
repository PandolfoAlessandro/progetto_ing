<%-- 
    Document   : profile
    Created on : 12-set-2015, 11.11.26
    Author     : insan3
--%>

<%@page import="java.sql.PreparedStatement"%>
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
            String librieUtente = "SELECT * "
                    + "from libro join book_user on (libro.book_user=book_user.email) "
                    + "WHERE disponibilita=1 AND book_user='" + request.getParameter("emailSel") + "'";
            Connection con = Connessione.getConnection();
            int go = 0;
            PreparedStatement stmt = con.prepareStatement(librieUtente);
            stmt.clearParameters();
            ResultSet pb = null;
            pb = stmt.executeQuery();
            if (pb.next()) {
                go = 1;
            }

            if (go == 1) {
        %>
        <div id="fotoProfilo">
            <img src="PrintImage?id_img=<%=request.getParameter("emailSel")%>&amp;what=utente" 
                 width="200" height="200" 
                 alt="Immagine non Disponibile"/>


        </div>

        <div id="infoProfilo">

            <h1><%= pb.getString("nome")%> <%= pb.getString("cognome")%></h1>
            <p>email: <%= pb.getString("email")%></p>

        </div>

        <div id="infoLibri">
            <form method="POST" action="OperazioniPrestito" >
                <center>
                    <table border="1" width="30%" cellpadding="5">
                        <tbody>
                            <tr>
                                <th>Copertina:</th>
                                <th>Titolo:</th>
                                <th>Autore:</th>
                                <th>Casa editrice:</th>
                                <th>Numero di pagine:</th> 
                                <th>Anno di pubblicazione:</th>
                                <th>Genere:</th>
                                <th>Distanza:</th>
                            </tr>
                            <%while (pb.next()) {%>
                            <tr>

                                <td><img src="PrintImage?id_img=<%= pb.getString("copertina")%>&amp;what=utente" 
                                         width="50" height="50"
                                         alt="Immagine non Disponibile"/>

                                <td> <p><%= pb.getString("titolo")%> </p></td>

                                <td> <p><%= pb.getString("nome_autore")%>,<%= pb.getString("cognome_autore")%> </p></td>    

                                <td> <p><%= pb.getString("casa_ed")%> </p></td>

                                <td> <p><%= pb.getInt("n_pagine")%> </p></td>

                                <td> <p><%= pb.getInt("anno_pubblicazione")%> </p></td>

                                <td> <p><%= pb.getString("genere")%> </p></td>
                                
                                <td> <p> Km </p></td>
                                
                                <td> prenota </td>
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
