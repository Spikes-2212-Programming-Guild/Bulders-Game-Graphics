package sql;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class GurnyStaff {

    private Connection conn;
    private PreparedStatement statement;

    public Connection getConn() {
        return conn;
    }

    /**
     * constructor - create object con ( Connection type) invoking from the
     * line: <jsp:useBean id="db" class = "jdbc.ForDataBase"/>
     */
    public GurnyStaff() {
        try {
            //we want use MySQL Connector
            Class.forName("com.mysql.jdbc.Driver").newInstance();

            //param #1 - The URL of the database : jdbc:mysql://127.0.0.1:3306/kvutza1
            // jdbc:mysql - protocol
            // 127.0.0.1 - IP	
            // 3306 - port number
            // kvutza1 - database name
            // param #2 -  default user of MySQLServer, name -root
            // param #3 - root password
            System.out.println("Starting connection to " + constants.DB_URL);
            conn = DriverManager.getConnection(constants.DB_URL, constants.USER, constants.PASS);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public PreparedStatement prepareStatement() {
        return statement;
    }

    public PreparedStatement prepareStatement(String sql) {
        if (statement == null) {
            try {
                statement = conn.prepareStatement(sql);
            } catch (SQLException ex) {
                Logger.getLogger(GurnyStaff.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return statement;
    }

    public PreparedStatement prepareSelectStatement(String sql) {
        if (statement == null) {
            try {
                statement = conn.prepareStatement(sql,
                        ResultSet.TYPE_SCROLL_INSENSITIVE,
                        ResultSet.CONCUR_UPDATABLE
                );
            } catch (SQLException ex) {
                Logger.getLogger(GurnyStaff.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return statement;
    }

    public int executeUpdate() {
        System.out.println("Running command: " + statement.toString());
        int num = 0;
        try {
            // Invoke sql command
            num = statement.executeUpdate();
            statement.close();
            statement = null;
            System.out.println("Command executed!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return num;
    }

    public String[][] executeSelect() {
        System.out.println("Running Select Command: " + statement.toString());
        String result[][] = null;
        try {
            // Invoke sql command and puts the result into ResultSet object - res
            ResultSet res = statement.executeQuery();
            // m- the column number
            int m = res.getMetaData().getColumnCount();
            // move the cursor to the last row
            res.last();
            // n- the number of the last row
            int n = res.getRow();
            // create the array
            result = new String[n][m];
            // move the cursor before the first line
            res.beforeFirst();
            // copy the data from resultset to the array
            int i = 0;
            while (res.next()) {

                for (int j = 0; j < m; j++) {
                    result[i][j] = res.getString(j + 1);
                }
                i++;
            }
            res.close();
            statement.close();
            statement = null;
            System.out.println("Command executed!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * This function performs one direction SQL commands and returns the number
     * of updated rows
     */
    public int insertUpdateDelete(String sql) {
        System.out.println("Running command: " + sql);
        int num = 0;
        try {
            // Create object st (Statement type) - help object for con
            Statement st = conn.createStatement();
            // Invoke sql command
            num = st.executeUpdate(sql);
            st.close();
            System.out.println("Command executed!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return num;
    }

    /**
     * This function performs Select SQL commands and returns the result array
     * of the data
     */
    public String[][] select(String sql) {
        System.out.println("Running Select Command: " + sql);
        String result[][] = null;
        try {
            // Create object st (Statement type) - help object for con
            Statement st = conn.createStatement(
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_UPDATABLE
            );
            // Invoke sql command and puts the result into ResultSet object - res
            ResultSet res = st.executeQuery(sql);
            // m- the column number
            int m = res.getMetaData().getColumnCount();
            // move the cursor to the last row
            res.last();
            // n- the number of the last row
            int n = res.getRow();
            // create the array
            result = new String[n][m];
            // move the cursor before the first line
            res.beforeFirst();
            // copy the data from resultset to the array
            int i = 0;
            while (res.next()) {

                for (int j = 0; j < m; j++) {
                    result[i][j] = res.getString(j + 1);
                }
                i++;
            }
            res.close();
            st.close();
            System.out.println("Command executed!");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

}
