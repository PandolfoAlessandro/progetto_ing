package it.database.beans;

public class Residenza {

    private String utente;
    private String coordinate_geografiche;

    public Residenza() {};
    
    public String getUtente() {
        return utente;
    }

    public void setUtente(String utente) {
        this.utente = utente;
    }

    public String getCoordinate_geografiche() {
        return coordinate_geografiche;
    }

    public void setCoordinate_geografiche(String coordinate_geografiche) {
        this.coordinate_geografiche = coordinate_geografiche;
    }

}
