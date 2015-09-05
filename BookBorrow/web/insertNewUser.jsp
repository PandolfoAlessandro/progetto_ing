<%@page import="it.database.Geolocalizzazione"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page import="it.database.Connessione"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="it.elbuild.jcoord.resolver.GeoCodeResolver"%>
<%@page import="it.elbuild.jcoord.LatLng"%>
<html>
    <body>
        <%@ page language="java" import ="java.sql.*" %>
        <%@ page errorPage="errorRegistration.jsp" %>
        <%

            String insertNewUser = "INSERT INTO Book_User VALUES (?,?,?,?,?,?,?,0)";
            String insertNewAddress = "INSERT INTO Indirizzo VALUES (?,?,?,?,?,?,?)";

            Connection con = new Connessione().getConnection();
            PreparedStatement pstmt=null;
            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            pstmt = con.prepareStatement(insertNewUser);
            
            pstmt.clearParameters();

            // imposto i parametri della query
            pstmt.setString(1, request.getParameter("userEmail"));
            pstmt.setString(2, request.getParameter("userPwd"));
            pstmt.setString(3, request.getParameter("userName"));
            pstmt.setString(4, request.getParameter("userSurname"));
            pstmt.setString(5, request.getParameter("sesso"));
            pstmt.setString(6, request.getParameter("userBirthDate"));
            pstmt.setString(7, request.getParameter("userProfilePhoto"));

            JOptionPane.showMessageDialog(null, "bio parco 1");

            pstmt.executeUpdate();
            JOptionPane.showMessageDialog(null, " bio parco 2");
            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            
            
            
            
            pstmt = con.prepareStatement(insertNewAddress);
            pstmt.clearParameters();
            // TODO: chiaedere allo Scardo di convertire indirizzo in coordinate geografiche
            JOptionPane.showMessageDialog(null, "bio parco 3");

            String indirizzo = 
                    request.getParameter("userVia") + " "
                    + request.getParameter("userNumCiv") + " "
                    + request.getParameter("userCAP") + " "
                    + request.getParameter("userCity") + " "
                    + request.getParameter("userProv") + " "
                    + request.getParameter("userState");
            
            // imposto i parametri della query
            pstmt.setString(1, Geolocalizzazione.getCoordinate(indirizzo));
            pstmt.setString(2, request.getParameter("userVia"));
            pstmt.setString(3, request.getParameter("userNumCiv"));
            pstmt.setString(4, request.getParameter("userCAP"));
            pstmt.setString(5, request.getParameter("userCity"));
            pstmt.setString(6, request.getParameter("userProv"));
            pstmt.setString(7, request.getParameter("userState"));

            pstmt.executeUpdate();
            
            con.close();

            session.setAttribute("userEmail", request.getParameter("userEmail"));
            session.setAttribute("userName", request.getParameter("userName"));
            session.setAttribute("userSurname", request.getParameter("userSurname"));
            session.setAttribute("isAdmin", false);
            response.sendRedirect("main.jsp"); // compleata l'iscrizione, l'utente viene reindirizzato alla sua home page

        %>
    </body>
</html>
