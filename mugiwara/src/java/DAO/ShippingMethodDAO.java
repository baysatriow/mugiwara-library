package DAO;

import Models.ShippingMethod;
import java.sql.ResultSet;
import java.sql.SQLException;

// For the generic insert/update/delete in Models.java to work as written,
// this DAO class itself would need to have fields like 'name', 'cost', etc.
// and those fields would be set before calling this.insert(). This is highly unconventional.
// A more standard DAO would be: public void insert(ShippingMethod method) { ... }
// I am proceeding with the structure implied by your Models.java.
// This means to insert a new ShippingMethod, you would:
// ShippingMethodDAO dao = new ShippingMethodDAO();
// dao.name = "Express"; // Assuming ShippingMethodDAO has public fields or setters for these
// dao.cost = 10.0;
// dao.insert();
// This is not good. The DAO should operate on ShippingMethod objects.

// Let's assume a slightly more conventional use:
// The DAO methods like get() and find() return ShippingMethod objects.
// For insert/update/delete, you'd pass a ShippingMethod object.
// However, your Models.java uses `this.g etClass().getDeclaredFields()` for insert/update.
// This means the DAO instance itself must hold the data.

// To make the generic insert/update/delete from Models.java usable with model objects,
// we would need to pass the model object to them, or the DAO subclass would need
// to temporarily copy data from a model object to its own fields before calling super.insert().

public class ShippingMethodDAO extends Models<ShippingMethod> {

    // Fields for data to be inserted/updated if using the stateful DAO pattern from Models.java
    // These names MUST match database column names.
    public int shipping_method_id; // Also used for delete if DAO holds PK
    public String name;
    public String description;
    public double cost;
    public int estimated_days;


    public ShippingMethodDAO() {
        this.table = "mugiwara_l_shipping_method";
        this.primaryKey = "shipping_method_id";
    }

    @Override
    ShippingMethod toModel(ResultSet rs) {
        ShippingMethod method = new ShippingMethod();
        try {
            method.setShipping_method_id(rs.getInt("shipping_method_id"));
            method.setName(rs.getString("name"));
            method.setDescription(rs.getString("description"));
            method.setCost(rs.getDouble("cost"));
            method.setEstimated_days(rs.getInt("estimated_days"));
        } catch (SQLException e) {
            setMessage("Error mapping Users: " + e.getMessage());
        }
        return method;
    }
    
    // Conventional CRUD methods that operate on ShippingMethod objects
    // These would ideally call a modified super.insert(entity), etc.
    // Or, they re-implement the logic using PreparedStatement for safety.

    public void insertShippingMethod(ShippingMethod method) {
        // To use super.insert(), we need to set the fields of this DAO instance
        this.name = method.getName();
        this.description = method.getDescription();
        this.cost = method.getCost();
        this.estimated_days = method.getEstimated_days();
        // The shipping_method_id is auto-increment, so not set here for insert.
        super.insert(); // Calls the problematic insert in Models.java
        // After insert, if Models.java could return generated ID, we could set it back to method object.
        // The current Models.java doesn't handle returning generated keys to the caller of insert().
        this.setMessage(super.getMessage()); // Propagate message
    }

    public void updateShippingMethod(ShippingMethod method) {
        // Set fields of this DAO instance from the method object
        this.shipping_method_id = method.getShipping_method_id(); // PK for where clause
        this.name = method.getName();
        this.description = method.getDescription();
        this.cost = method.getCost();
        this.estimated_days = method.getEstimated_days();
        super.update();
        this.setMessage(super.getMessage());
    }

    public void deleteShippingMethod(int id) {
        // Set the primary key field of this DAO instance
        this.shipping_method_id = id; // Assuming primaryKey field in DAO is named 'shipping_method_id'
        super.delete(); // This requires `primaryKey` field in DAO to be set.
        this.setMessage(super.getMessage());
    }
    
    // The get() and find() methods from Models<ShippingMethod> can be used directly.
    // Example:
    // ShippingMethodDAO dao = new ShippingMethodDAO();
    // ShippingMethod method = dao.find(1);
    // ArrayList<ShippingMethod> methods = dao.get();
}
