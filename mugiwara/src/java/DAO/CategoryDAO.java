package DAO;

import Models.Category;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class CategoryDAO extends Models<Category> {

    public CategoryDAO() {
        table = "category";
        primaryKey = "category_id";
    }

    @Override
    Category toModel(ResultSet rs) {
        try {
            Category category = new Category();
            category.setCategory_id(rs.getInt("category_id"));
            category.setName(rs.getString("name"));
            return category;
        } catch (SQLException e) {
            setMessage("Error creating Category model: " + e.getMessage());
            return null;
        }
    }

    public ArrayList<Category> getAllCategories() {
        try {
            addQuery("ORDER BY name");
            return get();
        } catch (Exception e) {
            setMessage("Error getting all categories: " + e.getMessage());
            return new ArrayList<>();
        }
    }
}
