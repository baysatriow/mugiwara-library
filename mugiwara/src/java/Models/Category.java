package Models;

import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author ASUS
 */
public class Category {
    private int category_id;
    private String name;
    private List<Book> books = new ArrayList<>();
    
    public Category(){
    }
    
    public Category(String name){
         this.name = name;
    }
    
    public Category(int category_id, String name){
        this.category_id = category_id;
        this.name = name;
    }
    
    public int getCategory_id(){
        return category_id;
    }
    
    public String getName(){
        return name;
    }
    
    public List<Book> getBooks(){
        return books;
    }
    
    public void setName(String name){
        this.name = name;
    }
    
    public void setCategory_id(int category_id){
        this.category_id = category_id;
    }
    
    public void setBooks(List<Book> books) {
        this.books = books;
    }
    
    public void categoryInfo() {

    }
}
