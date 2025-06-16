package DAO;

import Models.Author;
import Models.Book;
import Models.Category;
import Models.Publisher;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class BookDAO extends Models<Book> {
    
    public BookDAO() {
        table = "book";
        primaryKey = "book_id";
    }
    
    @Override
    Book toModel(ResultSet rs) {
        try {
            Book book = new Book();
            book.setBook_id(rs.getInt("book_id"));
            book.setISBN(rs.getString("isbn"));
            book.setTitle(rs.getString("title"));
            book.setPrice(rs.getInt("price"));
            book.setDescription(rs.getString("description"));
            book.setPublicationDate(rs.getDate("publication_date"));
            book.setWidth(rs.getDouble("width"));
            book.setLength(rs.getDouble("length"));
            book.setWeight(rs.getInt("weight"));
            book.setStock(rs.getInt("stock"));
            book.setImagePath(rs.getString("image_path"));
            
            // Set related objects if joined
            try {
                Author author = new Author();
                author.setAuthor_id(rs.getInt("author_id"));
                author.setName(rs.getString("author_name"));
                author.setDescription(rs.getString("author_description"));
                book.setAuthor(author);
            } catch (SQLException e) {
                // Author data not available in this query
            }
            
            try {
                Publisher publisher = new Publisher();
                publisher.setPublisher_id(rs.getInt("publisher_id"));
                publisher.setName(rs.getString("publisher_name"));
                publisher.setDescription(rs.getString("publisher_description"));
                book.setPublisher(publisher);
            } catch (SQLException e) {
                // Publisher data not available in this query
            }
            
            try {
                Category category = new Category();
                category.setCategory_id(rs.getInt("category_id"));
                category.setName(rs.getString("category_name"));
                book.setCategory(category);
            } catch (SQLException e) {
                // Category data not available in this query
            }
            
            return book;
        } catch (SQLException e) {
            setMessage("Error creating Book model: " + e.getMessage());
            return null;
        }
    }
    
    public ArrayList<Book> getBooksWithDetails() {
        select("b.*, a.name as author_name, a.description as author_description, " +
               "p.name as publisher_name, p.description as publisher_description, " +
               "c.name as category_name");
        join("author a", "b.author_id = a.author_id");
        join("publisher p", "b.publisher_id = p.publisher_id");
        join("category c", "b.category_id = c.category_id");
        table = "book b";
        ArrayList<Book> result = get();
        table = "book"; // Reset table name
        return result;
    }
    
    public ArrayList<Book> getLatestBooks(int limit) {
        select("b.*, a.name as author_name, p.name as publisher_name, c.name as category_name");
        join("author a", "b.author_id = a.author_id");
        join("publisher p", "b.publisher_id = p.publisher_id");
        join("category c", "b.category_id = c.category_id");
        addQuery("ORDER BY b.publication_date DESC LIMIT " + limit);
        table = "book b";
        ArrayList<Book> result = get();
        table = "book"; // Reset table name
        return result;
    }
    
    public ArrayList<Book> getBestSellingBooks(int limit) {
        ArrayList<ArrayList<Object>> orderData = query(
            "SELECT b.*, a.name as author_name, p.name as publisher_name, c.name as category_name, " +
            "COALESCE(SUM(oi.quantity), 0) as total_sold " +
            "FROM book b " +
            "LEFT JOIN order_item oi ON b.book_id = oi.book_id " +
            "LEFT JOIN author a ON b.author_id = a.author_id " +
            "LEFT JOIN publisher p ON b.publisher_id = p.publisher_id " +
            "LEFT JOIN category c ON b.category_id = c.category_id " +
            "GROUP BY b.book_id " +
            "ORDER BY total_sold DESC, RAND() " +
            "LIMIT " + limit
        );
        
        ArrayList<Book> books = new ArrayList<>();
        for (ArrayList<Object> row : orderData) {
            Book book = new Book();
            book.setBook_id((Integer) row.get(0));
            book.setISBN((String) row.get(1));
            book.setTitle((String) row.get(2));
            book.setPrice(((Double) row.get(4)).intValue());
            book.setDescription((String) row.get(5));
            book.setPublicationDate((Date) row.get(7));
            book.setWidth((Double) row.get(8));
            book.setLength((Double) row.get(9));
            book.setWeight((Integer) row.get(10));
            book.setStock((Integer) row.get(11));
            book.setImagePath((String) row.get(13));
            
            Author author = new Author();
            author.setAuthor_id((Integer) row.get(3));
            author.setName((String) row.get(14));
            book.setAuthor(author);
            
            Publisher publisher = new Publisher();
            publisher.setPublisher_id((Integer) row.get(6));
            publisher.setName((String) row.get(15));
            book.setPublisher(publisher);
            
            Category category = new Category();
            category.setCategory_id((Integer) row.get(12));
            category.setName((String) row.get(16));
            book.setCategory(category);
            
            books.add(book);
        }
        return books;
    }
    
    public ArrayList<Book> searchBooks(String query, String category) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT b.*, a.name as author_name, p.name as publisher_name, c.name as category_name ");
        sql.append("FROM book b ");
        sql.append("LEFT JOIN author a ON b.author_id = a.author_id ");
        sql.append("LEFT JOIN publisher p ON b.publisher_id = p.publisher_id ");
        sql.append("LEFT JOIN category c ON b.category_id = c.category_id ");
        sql.append("WHERE 1=1 ");
        
        if (query != null && !query.trim().isEmpty()) {
            sql.append("AND (b.title LIKE '%").append(query).append("%' ");
            sql.append("OR a.name LIKE '%").append(query).append("%' ");
            sql.append("OR b.description LIKE '%").append(query).append("%') ");
        }
        
        if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("Semua")) {
            sql.append("AND c.name = '").append(category).append("' ");
        }
        
        sql.append("ORDER BY b.title");
        
        ArrayList<ArrayList<Object>> searchData = query(sql.toString());
        ArrayList<Book> books = new ArrayList<>();
        
        for (ArrayList<Object> row : searchData) {
            Book book = new Book();
            book.setBook_id((Integer) row.get(0));
            book.setISBN((String) row.get(1));
            book.setTitle((String) row.get(2));
            book.setPrice(((Double) row.get(4)).intValue());
            book.setDescription((String) row.get(5));
            book.setPublicationDate((Date) row.get(7));
            book.setWidth((Double) row.get(8));
            book.setLength((Double) row.get(9));
            book.setWeight((Integer) row.get(10));
            book.setStock((Integer) row.get(11));
            book.setImagePath((String) row.get(13));
            
            Author author = new Author();
            author.setAuthor_id((Integer) row.get(3));
            author.setName((String) row.get(14));
            book.setAuthor(author);
            
            Publisher publisher = new Publisher();
            publisher.setPublisher_id((Integer) row.get(6));
            publisher.setName((String) row.get(15));
            book.setPublisher(publisher);
            
            Category category_obj = new Category();
            category_obj.setCategory_id((Integer) row.get(12));
            category_obj.setName((String) row.get(16));
            book.setCategory(category_obj);
            
            books.add(book);
        }
        return books;
    }
    
    public ArrayList<Book> getBooksByAuthor(int authorId, int limit) {
        select("b.*, a.name as author_name, p.name as publisher_name, c.name as category_name");
        join("author a", "b.author_id = a.author_id");
        join("publisher p", "b.publisher_id = p.publisher_id");
        join("category c", "b.category_id = c.category_id");
        where("b.author_id = " + authorId);
        addQuery("LIMIT " + limit);
        table = "book b";
        ArrayList<Book> result = get();
        table = "book"; // Reset table name
        return result;
    }
}
