<%-- 
    Document   : profile
    Created on : 12-set-2015, 11.11.26
    Author     : insan3
--%>

<%@page import="it.functions.Geolocalizzazione"%>
<%@page import="java.util.ArrayList"%>
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
            String profiloUtente = "SELECT u.nome, u.cognome, date_part('Year', u.data_nascita) as an, "
                    + "i.coordinate_geografiche, i.citta, i.provincia, i.paese "
                    + "FROM Book_user u JOIN Indirizzo i ON (u.email=i.Book_user) "
                    + "WHERE u.mail='" + request.getParameter("emailSel") + "' AND principale=1 ";
            
            Connection con = Connessione.getConnection();

            Statement stmt = con.createStatement();
            ResultSet rspu = stmt.executeQuery(profiloUtente);
        %>
        <div id="fotoProfilo">
            <img src="PrintImage?id_img=<%=request.getParameter("emailSel")%>&amp;what=utente" 
                 width="200" height="200" 
                 alt="Immagine non Disponibile"/>
        </div>

        <div id="infoProfilo">
            <h1><%= rspu.getString("nome")%> <%= rspu.getString("cognome")%></h1>
            <p>email: <%= rspu.getString("email")%></p>
            <p>Anno di nascita: <%= rspu.getInt("an")%></p>
            <p>Residenza: <%= rspu.getString("citta")%>(<%= rspu.getString("provincia")%>),<%= rspu.getString("paese")%></p>
        </div>
            <%  String cord = rspu.getString("coordinate_geografiche");
            String libriUtente = "SELECT count(*), l.id, l.titolo, l.nome_autore, l.cognome_autore, "
                    + "l.casa_ed, l.n_pagine, l.anno_pubblicazione, l.genere, "
                    + "i.coordinate_geografiche, i.citta, i.provincia, i.paese, i.principale "
                    + "FROM Indirizzo i JOIN libro l "
                    + "on (i.coordinate_geografiche=l.coordinate_geografiche and i.Book_User=l.Book_User) "
                    + "WHERE l.Book_User = '" + request.getParameter("emailSel") + "' "
                    + "group by l.id, i.coordinate_geografiche, i.citta, i.provincia, i.paese ";

            Statement stmt1 = con.createStatement();
            ResultSet rslu = stmt1.executeQuery(libriUtente);
            
            ArrayList<Object[]> listaUtenti = new ArrayList<Object[]>();
            Object[] utenteCorrente;
            Object[][] distanze = null;
            
            if (rslu.next()) {
                session.setAttribute("trovato", true);
                distanze = new Object[2][rslu.getInt(1)];
                int i = 0;
                do {
                    utenteCorrente = new Object[11];
                    utenteCorrente[0] = rslu.getString(2);
                    utenteCorrente[1] = rslu.getString(3);
                    utenteCorrente[2] = rslu.getString(4);
                    utenteCorrente[3] = rslu.getInt(5);
                    utenteCorrente[4] = rslu.getString(7);
                    utenteCorrente[5] = rslu.getString(8);
                    utenteCorrente[6] = rslu.getInt(9);
                    utenteCorrente[7] = rslu.getInt(10);
                    utenteCorrente[8] = rslu.getInt(10);
                    utenteCorrente[9] = rslu.getInt(10);
                    utenteCorrente[10] = rslu.getInt(10);
                    listaUtenti.add(utenteCorrente);
                    distanze[0][i] = (int) i;
                    distanze[1][i] = Geolocalizzazione.getDistance(cord, rslu.getString(6));
                } while (rslu.next());
            } else {
                session.setAttribute("trovato", false);
            }
        %>
        

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
                            <%while (rslu.next()) {%>
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
