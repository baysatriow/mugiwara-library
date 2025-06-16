package Models;

public class Order {
    private Customer customer;
    private double total;
    private String status;
    private Payment payment;
    private Shipment shipment;
    private Staff processedBy;

    
    public Order() {}
    
    public Order(Customer customer, double total, String status, Payment payment, Shipment shipment, Staff processedBy) {
        this.customer = customer;
        this.total = total;
        this.status = status;
        this.payment = payment;
        this.shipment = shipment;
        this.processedBy = processedBy;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public Shipment getShipment() {
        return shipment;
    }

    public void setShipment(Shipment shipment) {
        this.shipment = shipment;
    }

    public Staff getProcessedBy() {
        return processedBy;
    }

    public void setProcessedBy(Staff processedBy) {
        this.processedBy = processedBy;
    }

}
