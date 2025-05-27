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
import java.util.List;

public class Admin extends Users {
    
    public Admin() {
        super();
    }
    
    public Admin(String username, String email, String password, String fullName, 
                String gender, Date birthDate, UserRole role, String imagePath) {
        super(username, email, password, fullName, gender, birthDate, role, imagePath);
    }
    
//    // Methods
//    public void addBook(Book book) {
//        // Implementation for adding a book
//    }
//    
//    public void removeBook(Book book) {
//        // Implementation for removing a book
//    }
//    
//    public void updateBook(Book book) {
//        // Implementation for updating a book
//    }
//    
    public void addUser(Users user) {
        // Implementation for adding a user
    }
    
    public void removeUser(Users user) {
        // Implementation for removing a user
    }
    
    public void updateUser(Users user) {
        // Implementation for updating a user
    }
    
    public void viewAllUsers() {
        // Implementation for viewing all users
    }
    
    public void viewAllOrders() {
        // Implementation for viewing all orders
    }
    
//    public void generateReport(ReportType reportType) {
//        // Implementation for generating a report
//    }
//    
//    public void processOrder(Order order) {
//        // Implementation for processing an order
//    }
//    
//    public void updateStoreSetting(StoreSetting storeSetting) {
//        // Implementation for updating store settings
//    }
    
    public void setImagePath(String imagePath) {
        super.setImagePath(imagePath);
    }
    
    public void setLogoutPath(String logoutPath) {
        // Implementation for setting logout path
    }
}
