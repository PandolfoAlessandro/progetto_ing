<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="it.database.Connessione"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Lista utenti</title>
    </head>
    <body>
        <%! public void select(String sel, HttpSession session){session.setAttribute("elimSel", sel);  } %>
        
        <%  HttpSession sessCorrente = session;         
            String selectUsers = "SELECT DISTINCT b.email, b.nome, b.cognome, i.citta, i.provincia "
                    + "FROM book_user b join residenza r ON (b.email=r.utente) JOIN indirizzo i ON (r.coordinate_geografiche = i.coordinate_geografiche)";

            Connection con = new Connessione().getConnection();

            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();

            ResultSet rs;
            // Verifico che le credenziali inserite siano di un utente "normale"
            rs = stmt.executeQuery(selectUsers);
        %>    
        <form method="POST" action="OperazioniAdmin">
            <a href="admin.jsp">Indietro</a>
            <% session.setAttribute("Operazione", "elimina"); %>
            <TABLE BORDER="1">
                <TR>
                    <TH>Email</TH>
                    <TH>Nome</TH>
                    <TH>Cognome</TH>
                    <TH>Citt&agrave;</TH>
                    <TH>Provincia</TH>
                </TR>
                <% while (rs.next()) {%>
                <TR>
                    <TD> <%= rs.getString(1)%></TD>
                    <TD> <%= rs.getString(2)%></TD>
                    <TD> <%= rs.getString(3)%></TD>
                    <TD> <%= rs.getString(4)%></TD>
                    <TD> <%= rs.getString(5)%></TD>
                    <TD> <input type="submit" name="delete" onSubmit="select(<%= rs.getString(1)%>,<%= sessCorrente %>)" value="Elimina utente"/> </td>
                </TR>
                <% }%>
            </TABLE>
        </form>



    </body>
</html>
