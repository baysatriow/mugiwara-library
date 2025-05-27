/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author bayus
 */

import java.time.LocalDateTime;

public abstract class PaymentMethod {
    private int paymentId;
    private String paymentCode;
    private String paymentStatus;
    private LocalDateTime dateTime;
    private String status;
    private String imagePath;
    
    public PaymentMethod() {
    }
    
    public PaymentMethod(int paymentId, String paymentCode, String paymentStatus, 
                         LocalDateTime dateTime, String status, String imagePath) {
        this.paymentId = paymentId;
        this.paymentCode = paymentCode;
        this.paymentStatus = paymentStatus;
        this.dateTime = dateTime;
        this.status = status;
        this.imagePath = imagePath;
    }
    
    // Abstract method to be implemented by subclasses
    public abstract boolean processPayment();
    
    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }
    
    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }
    
    public String getPaymentCode() {
        return paymentCode;
    }
    
    public void setPaymentCode(String paymentCode) {
        this.paymentCode = paymentCode;
    }
    
    public String getPaymentStatus() {
        return paymentStatus;
    }
    
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    
    public LocalDateTime getDateTime() {
        return dateTime;
    }
    
    public void setDateTime(LocalDateTime dateTime) {
        this.dateTime = dateTime;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getImagePath() {
        return imagePath;
    }
    
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    public boolean validatePayment() {
        // Implementation for payment validation
        return true;
    }
}
