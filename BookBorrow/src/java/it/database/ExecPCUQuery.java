package it.database;

import java.sql.*;

/**
 *
 * @author alessandro
 */
public class ExecPCUQuery implements QueryExec{
    private String utente;

    public ExecPCUQuery() {
        this.utente = null;
    }

    @Override
    public void setPrameters(Object... obj) {
        this.utente = (String) obj[0];
    }

    @Override
    public ResultSet getResult() {
        ResultSet rs = null;

        String datiProfilo = "SELECT nome,cognome,sesso,data_nascita,foto_profilo "
                    + "FROM book_user "
                    + "WHERE email='" + this.utente +"'";

        try {
            Connection con = Connessione.getConnection();
            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();
            // Verifico che le credenziali inserite siano di un utente "normale"
            rs = stmt.executeQuery(datiProfilo);
            con.close();
        } catch (ClassNotFoundException | SQLException ex) {
        }
        return rs;
    }
}
