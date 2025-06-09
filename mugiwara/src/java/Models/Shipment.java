package Models;

import java.sql.Date;

public class Shipment {
    // Field names must match database column names for DAO.Models<E> generic methods
    private int shipment_id;
    private int shipping_method_id; // Foreign key
    private Date estimated_date;
    private String address;
    private double cost;

    // These fields are not in the 'mugiwara_l_shipment' table based on the screenshot.
    // If they are added to the DB, they can be used. Otherwise, they'll cause issues with generic insert/update.
    // private int order_id; 
    // private String tracking_number;
    // private String status;

    // This is for the object relationship, populated by DAO, not directly by generic methods
    private ShippingMethod shippingMethodObj;

    // Constructors
    public Shipment() {
    }

    public Shipment(int shipping_method_id, Date estimated_date, String address, double cost) {
        this.shipping_method_id = shipping_method_id;
        this.estimated_date = estimated_date;
        this.address = address;
        this.cost = cost;
    }

    public Shipment(int shipment_id, int shipping_method_id, Date estimated_date, String address, double cost) {
        this.shipment_id = shipment_id;
        this.shipping_method_id = shipping_method_id;
        this.estimated_date = estimated_date;
        this.address = address;
        this.cost = cost;
    }


    // Getters and Setters
    public int getShipment_id() {
        return shipment_id;
    }

    public void setShipment_id(int shipment_id) {
        this.shipment_id = shipment_id;
    }

    public int getShipping_method_id() {
        return shipping_method_id;
    }

    public void setShipping_method_id(int shipping_method_id) {
        this.shipping_method_id = shipping_method_id;
    }

    public Date getEstimated_date() {
        return estimated_date;
    }

    public void setEstimated_date(Date estimated_date) {
        this.estimated_date = estimated_date;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public ShippingMethod getShippingMethodObj() {
        return shippingMethodObj;
    }

    public void setShippingMethodObj(ShippingMethod shippingMethodObj) {
        this.shippingMethodObj = shippingMethodObj;
    }

    // public int getOrder_id() { return order_id; }
    // public void setOrder_id(int order_id) { this.order_id = order_id; }
    // public String getTracking_number() { return tracking_number; }
    // public void setTracking_number(String tracking_number) { this.tracking_number = tracking_number; }
    // public String getStatus() { return status; }
    // public void setStatus(String status) { this.status = status; }

    @Override
    public String toString() {
        return "Shipment{" +
               "shipment_id=" + shipment_id +
               ", shipping_method_id=" + shipping_method_id +
               ", estimated_date=" + estimated_date +
               ", address='" + address + '\'' +
               ", cost=" + cost +
               ", shippingMethodObj=" + (shippingMethodObj != null ? shippingMethodObj.getName() : "N/A") +
               '}';
    }
}
