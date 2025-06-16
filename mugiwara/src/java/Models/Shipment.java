package Models;

import java.sql.Date;

public class Shipment {
    private Order order;
    private String trackingNumber;
    private String status;
    private ShippingMethod shippingMethod;
    private Date estimated;
    private String Address;
    private double total;

    public Shipment(Order order, String trackingNumber, String status, ShippingMethod shippingMethod, Date estimated, String Address, double total) {
        this.order = order;
        this.trackingNumber = trackingNumber;
        this.status = status;
        this.shippingMethod = shippingMethod;
        this.estimated = estimated;
        this.Address = Address;
        this.total = total;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public String getTrackingNumber() {
        return trackingNumber;
    }

    public void setTrackingNumber(String trackingNumber) {
        this.trackingNumber = trackingNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public ShippingMethod getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(ShippingMethod shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    public Date getEstimated() {
        return estimated;
    }

    public void setEstimated(Date estimated) {
        this.estimated = estimated;
    }

    public String getAddress() {
        return Address;
    }

    public void setAddress(String Address) {
        this.Address = Address;
    }

    public double getCost() {
        return total;
    }

    public void setCost(double total) {
        this.total = total;
    }
    
    
}
