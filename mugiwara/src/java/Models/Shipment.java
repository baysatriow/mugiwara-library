/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;
import java.util.Date; // Untuk tipe data Date
/**
 *
 * @author VIVOBOOK
 */
public class Shipment {
    private String shipmentID;
    private Date date;
    private String status;
    private double cost;

    // Relasi dengan Order 
    private Order order;

    // Relasi dengan ShippingMethod 
    private ShippingMethod shippingMethod;

    /**
     * Konstruktor default
     */
    public Shipment() {
    }
    
    public Shipment(String shipmentID, Date date, String status, double cost, Order order, ShippingMethod shippingMethod) {
        this.shipmentID = shipmentID;
        this.date = date;
        this.status = status;
        this.cost = cost;
        this.order = order;
        this.shippingMethod = shippingMethod;
    }

    // --- Getter dan Setter untuk atribut ---

    public String getShipmentID() {
        return shipmentID;
    }

    public void setShipmentID(String shipmentID) {
        this.shipmentID = shipmentID;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    // --- Getter dan Setter untuk relasi (objek Order dan ShippingMethod) ---

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public ShippingMethod getShippingMethod() {
        return shippingMethod;
    }

    public void setShippingMethod(ShippingMethod shippingMethod) {
        this.shippingMethod = shippingMethod;
    }

    // --- Metode (opsional, jika ada perilaku spesifik) ---
    public void updateStatus(String newStatus) {
        this.status = newStatus;
        System.out.println("Status pengiriman " + this.shipmentID + " diperbarui menjadi: " + newStatus);
    }

    @Override
    public String toString() {
        return "Shipment{" +
               "shipmentID='" + shipmentID + '\'' +
               ", date=" + date +
               ", status='" + status + '\'' +
               ", cost=" + cost +
               ", orderID=" + (order != null ? order.getOrderID() : "N/A") + // Asumsi Order memiliki getOrderID()
               ", shippingMethodName=" + (shippingMethod != null ? shippingMethod.getMethodName() : "N/A") + // Asumsi ShippingMethod memiliki getMethodName()
               '}';
    }
}