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
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.JOptionPane;
import org.apache.catalina.connector.Response;

/**
 *
 * @author alessandro
 */
public class OperazioniAdmin extends HttpServlet {

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
            out.println("<title>Servlet OperazioniAdmin</title>");
            out.println("</head>");

            out.print(request.getSession().getAttribute("operazione"));

            out.println("<body>");
            out.println("<h1>Servlet OperazioniAdmin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    /*

     @Override
     protected void doGet(HttpServletRequest request, HttpServletResponse response)
     throws ServletException, IOException {
     processRequest(request, response);
        
     switch ((String) request.getSession().getAttribute("Operazione")) {
     case "elimina": eliminazione(request,response);
     break;
     case "gestisci": gestione(request,response);
     break;
     case "statistiche": statistiche(request,response);
     break;
     }
     }
     */

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String mail = request.getParameter("delete");
        String manageSet = request.getParameter("manage");

        //processRequest(request, response);
        switch ((String) request.getSession().getAttribute("Operazione")) {
            case "elimina": {
                int conferma = JOptionPane.showConfirmDialog(null, "sicuro di voler rimuovere l'utente:" + mail);
                if (conferma == JOptionPane.YES_OPTION) {
                    try {
                        eliminazione(mail);
                    } catch (ClassNotFoundException | SQLException ex) {
                        response.sendRedirect("errorPage.jsp");
                    }
                }
                response.sendRedirect("deleteUser.jsp");
            }
            break;
            case "gestisci": {
                String whatToDo = manageSet.split("/")[0];
                String id_libro = manageSet.split("/")[1];
                switch (whatToDo) {
                    case "elimina": {
                        int conferma = JOptionPane.showConfirmDialog(null, "sicuro di voler rimuovere il libro selezionato(id=" + mail + ")");
                        if (conferma == JOptionPane.YES_OPTION) {
                            try {
                                eliminaLibro(id_libro);
                            } catch (ClassNotFoundException | SQLException ex) {
                                response.sendRedirect("errorPage.jsp");
                            }
                        }
                        response.sendRedirect("manageBookAdmin.jsp");
                    }
                    break;

                    case "gestisci": {
                        response.sendRedirect("dataBookChangeAdmin.jsp?id_l=" + id_libro);
                        break;
                    }
                    default:
                        break;
                }
            }
            break;
            case "statistiche":
                statistiche(request, response);
                break;
            case "gestisciLibro": {
                int conferma = JOptionPane.showConfirmDialog(null, "sicuro di voler modificare il libro selezionato(id=" + mail + ")");
                String id_libro = (String) request.getSession().getAttribute("id_lib");
                if (conferma == JOptionPane.YES_OPTION) {
                    try {
                        modificaDatiLibro(id_libro, request);
                    } catch (ClassNotFoundException | SQLException ex) {
                        response.sendRedirect("errorPage.jsp");
                    }
                }
                response.sendRedirect("dataBookChangeAdmin.jsp?id_l=" + id_libro);
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

    private void eliminazione(String mail) throws ClassNotFoundException, SQLException {

        String deleteUser = "DELETE FROM book_user WHERE email='" + mail + "'";
        String banUser = "INSERT INTO blacklist VALUES('" + mail + "')";
        try (Connection con = Connessione.getConnection()) {
            Statement stmt = con.createStatement();
            stmt.executeUpdate(deleteUser);
            stmt.executeUpdate(banUser);
            con.close();
        }
    }

    private void statistiche(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

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

}
