
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ADMIN LOGIN</title>
    </head>
    <body>
        Benvenuto nella pagina di amministrazione di Book Borrow
        <div>
            
            //da rivedere... ricorda idea radio button
            <form action="OperazioniAdmin" method="POST">
                <table>
                    <tr>					
                        <td> 
                            <input type="submit" value="Elimina utenti" name="EliminaUtenti" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" value="Gestisci libri" name="GesticiLibri" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Visualizza le statische globali di utilizzo di Book Borrow<input type="submit" value="qui" name="stat" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="submit" value="Logout" name="logout" />
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </body>
</html>
