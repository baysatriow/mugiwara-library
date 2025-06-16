package Models;

public class OrderItem extends Cart{
    private Book book; 
    private int quantity; 
    private double price; 
    private double total; 

    public OrderItem() {}
    
    public OrderItem(Book book, int quantity, double price) {
        this.book = book;
        this.quantity = quantity;
        this.price = price;
        this.total = calculateTotal();
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.total = calculateTotal(); 
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
        this.total = calculateTotal(); 
    }

    public double getTotal() {
        return total;
    }

    public double calculateTotal() {
        return this.quantity * this.price;
    }
}

