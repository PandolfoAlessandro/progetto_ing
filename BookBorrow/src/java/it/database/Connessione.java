package it.database;

import java.sql.*;
import javax.swing.JOptionPane;

public class Connessione {

    private static final String DRIVER = "org.postgresql.Driver";
    private static final String url = "jdbc:postgresql://dbserver.scienze.univr.it/dblab41";
    private static final String user = "userlab41";
    private static final String psw = "quarantaunoUd";

    public static Connection connect() {
        Connection con = null;

        try {
            Class.forName(DRIVER);
            JOptionPane.showMessageDialog(null, "ciao");
            con = DriverManager.getConnection(url, user, psw);

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return con;

    }
}
