/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.database;

import java.awt.HeadlessException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author insan3
 */
public class ExecStatQuery {
    
    private static final String numUtenti = "SELECT count(*) FROM book_user";
    private static final String numLibri = "SELECT count(*) FROM libro";
    private static final String numPrestAcc = "SELECT count(*) FROM prestito WHERE stato='a'";
    private static final String numMaschi = "SELECT count(*) FROM book_user WHERE sesso='m'";
    
    private String nUt;
    private String nLi;
    private String nPA;
    private String nMa;
    private String nFe;
    
    private static ExecStatQuery q=null;
    
    
    private ExecStatQuery(){
        try{
        ResultSet r1=doQuery(numUtenti);
        r1.next();
        ResultSet r2=doQuery(numLibri);
        r2.next();
        ResultSet r3=doQuery(numPrestAcc);
        r3.next();
        ResultSet r4=doQuery(numMaschi);
        r4.next();
        

        this.nUt=r1.getInt(1)+"";
        this.nLi=r2.getInt(1)+"";
        this.nPA=r3.getInt(1)+"";
        this.nMa=((r4.getInt(1))*100/(r1.getInt(1))*100)/100+"% ";
        this.nFe=(((r1.getInt(1)-r4.getInt(1)))*100/r1.getInt(1)*100)/100 +"% ";
        
        }catch(SQLException | HeadlessException e){}
        
        


    } 
    
    public static ExecStatQuery getInstance(){
        if(!(q instanceof ExecStatQuery)){
            q=new ExecStatQuery();
        }
        
        return q;
        
    }

    public String getnUt() {
        return nUt;
    }

    public String getnLi() {
        return nLi;
    }

    public String getnPA() {
        return nPA;
    }

    public String getnMa() {
        return nMa;
    }

    public String getnFe() {
        return nFe;
    }
    
    private static ResultSet doQuery(String s) throws SQLException{
     
        try {
            ResultSet rs;
            try (Connection con = Connessione.getConnection()) {
                Statement stmt = con.createStatement();
                rs = stmt.executeQuery(s);
                con.close();
            }
            return rs;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ExecStatQuery.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;   
    }  
    
    
}
