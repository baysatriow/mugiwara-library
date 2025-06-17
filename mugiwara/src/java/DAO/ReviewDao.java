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
            review.setReview_id(rs.getInt("review_id"));
            review.setBook_id(rs.getInt("book_id"));
            review.setReviewer_id(rs.getInt("reviewer_id"));
            review.setRating(rs.getInt("rating"));
            review.setComment(rs.getString("comment"));
            
            // Handle review_date
            try {
                review.setReview_date(rs.getTimestamp("review_date"));
            } catch (SQLException e) {
                // If review_date doesn't exist, use current date
                review.setReview_date(new java.util.Date());
            }
            
            // Set Book if available in joined query
            try {
                String bookTitle = rs.getString("book_title");
                if (bookTitle != null) {
                    Book book = new Book();
                    book.setBook_id(rs.getInt("book_id"));
                    book.setTitle(bookTitle);
                    
                    try {
                        String bookImage = rs.getString("book_image");
                        if (bookImage != null) {
                            book.setImagePath(bookImage);
                        }
                    } catch (SQLException e) {
                        // book_image not available
                    }
                    
                    review.setBook(book);
                }
            } catch (SQLException e) {
                // Book data not available in this query
            }
            
            // Set User if available in joined query
            try {
                String userName = rs.getString("user_name");
                if (userName != null) {
                    Users user = new Users();
                    user.setUserId(rs.getInt("reviewer_id"));
                    user.setFullName(userName);
                    
                    try {
                        String username = rs.getString("username");
                        if (username != null) {
                            user.setUsername(username);
                        }
                    } catch (SQLException e) {
                        // username not available
                    }
                    
                    review.setUser(user);
                }
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
        try {
            String sql = "SELECT r.review_id, r.book_id, r.reviewer_id, r.rating, r.comment, r.review_date, " +
                        "b.title as book_title, b.image_path as book_image, " +
                        "u.full_name as user_name, u.username " +
                        "FROM review r " +
                        "LEFT JOIN book b ON r.book_id = b.book_id " +
                        "LEFT JOIN users u ON r.reviewer_id = u.user_id " +
                        "ORDER BY r.review_date DESC LIMIT 50";
            
            ArrayList<ArrayList<Object>> data = query(sql);
            ArrayList<Review> reviews = new ArrayList<>();
            
            for (ArrayList<Object> row : data) {
                if (row != null && row.size() >= 6) {
                    try {
                        Review review = new Review();
                        review.setReview_id(getIntValue(row.get(0)));
                        review.setBook_id(getIntValue(row.get(1)));
                        review.setReviewer_id(getIntValue(row.get(2)));
                        review.setRating(getIntValue(row.get(3)));
                        review.setComment(getStringValue(row.get(4)));
                        
                        // Handle review_date
                        Object dateObj = row.get(5);
                        if (dateObj instanceof java.sql.Timestamp) {
                            review.setReview_date((java.sql.Timestamp) dateObj);
                        } else if (dateObj instanceof java.sql.Date) {
                            review.setReview_date((java.sql.Date) dateObj);
                        } else {
                            review.setReview_date(new java.util.Date());
                        }
                        
                        // Set Book if available
                        if (row.size() > 6 && row.get(6) != null) {
                            Book book = new Book();
                            book.setBook_id(getIntValue(row.get(1)));
                            book.setTitle(getStringValue(row.get(6)));
                            
                            if (row.size() > 7 && row.get(7) != null) {
                                book.setImagePath(getStringValue(row.get(7)));
                            }
                            
                            review.setBook(book);
                        }
                        
                        // Set User if available
                        if (row.size() > 8 && row.get(8) != null) {
                            Users user = new Users();
                            user.setUserId(getIntValue(row.get(2)));
                            user.setFullName(getStringValue(row.get(8)));
                            
                            if (row.size() > 9 && row.get(9) != null) {
                                user.setUsername(getStringValue(row.get(9)));
                            }
                            
                            review.setUser(user);
                        }
                        
                        reviews.add(review);
                    } catch (Exception e) {
                        System.err.println("Error processing review row: " + e.getMessage());
                        continue;
                    }
                }
            }
            
            return reviews;
        } catch (Exception e) {
            setMessage("Error getting reviews with details: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public ArrayList<Review> getReviewsByBook(int bookId) {
        try {
            String sql = "SELECT r.review_id, r.book_id, r.reviewer_id, r.rating, r.comment, r.review_date, " +
                        "u.full_name as user_name, u.username " +
                        "FROM review r " +
                        "LEFT JOIN users u ON r.reviewer_id = u.user_id " +
                        "WHERE r.book_id = " + bookId + " " +
                        "ORDER BY r.review_date DESC LIMIT 20";
            
            ArrayList<ArrayList<Object>> data = query(sql);
            ArrayList<Review> reviews = new ArrayList<>();
            
            for (ArrayList<Object> row : data) {
                if (row != null && row.size() >= 6) {
                    try {
                        Review review = new Review();
                        review.setReview_id(getIntValue(row.get(0)));
                        review.setBook_id(getIntValue(row.get(1)));
                        review.setReviewer_id(getIntValue(row.get(2)));
                        review.setRating(getIntValue(row.get(3)));
                        review.setComment(getStringValue(row.get(4)));
                        
                        // Handle review_date
                        Object dateObj = row.get(5);
                        if (dateObj instanceof java.sql.Timestamp) {
                            review.setReview_date((java.sql.Timestamp) dateObj);
                        } else if (dateObj instanceof java.sql.Date) {
                            review.setReview_date((java.sql.Date) dateObj);
                        } else {
                            review.setReview_date(new java.util.Date());
                        }
                        
                        // Set User if available
                        if (row.size() > 6 && row.get(6) != null) {
                            Users user = new Users();
                            user.setUserId(getIntValue(row.get(2)));
                            user.setFullName(getStringValue(row.get(6)));
                            
                            if (row.size() > 7 && row.get(7) != null) {
                                user.setUsername(getStringValue(row.get(7)));
                            }
                            
                            review.setUser(user);
                        }
                        
                        reviews.add(review);
                    } catch (Exception e) {
                        System.err.println("Error processing review row: " + e.getMessage());
                        continue;
                    }
                }
            }
            
            return reviews;
        } catch (Exception e) {
            setMessage("Error getting reviews by book: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public ArrayList<Review> getLatestReviews(int limit) {
        try {
            int safeLimit = Math.min(limit, 20);
            
            String sql = "SELECT r.review_id, r.book_id, r.reviewer_id, r.rating, r.comment, r.review_date, " +
                        "b.title as book_title, b.image_path as book_image, " +
                        "u.full_name as user_name, u.username " +
                        "FROM review r " +
                        "LEFT JOIN book b ON r.book_id = b.book_id " +
                        "LEFT JOIN users u ON r.reviewer_id = u.user_id " +
                        "ORDER BY r.review_date DESC LIMIT " + safeLimit;
            
            return processReviewQuery(sql);
        } catch (Exception e) {
            setMessage("Error getting latest reviews: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    private ArrayList<Review> processReviewQuery(String sql) {
        ArrayList<ArrayList<Object>> data = query(sql);
        ArrayList<Review> reviews = new ArrayList<>();
        
        for (ArrayList<Object> row : data) {
            if (row != null && row.size() >= 6) {
                try {
                    Review review = new Review();
                    review.setReview_id(getIntValue(row.get(0)));
                    review.setBook_id(getIntValue(row.get(1)));
                    review.setReviewer_id(getIntValue(row.get(2)));
                    review.setRating(getIntValue(row.get(3)));
                    review.setComment(getStringValue(row.get(4)));
                    
                    // Handle review_date
                    Object dateObj = row.get(5);
                    if (dateObj instanceof java.sql.Timestamp) {
                        review.setReview_date((java.sql.Timestamp) dateObj);
                    } else if (dateObj instanceof java.sql.Date) {
                        review.setReview_date((java.sql.Date) dateObj);
                    } else {
                        review.setReview_date(new java.util.Date());
                    }
                    
                    // Set Book if available (for queries with book data)
                    if (row.size() > 6 && row.get(6) != null) {
                        Book book = new Book();
                        book.setBook_id(getIntValue(row.get(1)));
                        book.setTitle(getStringValue(row.get(6)));
                        
                        if (row.size() > 7 && row.get(7) != null) {
                            book.setImagePath(getStringValue(row.get(7)));
                        }
                        
                        review.setBook(book);
                    }
                    
                    // Set User if available
                    int userNameIndex = row.size() > 8 ? 8 : 6; // Adjust based on query structure
                    int usernameIndex = row.size() > 9 ? 9 : 7;
                    
                    if (row.size() > userNameIndex && row.get(userNameIndex) != null) {
                        Users user = new Users();
                        user.setUserId(getIntValue(row.get(2)));
                        user.setFullName(getStringValue(row.get(userNameIndex)));
                        
                        if (row.size() > usernameIndex && row.get(usernameIndex) != null) {
                            user.setUsername(getStringValue(row.get(usernameIndex)));
                        }
                        
                        review.setUser(user);
                    }
                    
                    reviews.add(review);
                } catch (Exception e) {
                    System.err.println("Error processing review row: " + e.getMessage());
                    continue;
                }
            }
        }
        
        return reviews;
    }

    public double getAverageRating(int bookId) {
        try {
            String sql = "SELECT AVG(rating) as avg_rating FROM review WHERE book_id = " + bookId;
            ArrayList<ArrayList<Object>> result = query(sql);
            
            if (!result.isEmpty() && result.get(0).get(0) != null) {
                return getDoubleValue(result.get(0).get(0));
            }
            return 0.0;
        } catch (Exception e) {
            setMessage("Error getting average rating: " + e.getMessage());
            return 0.0;
        }
    }

    public int getTotalReviews(int bookId) {
        try {
            String sql = "SELECT COUNT(*) as total FROM review WHERE book_id = " + bookId;
            ArrayList<ArrayList<Object>> result = query(sql);
            
            if (!result.isEmpty() && result.get(0).get(0) != null) {
                return getIntValue(result.get(0).get(0));
            }
            return 0;
        } catch (Exception e) {
            setMessage("Error getting total reviews: " + e.getMessage());
            return 0;
        }
    }

    public boolean insertReview(int bookId, int reviewerId, int rating, String comment) {
        try {
            String sql = "INSERT INTO review (book_id, reviewer_id, rating, comment, review_date) VALUES (" +
                        bookId + ", " + reviewerId + ", " + rating + ", '" + 
                        comment.replace("'", "''") + "', NOW())";
            
            int result = stmt.executeUpdate(sql);
            return result > 0;
        } catch (Exception e) {
            setMessage("Error inserting review: " + e.getMessage());
            return false;
        }
    }
    
    // Helper methods for safe casting
    private int getIntValue(Object obj) {
        if (obj == null) return 0;
        if (obj instanceof Integer) return (Integer) obj;
        if (obj instanceof Long) return ((Long) obj).intValue();
        if (obj instanceof Double) return ((Double) obj).intValue();
        if (obj instanceof String) {
            try {
                return Integer.parseInt((String) obj);
            } catch (NumberFormatException e) {
                return 0;
            }
        }
        return 0;
    }
    
    private double getDoubleValue(Object obj) {
        if (obj == null) return 0.0;
        if (obj instanceof Double) return (Double) obj;
        if (obj instanceof Float) return ((Float) obj).doubleValue();
        if (obj instanceof Integer) return ((Integer) obj).doubleValue();
        if (obj instanceof Long) return ((Long) obj).doubleValue();
        if (obj instanceof String) {
            try {
                return Double.parseDouble((String) obj);
            } catch (NumberFormatException e) {
                return 0.0;
            }
        }
        return 0.0;
    }
    
    private String getStringValue(Object obj) {
        if (obj == null) return "";
        return obj.toString();
    }
}
