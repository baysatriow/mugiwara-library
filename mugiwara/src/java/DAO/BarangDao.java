package DAO;

import Models.*;
import Config.ValidationConf;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class BarangDao extends Models<Book> {
    
    public BarangDao() {
        this.table = "book";
        this.primaryKey = "book_id";
    }
    
    @Override
    Book toModel(ResultSet rs) {
        Book book = new Book();
        try {
            book.setBook_id(rs.getInt("book_id")); // Set primary key
            book.setISBN(rs.getString("isbn"));
            book.setPrice(rs.getInt("price"));
            book.setTitle(rs.getString("title"));
            book.setDescription(rs.getString("description"));
            book.setPublicationDate(rs.getDate("publication_date"));
            book.setWidth(rs.getDouble("width"));
            book.setLength(rs.getDouble("length"));
            book.setWeight(rs.getInt("weight"));
            book.setStock(rs.getInt("stock"));
            book.setImagePath(rs.getString("image_path"));
            
            // Set Author
            Author author = new Author();
            author.setAuthor_id(rs.getInt("author_id"));
            author.setName(rs.getString("author_name"));
            author.setDescription(rs.getString("author_description"));
            book.setAuthor(author);
            
            // Set Publisher
            Publisher publisher = new Publisher();
            publisher.setPublisher_id(rs.getInt("publisher_id"));
            publisher.setName(rs.getString("publisher_name"));
            publisher.setDescription(rs.getString("publisher_description"));
            book.setPublisher(publisher);
            
            // Set Category
            Category category = new Category();
            category.setCategory_id(rs.getInt("category_id"));
            category.setName(rs.getString("category_name"));
            book.setCategory(category);
            
        } catch (SQLException e) {
            setMessage("Error mapping ResultSet to Book: " + e.getMessage());
        }
        return book;
    }
    
    // ===== BOOK OPERATIONS =====
    
    public boolean addBook(String isbn, String title, int authorId, int publisherId, 
                          int categoryId, int price, String description, Date publicationDate,
                          double width, double length, int weight, int stock, String imagePath) {
        try {
            // Validasi input
            if (ValidationConf.isEmpty(title) || ValidationConf.isEmpty(isbn)) {
                setMessage("Judul dan ISBN tidak boleh kosong");
                return false;
            }
            
            if (!ValidationConf.isValidISBN(isbn)) {
                setMessage("Format ISBN tidak valid");
                return false;
            }
            
            if (price < 0 || stock < 0) {
                setMessage("Harga dan stok tidak boleh negatif");
                return false;
            }
            
            connect();
            
            // Check if ISBN already exists
            if (isISBNExists(isbn)) {
                setMessage("ISBN sudah digunakan");
                return false;
            }
            
            // Sanitize input
            String sanitizedTitle = ValidationConf.sanitizeForSQL(title);
            String sanitizedISBN = ValidationConf.sanitizeForSQL(isbn);
            String sanitizedDescription = ValidationConf.sanitizeForSQL(description);
            String sanitizedImagePath = ValidationConf.sanitizeForSQL(imagePath);
            
            String query = "INSERT INTO book (isbn, title, author_id, publisher_id, category_id, " +
                          "price, description, publication_date, width, length, weight, stock, image_path) " +
                          "VALUES ('" + sanitizedISBN + "', '" + sanitizedTitle + "', " + authorId + ", " +
                          publisherId + ", " + categoryId + ", " + price + ", '" + sanitizedDescription + "', '" +
                          new java.sql.Date(publicationDate.getTime()) + "', " + width + ", " + length + ", " +
                          weight + ", " + stock + ", '" + sanitizedImagePath + "')";
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Buku berhasil ditambahkan");
                return true;
            }
            
        } catch (SQLException e) {
            setMessage("Gagal menambahkan buku: " + e.getMessage());
        }
        return false;
    }
    
    public boolean updateBook(int bookId, String isbn, String title, int authorId, int publisherId,
                             int categoryId, int price, String description, Date publicationDate,
                             double width, double length, int weight, int stock, String imagePath) {
        try {
            // Validasi input
            if (ValidationConf.isEmpty(title) || ValidationConf.isEmpty(isbn)) {
                setMessage("Judul dan ISBN tidak boleh kosong");
                return false;
            }
            
            if (price < 0 || stock < 0) {
                setMessage("Harga dan stok tidak boleh negatif");
                return false;
            }
            
            connect();
            
            // Check if ISBN exists for other books
            if (isISBNExistsForOtherBook(isbn, bookId)) {
                setMessage("ISBN sudah digunakan oleh buku lain");
                return false;
            }
            
            // Sanitize input
            String sanitizedTitle = ValidationConf.sanitizeForSQL(title);
            String sanitizedISBN = ValidationConf.sanitizeForSQL(isbn);
            String sanitizedDescription = ValidationConf.sanitizeForSQL(description);
            String sanitizedImagePath = ValidationConf.sanitizeForSQL(imagePath);
            
            String query = "UPDATE book SET isbn = '" + sanitizedISBN + "', title = '" + sanitizedTitle + "', " +
                          "author_id = " + authorId + ", publisher_id = " + publisherId + ", " +
                          "category_id = " + categoryId + ", price = " + price + ", " +
                          "description = '" + sanitizedDescription + "', " +
                          "publication_date = '" + new java.sql.Date(publicationDate.getTime()) + "', " +
                          "width = " + width + ", length = " + length + ", weight = " + weight + ", " +
                          "stock = " + stock + ", image_path = '" + sanitizedImagePath + "' " +
                          "WHERE book_id = " + bookId;
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Buku berhasil diupdate");
                return true;
            }
            
        } catch (SQLException e) {
            setMessage("Gagal mengupdate buku: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    public boolean deleteBook(int bookId) {
        try {
            connect();
            String query = "DELETE FROM book WHERE book_id = " + bookId;
            int result = stmt.executeUpdate(query);
            
            if (result > 0) {
                setMessage("Buku berhasil dihapus");
                return true;
            } else {
                setMessage("Buku tidak ditemukan");
            }
            
        } catch (SQLException e) {
            setMessage("Gagal menghapus buku: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    public ArrayList<Book> getAllBooksWithDetails() {
        ArrayList<Book> books = new ArrayList<>();
        try {
            connect();
            String query = "SELECT b.*, a.name as author_name, a.description as author_description, " +
                          "p.name as publisher_name, p.description as publisher_description, " +
                          "c.name as category_name " +
                          "FROM book b " +
                          "LEFT JOIN author a ON b.author_id = a.author_id " +
                          "LEFT JOIN publisher p ON b.publisher_id = p.publisher_id " +
                          "LEFT JOIN category c ON b.category_id = c.category_id " +
                          "ORDER BY b.book_id DESC";
            
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                books.add(toModel(rs));
            }
            
        } catch (SQLException e) {
            setMessage("Error getting books: " + e.getMessage());
        } finally {
            disconnect();
        }
        return books;
    }
    
    public ArrayList<Book> searchBooks(String keyword) {
        ArrayList<Book> books = new ArrayList<>();
        try {
            if (ValidationConf.isEmpty(keyword)) {
                return getAllBooksWithDetails();
            }
            
            connect();
            String sanitizedKeyword = ValidationConf.sanitizeForSQL(keyword);
            
            String query = "SELECT b.*, a.name as author_name, a.description as author_description, " +
                          "p.name as publisher_name, p.description as publisher_description, " +
                          "c.name as category_name " +
                          "FROM book b " +
                          "LEFT JOIN author a ON b.author_id = a.author_id " +
                          "LEFT JOIN publisher p ON b.publisher_id = p.publisher_id " +
                          "LEFT JOIN category c ON b.category_id = c.category_id " +
                          "WHERE b.title LIKE '%" + sanitizedKeyword + "%' " +
                          "OR b.isbn LIKE '%" + sanitizedKeyword + "%' " +
                          "OR a.name LIKE '%" + sanitizedKeyword + "%' " +
                          "OR p.name LIKE '%" + sanitizedKeyword + "%' " +
                          "OR c.name LIKE '%" + sanitizedKeyword + "%' " +
                          "ORDER BY b.book_id DESC";
            
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                books.add(toModel(rs));
            }
            
        } catch (SQLException e) {
            setMessage("Error searching books: " + e.getMessage());
        } finally {
            disconnect();
        }
        return books;
    }
    
    // ===== AUTHOR OPERATIONS =====
    
    public boolean addAuthor(String name, String description) {
        try {
            if (ValidationConf.isEmpty(name)) {
                setMessage("Nama penulis tidak boleh kosong");
                return false;
            }
            
            connect();
            
            String sanitizedName = ValidationConf.sanitizeForSQL(name);
            String sanitizedDescription = ValidationConf.sanitizeForSQL(description);
            
            String query = "INSERT INTO author (name, description) VALUES ('" + 
                          sanitizedName + "', '" + sanitizedDescription + "')";
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Penulis berhasil ditambahkan");
                return true;
            }
            
        } catch (SQLException e) {
            setMessage("Gagal menambahkan penulis: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    public ArrayList<Author> getAllAuthors() {
        ArrayList<Author> authors = new ArrayList<>();
        try {
            connect();
            String query = "SELECT * FROM author ORDER BY name";
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                Author author = new Author();
                author.setAuthor_id(rs.getInt("author_id"));
                author.setName(rs.getString("name"));
                author.setDescription(rs.getString("description"));
                authors.add(author);
            }
            
        } catch (SQLException e) {
            setMessage("Error getting authors: " + e.getMessage());
        } finally {
            disconnect();
        }
        return authors;
    }
    
    // ===== CATEGORY OPERATIONS =====
    
    public boolean addCategory(String name) {
        try {
            if (ValidationConf.isEmpty(name)) {
                setMessage("Nama kategori tidak boleh kosong");
                return false;
            }
            
            connect();
            
            String sanitizedName = ValidationConf.sanitizeForSQL(name);
            String query = "INSERT INTO category (name) VALUES ('" + sanitizedName + "')";
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Kategori berhasil ditambahkan");
                return true;
            }
            
        } catch (SQLException e) {
            setMessage("Gagal menambahkan kategori: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> categories = new ArrayList<>();
        try {
            connect();
            String query = "SELECT * FROM category ORDER BY name";
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                Category category = new Category();
                category.setCategory_id(rs.getInt("category_id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }
            
        } catch (SQLException e) {
            setMessage("Error getting categories: " + e.getMessage());
        } finally {
            disconnect();
        }
        return categories;
    }
    
    // ===== PUBLISHER OPERATIONS =====
    
    public boolean addPublisher(String name, String description) {
        try {
            if (ValidationConf.isEmpty(name)) {
                setMessage("Nama penerbit tidak boleh kosong");
                return false;
            }
            
            connect();
            
            String sanitizedName = ValidationConf.sanitizeForSQL(name);
            String sanitizedDescription = ValidationConf.sanitizeForSQL(description);
            
            String query = "INSERT INTO publisher (name, description) VALUES ('" + 
                          sanitizedName + "', '" + sanitizedDescription + "')";
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Penerbit berhasil ditambahkan");
                return true;
            }
            
        } catch (SQLException e) {
            setMessage("Gagal menambahkan penerbit: " + e.getMessage());
        } finally {
            disconnect();
        }
        return false;
    }
    
    public ArrayList<Publisher> getAllPublishers() {
        ArrayList<Publisher> publishers = new ArrayList<>();
        try {
            connect();
            String query = "SELECT * FROM publisher ORDER BY name";
            ResultSet rs = stmt.executeQuery(query);
            
            while (rs.next()) {
                Publisher publisher = new Publisher();
                publisher.setName(rs.getString("name"));
                publisher.setPublisher_id(rs.getInt("publisher_id"));
                publisher.setDescription(rs.getString("description"));
                publishers.add(publisher);
            }
            
        } catch (SQLException e) {
            setMessage("Error getting publishers: " + e.getMessage());
        } finally {
            disconnect();
        }
        return publishers;
    }
    
    // ===== HELPER METHODS =====
    
    private boolean isISBNExists(String isbn) {
        try {
            String sanitizedISBN = ValidationConf.sanitizeForSQL(isbn);
            String query = "SELECT COUNT(*) as count FROM book WHERE isbn = '" + sanitizedISBN + "'";
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            setMessage("Error checking ISBN: " + e.getMessage());
        }
        return false;
    }
    
    private boolean isISBNExistsForOtherBook(String isbn, int bookId) {
        try {
            String sanitizedISBN = ValidationConf.sanitizeForSQL(isbn);
            String query = "SELECT COUNT(*) as count FROM book WHERE isbn = '" + sanitizedISBN + 
                          "' AND book_id != " + bookId;
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
        } catch (SQLException e) {
            setMessage("Error checking ISBN: " + e.getMessage());
        }
        return false;
    }
    
    public Book getBookById(int bookId) {
        try {
            connect();
            String query = "SELECT b.*, a.name as author_name, a.description as author_description, " +
                          "p.name as publisher_name, p.description as publisher_description, " +
                          "c.name as category_name " +
                          "FROM book b " +
                          "LEFT JOIN author a ON b.author_id = a.author_id " +
                          "LEFT JOIN publisher p ON b.publisher_id = p.publisher_id " +
                          "LEFT JOIN category c ON b.category_id = c.category_id " +
                          "WHERE b.book_id = " + bookId;
            
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return toModel(rs);
            }
            
        } catch (SQLException e) {
            setMessage("Error getting book: " + e.getMessage());
        } finally {
            disconnect();
        }
        return null;
    }
    
    public ArrayList<Book> getBooksByCategory(int categoryId) {
        ArrayList<Book> books = new ArrayList<>();
        try {
            connect();
            String query = "SELECT b.*, a.name as author_name, a.description as author_description, " +
                          "p.name as publisher_name, p.description as publisher_description, " +
                          "c.name as category_name " +
                          "FROM book b " +
                          "LEFT JOIN author a ON b.author_id = a.author_id " +
                          "LEFT JOIN publisher p ON b.publisher_id = p.publisher_id " +
                          "LEFT JOIN category c ON b.category_id = c.category_id " +
                          "WHERE b.category_id = " + categoryId + " " +
                          "ORDER BY b.book_id DESC";
            
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                books.add(toModel(rs));
            }
            
        } catch (SQLException e) {
            setMessage("Error getting books by category: " + e.getMessage());
        } finally {
            disconnect();
        }
        return books;
    }
}
