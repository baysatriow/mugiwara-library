package Models;

import java.util.List;
import java.util.ArrayList;

public class Cart {
    private int cart_id;
    private Customer customer;
    private List<CartItem> items;
    
    public Cart(){
    }
    
    public Cart(Customer customer) {
        this.customer = customer;
        this.items = new ArrayList<>();
    }
    
    public Cart(int cart_id, Customer customer) {
        this.cart_id = cart_id;
        this.customer = customer;
        this.items = new ArrayList<>();
    }
<<<<<<< HEAD
    
    public void addItem(CartItem item) {
        if (item != null) {
            boolean found = false;
            for (CartItem existingItem : items) {
                if (existingItem.getBook().getISBN().equals(item.getBook().getISBN())) {
                    existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
                    found = true;
                    break;
                }
            }
            
            if (!found) {
                this.items.add(item);
            }
        }
    }
    
    public void removeItem(CartItem item) {
        if (item != null) {
            this.items.remove(item);
        }
    }
    
    public void removeItem(String ISBN) {
        items.removeIf(item -> item.getBook().getISBN().equals(ISBN));
    }
    
    public void updateQuantity(CartItem item, int quantity) {
        if (item != null && quantity > 0) {
            for (CartItem cartItem : items) {
                if (cartItem.equals(item)) {
                    cartItem.setQuantity(quantity);
                    break;
                }
            }
        } else if (quantity <= 0) {
            removeItem(item);
        }
    }
    
    public void updateQuantity(String ISBN, int quantity) {
        if (quantity > 0) {
            for (CartItem item : items) {
                if (item.getBook().getISBN().equals(ISBN)) {
                    item.setQuantity(quantity);
                    break;
                }
            }
        } else {
            // If quantity is 0 or negative, remove the item
            removeItem(ISBN);
        }
    }
    
    public double calculateTotal() {
        double total = 0.0;
        for (CartItem item : items) {
            total += item.total();
        }
        return total;
    }
     
    public void clearCart() {
        this.items.clear();
    }
     
    public OrderItem checkout() {
        if (items.isEmpty()) {
            System.out.println("Cart is empty. Cannot checkout.");
            return null;
        }
        
        // Create OrderItem from cart
        OrderItem orderItem = new OrderItem();
        orderItem.setCustomer(this.customer);
        orderItem.setItems(new ArrayList<>(this.items)); // Copy items
        orderItem.setPrice(calculateTotal());
        // Clear cart after checkout
        clearCart();
        
        return orderItem;
=======

    public int getCart_id() {
        return cart_id;
>>>>>>> ebaa04640c5475598804e90d853d318d5b75fba9
    }
    
    public Customer getCustomer() {
        return customer;
    }

    public List<CartItem> getItems() {
        return items;
    }
    
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public void setItems(List<CartItem> items) {
<<<<<<< HEAD
        this.items = items != null ? items : new ArrayList<>();
    }
    
    // Utility methods
    public int getTotalItems() {
        int total = 0;
        for (CartItem item : items) {
            total += item.getQuantity();
        }
        return total;
    }
    
    public boolean isEmpty() {
        return items.isEmpty();
    }
    
    public void displayCart() {
=======
        this.items = items;
>>>>>>> ebaa04640c5475598804e90d853d318d5b75fba9
    }
}
