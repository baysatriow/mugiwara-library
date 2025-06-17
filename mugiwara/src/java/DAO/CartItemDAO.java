package DAO;

import Models.Book;
import Models.CartItem;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CartItemDAO extends Models<CartItem> {
    
    private BookDAO bookDAO;
    
    public CartItemDAO() {
        table = "cart_item";
        primaryKey = "cart_id"; // Note: cart_item has composite primary key
        
        // Initialize related DAO
        bookDAO = new BookDAO();
    }
    
    @Override
    CartItem toModel(ResultSet rs) {
        try {
            CartItem cartItem = new CartItem();
            cartItem.setCart_id(rs.getInt("cart_id"));
            cartItem.setQuantity(rs.getInt("quantity"));
            cartItem.setHarga(rs.getDouble("price"));
            
            // Get book data
            int bookId = rs.getInt("book_id");
            Book book = bookDAO.find(String.valueOf(bookId));
            cartItem.setBook(book);
            
            return cartItem;
        } catch (SQLException e) {
            setMessage("Error creating CartItem model: " + e.getMessage());
            return null;
        }
    }
    
    // Get all cart items by cart ID
    public ArrayList<CartItem> getCartItemsByCartId(int cartId) {
        try {
            connect();
            String query = "SELECT * FROM cart_item WHERE cart_id = " + cartId;
            
            ArrayList<CartItem> cartItems = new ArrayList<>();
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                CartItem item = toModel(rs);
                if (item != null) {
                    cartItems.add(item);
                }
            }
            
            return cartItems;
            
        } catch (SQLException e) {
            setMessage("Error getting cart items: " + e.getMessage());
            return new ArrayList<>();
        } finally {
            disconnect();
        }
    }
    
    // Add item to cart
    public boolean addItemToCart(int cartId, int bookId, int quantity, double price) {
        try {
            connect();
            
            // Check if item already exists in cart
            String checkQuery = "SELECT quantity FROM cart_item WHERE cart_id = " + cartId + 
                               " AND book_id = " + bookId;
            ResultSet rs = stmt.executeQuery(checkQuery);
            
            if (rs.next()) {
                // Item exists, update quantity
                int existingQuantity = rs.getInt("quantity");
                int newQuantity = existingQuantity + quantity;
                
                String updateQuery = "UPDATE cart_item SET quantity = " + newQuantity + 
                                   ", price = " + price + 
                                   " WHERE cart_id = " + cartId + " AND book_id = " + bookId;
                
                int result = stmt.executeUpdate(updateQuery);
                if (result > 0) {
                    setMessage("Item quantity updated in cart");
                    return true;
                }
            } else {
                // Item doesn't exist, insert new
                String insertQuery = "INSERT INTO cart_item (cart_id, book_id, quantity, price) VALUES (" +
                                   cartId + ", " + bookId + ", " + quantity + ", " + price + ")";
                
                int result = stmt.executeUpdate(insertQuery);
                if (result > 0) {
                    setMessage("Item added to cart successfully");
                    return true;
                }
            }
            
        } catch (SQLException e) {
            setMessage("Error adding item to cart: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Update item quantity in cart
    public boolean updateItemQuantity(int cartId, int bookId, int newQuantity) {
        try {
            connect();
            
            if (newQuantity <= 0) {
                // Remove item if quantity is 0 or negative
                return removeItemFromCart(cartId, bookId);
            }
            
            String query = "UPDATE cart_item SET quantity = " + newQuantity + 
                          " WHERE cart_id = " + cartId + " AND book_id = " + bookId;
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Item quantity updated successfully");
                return true;
            } else {
                setMessage("Item not found in cart");
            }
            
        } catch (SQLException e) {
            setMessage("Error updating item quantity: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Remove item from cart
    public boolean removeItemFromCart(int cartId, int bookId) {
        try {
            connect();
            
            String query = "DELETE FROM cart_item WHERE cart_id = " + cartId + " AND book_id = " + bookId;
            int result = stmt.executeUpdate(query);
            
            if (result > 0) {
                setMessage("Item removed from cart successfully");
                return true;
            } else {
                setMessage("Item not found in cart");
            }
            
        } catch (SQLException e) {
            setMessage("Error removing item from cart: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Remove all items from cart
    public boolean removeAllItemsFromCart(int cartId) {
        try {
            connect();
            
            String query = "DELETE FROM cart_item WHERE cart_id = " + cartId;
            int result = stmt.executeUpdate(query);
            
            setMessage("All items removed from cart");
            return true; // Return true even if no items were removed
            
        } catch (SQLException e) {
            setMessage("Error removing all items from cart: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Get cart item by cart ID and book ID
    public CartItem getCartItem(int cartId, int bookId) {
        try {
            connect();
            
            String query = "SELECT * FROM cart_item WHERE cart_id = " + cartId + " AND book_id = " + bookId;
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return toModel(rs);
            }
            
        } catch (SQLException e) {
            setMessage("Error getting cart item: " + e.getMessage());
        } finally {
            disconnect();
        }
        return null;
    }
    
    // Check if item exists in cart
    public boolean itemExistsInCart(int cartId, int bookId) {
        try {
            connect();
            
            String query = "SELECT COUNT(*) as count FROM cart_item WHERE cart_id = " + cartId + 
                          " AND book_id = " + bookId;
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
            
        } catch (SQLException e) {
            setMessage("Error checking item existence in cart: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    // Get total items count in cart
    public int getTotalItemsInCart(int cartId) {
        try {
            connect();
            
            String query = "SELECT SUM(quantity) as total FROM cart_item WHERE cart_id = " + cartId;
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return rs.getInt("total");
            }
            
        } catch (SQLException e) {
            setMessage("Error getting total items in cart: " + e.getMessage());
        } finally {
            disconnect();
        }
        return 0;
    }
    
    // Calculate total price for cart
    public double calculateCartTotal(int cartId) {
        try {
            connect();
            
            String query = "SELECT SUM(quantity * price) as total FROM cart_item WHERE cart_id = " + cartId;
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return rs.getDouble("total");
            }
            
        } catch (SQLException e) {
            setMessage("Error calculating cart total: " + e.getMessage());
        } finally {
            disconnect();
        }
        return 0.0;
    }
}