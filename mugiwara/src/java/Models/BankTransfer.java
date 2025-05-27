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

public class BankTransfer extends PaymentMethod {
    private String bankName;
    private String accountNumber;
    private String accName;
    private String paymentCode;
    
    public BankTransfer() {
        super();
    }
    
    public BankTransfer(int paymentId, String paymentCode, String paymentStatus, 
                        LocalDateTime dateTime, String status, String imagePath,
                        String bankName, String accountNumber, String accName) {
        super(paymentId, paymentCode, paymentStatus, dateTime, status, imagePath);
        this.bankName = bankName;
        this.accountNumber = accountNumber;
        this.accName = accName;
        this.paymentCode = paymentCode;
    }
    
    // Getters and Setters
    public String getBankName() {
        return bankName;
    }
    
    public void setBankName(String bankName) {
        this.bankName = bankName;
    }
    
    public String getAccountNumber() {
        return accountNumber;
    }
    
    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }
    
    public String getAccName() {
        return accName;
    }
    
    public void setAccName(String accName) {
        this.accName = accName;
    }
    
    @Override
    public String getPaymentCode() {
        return paymentCode;
    }
    
    @Override
    public void setPaymentCode(String paymentCode) {
        this.paymentCode = paymentCode;
    }
    
    @Override
    public boolean processPayment() {
        // Implementation for bank transfer payment processing
        System.out.println("Processing bank transfer to " + bankName + ", Account: " + accountNumber);
        return true;
    }
    
    public boolean verifyBankAccount() {
        // Implementation to verify bank account
        return true;
    }
    
    public String generatePaymentCode() {
        // Implementation to generate payment code for bank transfer
        return "BT-" + System.currentTimeMillis();
    }
}
