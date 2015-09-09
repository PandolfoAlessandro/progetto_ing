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
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
                try {
                    eliminazione(mail);
                    response.sendRedirect("deleteUser.jsp");
                } catch (ClassNotFoundException | SQLException ex) {
                    response.sendRedirect("errorPage.jsp");
                }
            }
            break;
            case "gestisci": {
                try {
                    gestione(manageSet, response);
                    response.sendRedirect("manageBookAdmin.jsp");
                } catch (ClassNotFoundException | SQLException ex) {
                    response.sendRedirect("errorPage.jsp");
                }
            }
            break;
            case "statistiche":
                statistiche(request, response);
                break;
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

    private void gestione(String mSet, HttpServletResponse response) throws IOException, ClassNotFoundException, SQLException {
        String whatToDo = mSet.split("/")[0];
        String id_libro = mSet.split("/")[1];

        switch (whatToDo) {
            case "elimina":
                eliminaLibro(id_libro);
            case "gestisci":
                response.sendRedirect("dataBookChangeAdmin.jsp");
            default:
                break;
        }
        //notifica operazione all'utente!!!!!!!
    }

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

}
