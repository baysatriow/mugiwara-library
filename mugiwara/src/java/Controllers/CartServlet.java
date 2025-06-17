package Controllers;

import Config.ErrorHandler;
import DAO.CartDAO;
import DAO.CartItemDAO;
import DAO.BookDAO;
import Models.Cart;
import Models.Book;
import Models.Users;
import Models.UserRoles;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CartServlet", urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {
    
    private CartDAO cartDAO;
    private CartItemDAO cartItemDAO;
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        try {
            cartDAO = new CartDAO();
            cartItemDAO = new CartItemDAO();
            bookDAO = new BookDAO();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize CartServlet: " + e.getMessage(), e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            ErrorHandler.handleAuthenticationError(request, response, 
                "Anda harus login untuk mengakses keranjang belanja.");
            return;
        }
        
        // Check if user is customer
        if (user.getRole() != UserRoles.CUSTOMER) {
            ErrorHandler.handleAuthorizationError(request, response, 
                "Akses ditolak. Hanya customer yang dapat mengakses keranjang belanja.");
            return;
        }
        
        try {
            // Get or create cart for customer
            Cart cart = cartDAO.getOrCreateCartForCustomer(user.getUserId());
            
            if (cart == null) {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Gagal mengakses keranjang belanja. Silakan coba lagi.", null);
                return;
            }
            
            // Calculate totals
            double subtotal = cart.calculateTotal();
            double shipping = subtotal >= 100000 ? 0.0 : 15000.0; // Free shipping for orders above 100k
            double total = subtotal + shipping;
            
            // Get recommendations
            ArrayList<Book> recommendations = getRecommendations(cart);
            
            // Update cart item count in session
            session.setAttribute("cartItemCount", cart.getTotalItems());
            
            // Set attributes for JSP
            request.setAttribute("cart", cart);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("shipping", shipping);
            request.setAttribute("total", total);
            request.setAttribute("recommendations", recommendations);
            
            // Forward to cart.jsp
            request.getRequestDispatcher("cart.jsp").forward(request, response);
            
        } catch (Exception e) {
            ErrorHandler.handleDatabaseError(request, response, 
                "Terjadi kesalahan saat memuat keranjang belanja.", e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Users user = (Users) session.getAttribute("user");
        
        // Check if user is logged in
        if (user == null) {
            ErrorHandler.handleAuthenticationError(request, response, 
                "Anda harus login untuk melakukan operasi keranjang.");
            return;
        }
        
        // Check if user is customer
        if (user.getRole() != UserRoles.CUSTOMER) {
            ErrorHandler.handleAuthorizationError(request, response, 
                "Akses ditolak. Hanya customer yang dapat melakukan operasi keranjang.");
            return;
        }
        
        String action = request.getParameter("action");
        
        // Validate action parameter
        if (action == null || action.trim().isEmpty()) {
            ErrorHandler.handleValidationError(request, response, 
                "Parameter aksi tidak valid atau kosong.");
            return;
        }
        
        try {
            // Get or create cart for customer
            Cart cart = cartDAO.getOrCreateCartForCustomer(user.getUserId());
            
            if (cart == null) {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Gagal mengakses keranjang belanja.", null);
                return;
            }
            
            switch (action.toLowerCase()) {
                case "add":
                    handleAddToCart(request, response, session, cart);
                    break;
                case "update":
                    handleUpdateQuantity(request, response, session, cart);
                    break;
                case "remove":
                    handleRemoveItem(request, response, session, cart);
                    break;
                case "clear":
                    handleClearCart(request, response, session, cart);
                    break;
                default:
                    ErrorHandler.handleValidationError(request, response, 
                        "Aksi '" + action + "' tidak dikenali atau tidak didukung.");
                    return;
            }
            
        } catch (NumberFormatException e) {
            ErrorHandler.handleValidationError(request, response, 
                "Parameter numerik tidak valid: " + e.getMessage());
        } catch (Exception e) {
            ErrorHandler.handleDatabaseError(request, response, 
                "Terjadi kesalahan saat memproses operasi keranjang.", e);
        }
    }
    
    private void handleAddToCart(HttpServletRequest request, HttpServletResponse response, 
                                HttpSession session, Cart cart) throws IOException, ServletException {
        try {
            // Validate and parse parameters
            String bookIdStr = request.getParameter("bookId");
            String quantityStr = request.getParameter("quantity");
            
            if (bookIdStr == null || bookIdStr.trim().isEmpty()) {
                ErrorHandler.handleValidationError(request, response, 
                    "ID buku tidak boleh kosong.");
                return;
            }
            
            if (quantityStr == null || quantityStr.trim().isEmpty()) {
                ErrorHandler.handleValidationError(request, response, 
                    "Jumlah item tidak boleh kosong.");
                return;
            }
            
            int bookId = Integer.parseInt(bookIdStr);
            int quantity = Integer.parseInt(quantityStr);
            
            // Validate quantity
            if (quantity <= 0) {
                ErrorHandler.handleValidationError(request, response, 
                    "Jumlah item harus lebih dari 0.");
                return;
            }
            
            if (quantity > 100) { // Reasonable limit
                ErrorHandler.handleValidationError(request, response, 
                    "Jumlah item tidak boleh lebih dari 100.");
                return;
            }
            
            // Get book details
            Book book = bookDAO.find(String.valueOf(bookId));
            if (book == null) {
                ErrorHandler.handleNotFoundError(request, response, 
                    "Buku dengan ID " + bookId + " tidak ditemukan.");
                return;
            }
            
            // Check stock availability
            if (book.getStock() <= 0) {
                ErrorHandler.handleValidationError(request, response, 
                    "Maaf, buku '" + book.getTitle() + "' sedang tidak tersedia (stok habis).");
                return;
            }
            
            if (book.getStock() < quantity) {
                ErrorHandler.handleValidationError(request, response, 
                    "Stok tidak mencukupi untuk buku '" + book.getTitle() + "'. " +
                    "Stok tersedia: " + book.getStock() + ", diminta: " + quantity);
                return;
            }
            
            // Add item to cart
            boolean success = cartItemDAO.addItemToCart(cart.getCart_id(), bookId, quantity, book.getPrice());
            
            if (success) {
                session.setAttribute("message", "Buku '" + book.getTitle() + "' berhasil ditambahkan ke keranjang.");
                
                // Update cart item count in session
                Cart updatedCart = cartDAO.getCartWithDetails(cart.getCart_id());
                if (updatedCart != null) {
                    session.setAttribute("cartItemCount", updatedCart.getTotalItems());
                }
                
                // Redirect back to book detail or cart
                String referer = request.getHeader("Referer");
                if (referer != null && referer.contains("books?action=detail")) {
                    response.sendRedirect(referer);
                } else {
                    response.sendRedirect("cart");
                }
            } else {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Gagal menambahkan buku ke keranjang. Silakan coba lagi.", null);
            }
            
        } catch (NumberFormatException e) {
            ErrorHandler.handleValidationError(request, response, 
                "Format ID buku atau jumlah tidak valid.");
        }
    }
    
    private void handleUpdateQuantity(HttpServletRequest request, HttpServletResponse response,
                                     HttpSession session, Cart cart) throws IOException, ServletException {
        try {
            // Validate and parse parameters
            String bookIdStr = request.getParameter("bookId");
            String quantityStr = request.getParameter("quantity");
            
            if (bookIdStr == null || bookIdStr.trim().isEmpty()) {
                ErrorHandler.handleValidationError(request, response, 
                    "ID buku tidak boleh kosong.");
                return;
            }
            
            if (quantityStr == null || quantityStr.trim().isEmpty()) {
                ErrorHandler.handleValidationError(request, response, 
                    "Jumlah item tidak boleh kosong.");
                return;
            }
            
            int bookId = Integer.parseInt(bookIdStr);
            int quantity = Integer.parseInt(quantityStr);
            
            // Validate quantity (allow 0 for removal)
            if (quantity < 0) {
                ErrorHandler.handleValidationError(request, response, 
                    "Jumlah item tidak boleh negatif.");
                return;
            }
            
            if (quantity > 100) { // Reasonable limit
                ErrorHandler.handleValidationError(request, response, 
                    "Jumlah item tidak boleh lebih dari 100.");
                return;
            }
            
            // Get book details for stock validation
            Book book = bookDAO.find(String.valueOf(bookId));
            if (book == null) {
                ErrorHandler.handleNotFoundError(request, response, 
                    "Buku dengan ID " + bookId + " tidak ditemukan.");
                return;
            }
            
            // Validate quantity against stock (if not removing)
            if (quantity > 0 && quantity > book.getStock()) {
                ErrorHandler.handleValidationError(request, response, 
                    "Jumlah melebihi stok yang tersedia untuk buku '" + book.getTitle() + "'. " +
                    "Stok tersedia: " + book.getStock());
                return;
            }
            
            // Update quantity
            boolean success = cartItemDAO.updateItemQuantity(cart.getCart_id(), bookId, quantity);
            
            if (success) {
                if (quantity > 0) {
                    session.setAttribute("message", "Jumlah item '" + book.getTitle() + "' berhasil diperbarui.");
                } else {
                    session.setAttribute("message", "Item '" + book.getTitle() + "' berhasil dihapus dari keranjang.");
                }
                
                // Update cart item count in session
                Cart updatedCart = cartDAO.getCartWithDetails(cart.getCart_id());
                if (updatedCart != null) {
                    session.setAttribute("cartItemCount", updatedCart.getTotalItems());
                }
            } else {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Gagal memperbarui jumlah item. Item mungkin tidak ada dalam keranjang.", null);
                return;
            }
            
            response.sendRedirect("cart");
            
        } catch (NumberFormatException e) {
            ErrorHandler.handleValidationError(request, response, 
                "Format ID buku atau jumlah tidak valid.");
        }
    }
    
    private void handleRemoveItem(HttpServletRequest request, HttpServletResponse response,
                                 HttpSession session, Cart cart) throws IOException, ServletException {
        try {
            // Validate and parse parameters
            String bookIdStr = request.getParameter("bookId");
            
            if (bookIdStr == null || bookIdStr.trim().isEmpty()) {
                ErrorHandler.handleValidationError(request, response, 
                    "ID buku tidak boleh kosong.");
                return;
            }
            
            int bookId = Integer.parseInt(bookIdStr);
            
            // Get book details for better error messages
            Book book = bookDAO.find(String.valueOf(bookId));
            String bookTitle = (book != null) ? book.getTitle() : "ID " + bookId;
            
            boolean success = cartItemDAO.removeItemFromCart(cart.getCart_id(), bookId);
            
            if (success) {
                session.setAttribute("message", "Item '" + bookTitle + "' berhasil dihapus dari keranjang.");
                
                // Update cart item count in session
                Cart updatedCart = cartDAO.getCartWithDetails(cart.getCart_id());
                if (updatedCart != null) {
                    session.setAttribute("cartItemCount", updatedCart.getTotalItems());
                }
            } else {
                ErrorHandler.handleNotFoundError(request, response, 
                    "Item '" + bookTitle + "' tidak ditemukan dalam keranjang.");
                return;
            }
            
            response.sendRedirect("cart");
            
        } catch (NumberFormatException e) {
            ErrorHandler.handleValidationError(request, response, 
                "Format ID buku tidak valid.");
        }
    }
    
    private void handleClearCart(HttpServletRequest request, HttpServletResponse response,
                                HttpSession session, Cart cart) throws IOException, ServletException {
        try {
            boolean success = cartDAO.clearCart(cart.getCart_id());
            
            if (success) {
                session.setAttribute("message", "Keranjang berhasil dikosongkan.");
                session.setAttribute("cartItemCount", 0);
            } else {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Gagal mengosongkan keranjang. Silakan coba lagi.", null);
                return;
            }
            
            response.sendRedirect("cart");
            
        } catch (Exception e) {
            ErrorHandler.handleDatabaseError(request, response, 
                "Terjadi kesalahan saat mengosongkan keranjang.", e);
        }
    }
    
    // Helper method to get book recommendations
    private ArrayList<Book> getRecommendations(Cart cart) {
        try {
            // Simple recommendation: get latest books
            // You can enhance this with more sophisticated logic based on cart contents
            return bookDAO.getLatestBooks(8);
        } catch (Exception e) {
            // Log error but don't fail the main request
            System.err.println("Error getting recommendations: " + e.getMessage());
            return new ArrayList<>();
        }
    }
    
    @Override
    public String getServletInfo() {
        return "Cart Servlet for Mugiwara Library - Handles shopping cart operations";
    }
}