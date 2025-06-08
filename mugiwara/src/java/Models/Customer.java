package Models;
import java.util.ArrayList;
import java.util.List;

public class Customer extends Users {
    private String phone;
    private Address address;
    private Object cart; // Will be implemented later
    private List<Object> orders; // Will be implemented later
    
    public Customer() {
        super();
        this.roleId = UserRoles.CUSTOMER;
        this.orders = new ArrayList<>();
    }
    
    public Customer(String username, String email) {
        super(username, email, null);
        this.roleId = UserRoles.CUSTOMER;
        this.orders = new ArrayList<>();
    }
    
    // Customer specific methods
    public void addToCart(Object book) {
        // Add to cart logic
    }
    
    public Object viewCart() {
        // View cart logic
        return cart;
    }
    
    public void checkout() {
        // Checkout logic
    }
    
    public List<Object> orderHistory() {
        // Order history logic
        return orders;
    }
    
    // Getters and Setters
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    
    public Address getAddress() { return address; }
    public void setAddress(Address address) { this.address = address; }
    
    public Object getCart() { return cart; }
    public void setCart(Object cart) { this.cart = cart; }
    
    public List<Object> getOrders() { return orders; }
    public void setOrders(List<Object> orders) { this.orders = orders; }
}
