<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="it.database.Connessione"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Gestione Libri</title>
    </head>
    <body>
        <form method="POST" action="booksManagement.jsp">
            <center>
                <table border="1" width="30%" cellpadding="5">
                    <thead>
                        <tr>
                            <th colspan="2">Lista dei libri</th>
                        </tr>
                    </thead>
                    <tbody>
        
        
        <%
            String selectBooks = 
                    "SELECT DISTINCT * "
                    +"FROM libro ";
      
            
            if(!(boolean)session.getAttribute("isAdmin")){     
                selectBooks+="WHERE proprietario= "+(String)session.getAttribute("userEmail");             
            }
            

            Connection con = new Connessione().getConnection();

            // connessione riuscita, ottengo l'oggetto per l'esecuzione dell'interrogazione.
            Statement stmt = con.createStatement();

            ResultSet rs;
            
            rs = stmt.executeQuery(selectBooks);
            con.close();
            while(rs.next()){%>
            
                <tr>
                    <td>titolo</td>
                    <td><input type="string" name="" value="<%rs.getString("titolo");%>" ></td>
                </tr>
            
                
            <%}
            
            con.close();
        %>
        
        
        </tbody>
                </table>
            </center>
        </form>

        <a href="index.jsp">Torna alla pagina di login!</a>
    </body>
        
    </body>
</html>
