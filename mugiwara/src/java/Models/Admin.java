/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author bayus
 */

import java.util.List;

public class Admin extends Users {
    
    public Admin() {
        super();
        this.roleId = UserRoles.ADMIN;
    }
    
    public Admin(String username, String email, String password) {
        super(username, email, password);
        this.roleId = UserRoles.ADMIN;
    }
    
    // Admin specific methods
    public void addStaff() {
        // Add staff logic
    }
    
    public void updateStaff() {
        // Update staff logic
    }
    
    public List<Object> viewStaffList() {
        // View staff list logic
        return null;
    }
    
    public void viewSalesReport() {
        // View sales report logic
    }
    
    public void viewStockReport() {
        // View stock report logic
    }
    
    public void viewDashboard() {
        // View dashboard logic
    }
    
    public void addBook() {
        // Add book logic
    }
    
    public void updateBook() {
        // Update book logic
    }
    
    public void removeBook() {
        // Remove book logic
    }
}
