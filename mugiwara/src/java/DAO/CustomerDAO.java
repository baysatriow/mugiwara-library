package DAO;

/**
 *
 * @author bayus
 */


import Models.Customer;
import Models.UserRoles;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CustomerDAO extends Models<Customer> {
    
    public CustomerDAO() {
        this.table = "users";
        this.primaryKey = "user_id";
    }
    
    @Override
    Customer toModel(ResultSet rs) {
        Customer customer = new Customer();
        try {
            customer.setUserId(rs.getString("user_id"));
            customer.setUsername(rs.getString("username"));
            customer.setEmail(rs.getString("email"));
            customer.setPassword(rs.getString("password"));
            customer.setFullName(rs.getString("full_name"));
            customer.setGender(rs.getString("gender"));
            customer.setBirthDate(rs.getDate("birth_date"));
            customer.setRoleId(UserRoles.CUSTOMER);
            customer.setImagePath(rs.getString("image_path"));
            customer.setLogin(rs.getInt("login"));
            
            // Try to get phone if it exists in the result set
            try {
                customer.setPhone(rs.getString("phone"));
            } catch (SQLException e) {
                // Phone field might not exist in the result set
            }
        } catch (SQLException e) {
            setMessage("Error mapping Customer: " + e.getMessage());
        }
        return customer;
    }
    
    // Custom methods for Customer operations
    public ArrayList<Customer> getAllCustomers() {
        this.where("role_id = " + UserRoles.CUSTOMER);
        return this.get();
    }
    
    public Customer findCustomerByEmail(String email) {
        this.where("email = '" + email + "' AND role_id = " + UserRoles.CUSTOMER);
        ArrayList<Customer> customers = this.get();
        return customers.isEmpty() ? null : customers.get(0);
    }
    
    public boolean validateCustomerLogin(String email, String password) {
        this.where("email = '" + email + "' AND password = '" + password + "' AND role_id = " + UserRoles.CUSTOMER);
        ArrayList<Customer> customers = this.get();
        return !customers.isEmpty();
    }
    
    public ArrayList<Customer> findCustomersByPhone(String phone) {
        this.where("phone LIKE '%" + phone + "%' AND role_id = " + UserRoles.CUSTOMER);
        return this.get();
    }
    
    // Customer specific database operations
    public ArrayList<ArrayList<Object>> getCustomerOrders(String customerId) {
        String query = "SELECT o.*, oi.quantity, oi.price, b.title " +
                      "FROM orders o " +
                      "JOIN order_items oi ON o.order_id = oi.order_id " +
                      "JOIN books b ON oi.book_id = b.book_id " +
                      "WHERE o.customer_id = '" + customerId + "' " +
                      "ORDER BY o.order_date DESC";
        return this.query(query);
    }
    
    public ArrayList<ArrayList<Object>> getCustomerCart(String customerId) {
        String query = "SELECT c.*, ci.quantity, b.title, b.price " +
                      "FROM cart c " +
                      "JOIN cart_items ci ON c.cart_id = ci.cart_id " +
                      "JOIN books b ON ci.book_id = b.book_id " +
                      "WHERE c.customer_id = '" + customerId + "'";
        return this.query(query);
    }
    
    public int getCustomerTotalOrders(String customerId) {
        ArrayList<ArrayList<Object>> result = this.query(
            "SELECT COUNT(*) as total FROM orders WHERE customer_id = '" + customerId + "'"
        );
        if (!result.isEmpty() && !result.get(0).isEmpty()) {
            return ((Number) result.get(0).get(0)).intValue();
        }
        return 0;
    }
}
