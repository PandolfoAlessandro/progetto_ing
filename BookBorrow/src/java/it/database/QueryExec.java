
package it.database;

import java.sql.ResultSet;

/**
 *
 * @author alessandro
 */
public interface QueryExec {
    public void setPrameters(Object ... obj);
    public ResultSet getResult();
}
