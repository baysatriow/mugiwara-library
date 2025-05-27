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

public class Payment {
    private int paymentId;
    private Order order;
    private double amount;
    private LocalDateTime dateTime;
    private String status;
    private String imagePath;
    private PaymentMethod paymentMethod;
    
    public Payment() {
    }
    
    public Payment(int paymentId, Order order, double amount, LocalDateTime dateTime, 
                  String status, String imagePath, PaymentMethod paymentMethod) {
        this.paymentId = paymentId;
        this.order = order;
        this.amount = amount;
        this.dateTime = dateTime;
        this.status = status;
        this.imagePath = imagePath;
        this.paymentMethod = paymentMethod;
    }
    
    // Getters and Setters
    public int getPaymentId() {
        return paymentId;
    }
    
    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }
    
    public Order getOrder() {
        return order;
    }
    
    public void setOrder(Order order) {
        this.order = order;
    }
    
    public double getAmount() {
        return amount;
    }
    
    public void setAmount(double amount) {
        this.amount = amount;
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
    
    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }
    
    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    
    public boolean getStatus(String status) {
        return this.status.equals(status);
    }
    
    public void setPayment() {
        // Implementation for setting payment
    }
    
    public void editPayment() {
        // Implementation for editing payment
    }
    
    public void validatePayment() {
        // Implementation for validating payment
    }
}
