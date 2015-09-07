package it.structures;


public interface Delete {
    /**
     * Metodo che consente di eliminare un oggetto dal database
     * @param key Chiave primaria dell'oggetto da eliminare dal database
     * @return valore di ritorno alla chiamate executeUpdate(). 1 se va a buon fine, 0 altrimenti
     */
    public int deleteObject(String key);
}
