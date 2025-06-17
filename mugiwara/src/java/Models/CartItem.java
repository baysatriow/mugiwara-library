package Models;

public class CartItem {
    private int cart_item_id;
    private int cart_id;
    private Book book;
    private int quantity;
    private double harga;

    // Constructors
    public CartItem() {}

    public CartItem(Book book, int quantity, double harga) {
        this.book = book;
        this.quantity = quantity;
        this.harga = harga;
    }

    public CartItem(int cart_id, Book book, int quantity, double harga) {
        this.cart_id = cart_id;
        this.book = book;
        this.quantity = quantity;
        this.harga = harga;
    }

    // Getters and Setters
    public int getCart_item_id() {
        return cart_item_id;
    }

    public void setCart_item_id(int cart_item_id) {
        this.cart_item_id = cart_item_id;
    }

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
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
    }

    public double getHarga() {
        return harga;
    }

    public void setHarga(double harga) {
        this.harga = harga;
    }

    // Utility methods
    public double getTotalPrice() {
        return harga * quantity;
    }

    public boolean isValid() {
        return book != null && quantity > 0 && harga >= 0;
    }
}
