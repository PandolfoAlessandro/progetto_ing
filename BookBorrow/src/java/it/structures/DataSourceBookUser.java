package it.structures;

import it.database.Connessione;
import java.sql.*;


public class DataSourceBookUser {

    private static String loginUser = "SELECT nome, cognome FROM Book_User WHERE email = ? AND password = ?";
    private boolean loginFailed;
    private String userEmail;
    private String userSurname;
    private boolean isAdmin;
    
    public String controlLogin(String userEmail, String userPwd) throws ClassNotFoundException, SQLException {
        String loginUser = "SELECT nome, cognome FROM Book_User WHERE email = '" + userEmail + "' AND password = '" + userPwd + "'";
        String loginAdmin = "SELECT 1 FROM Admin WHERE email = '" + userEmail + "' AND password = '" + userPwd + "'";

        Connection con = Connessione.getConnection();

        // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
        Statement stmt = con.createStatement();

        ResultSet rs;
        // Verifico che le credenziali inserite siano di un utente "normale"
        rs = stmt.executeQuery(loginUser);

        if (rs.next()) {
            loginFailed = false;
            session.setAttribute("userEmail", userEmail);
            session.setAttribute("userName", rs.getString(1));
            session.setAttribute("userSurname", rs.getString(2));
            session.setAttribute("isAdmin", false);
            response.sendRedirect("main.jsp"); // home page personale dell'utente
        } else {
            rs = stmt.executeQuery(loginAdmin);
            if (rs.next()) {
                session.setAttribute("loginFailed", false);
                session.setAttribute("userEmail", userEmail);
                session.setAttribute("isAdmin", true);
                response.sendRedirect("admin.jsp"); // home page dell'amministratore di sistema
            } else {
                session.setAttribute("loginFailed", true);
                response.sendRedirect("index.jsp");
            }
        }
    }
}
