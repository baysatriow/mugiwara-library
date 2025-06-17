package DAO;

import Models.Customer;
import Models.Users;
import Models.UserRoles;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class ProfileDAO extends Models<Customer> {
    
    public ProfileDAO() {
        this.table = "users u LEFT JOIN customer c ON u.user_id = c.user_id";
        this.primaryKey = "u.user_id";
    }
    
    @Override
    Customer toModel(ResultSet rs) {
        try {
            Customer customer = new Customer();
            
            // Data dari tabel users
            customer.setUserId(rs.getInt("user_id"));
            customer.setUsername(rs.getString("username"));
            customer.setEmail(rs.getString("email"));
            customer.setPassword(rs.getString("password"));
            customer.setFullName(rs.getString("full_name"));
            customer.setGender(rs.getString("gender"));
            customer.setBirthDate(rs.getDate("birth_date"));
            customer.setImagePath(rs.getString("image_path"));
            customer.setLogin(rs.getBoolean("login"));
            
            // Set role
            int roleId = rs.getInt("role_id");
            customer.setRoleById(roleId);
            
            // Data dari tabel customer
            customer.setPhone(rs.getString("phone"));
            
            return customer;
        } catch (SQLException e) {
            setMessage("Error converting ResultSet to Customer: " + e.getMessage());
            return null;
        }
    }
    
    public Customer getCustomerProfile(int userId) {
        this.where("u.user_id = " + userId + " AND u.role_id = 3");
        ArrayList<Customer> results = this.get();
        
        if (!results.isEmpty()) {
            return results.get(0);
        }
        return null;
    }
    
    public boolean updateProfile(int userId, String fullName, String gender, 
                               java.sql.Date birthDate, String phone) {
        try {
            this.connect();
            
            // Update tabel users
            String updateUsersQuery = "UPDATE users SET " +
                                    "full_name = '" + fullName.replace("'", "''") + "', " +
                                    "gender = '" + gender + "', " +
                                    "birth_date = '" + birthDate + "' " +
                                    "WHERE user_id = " + userId;
            
            int usersResult = this.stmt.executeUpdate(updateUsersQuery);
            
            // Update atau insert ke tabel customer
            String checkCustomerQuery = "SELECT COUNT(*) FROM customer WHERE user_id = " + userId;
            ResultSet rs = this.stmt.executeQuery(checkCustomerQuery);
            rs.next();
            int customerExists = rs.getInt(1);
            
            int customerResult = 0;
            if (customerExists > 0) {
                // Update existing customer record
                String updateCustomerQuery = "UPDATE customer SET " +
                                           "phone = '" + phone + "' " +
                                           "WHERE user_id = " + userId;
                customerResult = this.stmt.executeUpdate(updateCustomerQuery);
            } else {
                // Insert new customer record
                String insertCustomerQuery = "INSERT INTO customer (user_id, phone) " +
                                           "VALUES (" + userId + ", '" + phone + "')";
                customerResult = this.stmt.executeUpdate(insertCustomerQuery);
            }
            
            this.disconnect();
            
            return usersResult > 0 && customerResult > 0;
        } catch (SQLException e) {
            setMessage("Error updating profile: " + e.getMessage());
            return false;
        }
    }
    
    public boolean changePassword(int userId, String currentPassword, String newPassword) {
        try {
            this.connect();
            
            // Verify current password
            String checkPasswordQuery = "SELECT password FROM users WHERE user_id = " + userId;
            ResultSet rs = this.stmt.executeQuery(checkPasswordQuery);
            
            if (!rs.next()) {
                setMessage("User not found");
                this.disconnect();
                return false;
            }
            
            String storedPassword = rs.getString("password");
            String hashedCurrentPassword = hashPassword(currentPassword);
            
            if (!storedPassword.equals(hashedCurrentPassword)) {
                setMessage("Current password is incorrect");
                this.disconnect();
                return false;
            }
            
            // Update with new password
            String hashedNewPassword = hashPassword(newPassword);
            String updatePasswordQuery = "UPDATE users SET password = '" + hashedNewPassword + "' " +
                                       "WHERE user_id = " + userId;
            
            int result = this.stmt.executeUpdate(updatePasswordQuery);
            this.disconnect();
            
            return result > 0;
        } catch (SQLException e) {
            setMessage("Error changing password: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateProfileImage(int userId, String imagePath) {
        try {
            this.connect();
            
            String updateQuery = "UPDATE users SET image_path = '" + imagePath + "' " +
                               "WHERE user_id = " + userId;
            
            int result = this.stmt.executeUpdate(updateQuery);
            this.disconnect();
            
            return result > 0;
        } catch (SQLException e) {
            setMessage("Error updating profile image: " + e.getMessage());
            return false;
        }
    }
    
    public boolean isEmailExists(String email, int excludeUserId) {
        try {
            this.connect();
            
            String query = "SELECT COUNT(*) FROM users WHERE email = '" + email + "'";
            if (excludeUserId > 0) {
                query += " AND user_id != " + excludeUserId;
            }
            
            ResultSet rs = this.stmt.executeQuery(query);
            rs.next();
            int count = rs.getInt(1);
            
            this.disconnect();
            return count > 0;
        } catch (SQLException e) {
            setMessage("Error checking email existence: " + e.getMessage());
            return false;
        }
    }
    
    public boolean isUsernameExists(String username, int excludeUserId) {
        try {
            this.connect();
            
            String query = "SELECT COUNT(*) FROM users WHERE username = '" + username + "'";
            if (excludeUserId > 0) {
                query += " AND user_id != " + excludeUserId;
            }
            
            ResultSet rs = this.stmt.executeQuery(query);
            rs.next();
            int count = rs.getInt(1);
            
            this.disconnect();
            return count > 0;
        } catch (SQLException e) {
            setMessage("Error checking username existence: " + e.getMessage());
            return false;
        }
    }
    
    // Helper method untuk hash password
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            setMessage("Error hashing password: " + e.getMessage());
            return password; // Fallback, tidak direkomendasikan untuk production
        }
    }
    
    // Method untuk validasi password strength
    public boolean isValidPassword(String password) {
        if (password == null || password.length() < 6) {
            return false;
        }
        
        boolean hasLetter = false;
        boolean hasDigit = false;
        
        for (char c : password.toCharArray()) {
            if (Character.isLetter(c)) {
                hasLetter = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            }
        }
        
        return hasLetter && hasDigit;
    }
}