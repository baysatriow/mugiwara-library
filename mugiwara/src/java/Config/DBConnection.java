package Config;

import java.sql.Connection;
import java.sql.Statement;
import java.sql.DriverManager;

/**
 *
 * @author bayus
 */
public class DBConnection {
    private Connection con;
    private Statement stmt;
    private boolean isConnected;
    private String message;

    // Constructor
    public DBConnection() {
        this.connect();
    }

    // Metode untuk membuat koneksi ke database
    private void connect() {
        String db_name = "mugiwara_library";
        String username = "root";
        String password = "";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + db_name, username, password);
            stmt = con.createStatement();
            isConnected = true;
            message = "Database Terkoneksi";
        } catch (Exception e) {
            isConnected = false;
            message = e.getMessage();
        }
    }

    // Getter untuk mendapatkan objek Connection
    public Connection getConnection() {
        return con;
    }

    // Getter untuk mendapatkan objek Statement
    public Statement getStatement() {
        return stmt;
    }

    // Getter untuk status koneksi
    public boolean isConnected() {
        return isConnected;
    }

    // Getter untuk pesan
    public String getMessage() {
        return message;
    }

    // Metode untuk menutup koneksi
    public void closeConnection() {
        try {
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
            isConnected = false;
            message = "Database Disconnected";
        } catch (Exception e) {
            message = e.getMessage();
        }
    }
}