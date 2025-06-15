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

    public int getCart_id() {
        return cart_id;
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
        this.items = items;
    }
}
