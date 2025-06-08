/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author bayus
 */

public class Staff {
    private String staffId;
    private String staffName;
    private String email;
    private String phone;
    private String position;
    private String password;
    
    public Staff() {}
    
    public Staff(String staffName, String email, String phone) {
        this.staffName = staffName;
        this.email = email;
        this.phone = phone;
    }
    
    // Staff specific methods
    public void updateProfile() {
        // Update profile logic
    }
    
    public void processOrder(Object order) {
        // Process order logic
    }
    
    // Getters and Setters
    public String getStaffId() { return staffId; }
    public void setStaffId(String staffId) { this.staffId = staffId; }
    
    public String getStaffName() { return staffName; }
    public void setStaffName(String staffName) { this.staffName = staffName; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
