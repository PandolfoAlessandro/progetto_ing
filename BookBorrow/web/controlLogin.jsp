<%@ page language="java" import="javax.swing.JOptionPane"%>
<%@ page language="java" import ="java.sql.*" %>
<%@ page language="java" import ="it.database.*" %>
<%@ page errorPage="errorLogin.jsp" %>
<html>
<body>

<%
    String userEmail = request.getParameter("userEmail");    
    String userPwd = request.getParameter("userPwd");
	String loginUser= "SELECT nome,cognome FROM BookUser WHERE email = '"+userEmail+"' AND password = '"+userPwd+"'";
	String loginAdmin = "SELECT 1 FROM Admin WHERE email = '"+userEmail+"' AND password = '"+userPwd+"'";

    Connection con = Connessione.connect();
	
    // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
    Statement stmt = con.createStatement();
    
    ResultSet rs;
    // Verifico che le credenziali inserite siano di un utente "normale"
    rs = stmt.executeQuery(loginUser);
    if (rs.next()) {
        session.setAttribute("userEmail", userEmail);
        session.setAttribute("userName", rs.getString(1));
        session.setAttribute("userSurname", rs.getString(2));
        session.setAttribute("isAdmin", false);
        response.sendRedirect("main.jsp"); // home page personale dell'utente
    } else{
    	rs = stmt.executeQuery(loginAdmin);
    	if(rs.next()){
    		session.setAttribute("userEmail", userEmail);
    		session.setAttribute("isAdmin", true);
    		response.sendRedirect("admin.jps"); // home page dell'amministratore di sistema
    	} else{
    		session.setAttribute("loginFailed", true);
    		response.sendRedirect("index.jsp");
    	}
    }
%>
</body>
</html>
