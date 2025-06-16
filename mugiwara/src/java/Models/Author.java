package Models;

import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author ASUS
 */
public class Author {
    private int author_id;
    private String name;
    private String description;
    private List<Book> books = new ArrayList<>();
    
    public Author(){
    }
    
    public Author(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public Author(int author_id, String name, String description) {
        this.author_id = author_id;
        this.name = name;
        this.description = description;
    }

    public int getAuthor_id(){
        return author_id;
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

    public void setAuthor_id(int author_id){
        this.author_id = author_id;
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
