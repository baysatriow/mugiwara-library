/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author ASUS
 */
public class Author {
    private int authorId;
    private String name;
    private String description;
    private List<Book> books = new ArrayList<>();
    
    public Author(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public Author(int id, String name, String description) {
        this.authorId = id;
        this.name = name;
        this.description = description;
    }

    public int getAuthorId(){
        return authorId;
    }

    public String getName() {
        return name;
    }

    public String getDescription(){
        return description;
    }

    public List<Book> getBooks(){
        return books;
    }

    public void setId(int id){
        this.authorId = id;
    }

    public void setName(String name){
        this.name = name;
    }

    public void setDescription(String description){
        this.description = description;
    }

    public void setBooks(List<Book> books) {
        this.books = books;
    }
    
    public void authorInfo(){
        System.out.println("Penulis: " + name);
        System.out.println("Deskripsi: " + description);
        if (books != null && !books.isEmpty())  {
            System.out.println("Books:");
            for (Book book : books) {
                System.out.println(" - " + book.getTitle()); 
            }
        } else {
            System.out.println(name + "belum menerbitkan buku apapun.");
        }
    }
}
