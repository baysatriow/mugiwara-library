/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author ASUS
 */
public class Author {
    private String name;
    private String description;
    private Book[] books;
    
    public Author(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setBooks(Book[] books) {
        this.books = books;
    }
    
    public void authorInfo(){
        System.out.println("Penulis: " + name);
        System.out.println("Deskripsi: " + description);
        if (books != null) {
            System.out.println("Books:");
            for (Book book : books) {
                System.out.println(" - " + book.getTitle()); 
            }
        } else {
            System.out.println(name + "belum menerbitkan buku apapun.");
        }
    }
}
