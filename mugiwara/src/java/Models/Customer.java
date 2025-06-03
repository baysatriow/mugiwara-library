/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
/**
 *
 * @author VIVOBOOK
 */
public class Customer {

    private String customerID;
    private String accountStatus;
    private Date dateJoined;
    private int loyaltyPoints;
    // Jika ada cartID tunggal, itu mungkin menunjukkan cart aktif saat ini.
    // Namun, relasi objek 'Cart' ke 'Customer' lebih umum untuk melacak keranjang
    // atau riwayat keranjang. Kita akan fokus pada List<Cart> untuk relasi Many-to-Many.
    // private String cartID; // Dihapus karena relasi objek Cart akan ditangani oleh List<Cart>

    // Relasi One-to-One
    private User user; // Satu Customer terkait dengan satu User
    private Address address; // Satu Customer memiliki satu Address (alamat utama)

    // Relasi One-to-Many (menggunakan List untuk menyimpan banyak objek terkait)
    private List<Cart> carts; // Seorang Customer bisa memiliki banyak Cart (misal: riwayat, aktif)
    private List<Order> orders; // Seorang Customer bisa memiliki banyak Order
    private List<Review> reviews; // Seorang Customer bisa memiliki banyak Review
    private List<Payment> payments; // Seorang Customer bisa memiliki banyak Payment


    /**
     * Konstruktor default
     * Menginisialisasi List untuk mencegah NullPointerException.
     */
    public Customer() {
        this.carts = new ArrayList<>();
        this.orders = new ArrayList<>();
        this.reviews = new ArrayList<>();
        this.payments = new ArrayList<>();
    }

    /**
     * Konstruktor dengan atribut dasar Customer dan relasi One-to-One.
     * Atribut List diinisialisasi secara otomatis oleh konstruktor default atau saat objek dibuat.
     * @param customerID ID Customer
     * @param accountStatus Status Akun (e.g., "Active", "Inactive")
     * @param dateJoined Tanggal Bergabung
     * @param loyaltyPoints Poin Loyalitas
     * @param user Objek User yang terkait dengan Customer ini
     * @param address Objek Address yang terkait dengan Customer ini
     */
    public Customer(String customerID, String accountStatus, Date dateJoined, int loyaltyPoints, User user, Address address) {
        this.customerID = customerID;
        this.accountStatus = accountStatus;
        this.dateJoined = dateJoined;
        this.loyaltyPoints = loyaltyPoints;
        this.user = user;
        this.address = address;
        // Inisialisasi List juga di sini jika konstruktor ini yang paling sering digunakan
        this.carts = new ArrayList<>();
        this.orders = new ArrayList<>();
        this.reviews = new ArrayList<>();
        this.payments = new ArrayList<>();
    }

    // --- Getter dan Setter untuk atribut ---

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(String accountStatus) {
        this.accountStatus = accountStatus;
    }

    public Date getDateJoined() {
        return dateJoined;
    }

    public void setDateJoined(Date dateJoined) {
        this.dateJoined = dateJoined;
    }

    public int getLoyaltyPoints() {
        return loyaltyPoints;
    }

    public void setLoyaltyPoints(int loyaltyPoints) {
        this.loyaltyPoints = loyaltyPoints;
    }

    // --- Getter dan Setter untuk relasi One-to-One ---

    public User getUser() {
        return user;
    }

    /**
     * Menetapkan objek User yang terkait dengan Customer ini.
     * @param user Objek User
     */
    public void setUser(User user) {
        this.user = user;
    }

    public Address getAddress() {
        return address;
    }

    /**
     * Menetapkan objek Address yang terkait dengan Customer ini.
     * @param address Objek Address
     */
    public void setAddress(Address address) {
        this.address = address;
    }

    // --- Getter dan Setter untuk relasi One-to-Many (mengembalikan List) ---
    // Biasanya, setter untuk List sebaiknya tidak digunakan secara langsung
    // kecuali untuk inisialisasi atau mengganti seluruh koleksi.
    // Metode 'add' lebih disarankan untuk penambahan satu per satu.

