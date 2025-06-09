package Models;

public class ShippingMethod {
    // Field names must match database column names for DAO.Models<E> generic methods
    private int shipping_method_id;
    private String name;
    private String description;
    private double cost;
    private int estimated_days;

    // Constructors
    public ShippingMethod() {
    }

    public ShippingMethod(String name, String description, double cost, int estimated_days) {
        this.name = name;
        this.description = description;
        this.cost = cost;
        this.estimated_days = estimated_days;
    }
    
    public ShippingMethod(int shipping_method_id, String name, String description, double cost, int estimated_days) {
        this.shipping_method_id = shipping_method_id;
        this.name = name;
        this.description = description;
        this.cost = cost;
        this.estimated_days = estimated_days;
    }

    // Getters and Setters
    public int getShipping_method_id() {
        return shipping_method_id;
    }

    public void setShipping_method_id(int shipping_method_id) {
        this.shipping_method_id = shipping_method_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public int getEstimated_days() {
        return estimated_days;
    }

    public void setEstimated_days(int estimated_days) {
        this.estimated_days = estimated_days;
    }

    @Override
    public String toString() {
        return "ShippingMethod{" +
               "shipping_method_id=" + shipping_method_id +
               ", name='" + name + '\'' +
               ", description='" + description + '\'' +
               ", cost=" + cost +
               ", estimated_days=" + estimated_days +
               '}';
    }
}
