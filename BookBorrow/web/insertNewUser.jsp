<html>
<body>
<%@ page language="java" import ="java.sql.*" %>
<%@ page language="java" import ="java.it.database.*" %>
<%@ page errorPage="errorRegistration.jsp" %>
<%
    
	String insertNewUser= "INSERT INTO Book_User VALUES (?,?,?,?,?,?,?,0)";
	
	String insertNewAddress="INSERT INTO Indirizzo VALUES (?,?,?,?,?,?,?)";


    Connessione connect = new Connessione();
    Connection con = connect.connect();
	
    // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
    PreparedStatement pstmt = con.prepareStatement(insertNewUser);
    pstmt.clearParameters();
    
    // imposto i parametri della query
    pstmt.setString(1, request.getParameter("userEmail") );
    pstmt.setString(2, request.getParameter("userPwd") );
    pstmt.setString(3, request.getParameter("userName") );
    pstmt.setString(4, request.getParameter("userSurname") );
    pstmt.setString(5, request.getParameter("sesso") );
    pstmt.setString(6, request.getParameter("userBirthDate") );
    pstmt.setString(7, request.getParameter("userProfilePhoto") );
    
    pstmt.executeUpdate();
    
    
 	
	// connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
    pstmt = con.prepareStatement(insertNewAddress);
    pstmt.clearParameters();
 	// TODO: chiaedere allo Scardo di convertire indirizzo in coordinate geografiche
 	
 	// CONVERSIONE INDIRIZZO IN COORDINATE GEOGRAFICHE
 	
 	
    // imposto i parametri della query
    pstmt.setString(1, coordinate_geografiche );
    pstmt.setString(2, request.getParameter("userVia") );
    pstmt.setString(3, request.getParameter("userNumCiv") );
    pstmt.setString(4, request.getParameter("userCAP") );
    pstmt.setString(5, request.getParameter("userCity") );
    pstmt.setString(6, request.getParameter("userProv") );
    pstmt.setString(7, request.getParameter("userState") );
    
    pstmt.executeUpdate();
    
    session.setAttribute("userEmail", request.getParameter("userEmail"));
    session.setAttribute("userName", request.getParameter("userName") );
    session.setAttribute("userSurname", request.getParameter("userSurname") );
    session.setAttribute("isAdmin", false);
    response.sendRedirect("main.jsp"); // compleata l'iscrizione, l'utente viene reindirizzato alla sua home page
    
%>
</body>
</html>
