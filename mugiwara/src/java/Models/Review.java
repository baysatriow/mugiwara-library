/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author ASUS
 */
public class Review {
    private Book book;
    private Customer reviewer;
    private String konten;

    public Review(Book book, Customer reviewer, String konten) {
        this.book = book;
        this.reviewer = reviewer;
        this.konten = konten;
    }

    public void infoReview() {
        System.out.println("Review Buku:");
        System.out.println("Judul: " + book.getJudul()); 
        System.out.println("Reviewer: " + reviewer.getNama());
        System.out.println("Isi Review: " + konten);
    }

  
}

