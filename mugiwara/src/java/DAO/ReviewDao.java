package DAO;

import Models.*;
import Config.ValidationConf;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class ReviewDao extends Models<Review> {
    
    public ReviewDao() {
        this.table = "review";
        this.primaryKey = "review_id";
    }
    
    @Override
    Review toModel(ResultSet rs) {
        Review review = new Review();
        try {
            review.setReviewId(rs.getInt("review_id"));
            review.setBookId(rs.getInt("book_id"));
            review.setUserId(rs.getInt("user_id"));
            review.setRating(rs.getInt("rating"));
            review.setComment(rs.getString("comment"));
            review.setReviewDate(rs.getDate("review_date"));
            
            // Set book info if available
            try {
                Book book = new Book();
                book.setBook_id(rs.getInt("book_id"));
                book.setTitle(rs.getString("book_title"));
                book.setImagePath(rs.getString("book_image"));
                review.setBook(book);
            } catch (SQLException e) {
                // Book info not available in this query
            }
            
            // Set user info if available
            try {
                Users user = new Users();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setFullName(rs.getString("full_name"));
                review.setUser(user);
            } catch (SQLException e) {
                // User info not available in this query
            }
            
        } catch (SQLException e) {
            setMessage("Error mapping ResultSet to Review: " + e.getMessage());
        }
        return review;
    }
    
    /**
     * Add new review
     */
    public boolean addReview(int bookId, int userId, int rating, String comment) {
        try {
            // Validasi input
            if (rating < 1 || rating > 5) {
                setMessage("Rating harus antara 1-5");
                return false;
            }
            
            if (ValidationConf.isEmpty(comment)) {
                setMessage("Komentar tidak boleh kosong");
                return false;
            }
            
            connect();
            
            if (stmt == null) {
                setMessage("Statement database tidak tersedia");
                return false;
            }
            
            // Check if user already reviewed this book
            if (hasUserReviewedBook(userId, bookId)) {
                setMessage("Anda sudah memberikan review untuk buku ini");
                return false;
            }
            
            String sanitizedComment = ValidationConf.sanitizeForSQL(comment);
            
            String query = "INSERT INTO review (book_id, user_id, rating, comment, review_date) " +
                          "VALUES (" + bookId + ", " + userId + ", " + rating + ", '" + 
                          sanitizedComment + "', NOW())";
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Review berhasil ditambahkan");
                return true;
            } else {
                setMessage("Gagal menambahkan review");
                return false;
            }
            
        } catch (SQLException e) {
            setMessage("Gagal menambahkan review: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }
    
    /**
     * Get all reviews with book and user details
     */
    public ArrayList<Review> getAllReviewsWithDetails() {
        ArrayList<Review> reviews = new ArrayList<>();
        try {
            connect();
            
            if (stmt == null) {
                setMessage("Statement database tidak tersedia");
                return reviews;
            }
            
            String query = "SELECT r.*, b.title as book_title, b.image_path as book_image, " +
                          "u.username, u.full_name " +
                          "FROM review r " +
                          "LEFT JOIN book b ON r.book_id = b.book_id " +
                          "LEFT JOIN users u ON r.user_id = u.user_id " +
                          "ORDER BY r.review_date DESC";
            
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                reviews.add(toModel(rs));
            }
            
        } catch (SQLException e) {
            setMessage("Error getting reviews: " + e.getMessage());
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return reviews;
    }
    
    /**
     * Get reviews for specific book
     */
    public ArrayList<Review> getReviewsByBook(int bookId) {
        ArrayList<Review> reviews = new ArrayList<>();
        try {
            connect();
            
            if (stmt == null) {
                setMessage("Statement database tidak tersedia");
                return reviews;
            }
            
            String query = "SELECT r.*, u.username, u.full_name " +
                          "FROM review r " +
                          "LEFT JOIN users u ON r.user_id = u.user_id " +
                          "WHERE r.book_id = " + bookId + " " +
                          "ORDER BY r.review_date DESC";
            
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                reviews.add(toModel(rs));
            }
            
        } catch (SQLException e) {
            setMessage("Error getting reviews by book: " + e.getMessage());
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return reviews;
    }
    
    /**
     * Get recent reviews (limited)
     */
    public ArrayList<Review> getRecentReviews(int limit) {
        ArrayList<Review> reviews = new ArrayList<>();
        try {
            connect();
            
            if (stmt == null) {
                setMessage("Statement database tidak tersedia");
                return reviews;
            }
            
            String query = "SELECT r.*, b.title as book_title, b.image_path as book_image, " +
                          "u.username, u.full_name " +
                          "FROM review r " +
                          "LEFT JOIN book b ON r.book_id = b.book_id " +
                          "LEFT JOIN users u ON r.user_id = u.user_id " +
                          "ORDER BY r.review_date DESC " +
                          "LIMIT " + limit;
            
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                reviews.add(toModel(rs));
            }
            
        } catch (SQLException e) {
            setMessage("Error getting recent reviews: " + e.getMessage());
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return reviews;
    }
    
    /**
     * Get average rating for a book
     */
    public double getAverageRating(int bookId) {
        try {
            connect();
            
            if (stmt == null) {
                setMessage("Statement database tidak tersedia");
                return 0.0;
            }
            
            String query = "SELECT AVG(rating) as avg_rating FROM review WHERE book_id = " + bookId;
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return rs.getDouble("avg_rating");
            }
            
        } catch (SQLException e) {
            setMessage("Error getting average rating: " + e.getMessage());
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return 0.0;
    }
    
    /**
     * Get total review count for a book
     */
    public int getReviewCount(int bookId) {
        try {
            connect();
            
            if (stmt == null) {
                setMessage("Statement database tidak tersedia");
                return 0;
            }
            
            String query = "SELECT COUNT(*) as review_count FROM review WHERE book_id = " + bookId;
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return rs.getInt("review_count");
            }
            
        } catch (SQLException e) {
            setMessage("Error getting review count: " + e.getMessage());
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return 0;
    }
    
    /**
     * Check if user has already reviewed a book
     */
    private boolean hasUserReviewedBook(int userId, int bookId) {
        try {
            String query = "SELECT COUNT(*) as count FROM review WHERE user_id = " + userId + 
                          " AND book_id = " + bookId;
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                return rs.getInt("count") > 0;
            }
            
        } catch (SQLException e) {
            setMessage("Error checking user review: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }
    
    /**
     * Update review
     */
    public boolean updateReview(int reviewId, int rating, String comment) {
        try {
            // Validasi input
            if (rating < 1 || rating > 5) {
                setMessage("Rating harus antara 1-5");
                return false;
            }
            
            if (ValidationConf.isEmpty(comment)) {
                setMessage("Komentar tidak boleh kosong");
                return false;
            }
            
            connect();
            
            if (stmt == null) {
                setMessage("Statement database tidak tersedia");
                return false;
            }
            
            String sanitizedComment = ValidationConf.sanitizeForSQL(comment);
            
            String query = "UPDATE review SET rating = " + rating + ", comment = '" + 
                          sanitizedComment + "' WHERE review_id = " + reviewId;
            
            int result = stmt.executeUpdate(query);
            if (result > 0) {
                setMessage("Review berhasil diupdate");
                return true;
            } else {
                setMessage("Review tidak ditemukan");
                return false;
            }
            
        } catch (SQLException e) {
            setMessage("Gagal mengupdate review: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }
    
    /**
     * Delete review
     */
    public boolean deleteReview(int reviewId) {
        try {
            connect();
            
            if (stmt == null) {
                setMessage("Statement database tidak tersedia");
                return false;
            }
            
            String query = "DELETE FROM review WHERE review_id = " + reviewId;
            int result = stmt.executeUpdate(query);
            
            if (result > 0) {
                setMessage("Review berhasil dihapus");
                return true;
            } else {
                setMessage("Review tidak ditemukan");
                return false;
            }
            
        } catch (SQLException e) {
            setMessage("Gagal menghapus review: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            disconnect();
        }
    }
    
    /**
     * Get reviews by user
     */
    public ArrayList<Review> getReviewsByUser(int userId) {
        ArrayList<Review> reviews = new ArrayList<>();
        try {
            connect();
            
            if (stmt == null) {
                setMessage("Statement database tidak tersedia");
                return reviews;
            }
            
            String query = "SELECT r.*, b.title as book_title, b.image_path as book_image " +
                          "FROM review r " +
                          "LEFT JOIN book b ON r.book_id = b.book_id " +
                          "WHERE r.user_id = " + userId + " " +
                          "ORDER BY r.review_date DESC";
            
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                reviews.add(toModel(rs));
            }
            
        } catch (SQLException e) {
            setMessage("Error getting reviews by user: " + e.getMessage());
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return reviews;
    }
    
    /**
     * Get top rated books based on reviews
     */
    public ArrayList<Book> getTopRatedBooks(int limit) {
        ArrayList<Book> books = new ArrayList<>();
        try {
            connect();
            
            if (stmt == null) {
                setMessage("Statement database tidak tersedia");
                return books;
            }
            
            String query = "SELECT b.*, AVG(r.rating) as avg_rating, COUNT(r.review_id) as review_count " +
                          "FROM book b " +
                          "INNER JOIN review r ON b.book_id = r.book_id " +
                          "GROUP BY b.book_id " +
                          "HAVING COUNT(r.review_id) >= 1 " +
                          "ORDER BY avg_rating DESC, review_count DESC " +
                          "LIMIT " + limit;
            
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Book book = new Book();
                book.setBook_id(rs.getInt("book_id"));
                book.setTitle(rs.getString("title"));
                book.setISBN(rs.getString("isbn"));
                book.setPrice(rs.getInt("price"));
                book.setDescription(rs.getString("description"));
                book.setImagePath(rs.getString("image_path"));
                book.setStock(rs.getInt("stock"));
                book.setPublicationDate(rs.getDate("publication_date"));
                
                // Set average rating and review count as additional info
                book.setAverageRating(rs.getDouble("avg_rating"));
                book.setReviewCount(rs.getInt("review_count"));
                
                books.add(book);
            }
            
        } catch (SQLException e) {
            setMessage("Error getting top rated books: " + e.getMessage());
            e.printStackTrace();
        } finally {
            disconnect();
        }
        return books;
    }
}
