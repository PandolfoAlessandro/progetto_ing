package it.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author alessandro
 */
public class ExecNotQuery implements QueryExec{
    
    private String utente;
    
    public ExecNotQuery(){
        this.utente=null;
    }
    
    @Override
    public void setParameters(Object... obj) {
        this.utente=(String)obj[0];
    }

    @Override
    public ResultSet getResult() {
        String ricevute = "SELECT p.email_richiedente, l.titolo, l.nome_autore, "
                    + "l.cognome_autore, date_part('Year', p.data_richiesta), date_part('Month', p.data_richiesta), "
                    + "date_part('Day', p.data_richiesta), l.id "
                    + "FROM prestito p JOIN libro l ON (p.id_libro=l.id) "
                    + "WHERE p.stato ilike 'p' and "
                    + "p.email_proprietario = '" + utente + "'";
        ResultSet rs = null;
        try {
            Connection con = Connessione.getConnection();
            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();    
            //eseguo la query
            rs = stmt.executeQuery(ricevute);    
            
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
        }
        return rs;
    }
    
}
