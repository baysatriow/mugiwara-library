/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author bayus
 */

import Models.Admin;
import Models.UserRoles;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AdminDAO extends Models<Admin> {
    
    public AdminDAO() {
        this.table = "users";
        this.primaryKey = "user_id";
    }
    
    @Override
    Admin toModel(ResultSet rs) {
        Admin admin = new Admin();
        try {
            admin.setUserId(rs.getString("user_id"));
            admin.setUsername(rs.getString("username"));
            admin.setEmail(rs.getString("email"));
            admin.setPassword(rs.getString("password"));
            admin.setFullName(rs.getString("full_name"));
            admin.setGender(rs.getString("gender"));
            admin.setBirthDate(rs.getDate("birth_date"));
            admin.setRoleId(UserRoles.ADMIN);
            admin.setImagePath(rs.getString("image_path"));
            admin.setLogin(rs.getInt("login"));
        } catch (SQLException e) {
            setMessage("Error mapping Admin: " + e.getMessage());
        }
        return admin;
    }
    
    // Custom methods for Admin operations
    public ArrayList<Admin> getAllAdmins() {
        this.where("role_id = " + UserRoles.ADMIN);
        return this.get();
    }
    
    public Admin findAdminByEmail(String email) {
        this.where("email = '" + email + "' AND role_id = " + UserRoles.ADMIN);
        ArrayList<Admin> admins = this.get();
        return admins.isEmpty() ? null : admins.get(0);
    }
    
    public boolean validateAdminLogin(String email, String password) {
        this.where("email = '" + email + "' AND password = '" + password + "' AND role_id = " + UserRoles.ADMIN);
        ArrayList<Admin> admins = this.get();
        return !admins.isEmpty();
    }
    
    // Admin specific database operations
    public ArrayList<ArrayList<Object>> getStaffReport() {
        String query = "SELECT u.*, COUNT(o.order_id) as total_orders " +
                      "FROM users u LEFT JOIN orders o ON u.user_id = o.staff_id " +
                      "WHERE u.role_id = " + UserRoles.STAFF + " GROUP BY u.user_id";
        return this.query(query);
    }
    
    public ArrayList<ArrayList<Object>> getSalesReport() {
        String query = "SELECT DATE(o.order_date) as date, COUNT(*) as total_orders, " +
                      "SUM(o.total_amount) as total_sales FROM orders o " +
                      "GROUP BY DATE(o.order_date) ORDER BY date DESC";
        return this.query(query);
    }
    
    public ArrayList<ArrayList<Object>> getStockReport() {
        String query = "SELECT b.title, b.stock, b.price, " +
                      "CASE WHEN b.stock < 10 THEN 'Low Stock' ELSE 'Normal' END as status " +
                      "FROM books b ORDER BY b.stock ASC";
        return this.query(query);
    }
}
