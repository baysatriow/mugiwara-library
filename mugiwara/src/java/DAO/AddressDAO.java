package DAO;

import Models.Address;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class AddressDAO extends Models<Address> {
    
    public AddressDAO() {
        this.table = "address";
        this.primaryKey = "address_id";
    }
    
    @Override
    Address toModel(ResultSet rs) {
        try {
            Address address = new Address();
            address.setAddressId(rs.getInt("address_id"));
            address.setProvince(rs.getString("province"));
            address.setCity(rs.getString("city"));
            address.setDistrict(rs.getString("district"));
            address.setPostalCode(rs.getString("postal_code"));
            address.setFullAddress(rs.getString("full_address"));
            address.setIsDefault(rs.getBoolean("is_default"));
            
            return address;
        } catch (SQLException e) {
            setMessage("Error converting ResultSet to Address: " + e.getMessage());
            return null;
        }
    }
    
    public ArrayList<Address> getAddressesByUserId(int userId) {
        this.where("user_id = " + userId);
        this.addQuery("ORDER BY is_default DESC, address_id ASC");
        return this.get();
    }
    
    public Address getDefaultAddressByUserId(int userId) {
        this.where("user_id = " + userId + " AND is_default = 1");
        this.addQuery("LIMIT 1");
        ArrayList<Address> results = this.get();
        
        if (!results.isEmpty()) {
            return results.get(0);
        }
        return null;
    }
    
    public Address getAddressById(int addressId, int userId) {
        this.where("address_id = " + addressId + " AND user_id = " + userId);
        ArrayList<Address> results = this.get();
        
        if (!results.isEmpty()) {
            return results.get(0);
        }
        return null;
    }
    
    public boolean addAddress(int userId, Address address) {
        try {
            // If this is set as default, first reset all other addresses
            if (address.isIsDefault()) {
                this.resetDefaultAddresses(userId);
            }
            
            // Use raw query for insert
            String query = "INSERT INTO " + this.table + 
                          " (user_id, province, city, district, postal_code, full_address, is_default) " +
                          "VALUES (" + userId + ", '" + 
                          address.getProvince().replace("'", "''") + "', '" + 
                          address.getCity().replace("'", "''") + "', '" + 
                          address.getDistrict().replace("'", "''") + "', '" + 
                          address.getPostalCode() + "', '" + 
                          address.getFullAddress().replace("'", "''") + "', " + 
                          (address.isIsDefault() ? 1 : 0) + ")";
            
            this.connect();
            int rowsAffected = this.stmt.executeUpdate(query);
            this.disconnect();
            
            return rowsAffected > 0;
        } catch (SQLException e) {
            setMessage("Error adding address: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateDefaultAddress(int userId, int newDefaultAddressId) {
        try {
            // First, verify the address belongs to the user
            Address address = this.getAddressById(newDefaultAddressId, userId);
            if (address == null) {
                return false;
            }
            
            // Reset all addresses to non-default
            this.resetDefaultAddresses(userId);
            
            // Set new default address
            String updateQuery = "UPDATE " + this.table + 
                               " SET is_default = 1 WHERE address_id = " + newDefaultAddressId + 
                               " AND user_id = " + userId;
            
            this.connect();
            int rowsAffected = this.stmt.executeUpdate(updateQuery);
            this.disconnect();
            
            return rowsAffected > 0;
        } catch (SQLException e) {
            setMessage("Error updating default address: " + e.getMessage());
            return false;
        }
    }
    
    public boolean updateAddress(int addressId, int userId, Address address) {
        try {
            // If this is being set as default, first reset all other addresses
            if (address.isIsDefault()) {
                this.resetDefaultAddresses(userId);
            }
            
            String updateQuery = "UPDATE " + this.table + 
                               " SET province = '" + address.getProvince().replace("'", "''") + 
                               "', city = '" + address.getCity().replace("'", "''") + 
                               "', district = '" + address.getDistrict().replace("'", "''") + 
                               "', postal_code = '" + address.getPostalCode() + 
                               "', full_address = '" + address.getFullAddress().replace("'", "''") + 
                               "', is_default = " + (address.isIsDefault() ? 1 : 0) + 
                               " WHERE address_id = " + addressId + " AND user_id = " + userId;
            
            this.connect();
            int rowsAffected = this.stmt.executeUpdate(updateQuery);
            this.disconnect();
            
            return rowsAffected > 0;
        } catch (SQLException e) {
            setMessage("Error updating address: " + e.getMessage());
            return false;
        }
    }
    
    public boolean deleteAddress(int addressId, int userId) {
        try {
            // Cannot delete default address
            String deleteQuery = "DELETE FROM " + this.table + 
                               " WHERE address_id = " + addressId + 
                               " AND user_id = " + userId + 
                               " AND is_default = 0";
            
            this.connect();
            int rowsAffected = this.stmt.executeUpdate(deleteQuery);
            this.disconnect();
            
            return rowsAffected > 0;
        } catch (SQLException e) {
            setMessage("Error deleting address: " + e.getMessage());
            return false;
        }
    }
    
    public int getAddressCount(int userId) {
        ArrayList<ArrayList<Object>> results = this.query(
            "SELECT COUNT(*) FROM " + this.table + " WHERE user_id = " + userId
        );
        
        if (!results.isEmpty() && !results.get(0).isEmpty()) {
            Object countObj = results.get(0).get(0);
            if (countObj instanceof Number) {
                return ((Number) countObj).intValue();
            }
        }
        return 0;
    }
    
    public boolean hasDefaultAddress(int userId) {
        ArrayList<ArrayList<Object>> results = this.query(
            "SELECT COUNT(*) FROM " + this.table + 
            " WHERE user_id = " + userId + " AND is_default = 1"
        );
        
        if (!results.isEmpty() && !results.get(0).isEmpty()) {
            Object countObj = results.get(0).get(0);
            if (countObj instanceof Number) {
                return ((Number) countObj).intValue() > 0;
            }
        }
        return false;
    }
    
    // Helper method to reset all addresses to non-default
    private void resetDefaultAddresses(int userId) {
        try {
            String resetQuery = "UPDATE " + this.table + 
                              " SET is_default = 0 WHERE user_id = " + userId;
            
            this.connect();
            this.stmt.executeUpdate(resetQuery);
            this.disconnect();
        } catch (SQLException e) {
            setMessage("Error resetting default addresses: " + e.getMessage());
        }
    }
}