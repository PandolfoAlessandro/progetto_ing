
package it.database;

import java.sql.ResultSet;

/**
 *
 * @author alessandro
 */
public interface QueryExec {
    public void setParameters(Object ... obj);
    public ResultSet getResult();
}