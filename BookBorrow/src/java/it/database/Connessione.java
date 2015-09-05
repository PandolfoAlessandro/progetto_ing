package it.database;

import java.sql.*;

public class Connessione {

    private static final String DRIVER = "org.postgresql.Driver";
    private static final String url = "jdbc:postgresql://dbserver.scienze.univr.it/dblab41";
    private static final String user = "userlab41";
    private static final String psw = "quarantaunoUd";

    public Connessione() throws ClassNotFoundException{
        Class.forName(DRIVER);
    }
    public Connection getConnection() {
        Connection con = null;

        try {
            
            con = DriverManager.getConnection(url, user, psw);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return con;

    }
}
