package DAO;

import Config.DBConnection;
import Models.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private DBConnection dbConnection;
    
    // Constructor
    public UserDAO() {
        dbConnection = new DBConnection();
    }
    
    // Create (Tambah User Baru)
    public boolean insertUser(User user) {
        boolean result = false;
        try {
            Connection conn = dbConnection.getConnection();
            String sql = "INSERT INTO users (username, email, password, full_name, role, created_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?)";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getFullName());
            pstmt.setInt(5, user.getRole());
            pstmt.setTimestamp(6, new Timestamp(System.currentTimeMillis()));
            
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
            }
            
            pstmt.close();
        } catch (Exception e) {
            System.out.println("Error in insertUser: " + e.getMessage());
        }
        return result;
    }
    
    // Read (Ambil Semua User)
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        try {
            Connection conn = dbConnection.getConnection();
            Statement stmt = conn.createStatement();
            String sql = "SELECT * FROM users";
            
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getInt("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
                
                userList.add(user);
            }
            rs.close();
            stmt.close();
        } catch (Exception e) {
            System.out.println("Error in getAllUsers: " + e.getMessage());
        }
        return userList;
    }
    
    // Read (Ambil User Berdasarkan ID)
    public User getUserById(int id) {
        User user = null;
        try {
            Connection conn = dbConnection.getConnection();
            String sql = "SELECT * FROM users WHERE user_id = ?";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getInt("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println("Error in getUserById: " + e.getMessage());
        }
        return user;
    }
    
    // Read (Cari User Berdasarkan Username)
    public User getUserByUsername(String username) {
        User user = null;
        try {
            Connection conn = dbConnection.getConnection();
            String sql = "SELECT * FROM users WHERE username = ?";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getInt("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println("Error in getUserByUsername: " + e.getMessage());
        }
        return user;
    }
    
    // Update User
    public boolean updateUser(User user) {
        boolean result = false;
        try {
            Connection conn = dbConnection.getConnection();
            String sql = "UPDATE users SET username = ?, email = ?, password = ?, " +
                         "full_name = ?, role = ?, updated_at = ? " +
                         "WHERE user_id = ?";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getFullName());
            pstmt.setInt(5, user.getRole());
            pstmt.setTimestamp(7, new Timestamp(System.currentTimeMillis()));
            pstmt.setInt(8, user.getId());
            
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
            }
            
            pstmt.close();
        } catch (Exception e) {
            System.out.println("Error in updateUser: " + e.getMessage());
        }
        return result;
    }
    
    // Delete User
    public boolean deleteUser(int id) {
        boolean result = false;
        try {
            Connection conn = dbConnection.getConnection();
            String sql = "DELETE FROM users WHERE user_id = ?";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                result = true;
            }
            
            pstmt.close();
        } catch (Exception e) {
            System.out.println("Error in deleteUser: " + e.getMessage());
        }
        return result;
    }
    
    // Metode Login
    public User login(String username, String password) {
        User user = null;
        try {
            Connection conn = dbConnection.getConnection();
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setRole(rs.getInt("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
            rs.close();
            pstmt.close();
        } catch (Exception e) {
            System.out.println("Error in login: " + e.getMessage());
        }
        return user;
    }
    
    // Menutup koneksi database
    public void closeConnection() {
        dbConnection.closeConnection();
    }
}