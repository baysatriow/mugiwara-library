/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author ASUS
 */
public class Category {
    private String name;
    private Book[] books;
    
    public Category(String name){
         this.name = name;
    }
    
    public void setBooks(Book[] books) {
        this.books = books;
    }

    public void categoryInfo() {
        System.out.println("Kategori: " + name);
        if (books != null) {
            System.out.println("Buku di kategori ini: ");
            for (Book book : books) {
                System.out.println(" - " + book.getTitle());
            }
        } else {
            System.out.println("Tidak ada buku di kategori ini.");
        }
    }
}
