package it.database.beans;

import java.sql.Date;

public class BookUser {
    
    private String email;
    private String password;
    private String nome;
    private String cognome;
    private char sesso;
    private java.sql.Date data_nascita;
    private String foto_profilo;
    private int tipologia;

    public BookUser() {};

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public String getNome() {
        return nome;
    }

    public String getCognome() {
        return cognome;
    }

    public char getSesso() {
        return sesso;
    }

    public Date getData_nascita() {
        return data_nascita;
    }

    public String getFoto_profilo() {
        return foto_profilo;
    }

    public int getTipologia() {
        return tipologia;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public void setSesso(char sesso) {
        this.sesso = sesso;
    }

    public void setData_nascita(Date data_nascita) {
        this.data_nascita = data_nascita;
    }

    public void setFoto_profilo(String foto_profilo) {
        this.foto_profilo = foto_profilo;
    }

    public void setTipologia(int tipologia) {
        this.tipologia = tipologia;
    }
}
