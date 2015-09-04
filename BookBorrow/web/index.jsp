<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!-- inserire bean ggiigigi -->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Benvenuto su BookBorrow!</title>
</head>
<body>
	<%
		session.setAttribute("loginFailed", false);
		session.setAttribute("isBanned", false);
	%>
	<div id="header">
		<table>
			<tr>
				<td>
					<p>BookBorrow</p>
				</td>
				<td>
					<!-- img -->
				</td>
				<td>
					<p>PGS.srl</p>
				</td>
			</tr>
		</table>
	</div>

	<div id="descrizione"></div>

	<div id="login">
		<form action="controlLogin.jsp" method="POST">
			<%
				if((Boolean)session.getAttribute("loginFailed")){
			%>
					E-mail o password inseriti errati o inesistenti
			<%
				}
			%>
			
			<%
				if((Boolean)session.getAttribute("isBanned")){
			%>
					Le credenziali inserite corrispondono a un utente espulso dal sistema.
			
			<%
				}
			%>
			
			User: <input type="text" name="userEmail"> <br />
			Password: <input type="password" name="userPwd" /> 
			<input type="submit" value="Submit" />
		</form>
		
		<a href="registration.jsp">Se non sei iscritto, registrati!</a>
	</div>

</body>