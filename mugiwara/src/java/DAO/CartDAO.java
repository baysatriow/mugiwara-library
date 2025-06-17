package DAO;

import Models.Cart;
import Models.CartItem;
import Models.Customer;
import Models.Users;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CartDAO extends Models<Cart> {
    
    private CartItemDAO cartItemDAO;
    private UsersDao usersDao;
    
    public CartDAO() {
        table = "cart";
        primaryKey = "cart_id";
        
        // Initialize related DAOs
        cartItemDAO = new CartItemDAO();
        usersDao = new UsersDao();
    }
    
    @Override
    Cart toModel(ResultSet rs) {
        try {
            Cart cart = new Cart();
            cart.setCart_id(rs.getInt("cart_id"));
            
            // Get customer data
            int customerId = rs.getInt("customer_id");
            Customer customer = usersDao.getCustomerById(customerId);
            cart.setCustomer(customer);
            
            // Load cart items
            ArrayList<CartItem> items = cartItemDAO.getCartItemsByCartId(cart.getCart_id());
            cart.setItems(items);
            
            return cart;
        } catch (SQLException e) {
            setMessage("Error creating Cart model: " + e.getMessage());
            return null;
        }
    }
    
    // Get or create cart for customer
    public Cart getOrCreateCartForCustomer(int customerId) {
        try {
            connect();
            
            // First, try to find existing cart
            String query = "SELECT * FROM cart WHERE customer_id = " + customerId;
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                // Cart exists, return it
                Cart cart = toModel(rs);
                return cart;
            } else {
                // Create new cart
                String insertQuery = "INSERT INTO cart (customer_id) VALUES (" + customerId + ")";
                int result = stmt.executeUpdate(insertQuery);
                
                if (result > 0) {
                    // Get the newly created cart
                    ResultSet newRs = stmt.executeQuery("SELECT LAST_INSERT_ID() as cart_id");
                    if (newRs.next()) {
                        int cartId = newRs.getInt("cart_id");
                        
                        // Create cart object
                        Cart cart = new Cart();
                        cart.setCart_id(cartId);
                        
                        Customer customer = usersDao.getCustomerById(customerId);
                        cart.setCustomer(customer);
                        
                        setMessage("Cart created successfully");
                        return cart;
                    }
                }
            }
            
        } catch (SQLException e) {
            setMessage("Error getting or creating cart: " + e.getMessage());
        } finally {
            disconnect();
        }
        return null;
    }
    
    // Get cart by customer ID
    public Cart getCartByCustomerId(int customerId) {
        try {
            connect();
            String query = "SELECT * FROM cart WHERE customer_id = " + customerId;
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return toModel(rs);
            }
            
        } catch (SQLException e) {
            setMessage("Error getting cart by customer ID: " + e.getMessage());
        } finally {
            disconnect();
        }
        return null;
    }
    
    // Clear cart (remove all items)
    public boolean clearCart(int cartId) {
        try {
            // First remove all cart items
            boolean itemsRemoved = cartItemDAO.removeAllItemsFromCart(cartId);
            
            if (itemsRemoved) {
                setMessage("Cart cleared successfully");
                return true;
            }
            
        } catch (Exception e) {
            setMessage("Error clearing cart: " + e.getMessage());
        }
        return false;
    }
    
    // Delete cart completely
    public boolean deleteCart(int cartId) {
        try {
            connect();
            
            // First remove all cart items
            cartItemDAO.removeAllItemsFromCart(cartId);
            
            // Then delete the cart
            String query = "DELETE FROM cart WHERE cart_id = " + cartId;
            int result = stmt.executeUpdate(query);
            
            if (result > 0) {
                setMessage("Cart deleted successfully");
                return true;
            }
            
        } catch (SQLException e) {
            setMessage("Error deleting cart: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Get cart with full details (including items)
    public Cart getCartWithDetails(int cartId) {
        Cart cart = find(String.valueOf(cartId));
        if (cart != null) {
            // Items are already loaded in toModel method
            return cart;
        }
        return null;
    }
    
    // Check if cart exists for customer
    public boolean cartExistsForCustomer(int customerId) {
        try {
            connect();
            String query = "SELECT COUNT(*) as count FROM cart WHERE customer_id = " + customerId;
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
            
        } catch (SQLException e) {
            setMessage("Error checking cart existence: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Get cart item count for customer
    public int getCartItemCount(int customerId) {
        try {
            Cart cart = getCartByCustomerId(customerId);
            if (cart != null) {
                return cart.getTotalItems();
            }
        } catch (Exception e) {
            setMessage("Error getting cart item count: " + e.getMessage());
        }
        return 0;
    }
    
    // Calculate cart total
    public double calculateCartTotal(int cartId) {
        try {
            Cart cart = getCartWithDetails(cartId);
            if (cart != null) {
                return cart.calculateTotal();
            }
        } catch (Exception e) {
            setMessage("Error calculating cart total: " + e.getMessage());
        }
        return 0.0;
    }
}