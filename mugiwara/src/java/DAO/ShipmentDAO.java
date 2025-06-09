/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Shipment;
import Models.ShippingMethod;
import java.sql.ResultSet;
import java.sql.SQLException;
/**
 *
 * @author VIVOBOOK
 */
public class ShipmentDAO extends Models<Shipment> {

    private ShippingMethodDAO shippingMethodDAO; // To fetch ShippingMethod objects

    // Fields for data to be inserted/updated if using the stateful DAO pattern from Models.java
    public int shipment_id; // PK, also for delete
    public int shipping_method_id;
    public java.sql.Date estimated_date;
    public String address;
    public double cost;
    // public int order_id; // If column exists
    // public String tracking_number; // If column exists
    // public String status; // If column exists


    public ShipmentDAO() {
        this.table = "mugiwara_l_shipment";
        this.primaryKey = "shipment_id";
        this.shippingMethodDAO = new ShippingMethodDAO();
    }

    @Override
    Shipment toModel(ResultSet rs) {
        Shipment shipment = new Shipment();
        
        // Fetch the associated ShippingMethod object
        ShippingMethod shippingMethod = shippingMethodDAO.find(shipment.getShipping_method_id());
        shipment.setShippingMethodObj(shippingMethod);
        
        // Populate other fields if they exist in DB and model
        // if (columnExists(rs, "order_id")) shipment.setOrder_id(rs.getInt("order_id"));
        // if (columnExists(rs, "tracking_number")) shipment.setTracking_number(rs.getString("tracking_number"));
        // if (columnExists(rs, "status")) shipment.setStatus(rs.getString("status"));
        try {
            shipment.setShipment_id(rs.getInt("shipment_id"));
            shipment.setShipping_method_id(rs.getInt("shipping_method_id"));
            shipment.setEstimated_date(rs.getDate("estimated_date"));
            shipment.setAddress(rs.getString("address"));
            shipment.setCost(rs.getDouble("cost"));
        } catch (SQLException e) {
            setMessage("Error mapping Users: " + e.getMessage());
        }
        return shipment;

    }

    // Helper to check if column exists in ResultSet to avoid SQLException
    // private boolean columnExists(ResultSet rs, String columnName) throws SQLException {
    //     try {
    //         rs.findColumn(columnName);
    //         return true;
    //     } catch (SQLException e) {
    //         return false;
    //     }
    // }

    // Conventional CRUD methods
    public void insertShipment(Shipment shipment) {
        this.shipping_method_id = shipment.getShipping_method_id();
        this.estimated_date = shipment.getEstimated_date();
        this.address = shipment.getAddress();
        this.cost = shipment.getCost();
        // Set other fields like order_id, tracking_number, status if they are part of the insert
        super.insert();
        this.setMessage(super.getMessage());
    }

    public void updateShipment(Shipment shipment) {
        this.shipment_id = shipment.getShipment_id(); // PK
        this.shipping_method_id = shipment.getShipping_method_id();
        this.estimated_date = shipment.getEstimated_date();
        this.address = shipment.getAddress();
        this.cost = shipment.getCost();
        super.update();
        this.setMessage(super.getMessage());
    }

    public void deleteShipment(int id) {
        this.shipment_id = id; // Set the PK field in the DAO instance
        super.delete();
        this.setMessage(super.getMessage());
    }
}
