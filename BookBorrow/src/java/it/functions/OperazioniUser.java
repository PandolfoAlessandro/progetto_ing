/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.functions;

import it.database.Connessione;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author insan3
 */
public class OperazioniUser extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OperazioniUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OperazioniUser at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = (String) (request.getSession().getAttribute("userEmail"));
        String manageSet = request.getParameter("manage");

        //processRequest(request, response);
        switch ((String) request.getSession().getAttribute("Operazione")) {

            case "gestisci": {
                String whatToDo = manageSet.split("/")[0];
                String id_libro = manageSet.split("/")[1];
                switch (whatToDo) {
                    case "elimina": {
                        try {
                            eliminaLibro(id_libro);
                            setTipologiaUser(email);
                        } catch (ClassNotFoundException | SQLException ex) {
                            response.sendRedirect("errorPage.jsp");
                        }

                        response.sendRedirect("manageBooks.jsp");
                    }

                    break;

                    case "gestisci": {
                        response.sendRedirect("dataBookChangeUser.jsp?id_l=" + id_libro);
                        break;
                    }

                    default:
                        break;
                }
            }
            break;

            case "gestisciLibro": {
                String id_libro = (String) request.getSession().getAttribute("id_lib");
                try {
                    modificaDatiLibro(id_libro, request);
                } catch (ClassNotFoundException | SQLException ex) {
                    response.sendRedirect("errorPage.jsp");
                }

                response.sendRedirect("dataBookChangeUser.jsp?id_l=" + id_libro);
                break;
            }

            case "inserisciLibro": {
                int id = 1;
                String query = "INSERT INTO libro VALUES(?,?,?,?,?,?,null,1,?,?,?,?)";
                String getId= "SELECT id FROM libro";

                try (Connection con = Connessione.getConnection()) {
                    PreparedStatement pstmt = con.prepareStatement(query);
                    Statement state= con.createStatement();
                    ResultSet res=state.executeQuery(getId);
                    pstmt.clearParameters();
                    
                    while(res.next()){
                        if(Integer.parseInt(res.getString("id"))>id){
                            id=Integer.parseInt(res.getString("id"));
                        }
                    }
                    id+=1;
                    
                    
                    
                    pstmt.setString( 1, id+"" );
                    pstmt.setInt( 2, Integer.parseInt(request.getParameter("annoPubblicazione")) );
                    pstmt.setInt( 3, Integer.parseInt(request.getParameter("numeroPagine")) );
                    pstmt.setString( 4, request.getParameter("nomeAutore") );
                    pstmt.setString( 5, request.getParameter("cognomeAutore") );
                    pstmt.setString( 6, request.getParameter("genere") );
                    pstmt.setString( 7, request.getParameter("casaEd") );
                    pstmt.setString( 8, request.getParameter("titolo") );
                    
                    //
                    pstmt.setString( 9, request.getParameter("mydropdown") );
                    pstmt.setString( 10, email );
                    
                    pstmt.executeUpdate();
                    setTipologiaUser(email);
                    con.close();
                    response.sendRedirect("completeInsertion.jsp?id="+id);
                } catch (ClassNotFoundException | SQLException ex) {
                    Logger.getLogger(OperazioniUser.class.getName()).log(Level.SEVERE, null, ex);
                }
                break;

            }
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void eliminaLibro(String id_libro) throws ClassNotFoundException, SQLException {
        String deleteBook = "DELETE FROM libro WHERE id='" + id_libro + "'";
        try (Connection con = Connessione.getConnection()) {
            Statement stmt = con.createStatement();
            stmt.executeUpdate(deleteBook);
            con.close();
        }

    }

    private void modificaDatiLibro(String id_l, HttpServletRequest request) throws ClassNotFoundException, SQLException {
        String updateBook = "UPDATE Libro SET anno_pubblicazione=?, n_pagine=?, "
                + "nome_autore=?, cognome_autore=?, genere=?, casa_ed=?, titolo=? "
                + "WHERE id='" + id_l + "'";
        try (Connection con = Connessione.getConnection()) {
            PreparedStatement pstmt = con.prepareStatement(updateBook);
            pstmt.clearParameters();

            // imposto i parametri della query
            pstmt.setInt(1, Integer.parseInt(request.getParameter("annoPub")));
            pstmt.setInt(2, Integer.parseInt(request.getParameter("nPag")));
            pstmt.setString(3, request.getParameter("libroAutore").split(",")[1]);
            pstmt.setString(4, request.getParameter("libroAutore").split(",")[0]);
            pstmt.setString(5, request.getParameter("gen"));
            pstmt.setString(6, request.getParameter("casaEd"));
            pstmt.setString(7, request.getParameter("libroTitolo"));

            pstmt.executeUpdate();
            con.close();
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void setTipologiaUser(String user) throws ClassNotFoundException, SQLException {
        String control
                = "SELECT count(libro.id) AS numLibri "
                + "FROM libro "
                + "WHERE libro.book_user='" + user + "'";

        String modifing = "UPDATE book_user SET tipologia= ";
        int numLibri = 0;

        try (Connection con = Connessione.getConnection()) {
            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery(control);

            if (rs.next()) {
                numLibri = rs.getInt("numLibri");
            }

            if (numLibri > 0) {
                stmt.executeUpdate(modifing + "1 WHERE email='" + user + "'");
            } else {
                stmt.executeUpdate(modifing + "0 WHERE email='" + user + "'");
            }
            con.close();
        }

    }

}
