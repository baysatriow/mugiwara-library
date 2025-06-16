package Models;

/**
 *
 * @author bayus
 */

import java.time.LocalDateTime;

public class Payment {
    private Order order;
    private double amount;
    private LocalDateTime dateTime;
    private String status;
    private PaymentMethod paymentMethod;
    
    public Payment() {
    }
    
    public Payment(Order order, double amount, LocalDateTime dateTime, 
                  String status, String imagePath, PaymentMethod paymentMethod) {
        this.order = order;
        this.amount = amount;
        this.dateTime = dateTime;
        this.status = status;
        this.paymentMethod = paymentMethod;
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
