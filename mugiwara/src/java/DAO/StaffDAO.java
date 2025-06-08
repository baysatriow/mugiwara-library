package DAO;

/**
 *
 * @author bayus
 */

import Models.Staff;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class StaffDAO extends Models<Staff> {
    
    public StaffDAO() {
        this.table = "staff";
        this.primaryKey = "staffId";
    }
    
    @Override
    Staff toModel(ResultSet rs) {
        Staff staff = new Staff();
        try {
            staff.setStaffId(rs.getString("staffId"));
            staff.setStaffName(rs.getString("staffName"));
            staff.setEmail(rs.getString("email"));
            staff.setPhone(rs.getString("phone"));
            staff.setPosition(rs.getString("position"));
            staff.setPassword(rs.getString("password"));
        } catch (SQLException e) {
            setMessage("Error mapping Staff: " + e.getMessage());
        }
        return staff;
    }
    
    // Custom methods for Staff operations
    public Staff findByEmail(String email) {
        this.where("email = '" + email + "'");
        ArrayList<Staff> staffList = this.get();
        return staffList.isEmpty() ? null : staffList.get(0);
    }
    
    public ArrayList<Staff> findByPosition(String position) {
        this.where("position = '" + position + "'");
        return this.get();
    }
    
    public boolean validateStaffLogin(String email, String password) {
        this.where("email = '" + email + "' AND password = '" + password + "'");
        ArrayList<Staff> staffList = this.get();
        return !staffList.isEmpty();
    }
    
    public ArrayList<Staff> searchStaff(String keyword) {
        this.where("staffName LIKE '%" + keyword + "%' OR email LIKE '%" + keyword + "%' OR position LIKE '%" + keyword + "%'");
        return this.get();
    }
    
    // Staff specific database operations
    public ArrayList<ArrayList<Object>> getStaffPerformance(String staffId) {
        String query = "SELECT s.staffName, s.position, COUNT(o.orderId) as orders_processed, " +
                      "AVG(r.rating) as avg_rating " +
                      "FROM staff s " +
                      "LEFT JOIN orders o ON s.staffId = o.processedBy " +
                      "LEFT JOIN reviews r ON o.orderId = r.orderId " +
                      "WHERE s.staffId = '" + staffId + "' " +
                      "GROUP BY s.staffId";
        return this.query(query);
    }
    
    public ArrayList<ArrayList<Object>> getStaffWorkload() {
        String query = "SELECT s.staffName, s.position, COUNT(o.orderId) as current_orders " +
                      "FROM staff s " +
                      "LEFT JOIN orders o ON s.staffId = o.processedBy AND o.status IN ('PENDING', 'PROCESSING') " +
                      "GROUP BY s.staffId " +
                      "ORDER BY current_orders DESC";
        return this.query(query);
    }
}
