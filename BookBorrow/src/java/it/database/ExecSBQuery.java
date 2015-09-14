package it.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author alessandro
 */
public class ExecSBQuery implements QueryExec {

    private String utente;
    private String genere;
    private String ricerca;
    private String provincia;
    private int Operazione;

    public ExecSBQuery() {
        this.utente = null;
        this.genere = null;
        this.ricerca = null;
        this.provincia = null;
        this.Operazione = -1;
    }

    @Override
    public void setParameters(Object... obj) {
        this.Operazione = (int) obj[0];
        if (this.Operazione == 2) {
        } else {
            if (this.Operazione == 0) {
                this.utente = (String) obj[1];
            } else {
                this.utente = (String) obj[1];
                if (obj[3] != null) {
                    this.genere = (String) obj[3];
                }
                if (obj[4] != null) {
                    this.ricerca = (String) obj[4];
                }
                this.provincia = (String) obj[2];
                if (this.Operazione == 1) {

                }
            }
        }
    }

    @Override
    public ResultSet getResult() {
        ResultSet rs = null;
        String query = "";
        switch (this.Operazione) {
            case 0:
                query = "SELECT coordinate_geografiche, provincia FROM indirizzo "
                        + "WHERE BOOK_USER='" + this.utente + "' "
                        + "and Principale=1 ";
                break;
            case 1: {
                query = "SELECT 1, l.id, l.titolo, l.nome_autore, l.cognome_autore, "
                        + "l.casa_ed, l.n_pagine, l.anno_pubblicazione, l.genere, "
                        + "i.coordinate_geografiche, i.citta, i.provincia, i.paese, i.principale, l.Book_User "
                        + "FROM Indirizzo i JOIN libro l "
                        + "on (i.coordinate_geografiche=l.coordinate_geografiche and i.Book_User=l.Book_User) "
                        + "WHERE l.disponibilita=1 and "
                        + "l.Book_User != '" + this.utente + "' ";

                if (this.ricerca != null && !(this.ricerca.equals(""))) {
                    query += " and (l.titolo ilike '%" + this.ricerca + "%' or "
                            + "l.nome_autore ilike '%" + this.ricerca + "%' or "
                            + "l.cognome_autore ilike '%" + this.ricerca + "%') ";
                    if (this.genere != null && !(this.genere.equals(""))) {
                        query += " and l.genere ilike '" + this.genere + "' ";
                    }
                } else {
                    if (this.genere != null && !(this.genere.equals(""))) {
                        query += " and l.genere ilike '" + this.genere + "' ";
                    } else {
                        query += "and i.provincia ilike '" + this.provincia + "' ";
                    }
                }
            }
            break;
            case 2:
                query = "SELECT DISTINCT genere FROM libro Where disponibilita=1 ";
                break;
        }

        try {
            Connection con = Connessione.getConnection();
            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();
            // Verifico che le credenziali inserite siano di un utente "normale"
            rs = stmt.executeQuery(query);
            con.close();
        } catch (ClassNotFoundException | SQLException ex) {
        }
        return rs;
    }
}