    public List<Cart> getCarts() {
        return carts;
    }

    // Setter ini bisa digunakan untuk menginisialisasi List secara keseluruhan
    public void setCarts(List<Cart> carts) {
        this.carts = carts;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    public List<Payment> getPayments() {
        return payments;
    }

    public void setPayments(List<Payment> payments) {
        this.payments = payments;
    }

    // --- Metode untuk menambahkan elemen ke List (praktik yang lebih baik) ---

    /**
     * Menambahkan Cart baru ke daftar carts Customer.
     * @param cart Objek Cart yang akan ditambahkan.
     */
    public void addCart(Cart cart) {
        // Cek jika list null (meskipun sudah diinisialisasi di konstruktor, ini sebagai pengamanan)
        if (this.carts == null) {
            this.carts = new ArrayList<>();
        }
        this.carts.add(cart);
    }

    /**
     * Menambahkan Order baru ke daftar orders Customer.
     * @param order Objek Order yang akan ditambahkan.
     */
    public void addOrder(Order order) {
        if (this.orders == null) {
            this.orders = new ArrayList<>();
        }
        this.orders.add(order);
    }

    /**
     * Menambahkan Review baru ke daftar reviews Customer.
     * @param review Objek Review yang akan ditambahkan.
     */
    public void addReview(Review review) {
        if (this.reviews == null) {
            this.reviews = new ArrayList<>();
        }
        this.reviews.add(review);
    }

    /**
     * Menambahkan Payment baru ke daftar payments Customer.
     * @param payment Objek Payment yang akan ditambahkan.
     */
    public void addPayment(Payment payment) {
        if (this.payments == null) {
            this.payments = new ArrayList<>();
        }
        this.payments.add(payment);
    }

    // --- Metode (opsional, jika ada perilaku spesifik Customer) ---
    /**
     * Menambahkan poin loyalitas ke saldo Customer.
     * @param points Jumlah poin yang akan ditambahkan.
     */
    public void addLoyaltyPoints(int points) {
        if (points > 0) {
            this.loyaltyPoints += points;
            System.out.println("Loyalty points updated. Current total: " + this.loyaltyPoints);
        } else {
            System.out.println("Points to add must be positive.");
        }
    }

    /**
     * Mengurangi poin loyalitas dari saldo Customer (misalnya untuk redeem).
     * @param points Jumlah poin yang akan dikurangi.
     * @return true jika poin berhasil dikurangi, false jika poin tidak cukup.
     */
    public boolean redeemLoyaltyPoints(int points) {
        if (points > 0 && this.loyaltyPoints >= points) {
            this.loyaltyPoints -= points;
            System.out.println("Loyalty points redeemed. Remaining: " + this.loyaltyPoints);
            return true;
        } else {
            System.out.println("Failed to redeem points. Not enough points or invalid amount.");
            return false;
        }
    }

    /**
     * Memperbarui status akun Customer.
     * @param newStatus Status akun yang baru.
     */
    public void updateAccountStatus(String newStatus) {
        if (newStatus != null && !newStatus.trim().isEmpty()) {
            this.accountStatus = newStatus;
            System.out.println("Account status for customer " + this.customerID + " updated to: " + newStatus);
        } else {
            System.out.println("New status cannot be empty.");
        }
    }

    @Override
    public String toString() {
        return "Customer{" +
               "customerID='" + customerID + '\'' +
               ", accountStatus='" + accountStatus + '\'' +
               ", dateJoined=" + dateJoined +
               ", loyaltyPoints=" + loyaltyPoints +
               // Asumsi User memiliki getId() seperti di referensi Anda
               ", userID=" + (user != null ? user.getId() : "N/A") +
               // Asumsi Address memiliki getAddressID()
               ", addressID=" + (address != null ? address.getAddressID() : "N/A") +
               ", numCarts=" + carts.size() +
               ", numOrders=" + orders.size() +
               ", numReviews=" + reviews.size() +
               ", numPayments=" + payments.size() +
               '}';
    }
}
