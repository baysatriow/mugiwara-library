package DAO;

import Models.Review;
import Models.Book;
import Models.Users;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReviewDAO extends Models<Review> {
    
    public ReviewDAO() {
        table = "review";
        primaryKey = "review_id";
    }
    
    @Override
    Review toModel(ResultSet rs) {
        try {
            Review review = new Review();
            review.setReviewId(rs.getInt("review_id"));
            review.setBookId(rs.getInt("book_id"));
            review.setUserId(rs.getInt("reviewer_id"));
            review.setRating(rs.getInt("rating"));
            review.setComment(rs.getString("content"));
            
            // Set related objects if joined
            try {
                Book book = new Book();
                book.setBook_id(rs.getInt("book_id"));
                book.setTitle(rs.getString("book_title"));
                review.setBook(book);
            } catch (SQLException e) {
                // Book data not available in this query
            }
            
            try {
                Users user = new Users();
                user.setUserId(rs.getInt("reviewer_id"));
                user.setFullName(rs.getString("user_name"));
                review.setUser(user);
            } catch (SQLException e) {
                // User data not available in this query
            }
            
            return review;
        } catch (SQLException e) {
            setMessage("Error creating Review model: " + e.getMessage());
            return null;
        }
    }
    
    public ArrayList<Review> getReviewsWithDetails() {
        select("r.*, b.title as book_title, u.full_name as user_name");
        join("book b", "r.book_id = b.book_id");
        join("users u", "r.reviewer_id = u.user_id");
        addQuery("ORDER BY r.review_id DESC");
        table = "review r";
        ArrayList<Review> result = get();
        table = "review"; // Reset table name
        return result;
    }
    
    public ArrayList<Review> getReviewsByBook(int bookId) {
        select("r.*, u.full_name as user_name");
        join("users u", "r.reviewer_id = u.user_id");
        where("r.book_id = " + bookId);
        addQuery("ORDER BY r.review_id DESC");
        table = "review r";
        ArrayList<Review> result = get();
        table = "review"; // Reset table name
        return result;
    }
    
    public double getAverageRating(int bookId) {
        ArrayList<ArrayList<Object>> result = query(
            "SELECT AVG(rating) as avg_rating FROM review WHERE book_id = " + bookId
        );
        
        if (!result.isEmpty() && result.get(0).get(0) != null) {
            return (Double) result.get(0).get(0);
        }
        return 0.0;
    }
    
    public int getTotalReviews(int bookId) {
        ArrayList<ArrayList<Object>> result = query(
            "SELECT COUNT(*) as total FROM review WHERE book_id = " + bookId
        );
        
        if (!result.isEmpty()) {
            return ((Long) result.get(0).get(0)).intValue();
        }
        return 0;
    }
}
