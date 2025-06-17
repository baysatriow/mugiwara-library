package Controllers;

import DAO.BookDAO;
import DAO.CategoryDAO;
import Models.Book;
import Models.Category;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Config.ErrorHandler; // Pastikan ErrorHandler Anda memiliki metode untuk validasi error.

@WebServlet(name = "BooksServlet", urlPatterns = {"/books", "/search"})
public class BooksServlet extends HttpServlet {

    private static final int BOOKS_PER_PAGE = 12;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        BookDAO bookDAO = new BookDAO();
        String action = request.getParameter("action");

        try {
            if ("detail".equals(action)) {
                handleBookDetail(request, response, bookDAO);
                return;
            }

            // Get pagination parameters
            int page = 1;
            try {
                String pageParam = request.getParameter("page");
                if (pageParam != null && !pageParam.trim().isEmpty()) { // Tambahkan cek isEmpty
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                }
            } catch (NumberFormatException e) {
                // Biarkan page tetap 1 jika parameter tidak valid atau kosong
                page = 1;
            }

            // Get filter parameters
            String query = request.getParameter("query");
            int querya = 0; // Inisialisasi dengan nilai default
            String queryaParam = request.getParameter("querya");
            if (queryaParam != null && !queryaParam.trim().isEmpty()) { // Tambahkan cek isEmpty
                try {
                    querya = Integer.parseInt(queryaParam);
                } catch (NumberFormatException e) {
                    // Log error or set a default, but don't stop execution
                    // ErrorHandler.logWarning(request, "Invalid 'querya' parameter: " + queryaParam);
                    querya = 0; // Set to default if invalid
                }
            }

            String category = request.getParameter("category");
            String sortBy = request.getParameter("sort");

            ArrayList<Book> allBooks;
            String pageTitle;
            String pageDescription;

            if ("latest".equals(action)) {
                allBooks = bookDAO.getLatestBooks(200);
                pageTitle = "Buku Terbaru";
                pageDescription = "Koleksi buku terbaru kami";
            } else if ("bestseller".equals(action)) {
                allBooks = bookDAO.getBestSellingBooks(200);
                pageTitle = "Buku Terlaris";
                pageDescription = "Buku-buku terlaris berdasarkan penjualan";
            } else {
                // Search or browse all books
                // Perbaiki prioritas atau tambahkan logika kombinasi jika diperlukan
                if (query != null && !query.trim().isEmpty()) { // Cari berdasarkan query teks
                    allBooks = bookDAO.searchBooks(query, category);
                    pageTitle = "Hasil Pencarian: '" + query + "'";
                    pageDescription = "Hasil pencarian buku berdasarkan kata kunci";
                } else if (querya > 0) { // Cari berdasarkan ID penulis
                    allBooks = bookDAO.getBooksByAuthor(querya, 200); // Batasi jumlah hasil jika tidak beresiko besar
                    pageTitle = "Karya Penulis";
                    pageDescription = "Hasil pencarian buku Karya Penulis";
                } else if (category != null && !category.trim().isEmpty()) { // Cari berdasarkan kategori saja
                    allBooks = bookDAO.searchBooks(null, category); // Hanya gunakan kategori
                    pageTitle = "Buku dalam Kategori: " + category;
                    pageDescription = "Jelajahi buku berdasarkan kategori";
                }
                else { // Tampilkan semua buku jika tidak ada filter
                    allBooks = bookDAO.getBooksWithDetails();
                    pageTitle = "Daftar Buku";
                    pageDescription = "Jelajahi koleksi lengkap buku kami";
                }
            }

            // Apply sorting if specified
            if (allBooks != null) {
                applySorting(allBooks, sortBy);
            } else {
                allBooks = new ArrayList<>();
            }

            // Calculate pagination
            int totalBooks = allBooks.size();
            int totalPages = (int) Math.ceil((double) totalBooks / BOOKS_PER_PAGE);
            int startIndex = (page - 1) * BOOKS_PER_PAGE;
            int endIndex = Math.min(startIndex + BOOKS_PER_PAGE, totalBooks);

            // Get books for current page
            ArrayList<Book> booksForPage = new ArrayList<>();
            // Pastikan startIndex tidak negatif
            if (startIndex < 0) startIndex = 0;
            // Pastikan endIndex tidak melebihi totalBooks
            if (endIndex > totalBooks) endIndex = totalBooks;

            for (int i = startIndex; i < endIndex; i++) {
                booksForPage.add(allBooks.get(i));
            }

            // Get categories for filter
            CategoryDAO categoryDAO = new CategoryDAO();
            ArrayList<Category> categories = categoryDAO.getAllCategories();

            // Set attributes
            request.setAttribute("books", booksForPage);
            request.setAttribute("categories", categories);
            request.setAttribute("pageTitle", pageTitle);
            request.setAttribute("pageDescription", pageDescription);
            request.setAttribute("searchQuery", query);
            request.setAttribute("selectedCategory", category);
            request.setAttribute("selectedSort", sortBy);
            request.setAttribute("totalBooks", totalBooks);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("booksPerPage", BOOKS_PER_PAGE);

            // Forward to books.jsp
            request.getRequestDispatcher("books.jsp").forward(request, response);

        } catch (Exception e) {
            // Tangani kesalahan umum sebagai kesalahan server internal jika tidak ditangani sebelumnya
            ErrorHandler.handleInternalServerError(request, response,
                    "Terjadi kesalahan internal saat memuat buku: " + e.getMessage(), e);
        }
    }

    private void handleBookDetail(HttpServletRequest request, HttpServletResponse response, BookDAO bookDAO)
            throws ServletException, IOException {

        String bookIdStr = request.getParameter("id");
        if (bookIdStr != null && !bookIdStr.trim().isEmpty()) { // Tambahkan cek isEmpty
            try {
                int bookId = Integer.parseInt(bookIdStr);
                Book book = bookDAO.find(String.valueOf(bookId));

                if (book != null) {
                    // Get other books by same author
                    ArrayList<Book> authorBooks = bookDAO.getBooksByAuthor(book.getAuthor().getAuthor_id(), 12);

                    request.setAttribute("book", book);
                    request.setAttribute("authorBooks", authorBooks);
                    request.getRequestDispatcher("book_details.jsp").forward(request, response);
                    return;
                } else {
                    ErrorHandler.handleNotFoundError(request, response,
                            "Buku dengan ID " + bookId + " tidak ditemukan");
                    return;
                }
            } catch (NumberFormatException e) {
                ErrorHandler.handleValidationError(request, response,
                        "ID buku tidak valid: " + bookIdStr);
                return;
            } catch (Exception e) {
                ErrorHandler.handleInternalServerError(request, response,
                        "Terjadi kesalahan internal saat memuat detail buku: " + e.getMessage(), e);
                return;
            }
        } else {
            ErrorHandler.handleValidationError(request, response,
                    "ID buku tidak boleh kosong atau tidak valid");
            return;
        }
    }

    private void applySorting(ArrayList<Book> books, String sortBy) {
        if (sortBy == null || books == null || books.isEmpty()) return; // Tambahkan cek null/kosong

        switch (sortBy) {
            case "price_asc":
                books.sort((a, b) -> Integer.compare(a.getPrice(), b.getPrice()));
                break;
            case "price_desc":
                books.sort((a, b) -> Integer.compare(b.getPrice(), a.getPrice()));
                break;
            case "title":
                books.sort((a, b) -> {
                    String titleA = a.getTitle() != null ? a.getTitle() : "";
                    String titleB = b.getTitle() != null ? b.getTitle() : "";
                    return titleA.compareToIgnoreCase(titleB);
                });
                break;
            case "author":
                books.sort((a, b) -> {
                    String authorA = (a.getAuthor() != null && a.getAuthor().getName() != null) ? a.getAuthor().getName() : "";
                    String authorB = (b.getAuthor() != null && b.getAuthor().getName() != null) ? b.getAuthor().getName() : "";
                    return authorA.compareToIgnoreCase(authorB);
                });
                break;
            // Default sorting should be considered if sortBy is not matched
            default:
                // Optionally, add a default sort order here
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Books Servlet for Mugiwara Library";
    }
}