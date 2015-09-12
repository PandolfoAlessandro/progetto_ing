<%-- 
    Document   : addLibro
    Created on : 11-set-2015, 16.27.17
    Author     : insan3
--%>

<%@page import="java.sql.ResultSet"%>
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
        <% session.setAttribute("Operazione", "inserisciLibro"); %>
        <form method="POST" action="OperazioniUser">
            <center>
                <table border="1" width="30%" cellpadding="5">
                    <thead>
                        <tr>
                            <th colspan="2">Inserisci le informazioni del libro</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="2"><b>Dati libro</b></td>
                        </tr>
                        <tr>
                            <td>Titolo:</td>
                            <td><input type="text" name="titolo" value="" ></td>
                        </tr>
                        <tr>
                            <td>Nome autore:</td>
                            <td><input type="text" name="nomeAutore" value="" ></td>
                        </tr>
                        <tr>
                            <td>Cognome autore:</td>
                            <td><input type="text" name="cognomeAutore" value="" ></td>
                        </tr>
                        <tr>
                            <td>Casa editrice:</td>
                            <td><input type="text" name="casaEd" value="" ></td>
                        </tr>

                        <tr>
                            <td>Genere:</td>
                            <td><input type="text" name="genere" value="" ></td>
                        </tr>

                        <tr>
                            <td>Anno pubblicazione:</td>
                            <td><input type="text" name="annoPubblicazione" value="" ></td>
                        </tr>

                        <tr>
                            <td>Numero pagine:</td>
                            <td><input type="text" name="numeroPagine" value="" ></td>
                        </tr>
                        <tr>
                            <td>Indirizzo:</td>
                            
<%!!!!!!!%>non prende su i valori dal menu a tendina

                            <td><select name="mydropdown">
                                    <%
                                        String indirizzi = "SELECT * FROM indirizzo WHERE book_user='" + (String) (session.getAttribute("userEmail")) + "'";
                                        Connection con = Connessione.getConnection();
                                        Statement stmt = con.createStatement();
                                        ResultSet rs = stmt.executeQuery(indirizzi);

                                        while (rs.next()) {

                                    %>    

                                    <option value="<%rs.getString("coordinate_geografiche");%>"> 
                                        <%out.print(rs.getString("via") + " " + rs.getString("n_civico") + ", " + rs.getString("cap") + " " + rs.getString("citta") + " (" + rs.getString("provincia") + ") " + rs.getString("paese"));%> 
                                    </option>                    
                                    <%}
                                        con.close();
                                    %>
                                </select></td>
                        </tr>
                        
                        <tr>
                            <td><button type="Submit" name="Operazione" value="inserisci" >Inserisci libro!</button></td>
                        </tr>

                    </tbody>
                </table>
            </center>
        </form>
        <p><a href="manageBooks.jsp">Indietro</a></p>
    </body>
</html>
