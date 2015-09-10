
package it.database;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class Conferma {
    private boolean confermato;
    private HttpServletRequest req;
    private HttpServletResponse res;

    public Conferma() {
        confermato=false;
    }

    public boolean isConfermato() {
        return confermato;
    }

    public void setConfermato(boolean confermato) {
        this.confermato = confermato;
    }

    public HttpServletRequest getReq() {
        return req;
    }

    public void setReq(HttpServletRequest req) {
        this.req = req;
    }

    public HttpServletResponse getRes() {
        return res;
    }

    public void setRes(HttpServletResponse res) {
        this.res = res;
    }
    
    
}
