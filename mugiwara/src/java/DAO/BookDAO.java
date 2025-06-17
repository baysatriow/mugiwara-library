package DAO;

import Models.Author;
import Models.Book;
import Models.Category;
import Models.Publisher;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BookDAO extends Models<Book> {

    private AuthorDAO authorDAO;
    private PublisherDAO publisherDAO;
    private CategoryDAO categoryDAO;

    public BookDAO() {
        table = "book";
        primaryKey = "book_id";
        
        // Initialize related DAOs
        authorDAO = new AuthorDAO();
        publisherDAO = new PublisherDAO();
        categoryDAO = new CategoryDAO();
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
            
            // Get related data using separate DAOs
            int authorId = rs.getInt("author_id");
            int publisherId = rs.getInt("publisher_id");
            int categoryId = rs.getInt("category_id");
            
            // Set Author using AuthorDAO
            if (authorId > 0) {
                Author author = authorDAO.find(String.valueOf(authorId));
                if (author != null) {
                    book.setAuthor(author);
                } else {
                    // Create default author if not found
                    Author defaultAuthor = new Author();
                    defaultAuthor.setAuthor_id(authorId);
                    defaultAuthor.setName("Unknown Author");
                    book.setAuthor(defaultAuthor);
                }
            }
            
            // Set Publisher using PublisherDAO
            if (publisherId > 0) {
                Publisher publisher = publisherDAO.find(String.valueOf(publisherId));
                if (publisher != null) {
                    book.setPublisher(publisher);
                } else {
                    // Create default publisher if not found
                    Publisher defaultPublisher = new Publisher();
                    defaultPublisher.setPublisher_id(publisherId);
                    defaultPublisher.setName("Unknown Publisher");
                    book.setPublisher(defaultPublisher);
                }
            }
            
            // Set Category using CategoryDAO
            if (categoryId > 0) {
                Category category = categoryDAO.find(String.valueOf(categoryId));
                if (category != null) {
                    book.setCategory(category);
                } else {
                    // Create default category if not found
                    Category defaultCategory = new Category();
                    defaultCategory.setCategory_id(categoryId);
                    defaultCategory.setName("Uncategorized");
                    book.setCategory(defaultCategory);
                }
            }
            
            return book;
        } catch (SQLException e) {
            setMessage("Error creating Book model: " + e.getMessage());
            return null;
        }
    }

    public ArrayList<Book> getBooksWithDetails() {
        try {
            // Simply get all books, related data will be loaded by toModel method
            addQuery("ORDER BY book_id LIMIT 100");
            return get();
        } catch (Exception e) {
            setMessage("Error getting books with details: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public ArrayList<Book> getLatestBooks(int limit) {
        try {
            // Limit the maximum to prevent memory issues
            int safeLimit = Math.min(limit, 50);
            addQuery("ORDER BY publication_date DESC LIMIT " + safeLimit);
            return get();
        } catch (Exception e) {
            setMessage("Error getting latest books: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public ArrayList<Book> getBestSellingBooks(int limit) {
        try {
            // Limit the maximum to prevent memory issues
            int safeLimit = Math.min(limit, 50);
            
            String sql = "SELECT b.book_id, b.isbn, b.title, b.author_id, b.price, b.description, " +
                        "b.publisher_id, b.publication_date, b.width, b.length, b.weight, b.stock, " +
                        "b.category_id, b.image_path, COALESCE(SUM(oi.quantity), 0) as total_sold " +
                        "FROM book b " +
                        "LEFT JOIN order_item oi ON b.book_id = oi.book_id " +
                        "GROUP BY b.book_id, b.isbn, b.title, b.author_id, b.price, b.description, " +
                        "b.publisher_id, b.publication_date, b.width, b.length, b.weight, b.stock, " +
                        "b.category_id, b.image_path " +
                        "ORDER BY total_sold DESC, RAND() LIMIT " + safeLimit;
            
            ArrayList<ArrayList<Object>> data = query(sql);
            ArrayList<Book> books = new ArrayList<>();
            
            for (ArrayList<Object> row : data) {
                if (row != null && row.size() >= 14) {
                    try {
                        Book book = createBookFromRowData(row);
                        if (book != null) {
                            books.add(book);
                        }
                    } catch (Exception e) {
                        System.err.println("Error processing book row: " + e.getMessage());
                        continue;
                    }
                }
            }
            
            return books;
        } catch (Exception e) {
            setMessage("Error getting best selling books: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public ArrayList<Book> searchBooks(String query, String category) {
        try {
            StringBuilder whereConditions = new StringBuilder();
            ArrayList<String> conditions = new ArrayList<>();
            
            if (query != null && !query.trim().isEmpty()) {
                // Search in title and description
                String escapedQuery = query.replace("'", "''").replace("\\", "\\\\");
                conditions.add("(title LIKE '%" + escapedQuery + "%' OR description LIKE '%" + escapedQuery + "%')");
            }
            
            if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("Semua")) {
                // Get category ID first
                Category cat = findCategoryByName(category);
                if (cat != null) {
                    conditions.add("category_id = " + cat.getCategory_id());
                }
            }
            
            // Build WHERE clause
            if (!conditions.isEmpty()) {
                whereConditions.append("WHERE ");
                whereConditions.append(String.join(" AND ", conditions));
            }
            
            String sql = "SELECT * FROM book " + whereConditions.toString() + " ORDER BY title LIMIT 100";
            
            ArrayList<ArrayList<Object>> data = query(sql);
            ArrayList<Book> books = new ArrayList<>();
            
            for (ArrayList<Object> row : data) {
                if (row != null && row.size() >= 14) {
                    try {
                        Book book = createBookFromRowData(row);
                        if (book != null) {
                            books.add(book);
                        }
                    } catch (Exception e) {
                        System.err.println("Error processing search result: " + e.getMessage());
                        continue;
                    }
                }
            }
            
            return books;
        } catch (Exception e) {
            setMessage("Error searching books: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public ArrayList<Book> getBooksByAuthor(int authorId, int limit) {
        try {
            // Limit the maximum to prevent memory issues
            int safeLimit = Math.min(limit, 20);
            where("author_id = " + authorId);
            addQuery("LIMIT " + safeLimit);
            return get();
        } catch (Exception e) {
            setMessage("Error getting books by author: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public ArrayList<Book> getBooksByCategory(int categoryId, int limit) {
        try {
            int safeLimit = Math.min(limit, 50);
            where("category_id = " + categoryId);
            addQuery("LIMIT " + safeLimit);
            return get();
        } catch (Exception e) {
            setMessage("Error getting books by category: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    public ArrayList<Book> getBooksByPublisher(int publisherId, int limit) {
        try {
            int safeLimit = Math.min(limit, 50);
            where("publisher_id = " + publisherId);
            addQuery("LIMIT " + safeLimit);
            return get();
        } catch (Exception e) {
            setMessage("Error getting books by publisher: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    // Helper method to find category by name
    private Category findCategoryByName(String categoryName) {
        try {
            ArrayList<Category> categories = categoryDAO.getAllCategories();
            for (Category cat : categories) {
                if (cat.getName().equalsIgnoreCase(categoryName)) {
                    return cat;
                }
            }
        } catch (Exception e) {
            System.err.println("Error finding category by name: " + e.getMessage());
        }
        return null;
    }

    // Enhanced method to create Book from row data with proper DAO usage
    private Book createBookFromRowData(ArrayList<Object> row) {
        if (row == null || row.size() < 14) {
            return null;
        }
        
        try {
            Book book = new Book();
            book.setBook_id(getIntValue(row.get(0)));
            book.setISBN(getStringValue(row.get(1)));
            book.setTitle(getStringValue(row.get(2)));
            book.setPrice(getIntValue(row.get(4)));
            book.setDescription(getStringValue(row.get(5)));
            
            // Handle date safely
            Object dateObj = row.get(7);
            if (dateObj instanceof java.sql.Date) {
                book.setPublicationDate((java.sql.Date) dateObj);
            } else if (dateObj instanceof java.util.Date) {
                book.setPublicationDate((java.util.Date) dateObj);
            }
            
            book.setWidth(getDoubleValue(row.get(8)));
            book.setLength(getDoubleValue(row.get(9)));
            book.setWeight(getIntValue(row.get(10)));
            book.setStock(getIntValue(row.get(11)));
            book.setImagePath(getStringValue(row.get(13)));
            
            // Get related data using DAOs
            int authorId = getIntValue(row.get(3));
            int publisherId = getIntValue(row.get(6));
            int categoryId = getIntValue(row.get(12));
            
            // Set Author using AuthorDAO
            if (authorId > 0) {
                Author author = authorDAO.find(String.valueOf(authorId));
                if (author != null) {
                    book.setAuthor(author);
                } else {
                    Author defaultAuthor = new Author();
                    defaultAuthor.setAuthor_id(authorId);
                    defaultAuthor.setName("Unknown Author");
                    book.setAuthor(defaultAuthor);
                }
            }
            
            // Set Publisher using PublisherDAO
            if (publisherId > 0) {
                Publisher publisher = publisherDAO.find(String.valueOf(publisherId));
                if (publisher != null) {
                    book.setPublisher(publisher);
                } else {
                    Publisher defaultPublisher = new Publisher();
                    defaultPublisher.setPublisher_id(publisherId);
                    defaultPublisher.setName("Unknown Publisher");
                    book.setPublisher(defaultPublisher);
                }
            }
            
            // Set Category using CategoryDAO
            if (categoryId > 0) {
                Category category = categoryDAO.find(String.valueOf(categoryId));
                if (category != null) {
                    book.setCategory(category);
                } else {
                    Category defaultCategory = new Category();
                    defaultCategory.setCategory_id(categoryId);
                    defaultCategory.setName("Uncategorized");
                    book.setCategory(defaultCategory);
                }
            }
            
            return book;
        } catch (Exception e) {
            System.err.println("Error creating book from row data: " + e.getMessage());
            return null;
        }
    }

    // Optimized method to get books with batch loading of related data
    public ArrayList<Book> getBooksWithBatchLoading() {
        try {
            // Get all books first
            ArrayList<Book> books = get();
            
            if (books.isEmpty()) {
                return books;
            }
            
            // Collect all unique IDs
            ArrayList<Integer> authorIds = new ArrayList<>();
            ArrayList<Integer> publisherIds = new ArrayList<>();
            ArrayList<Integer> categoryIds = new ArrayList<>();
            
            for (Book book : books) {
                if (book.getAuthor() != null && book.getAuthor().getAuthor_id() > 0) {
                    if (!authorIds.contains(book.getAuthor().getAuthor_id())) {
                        authorIds.add(book.getAuthor().getAuthor_id());
                    }
                }
                if (book.getPublisher() != null && book.getPublisher().getPublisher_id() > 0) {
                    if (!publisherIds.contains(book.getPublisher().getPublisher_id())) {
                        publisherIds.add(book.getPublisher().getPublisher_id());
                    }
                }
                if (book.getCategory() != null && book.getCategory().getCategory_id() > 0) {
                    if (!categoryIds.contains(book.getCategory().getCategory_id())) {
                        categoryIds.add(book.getCategory().getCategory_id());
                    }
                }
            }
            
            // Batch load all related data
            ArrayList<Author> authors = new ArrayList<>();
            ArrayList<Publisher> publishers = new ArrayList<>();
            ArrayList<Category> categories = new ArrayList<>();
            
            for (Integer id : authorIds) {
                Author author = authorDAO.find(String.valueOf(id));
                if (author != null) {
                    authors.add(author);
                }
            }
            
            for (Integer id : publisherIds) {
                Publisher publisher = publisherDAO.find(String.valueOf(id));
                if (publisher != null) {
                    publishers.add(publisher);
                }
            }
            
            for (Integer id : categoryIds) {
                Category category = categoryDAO.find(String.valueOf(id));
                if (category != null) {
                    categories.add(category);
                }
            }
            
            // Map related data back to books
            for (Book book : books) {
                // Find and set author
                if (book.getAuthor() != null) {
                    int authorId = book.getAuthor().getAuthor_id();
                    for (Author author : authors) {
                        if (author.getAuthor_id() == authorId) {
                            book.setAuthor(author);
                            break;
                        }
                    }
                }
                
                // Find and set publisher
                if (book.getPublisher() != null) {
                    int publisherId = book.getPublisher().getPublisher_id();
                    for (Publisher publisher : publishers) {
                        if (publisher.getPublisher_id() == publisherId) {
                            book.setPublisher(publisher);
                            break;
                        }
                    }
                }
                
                // Find and set category
                if (book.getCategory() != null) {
                    int categoryId = book.getCategory().getCategory_id();
                    for (Category category : categories) {
                        if (category.getCategory_id() == categoryId) {
                            book.setCategory(category);
                            break;
                        }
                    }
                }
            }
            
            return books;
        } catch (Exception e) {
            setMessage("Error getting books with batch loading: " + e.getMessage());
            return new ArrayList<>();
        }
    }

    // Helper methods untuk safe casting
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

    // Method to get book count by category
    public int getBookCountByCategory(int categoryId) {
        try {
            String sql = "SELECT COUNT(*) as total FROM book WHERE category_id = " + categoryId;
            ArrayList<ArrayList<Object>> result = query(sql);
            
            if (!result.isEmpty() && result.get(0).get(0) != null) {
                return getIntValue(result.get(0).get(0));
            }
            return 0;
        } catch (Exception e) {
            setMessage("Error getting book count by category: " + e.getMessage());
            return 0;
        }
    }

    // Method to get book count by author
    public int getBookCountByAuthor(int authorId) {
        try {
            String sql = "SELECT COUNT(*) as total FROM book WHERE author_id = " + authorId;
            ArrayList<ArrayList<Object>> result = query(sql);
            
            if (!result.isEmpty() && result.get(0).get(0) != null) {
                return getIntValue(result.get(0).get(0));
            }
            return 0;
        } catch (Exception e) {
            setMessage("Error getting book count by author: " + e.getMessage());
            return 0;
        }
    }

    // Method to get book count by publisher
    public int getBookCountByPublisher(int publisherId) {
        try {
            String sql = "SELECT COUNT(*) as total FROM book WHERE publisher_id = " + publisherId;
            ArrayList<ArrayList<Object>> result = query(sql);
            
            if (!result.isEmpty() && result.get(0).get(0) != null) {
                return getIntValue(result.get(0).get(0));
            }
            return 0;
        } catch (Exception e) {
            setMessage("Error getting book count by publisher: " + e.getMessage());
            return 0;
        }
    }
}
