package it.functions;

import it.database.Connessione;
/**
 *
 * @author insan3
 * 
 * 
 * 
 * http://forums.devshed.com/postgresql-help-21/storing-images-postgresql-database-10261.html
 * http://www.codejava.net/coding/upload-files-to-database-servlet-jsp-mysql
 * 
 * 
 * 
 */
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
 
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
 
@WebServlet("/uploadServlet")
@MultipartConfig(maxFileSize = 16177215)    // upload file's size up to 16MB
public class ImageUpload extends HttpServlet {
     

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response){
        switch ((String)(request.getParameterNames().nextElement())) {
            case "email":
                try {
                    doPostUser(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(ImageUpload.class.getName()).log(Level.SEVERE, null, ex);
                }   
                break;
            case "id":
                try {
                    doPostBook(request, response);
                } catch (ServletException | IOException ex) {
                    Logger.getLogger(ImageUpload.class.getName()).log(Level.SEVERE, null, ex);
                }   
                break;
        }
        
        
    }
    
    private void doPostUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // gets values of text fields
        String email = request.getParameter("email");

         
        InputStream inputStream = null; // input stream of the upload file
         
        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("foto_profilo");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
         
        Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client
         
        try {
            // connects to the database
           
            conn = Connessione.getConnection();
 
            // constructs SQL statement
            String sql = "UPDATE book_user SET foto_profilo=? WHERE email= '"+email+"'";
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.clearParameters();
            
        
          
             
            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                statement.setBlob(1, inputStream);
            }
 
            // sends the statement to the database server
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "File uploaded and saved into database";
            }
        } catch (ClassNotFoundException | SQLException ex) {
            message = "ERROR: " + ex.getMessage();
        } finally {
            if (conn != null) {
                // closes the database connection
                try {
                    conn.close();
                } catch (SQLException ex) {
                }
            }
            // sets the message in request scope
            request.setAttribute("Message", message);
             
            // forwards to the message page
            getServletContext().getRequestDispatcher("/Message.jsp").forward(request, response);
            
            response.sendRedirect("main.jsp");
        }
    }
    
    private void doPostBook(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // gets values of text fields
        String id = request.getParameter("id");

         
        InputStream inputStream = null; // input stream of the upload file
         
        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("copertina");
        if (filePart != null) {
            // prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());
             
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }
         
        Connection conn = null; // connection to the database
        String message = null;  // message will be sent back to client
         
        try {
            // connects to the database
           
            conn = new Connessione().getConnection();
 
            // constructs SQL statement
            String sql = "UPDATE libro SET copertina=? WHERE id= '"+id+"'";
            
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.clearParameters();
            
        
          
             
            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                statement.setBlob(1, inputStream);
            }
 
            // sends the statement to the database server
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "File uploaded and saved into database";
            }
        } catch (ClassNotFoundException | SQLException ex) {
            message = "ERROR: " + ex.getMessage();
        } finally {
            if (conn != null) {
                // closes the database connection
                try {
                    conn.close();
                } catch (SQLException ex) {
                }
            }
            // sets the message in request scope
            request.setAttribute("Message", message);
             
            // forwards to the message page
            getServletContext().getRequestDispatcher("/Message.jsp").forward(request, response);
            
        }
    }
}