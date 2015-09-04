package java.it.database;

import java.sql.*;

public class Connessione {

	protected String DRIVER = "org.postgresql.Driver";
	protected String url = "jdbc:postgresql://dbserver.scienze.univr.it/dblab41";
	protected String user = "userlab41";
	protected String psw = "quarantaunoUd";

	public Connessione(){
		super();
	}
	
	public Connection connect() {

		Connection con = null;

		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(url, user, psw);
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		return con;

	}
}
