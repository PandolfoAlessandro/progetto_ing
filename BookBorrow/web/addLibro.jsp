<%-- 
    Document   : addLibro
    Created on : 11-set-2015, 16.27.17
    Author     : insan3
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    
        *Anno_pubblicazione numeric(4,0),
	*N_pagine integer,
	*Nome_autore varchar(15) NOT NULL, 
	*Cognome_autore varchar(15) NOT NULL,
	*Genere varchar(50) NOT NULL, 
	Copertina bytea,
	Disponibilita integer NOT NULL,
	*Casa_ed varchar(40),
	*Titolo varchar(80) NOT NULL,
	Coordinate_geografiche varchar(140) NOT NULL,
	Book_User varchar(50) NOT NULL,
    
    <body>
        <form method="GET" action="OperazioniUser">
            <center>
                <table border="1" width="30%" cellpadding="5">
                    <thead>
                        <tr>
                            <th colspan="2">Inserisci le informazioni del libro</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="2"><b>Dati libro</b></td>
                        </tr>
                        <tr>
                            <td>Titolo:</td>
                            <td><input type="text" name="titolo" value="" ></td>
                        </tr>
                        <tr>
                            <td>Nome autore:</td>
                            <td><input type="text" name="nomeAutore" value="" ></td>
                        </tr>
                        <tr>
                            <td>Cognome autore:</td>
                            <td><input type="text" name="cognomeAutore" value="" ></td>
                        </tr>
                        <tr>
                            <td>Casa editrice:</td>
                            <td><input type="text" name="casaEd" value="" ></td>
                        </tr>
                        
                        <tr>
                            <td>Genere:</td>
                            <td><input type="text" name="genere" value="" ></td>
                        </tr>
                        
                        <tr>
                            <td>Anno pubblicazione:</td>
                            <td><input type="text" name="annoPubblicazione" value="" ></td>
                        </tr>
                        
                        <tr>
                            <td>Numero pagine:</td>
                            <td><input type="text" name="numeroPagine" value="" ></td>
                        </tr>
                        
                    </tbody>
                </table>
            </center>
        </form>
        
    </body>
</html>
