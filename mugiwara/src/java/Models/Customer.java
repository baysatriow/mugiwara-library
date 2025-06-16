package Models;

import java.util.ArrayList;
import java.util.List;

public class Customer extends Users {
    private int CustomerId;
    private String phone;
    private Address address[];
    private Object cart;
    private List<Object> orders;
    
    public Customer() {
        super();
        this.role = UserRoles.CUSTOMER;
        this.orders = new ArrayList<>();
    }
    
    public Customer(String username, String email, String password) {
        super(username, email, password);
        this.role = UserRoles.CUSTOMER;
        this.orders = new ArrayList<>();
    }

    public Customer(int CustomerId, String username, String email, String password) {
        super(username, email, password);
        this.CustomerId = CustomerId;
        this.role = UserRoles.CUSTOMER;
        this.orders = new ArrayList<>();
    }

    
    public Customer(int CustomerId, String phone, Address[] address, Object cart, List<Object> orders) {
        this.CustomerId = CustomerId;
        this.phone = phone;
        this.address = address;
        this.cart = cart;
        this.orders = orders;
    }

    public Customer(int CustomerId, String phone, Address[] address, Object cart, List<Object> orders, String username, String email, String password) {
        super(username, email, password);
        this.CustomerId = CustomerId;
        this.phone = phone;
        this.address = address;
        this.cart = cart;
        this.orders = orders;
    }

    public Customer(int CustomerId, String phone, Address[] address, Object cart, List<Object> orders, String username, String email, String password, UserRoles role) {
        super(username, email, password, role);
        this.CustomerId = CustomerId;
        this.phone = phone;
        this.address = address;
        this.cart = cart;
        this.orders = orders;
    }
    
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Address[] getAddress() {
        return address;
    }

    public void setAddress(Address[] address) {
        this.address = address;
    }

    public Object getCart() {
        return cart;
    }

    public void setCart(Object cart) {
        this.cart = cart;
    }

    public List<Object> getOrders() {
        return orders;
    }

    public void setOrders(List<Object> orders) {
        this.orders = orders;
    }

    public int getCustomerId() {
        return CustomerId;
    }

    public void setCustomerId(int CustomerId) {
        this.CustomerId = CustomerId;
    }
    
    @Override
    public String toString() {
        return "Customer{" +
                "customerId=" + CustomerId +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", userId=" + getUserId() +
                ", username='" + getUsername() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", fullName='" + getFullName() + '\'' +
                ", role=" + getRole() +
                '}';
    }
}
