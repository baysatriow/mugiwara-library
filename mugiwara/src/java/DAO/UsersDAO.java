package DAO;

/**
 *
 * @author bayus
 */

import Models.Users;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
public class UsersDAO extends Models<Users> {
    
    public UsersDAO() {
        this.table = "users";
        this.primaryKey = "user_id";
    }
    
    @Override
    Users toModel(ResultSet rs) {
        Users user = new Users();
        try {
            user.setUserId(rs.getString("user_id"));
            user.setUsername(rs.getString("username"));
            user.setEmail(rs.getString("email"));
            user.setPassword(rs.getString("password"));
            user.setFullName(rs.getString("full_name"));
            user.setGender(rs.getString("gender"));
            user.setBirthDate(rs.getDate("birth_date"));
            user.setRoleId(rs.getInt("role_id"));
            user.setImagePath(rs.getString("image_path"));
            user.setLogin(rs.getInt("login"));
        } catch (SQLException e) {
            setMessage("Error mapping Users: " + e.getMessage());
        }
        return user;
    }
    
    // Custom methods for Users operations
    public Users findByEmail(String email) {
        this.where("email = '" + email + "'");
        ArrayList<Users> users = this.get();
        return users.isEmpty() ? null : users.get(0);
    }
    
    public Users findByUsername(String username) {
        this.where("username = '" + username + "'");
        ArrayList<Users> users = this.get();
        return users.isEmpty() ? null : users.get(0);
    }
    
    public ArrayList<Users> findByRoleId(int roleId) {
        this.where("role_id = " + roleId);
        return this.get();
    }
    
    public boolean validateLogin(String email, String password) {
        this.where("email = '" + email + "' AND password = '" + password + "'");
        ArrayList<Users> users = this.get();
        return !users.isEmpty();
    }
    
    public ArrayList<Users> searchUsers(String keyword) {
        this.where("username LIKE '%" + keyword + "%' OR email LIKE '%" + keyword + "%' OR full_name LIKE '%" + keyword + "%'");
        return this.get();
    }

    // Add method to get combined admin and staff data
    public ArrayList<ArrayList<Object>> getAdminAndStaffData() {
        String query = "SELECT u.user_id, u.username, u.email, u.full_name, u.gender, " +
                      "u.role_id, ur.role_name, u.birth_date " +
                      "FROM users u " +
                      "JOIN user_role ur ON u.role_id = ur.role_id " +
                      "WHERE u.role_id IN (1, 2) " + // Admin and Staff
                      "ORDER BY u.role_id, u.username";
        return this.query(query);
    }
}
