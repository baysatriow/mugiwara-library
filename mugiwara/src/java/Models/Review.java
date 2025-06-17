package Models;

import java.util.Date;

public class Review {
    private int review_id;
    private int book_id;
    private int reviewer_id;
    private int rating;
    private String comment;
    private Date review_date;
    private Book book;
    private Users user;

    // Constructors
    public Review() {}

    public Review(int book_id, int reviewer_id, int rating, String comment) {
        this.book_id = book_id;
        this.reviewer_id = reviewer_id;
        this.rating = rating;
        this.comment = comment;
        this.review_date = new Date();
    }

    // Getters and Setters matching database columns
    public int getReview_id() {
        return review_id;
    }

    public void setReview_id(int review_id) {
        this.review_id = review_id;
    }

    public int getBook_id() {
        return book_id;
    }

    public void setBook_id(int book_id) {
        this.book_id = book_id;
    }

    public int getReviewer_id() {
        return reviewer_id;
    }

    public void setReviewer_id(int reviewer_id) {
        this.reviewer_id = reviewer_id;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public Date getReview_date() {
        return review_date;
    }

    public void setReview_date(Date review_date) {
        this.review_date = review_date;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    // Legacy getters for backward compatibility
    public int getReviewId() { return review_id; }
    public void setReviewId(int reviewId) { this.review_id = reviewId; }
    
    public int getBookId() { return book_id; }
    public void setBookId(int bookId) { this.book_id = bookId; }
    
    public int getUserId() { return reviewer_id; }
    public void setUserId(int userId) { this.reviewer_id = userId; }
    
    public Date getReviewDate() { return review_date; }
    public void setReviewDate(Date reviewDate) { this.review_date = reviewDate; }

    // Utility methods
    public String getStarRating() {
        StringBuilder stars = new StringBuilder();
        for (int i = 1; i <= 5; i++) {
            if (i <= rating) {
                stars.append("★");
            } else {
                stars.append("☆");
            }
        }
        return stars.toString();
    }

    public String getRatingClass() {
        if (rating >= 4) return "text-success";
        else if (rating >= 3) return "text-warning";
        else return "text-danger";
    }

    public String getRatingText() {
        switch (rating) {
            case 5: return "Sangat Bagus";
            case 4: return "Bagus";
            case 3: return "Cukup";
            case 2: return "Kurang";
            case 1: return "Sangat Kurang";
            default: return "Tidak ada rating";
        }
    }
}
