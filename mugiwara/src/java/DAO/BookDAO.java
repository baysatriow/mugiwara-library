/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Models.Author;
import Models.Book;
import Models.Category;
import Models.Publisher;
import Models.Review;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.ArrayList;
/**
 *
 * @author LENOVO
 */

public class BookDAO extends Models<Book>{
    private int book_id;
    private String ISBN;
    private int price;
    private String title;
    private Author author;
    private Publisher publisher;
    private Date publicationDate;
    private double width;
    private double length;
    private int weight;
    private int stock;
    private String description;
    private Category category;
    public Review review;
    public String imagePath;
    
    public BookDAO(){
        this.table = "book";
        this.primaryKey = "book_id";
    }
    
    @Override
    Book toModel(ResultSet rs){
        Book book = new Book();
        try{
            book.setBook_id(rs.getInt("book_id"));
            book.setISBN(rs.getString("ISBN"));
            book.setPrice(rs.getInt("price"));
            book.setTitle(rs.getString("title"));
            book.setAuthor(new AuthorDAO().find(rs.getString("author_id")));
            book.setPublisher(new PublisherDAO().find(rs.getString("publisher_id")));
            book.setPublicationDate(rs.getDate("publicationDate"));
            book.setWidth(rs.getDouble("width"));
            book.setLength(rs.getDouble("wlength"));
            book.setWeight(rs.getInt("weight"));
            book.setStock(rs.getInt("stock"));
            book.setCategory(new CategoryDAO().find(rs.getString("category_id")));
            book.setReview(new ReviewDAO().find(rs.getString("review_id")));
            book.setImagePath(rs.getString("imagePath"));
        }catch(SQLException e){
            setMessage("Error mapping Book: " + e.getMessage());
        }
        return book;
    }
    
    // ambil satu buku berdasarkan ID
    public Book findBookById(int bookId) {
        return super.find(String.valueOf(bookId));
    }
    
    // add data buku baru
    public void addBook(Book book) {
        this.book_id = book.getBook_id();
        this.ISBN = book.getISBN();
        this.price = book.getPrice();
        this.title = book.getTitle();
        this.author = book.getAuthor();
        this.publisher = book.getPublisher();
        this.publicationDate = book.getPublicationDate();
        this.width = book.getWidth();
        this.length = book.getLength();
        this.weight = book.getWeight();
        this.stock = book.getStock();
        this.description = book.getDescription();
        this.category = book.getCategory();
        
        super.insert();
        this.setMessage(super.getMessage());
    }
    
    // update data buku
    public void updateBook(Book book) {
        this.book_id = book.getBook_id();
        this.ISBN = book.getISBN();
        this.price = book.getPrice();
        this.title = book.getTitle();
        this.author = book.getAuthor();
        this.publisher = book.getPublisher();
        this.publicationDate = book.getPublicationDate();
        this.width = book.getWidth();
        this.length = book.getLength();
        this.weight = book.getWeight();
        this.stock = book.getStock();
        this.description = book.getDescription();
        this.category = book.getCategory();
        
        super.update();
        this.setMessage(super.getMessage());
    }

    // Menghapus buku berdasarkan ID
    public void deleteBook(int bookId) {
        this.book_id = bookId;
        super.delete();
        this.setMessage(super.getMessage());
    }

    // Mendapat semua buku
    public ArrayList<Book> getAllBooks() {
        return super.get();
    }

    // Cari buku berdasarkan publisher_id
    public ArrayList<Book> findByPublisher(int publisherId) {
        this.where("publisher_id = " + publisherId);
        return super.get();
    }

    // Cari buku berdasarkan category_id
    public ArrayList<Book> findByCategory(int categoryId) {
        this.where("category_id = " + categoryId);
        return super.get();
    }

    // Cari buku berdasarkan author_id (melalui tabel relasi author_book)
    public ArrayList<Book> findByAuthor(int authorId) {
        this.where("author_id = " + authorId);
        return super.get();
    }
}