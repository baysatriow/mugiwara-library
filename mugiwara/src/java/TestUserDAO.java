import Config.DBConnection;
import DAO.UserDAO;
import Models.User;

import java.util.List;

public class TestUserDAO {
    
    public static void main(String[] args) {
        // Membuat instance UserDAO
        UserDAO userDAO = new UserDAO();
        
        // Tes koneksi database
        testConnection(userDAO);
        
        // Tes insert user
        testInsertUser(userDAO);
        
        // Tes ambil semua user
        testGetAllUsers(userDAO);
        
        // Tes ambil user berdasarkan ID
        testGetUserById(userDAO);
        
        // Tes ambil user berdasarkan username
        testGetUserByUsername(userDAO);
        
        // Tes update user
        testUpdateUser(userDAO);
        
        // Tes login
        testLogin(userDAO);
        
        // Tes delete user
        testDeleteUser(userDAO);
        
        // Tutup koneksi database
        userDAO.closeConnection();
        
        System.out.println("Semua tes selesai!");
    }
    
    private static void testConnection(UserDAO userDAO) {
        System.out.println("\n===== TES KONEKSI DATABASE =====");
        
        // Periksa apakah koneksi database berhasil
        if (userDAO != null) {
            System.out.println("UserDAO berhasil dibuat");
            
            // Mendapatkan informasi koneksi dari config
            Config.DBConnection dbConn = new Config.DBConnection();
            if (dbConn.isConnected()) {
                System.out.println("Status koneksi: " + (dbConn.isConnected() ? "Terhubung" : "Gagal terhubung"));
                System.out.println("Pesan: " + dbConn.getMessage());
            } else {
                System.out.println("KONEKSI DATABASE GAGAL!");
                System.out.println("Error message: " + dbConn.getMessage());
                System.out.println("\nPastikan:");
                System.out.println("1. MySQL server sudah berjalan");
                System.out.println("2. Database 'ecommerce' sudah dibuat");
                System.out.println("3. Username dan password database sudah benar");
                System.out.println("4. Port 3306 tidak diblokir atau diubah");
                
                // Hentikan eksekusi jika koneksi gagal
                System.exit(1);
            }
        } else {
            System.out.println("UserDAO gagal dibuat");
            System.exit(1);
        }
    }
    
    private static void testInsertUser(UserDAO userDAO) {
        System.out.println("\n===== TES INSERT USER =====");
        
        // Membuat user baru
        User newUser = new User();
        newUser.setUsername("testuser");
        newUser.setEmail("testuser@example.com");
        newUser.setPassword("password123");
        newUser.setFullName("Test User");
        newUser.setRole(1);
        
        // Insert user
        boolean insertResult = userDAO.insertUser(newUser);
        System.out.println("Hasil insert user: " + (insertResult ? "Berhasil" : "Gagal"));
    }
    
    private static void testGetAllUsers(UserDAO userDAO) {
        System.out.println("\n===== TES GET ALL USERS =====");
        
        // Ambil semua user
        List<User> users = userDAO.getAllUsers();
        
        // Tampilkan semua user
        System.out.println("Jumlah user: " + users.size());
        for (User user : users) {
            System.out.println(user);
        }
    }
    
    private static void testGetUserById(UserDAO userDAO) {
        System.out.println("\n===== TES GET USER BY ID =====");
        
        // Ambil semua user terlebih dahulu untuk mendapatkan ID yang valid
        List<User> users = userDAO.getAllUsers();
        
        if (!users.isEmpty()) {
            // Ambil ID dari user pertama
            int userId = users.get(0).getId();
            
            // Ambil user berdasarkan ID
            User user = userDAO.getUserById(userId);
            
            if (user != null) {
                System.out.println("User ditemukan dengan ID " + userId + ": " + user);
            } else {
                System.out.println("User tidak ditemukan dengan ID " + userId);
            }
        } else {
            System.out.println("Tidak ada user dalam database untuk diuji");
        }
    }
    
    private static void testGetUserByUsername(UserDAO userDAO) {
        System.out.println("\n===== TES GET USER BY USERNAME =====");
        
        // Username yang akan dicari
        String username = "testuser";
        
        // Ambil user berdasarkan username
        User user = userDAO.getUserByUsername(username);
        
        if (user != null) {
            System.out.println("User ditemukan dengan username " + username + ": " + user);
        } else {
            System.out.println("User tidak ditemukan dengan username " + username);
        }
    }
    
    private static void testUpdateUser(UserDAO userDAO) {
        System.out.println("\n===== TES UPDATE USER =====");
        
        // Ambil user dengan username testuser
        User user = userDAO.getUserByUsername("testuser");
        
        if (user != null) {
            // Update data user
            System.out.println("Data user sebelum update: " + user);
            
            user.setFullName("Test User Updated");
            user.setEmail("updated@example.com");
            
            // Update user
            boolean updateResult = userDAO.updateUser(user);
            System.out.println("Hasil update user: " + (updateResult ? "Berhasil" : "Gagal"));
            
            // Ambil user lagi untuk memverifikasi perubahan
            User updatedUser = userDAO.getUserById(user.getId());
            System.out.println("Data user setelah update: " + updatedUser);
        } else {
            System.out.println("User dengan username testuser tidak ditemukan untuk diupdate");
        }
    }
    
    private static void testLogin(UserDAO userDAO) {
        System.out.println("\n===== TES LOGIN =====");
        
        // Username dan password untuk login
        String username = "testuser";
        String password = "password123";
        
        // Tes login
        User loggedInUser = userDAO.login(username, password);
        
        if (loggedInUser != null) {
            System.out.println("Login berhasil untuk user: " + loggedInUser);
        } else {
            System.out.println("Login gagal dengan username: " + username);
        }
        
        // Tes login dengan password salah
        String wrongPassword = "wrongpassword";
        User failedLogin = userDAO.login(username, wrongPassword);
        
        if (failedLogin != null) {
            System.out.println("Login tidak seharusnya berhasil dengan password salah");
        } else {
            System.out.println("Login gagal dengan password salah (sesuai harapan)");
        }
    }
    
    private static void testDeleteUser(UserDAO userDAO) {
        System.out.println("\n===== TES DELETE USER =====");
        
        // Ambil user dengan username testuser
        User user = userDAO.getUserByUsername("testuser");
        
        if (user != null) {
            int userId = user.getId();
            
            // Delete user
            boolean deleteResult = userDAO.deleteUser(userId);
            System.out.println("Hasil delete user dengan ID " + userId + ": " + (deleteResult ? "Berhasil" : "Gagal"));
            
            // Verifikasi user telah dihapus
            User deletedUser = userDAO.getUserById(userId);
            if (deletedUser == null) {
                System.out.println("User berhasil dihapus dari database");
            } else {
                System.out.println("User masih ada dalam database meskipun telah dihapus");
            }
        } else {
            System.out.println("User dengan username testuser tidak ditemukan untuk dihapus");
        }
    }
}