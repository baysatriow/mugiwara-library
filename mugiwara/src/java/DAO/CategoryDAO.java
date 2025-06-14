/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package DAO;

import Models.Category;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CategoryDAO extends Models<Category>{
    public int category_id;
    public String name;
    
    public CategoryDAO(){
        this.table = "category";
        this.primaryKey = "category_id";
    }
    
    @Override
    Category toModel(ResultSet rs){
        Category category = new Category();
        try{
            category.setCategory_id(rs.getInt("category_id"));
            category.setName(rs.getString("name"));
        }catch(SQLException e){
            setMessage("Error mapping Category: " + e.getMessage());
        }
        return category;
    }
    
    /* Save new Category object to database */
    public void saveCategory(Category category){
        this.name = category.getName();
        super.insert();
        this.setMessage(super.getMessage());
    }
    
    /* Updating existing Category data in database */
    public void updateCategory(Category category){
        this.category_id = category.getCategory_id();
        this.name = category.getName();
        super.update();
        this.setMessage(super.getMessage());
    }
    
    /* Delete Category data from database base on ID */
    public void deleteCategory(int id){
        this.category_id = id;
        super.delete();
        this.setMessage(super.getMessage());
    }
}