package Models;

import java.util.ArrayList;

public class Cart {
    private int cart_id;
    private Customer customer;
    private ArrayList<CartItem> items;

    // Constructors
    public Cart() {
        this.items = new ArrayList<>();
    }

    public Cart(Customer customer) {
        this.customer = customer;
        this.items = new ArrayList<>();
    }

    // Getters and Setters
    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public ArrayList<CartItem> getItems() {
        if (items == null) {
            items = new ArrayList<>();
        }
        return items;
    }

    public void setItems(ArrayList<CartItem> items) {
        this.items = items != null ? items : new ArrayList<>();
    }

    // Utility methods
    public void addItem(CartItem item) {
        if (items == null) {
            items = new ArrayList<>();
        }
        
        // Check if item already exists
        for (CartItem existingItem : items) {
            if (existingItem.getBook().getBook_id() == item.getBook().getBook_id()) {
                existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
                return;
            }
        }
        
        // Add new item
        items.add(item);
    }

    public void removeItem(int bookId) {
        if (items != null) {
            items.removeIf(item -> item.getBook().getBook_id() == bookId);
        }
    }

    public void updateItemQuantity(int bookId, int quantity) {
        if (items != null) {
            for (CartItem item : items) {
                if (item.getBook().getBook_id() == bookId) {
                    if (quantity <= 0) {
                        removeItem(bookId);
                    } else {
                        item.setQuantity(quantity);
                    }
                    return;
                }
            }
        }
    }

    public double calculateTotal() {
        double total = 0.0;
        if (items != null) {
            for (CartItem item : items) {
                total += item.getHarga() * item.getQuantity();
            }
        }
        return total;
    }

    public int getTotalItems() {
        int total = 0;
        if (items != null) {
            for (CartItem item : items) {
                total += item.getQuantity();
            }
        }
        return total;
    }

    public boolean isEmpty() {
        return items == null || items.isEmpty();
    }

    public void clear() {
        if (items != null) {
            items.clear();
        }
    }
}
