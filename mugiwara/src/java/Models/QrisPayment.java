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

public class QrisPayment extends PaymentMethod {
    private String qrisCode;
    
    public QrisPayment() {
        super();
    }
    
    public QrisPayment(int paymentId, String paymentCode, String paymentStatus, 
                      LocalDateTime dateTime, String status, String imagePath, 
                      String qrisCode) {
        super(paymentId, paymentCode, paymentStatus, dateTime, status, imagePath);
        this.qrisCode = qrisCode;
    }
    
    // Getters and Setters
    public String getQrisCode() {
        return qrisCode;
    }
    
    public void setQrisCode(String qrisCode) {
        this.qrisCode = qrisCode;
    }
    
    @Override
    public boolean processPayment() {
        // Implementation for QRIS payment processing
        System.out.println("Processing QRIS payment with code: " + qrisCode);
        return true;
    }
    
    public String generateQRISCode() {
        // Implementation to generate QRIS code
        return "QRIS-" + System.currentTimeMillis();
    }
}
