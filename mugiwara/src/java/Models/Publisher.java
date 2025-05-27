/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author ASUS
 */
    public class Publisher {
    private String name;
    private String description;
    private Book[] publication;

    public Publisher(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public String getPublisher() {
        return name;
    }

    public void setPublication(Book[] publication) {
        this.publication = publication;
    }

    public void publisherInfo() {
        System.out.println("Publisher: " + name);
        System.out.println("Deskripsi: " + description);
        System.out.println("Buku yang dipublikasi:");
        if (publication != null && publication.length > 0) {
            for (Book book : publication) {
                System.out.println("- " + book.getTitle()); 
            }
        } else {
            System.out.println("- Tidak ada publikasi");
        }
    }
}
