package Models;

import java.util.Date;
import java.util.List;

public class Book implements Searchable {
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
    public List<Review> review;
    public String imagePath;

    public Book(String ISBN, int price, String title, Author author, Publisher publisher, Date publicationDate, double width, double length, int weight, int stock, String description, Category category) {
        this.ISBN = ISBN;
        this.price = price;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.publicationDate = publicationDate;
        this.width = width;
        this.length = length;
        this.weight = weight;
        this.stock = stock;
        this.description = description;
        this.category = category;
    }

    public Book() {}

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setAuthor(Author author) {
        this.author = author;
    }

    public void setPublisher(Publisher publisher) {
        this.publisher = publisher;
    }

    public void setPublicationDate(Date publicationDate) {
        this.publicationDate = publicationDate;
    }

    public void setWidth(double width) {
        this.width = width;
    }

    public void setLength(double length) {
        this.length = length;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public void setReview(List<Review> review) {
        this.review = review;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getISBN() {
        return ISBN;
    }

    public int getPrice() {
        return price;
    }

    public String getTitle() {
        return title;
    }

    public Author getAuthor() {
        return author;
    }

    public Publisher getPublisher() {
        return publisher;
    }

    public Date getPublicationDate() {
        return publicationDate;
    }

    public double getWidth() {
        return width;
    }

    public double getLength() {
        return length;
    }

    public int getWeight() {
        return weight;
    }

    public int getStock() {
        return stock;
    }

    public String getDescription() {
        return description;
    }

    public Category getCategory() {
        return category;
    }

    public List<Review> getReview() {
        return review;
    }

    public String getImagePath() {
        return imagePath;
    }
    
    public void bookInfo() {
    }
    
    public void search(String x){
        
    }
    
    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }
}
