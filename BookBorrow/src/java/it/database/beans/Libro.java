/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.database.beans;

/**
 *
 * @author insan3
 */
public class Libro {
    private String id;
    private int anno_pubblicazione;
    private int n_pagine;
    private String nome_autore;
    private String cognome_autore;
    private String genere;
    private String copertina;
    private int disponibilita;
    private String casa_ed;
    private String titolo;
    private String indirizzo;
    private String proprietario;

    public Libro() {
        
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getAnno_pubblicazione() {
        return anno_pubblicazione;
    }

    public void setAnno_pubblicazione(int anno_pubblicazione) {
        this.anno_pubblicazione = anno_pubblicazione;
    }

    public int getN_pagine() {
        return n_pagine;
    }

    public void setN_pagine(int n_pagine) {
        this.n_pagine = n_pagine;
    }

    public String getNome_autore() {
        return nome_autore;
    }

    public void setNome_autore(String nome_autore) {
        this.nome_autore = nome_autore;
    }

    public String getCognome_autore() {
        return cognome_autore;
    }

    public void setCognome_autore(String cognome_autore) {
        this.cognome_autore = cognome_autore;
    }

    public String getGenere() {
        return genere;
    }

    public void setGenere(String genere) {
        this.genere = genere;
    }

    public String getCopertina() {
        return copertina;
    }

    public void setCopertina(String copertina) {
        this.copertina = copertina;
    }

    public int getDisponibilita() {
        return disponibilita;
    }

    public void setDisponibilita(int disponibilita) {
        this.disponibilita = disponibilita;
    }

    public String getCasa_ed() {
        return casa_ed;
    }

    public void setCasa_ed(String casa_ed) {
        this.casa_ed = casa_ed;
    }

    public String getTitolo() {
        return titolo;
    }

    public void setTitolo(String titolo) {
        this.titolo = titolo;
    }

    public String getIndirizzo() {
        return indirizzo;
    }

    public void setIndirizzo(String indirizzo) {
        this.indirizzo = indirizzo;
    }

    public String getProprietario() {
        return proprietario;
    }

    public void setProprietario(String proprietario) {
        this.proprietario = proprietario;
    }
    
    
    
    
}
