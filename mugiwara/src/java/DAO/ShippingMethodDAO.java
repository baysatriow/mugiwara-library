package DAO;

import Models.ShippingMethod;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ShippingMethodDAO extends Models<ShippingMethod> {
    
    public ShippingMethodDAO() {
        this.table = "shipping_method";
        this.primaryKey = "shipping_method_id";
    }
    
    @Override
    ShippingMethod toModel(ResultSet rs) {
        try {
            ShippingMethod shippingMethod = new ShippingMethod();
            shippingMethod.setShippingMethodId(rs.getInt("shipping_method_id"));
            shippingMethod.setName(rs.getString("name"));
            shippingMethod.setDescription(rs.getString("description"));
            shippingMethod.setCost(rs.getDouble("cost"));
            shippingMethod.setEstimatedDays(rs.getInt("estimated_days"));
            
            return shippingMethod;
        } catch (SQLException e) {
            setMessage("Error converting ResultSet to ShippingMethod: " + e.getMessage());
            return null;
        }
    }
    
    public ArrayList<ShippingMethod> getAllShippingMethods() {
        this.addQuery("ORDER BY cost ASC");
        return this.get();
    }
    
    public ShippingMethod getShippingMethodByName(String name) {
        this.where("name = '" + name.replace("'", "''") + "'");
        ArrayList<ShippingMethod> results = this.get();
        
        if (!results.isEmpty()) {
            return results.get(0);
        }
        return null;
    }
    
    public ShippingMethod getShippingMethodById(int shippingMethodId) {
        this.where("shipping_method_id = " + shippingMethodId);
        ArrayList<ShippingMethod> results = this.get();
        
        if (!results.isEmpty()) {
            return results.get(0);
        }
        return null;
    }
    
    public boolean isValidShippingMethod(String name) {
        ArrayList<ArrayList<Object>> results = this.query(
            "SELECT COUNT(*) FROM " + this.table + " WHERE name = '" + name.replace("'", "''") + "'"
        );
        
        if (!results.isEmpty() && !results.get(0).isEmpty()) {
            Object countObj = results.get(0).get(0);
            if (countObj instanceof Number) {
                return ((Number) countObj).intValue() > 0;
            }
        }
        return false;
    }
    
    public boolean isValidShippingMethodId(int shippingMethodId) {
        ArrayList<ArrayList<Object>> results = this.query(
            "SELECT COUNT(*) FROM " + this.table + " WHERE shipping_method_id = " + shippingMethodId
        );
        
        if (!results.isEmpty() && !results.get(0).isEmpty()) {
            Object countObj = results.get(0).get(0);
            if (countObj instanceof Number) {
                return ((Number) countObj).intValue() > 0;
            }
        }
        return false;
    }
    
    public ArrayList<ShippingMethod> getShippingMethodsWithEstimation() {
        this.select("shipping_method_id, name, description, cost, estimated_days");
        this.addQuery("ORDER BY cost ASC");
        return this.get();
    }
    
    public ShippingMethod getShippingMethodWithDetails(String name) {
        this.select("shipping_method_id, name, description, cost, estimated_days");
        this.where("name = '" + name.replace("'", "''") + "'");
        ArrayList<ShippingMethod> results = this.get();
        
        if (!results.isEmpty()) {
            return results.get(0);
        }
        return null;
    }
    
    public double getShippingCostByName(String name) {
        ArrayList<ArrayList<Object>> results = this.query(
            "SELECT cost FROM " + this.table + " WHERE name = '" + name.replace("'", "''") + "'"
        );
        
        if (!results.isEmpty() && !results.get(0).isEmpty()) {
            Object costObj = results.get(0).get(0);
            if (costObj instanceof Number) {
                return ((Number) costObj).doubleValue();
            }
        }
        return 0.0;
    }
    
    public int getEstimatedDaysByName(String name) {
        ArrayList<ArrayList<Object>> results = this.query(
            "SELECT estimated_days FROM " + this.table + " WHERE name = '" + name.replace("'", "''") + "'"
        );
        
        if (!results.isEmpty() && !results.get(0).isEmpty()) {
            Object daysObj = results.get(0).get(0);
            if (daysObj instanceof Number) {
                return ((Number) daysObj).intValue();
            }
        }
        return 0;
    }
}