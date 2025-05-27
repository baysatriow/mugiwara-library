/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author bayus
 */

import java.util.Date;

public class Staff extends Users {
    private String position;
    
    public Staff() {
        super();
    }
    
    public Staff(String username, String email, String password, String fullName, 
                String gender, Date birthDate, UserRole role, String imagePath,
                String position) {
        super(username, email, password, fullName, gender, birthDate, role, imagePath);
        this.position = position;
    }
    
    // Getters and Setters
    public String getPosition() {
        return position;
    }
    
    public void setPosition(String position) {
        this.position = position;
    }
    
    // Methods
    public void viewAllOrders() {
        // Implementation for viewing all orders
    }
    
    public void viewUserManagement() {
        // Implementation for viewing user management
    }
    
    public void viewStoreManagement() {
        // Implementation for viewing store management
    }
    
    public void viewAnalyticsAndReport() {
        // Implementation for viewing analytics and reports
    }
    
    public void updateProfile() {
        // Implementation for updating profile
        super.updateProfile();
    }
    
//    public void processOrder(Order order) {
//        // Implementation for processing an order
//    }
//    
//    public void generateReport(ReportType reportType) {
//        // Implementation for generating a report
//    }
//    
    public void verifyBankAccount(BankTransfer bankTransfer) {
        // Implementation for verifying bank account
    }
}
