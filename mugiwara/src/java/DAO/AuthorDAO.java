/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package DAO;

import Models.Author;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthorDAO extends Models<Author>{
    public int author_id;
    public String name;
    public String description;
    
    public AuthorDAO(){
        this.table = "author";
        this.primaryKey = "author_id";
    }
    
    @Override
    Author toModel(ResultSet rs){
        Author author = new Author();
        try{
            author.setAuthor_id(rs.getInt("author_id"));
            author.setName(rs.getString("name"));
            author.setDescription(rs.getString("description"));
        }catch(SQLException e){
            setMessage("Error mapping Author: " + e.getMessage());
        }
        return author;
    }
    
    /* Save new Author object to database */
    public void saveAuthor(Author author){
        this.name = author.getName();
        this.description = author.getDescription();
    }
    
    /* Updating existing Author data in database */
    public void updateAuthor(Author author){
        this.author_id = author.getAuthor_id();
        this.name = author.getName();
        this.description = author.getDescription();
        
        super.update();
        this.setMessage(super.getMessage());
    }
    
    /* Delete Author data from database base on ID */
    public void deleteAuthor(int id){
        this.author_id = id;
        super.delete();
        this.setMessage(super.getMessage());
    }
}