package Config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author bayus
 */
public class DBConnection_BCKP {

    private Connection con;
    private Statement stmt;
    private boolean isConnected;
    private String message;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/mugiwara_l";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    public DBConnection_BCKP() {
        this.isConnected = false;
        this.message = "Koneksi belum diinisialisasi.";
        // Buat Saya Debug apakah Library nya berhasil di import atau tidak
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            this.message = "MySQL JDBC Driver tidak ditemukan. Pastikan sudah ditambahkan ke Libraries. Error: " + e.getMessage();
            System.err.println(this.message);
        }
    }

    // Koneksi Ke Database
    public void connect() {
        try {
            // Class.forName sudah saya panggil di Constructor
            con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            stmt = con.createStatement();
            isConnected = true;
            message = "Koneksi ke database berhasil!";
            System.out.println(message);
        } catch (SQLException e) {
            isConnected = false;
            message = "Koneksi ke database gagal: " + e.getMessage();
            System.err.println(message);
            e.printStackTrace();
        }
    }

    // Tutup Koneksi Ke Database
    public void disconnect() {
        try {
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
            isConnected = false;
            message = "Koneksi ke database ditutup.";
            System.out.println(message);
        } catch (SQLException e) {
            message = "Gagal menutup koneksi: " + e.getMessage();
            System.err.println(message);
        }
    }

    public void runQuery(String query) {
        // Cek Koneksi, Kalau belum konek maka konekan 
        if (!isConnected) {
            connect();
        }
        if (isConnected) {
            try {
                int result = stmt.executeUpdate(query);
                message = "Query berhasil dijalankan. " + result + " baris terpengaruh.";
                System.out.println(message + " Query: " + query);
            } catch (SQLException e) {
                message = "Gagal menjalankan query: " + e.getMessage() + ". Query: " + query;
                System.err.println(message);
            } finally {
                disconnect();
            }
        } else {
            message = "Tidak dapat menjalankan query, koneksi database gagal.";
            System.err.println(message);
        }
    }

    public ResultSet getData(String query) {
        ResultSet rs = null;
        // Cek Koneksi, Kalau belum konek maka konekan 
        if (!isConnected) {
            connect();
        }
        if (isConnected) {
            try {
                rs = stmt.executeQuery(query);
                message = "Data berhasil diambil.";
                System.out.println(message + " Query: " + query);
            } catch (SQLException e) {
                message = "Gagal mengambil data: " + e.getMessage() + ". Query: " + query;
                System.err.println(message);
            }
        } else {
            message = "Tidak dapat mengambil data, koneksi database gagal.";
            System.err.println(message);
        }
        return rs;
    }

    public String getMessage() {
        return message;
    }

    public boolean isConnected() {
        return isConnected;
    }
}
