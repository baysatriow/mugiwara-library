package Models;

public class ShippingMethod {
    private int shippingMethodId;
    private String name;
    private String description;
    private double cost;
    private int estimatedDays;
    
    public ShippingMethod() {}
    
    public ShippingMethod(String name, double cost) {
        this.name = name;
        this.cost = cost;
    }
    
    public ShippingMethod(String name, String description, double cost, int estimatedDays) {
        this.name = name;
        this.description = description;
        this.cost = cost;
        this.estimatedDays = estimatedDays;
    }

    public int getShippingMethodId() {
        return shippingMethodId;
    }

    public void setShippingMethodId(int shippingMethodId) {
        this.shippingMethodId = shippingMethodId;
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

    public int getEstimatedDays() {
        return estimatedDays;
    }

    public void setEstimatedDays(int estimatedDays) {
        this.estimatedDays = estimatedDays;
    }
    
    public String getFormattedCost() {
        return String.format("Rp%,d", (int) cost);
    }
    
    public String getEstimationText() {
        if (estimatedDays == 0) {
            return "Same Day";
        } else if (estimatedDays == 1) {
            return "1 Day";
        } else {
            return estimatedDays + " Days";
        }
    }
    
    public void shippingInfo() {
        System.out.println("Shipping Method: " + name);
        System.out.println("Description: " + description);
        System.out.println("Cost: " + getFormattedCost());
        System.out.println("Estimated: " + getEstimationText());
    }
}