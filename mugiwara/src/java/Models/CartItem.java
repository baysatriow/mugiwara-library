package Models;

/**
 *
 * @author ASUS
 */
public class CartItem {
    private Book book;
    private int quantity;
    private double harga;

    public CartItem(Book book, int quantity, double harga) {
        this.book = book;
        this.quantity = quantity;
        this.harga = harga;
    }

    //Kelas Book di Isagi
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

    public double total() {
        return harga * quantity;
    }
}

