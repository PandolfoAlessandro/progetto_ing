
package it.database.beans;


public class Indirizzo {
    
    private String coordinate_geografiche;
    private String via;
    private int n_civico;
    private String cap;
    private String citta;
    private String provincia;
    private String paese;

    public Indirizzo() {};
    
    public String getCoordinate_geografiche() {
        return coordinate_geografiche;
    }

    public String getVia() {
        return via;
    }

    public int getN_civico() {
        return n_civico;
    }

    public String getCap() {
        return cap;
    }

    public String getCitta() {
        return citta;
    }

    public String getProvincia() {
        return provincia;
    }

    public String getPaese() {
        return paese;
    }

    public void setCoordinate_geografiche(String coordinate_geografiche) {
        this.coordinate_geografiche = coordinate_geografiche;
    }

    public void setVia(String via) {
        this.via = via;
    }

    public void setN_civico(int n_civico) {
        this.n_civico = n_civico;
    }

    public void setCap(String cap) {
        this.cap = cap;
    }

    public void setCitta(String citta) {
        this.citta = citta;
    }

    public void setProvincia(String provincia) {
        this.provincia = provincia;
    }

    public void setPaese(String paese) {
        this.paese = paese;
    }
    
    
}
