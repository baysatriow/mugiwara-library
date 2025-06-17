package Controllers;

import Config.ErrorHandler;
import DAO.CartDAO;
import DAO.AddressDAO;
import DAO.ShippingMethodDAO;
import Models.Cart;
import Models.Address;
import Models.ShippingMethod;
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

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    private CartDAO cartDAO;
    private AddressDAO addressDAO;
    private ShippingMethodDAO shippingMethodDAO;

    @Override
    public void init() throws ServletException {
        try {
            cartDAO = new CartDAO();
            addressDAO = new AddressDAO();
            shippingMethodDAO = new ShippingMethodDAO();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize CheckoutServlet: " + e.getMessage(), e);
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
                "Anda harus login untuk mengakses halaman checkout.");
            return;
        }
        
        // Check if user is customer
        if (user.getRole() != UserRoles.CUSTOMER) {
            ErrorHandler.handleAuthorizationError(request, response, 
                "Akses ditolak. Hanya customer yang dapat mengakses checkout.");
            return;
        }
        
        try {
            // Get customer's cart
            Cart cart = cartDAO.getOrCreateCartForCustomer(user.getUserId());
            
            if (cart == null || cart.getItems().isEmpty()) {
                ErrorHandler.handleValidationError(request, response, 
                    "Keranjang belanja kosong. Tambahkan item terlebih dahulu sebelum checkout.");
                return;
            }
            
            // Get customer's addresses - UPDATED METHOD NAME
            ArrayList<Address> addresses = addressDAO.getAddressesByUserId(user.getUserId());
            Address defaultAddress = addressDAO.getDefaultAddressByUserId(user.getUserId());
            
            // Get available shipping methods
            ArrayList<ShippingMethod> shippingMethods = shippingMethodDAO.getAllShippingMethods();
            
            // Calculate totals
            double subtotal = cart.calculateTotal();
            double defaultShippingCost = 0.0;
            
            // Use first shipping method as default if available
            if (!shippingMethods.isEmpty()) {
                defaultShippingCost = shippingMethods.get(0).getCost();
            }
            
            double total = subtotal + defaultShippingCost;
            
            // Set attributes for JSP
            request.setAttribute("cart", cart);
            request.setAttribute("addresses", addresses);
            request.setAttribute("defaultAddress", defaultAddress);
            request.setAttribute("shippingMethods", shippingMethods);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("defaultShippingCost", defaultShippingCost);
            request.setAttribute("total", total);
            
            // Check if DAO operations had errors
            if (addressDAO.getMessage() != null && addressDAO.getMessage().contains("Error")) {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Terjadi kesalahan saat memuat alamat: " + addressDAO.getMessage(), null);
                return;
            }
            
            if (shippingMethodDAO.getMessage() != null && shippingMethodDAO.getMessage().contains("Error")) {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Terjadi kesalahan saat memuat metode pengiriman: " + shippingMethodDAO.getMessage(), null);
                return;
            }
            
            // Forward to checkout.jsp
            request.getRequestDispatcher("checkout.jsp").forward(request, response);
            
        } catch (Exception e) {
            ErrorHandler.handleDatabaseError(request, response, 
                "Terjadi kesalahan saat memuat halaman checkout.", e);
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
                "Anda harus login untuk melakukan checkout.");
            return;
        }
        
        // Check if user is customer
        if (user.getRole() != UserRoles.CUSTOMER) {
            ErrorHandler.handleAuthorizationError(request, response, 
                "Akses ditolak. Hanya customer yang dapat melakukan checkout.");
            return;
        }
        
        String action = request.getParameter("action");
        
        if (action == null || action.trim().isEmpty()) {
            ErrorHandler.handleValidationError(request, response, 
                "Parameter aksi tidak valid atau kosong.");
            return;
        }
        
        try {
            switch (action.toLowerCase()) {
                case "add_address":
                    handleAddAddress(request, response, session, user);
                    break;
                case "select_address":
                    handleSelectAddress(request, response, session, user);
                    break;
                case "process_order":
                    handleProcessOrder(request, response, session, user);
                    break;
                default:
                    ErrorHandler.handleValidationError(request, response, 
                        "Aksi '" + action + "' tidak dikenali atau tidak didukung.");
                    return;
            }
            
        } catch (Exception e) {
            ErrorHandler.handleDatabaseError(request, response, 
                "Terjadi kesalahan saat memproses checkout.", e);
        }
    }

    private void handleAddAddress(HttpServletRequest request, HttpServletResponse response,
                                 HttpSession session, Users user) throws IOException, ServletException {
        try {
            // Validate required parameters
            String province = request.getParameter("province");
            String city = request.getParameter("city");
            String district = request.getParameter("district");
            String postalCode = request.getParameter("postalCode");
            String fullAddress = request.getParameter("fullAddress");
            String isDefaultStr = request.getParameter("isDefault");
            
            if (province == null || province.trim().isEmpty() ||
                city == null || city.trim().isEmpty() ||
                district == null || district.trim().isEmpty() ||
                postalCode == null || postalCode.trim().isEmpty() ||
                fullAddress == null || fullAddress.trim().isEmpty()) {
                
                ErrorHandler.handleValidationError(request, response, 
                    "Semua field alamat harus diisi.");
                return;
            }
            
            // Validate postal code format
            if (!postalCode.matches("\\d{5}")) {
                ErrorHandler.handleValidationError(request, response, 
                    "Kode pos harus berupa 5 digit angka.");
                return;
            }
            
            boolean isDefault = "true".equals(isDefaultStr) || "1".equals(isDefaultStr);
            
            // If this is the first address, make it default
            if (addressDAO.getAddressCount(user.getUserId()) == 0) {
                isDefault = true;
            }
            
            // Create address object
            Address address = new Address();
            address.setProvince(province.trim());
            address.setCity(city.trim());
            address.setDistrict(district.trim());
            address.setPostalCode(postalCode.trim());
            address.setFullAddress(fullAddress.trim());
            address.setIsDefault(isDefault);
            
            // Add address to database
            boolean success = addressDAO.addAddress(user.getUserId(), address);
            
            // Check for DAO errors
            if (addressDAO.getMessage() != null && addressDAO.getMessage().contains("Error")) {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Gagal menambahkan alamat: " + addressDAO.getMessage(), null);
                return;
            }
            
            if (success) {
                session.setAttribute("message", "Alamat berhasil ditambahkan.");
            } else {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Gagal menambahkan alamat. Silakan coba lagi.", null);
                return;
            }
            
            response.sendRedirect("checkout");
            
        } catch (Exception e) {
            ErrorHandler.handleDatabaseError(request, response, 
                "Terjadi kesalahan saat menambahkan alamat.", e);
        }
    }

    private void handleSelectAddress(HttpServletRequest request, HttpServletResponse response,
                                   HttpSession session, Users user) throws IOException, ServletException {
        try {
            String addressIdStr = request.getParameter("addressId");
            
            if (addressIdStr == null || addressIdStr.trim().isEmpty()) {
                ErrorHandler.handleValidationError(request, response, 
                    "ID alamat tidak boleh kosong.");
                return;
            }
            
            int addressId;
            try {
                addressId = Integer.parseInt(addressIdStr);
            } catch (NumberFormatException e) {
                ErrorHandler.handleValidationError(request, response, 
                    "Format ID alamat tidak valid.");
                return;
            }
            
            // Verify address belongs to customer
            Address address = addressDAO.getAddressById(addressId, user.getUserId());
            
            // Check for DAO errors
            if (addressDAO.getMessage() != null && addressDAO.getMessage().contains("Error")) {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Terjadi kesalahan saat memverifikasi alamat: " + addressDAO.getMessage(), null);
                return;
            }
            
            if (address == null) {
                ErrorHandler.handleValidationError(request, response, 
                    "Alamat tidak ditemukan atau tidak dapat diakses.");
                return;
            }
            
            // Update default address
            boolean success = addressDAO.updateDefaultAddress(user.getUserId(), addressId);
            
            // Check for DAO errors
            if (addressDAO.getMessage() != null && addressDAO.getMessage().contains("Error")) {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Gagal memperbarui alamat pengiriman: " + addressDAO.getMessage(), null);
                return;
            }
            
            if (success) {
                session.setAttribute("message", "Alamat pengiriman berhasil diperbarui.");
            } else {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Gagal memperbarui alamat pengiriman.", null);
                return;
            }
            
            response.sendRedirect("checkout");
            
        } catch (Exception e) {
            ErrorHandler.handleDatabaseError(request, response, 
                "Terjadi kesalahan saat memperbarui alamat.", e);
        }
    }

    private void handleProcessOrder(HttpServletRequest request, HttpServletResponse response,
                                  HttpSession session, Users user) throws IOException, ServletException {
        try {
            // Validate required parameters
            String shippingMethodName = request.getParameter("shippingMethod");
            String paymentMethod = request.getParameter("paymentMethod");
            
            if (shippingMethodName == null || shippingMethodName.trim().isEmpty()) {
                ErrorHandler.handleValidationError(request, response, 
                    "Metode pengiriman harus dipilih.");
                return;
            }
            
            if (paymentMethod == null || paymentMethod.trim().isEmpty()) {
                ErrorHandler.handleValidationError(request, response, 
                    "Metode pembayaran harus dipilih.");
                return;
            }
            
            // Validate shipping method
            boolean isValidShipping = shippingMethodDAO.isValidShippingMethod(shippingMethodName);
            
            // Check for DAO errors
            if (shippingMethodDAO.getMessage() != null && shippingMethodDAO.getMessage().contains("Error")) {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Terjadi kesalahan saat memvalidasi metode pengiriman: " + shippingMethodDAO.getMessage(), null);
                return;
            }
            
            if (!isValidShipping) {
                ErrorHandler.handleValidationError(request, response, 
                    "Metode pengiriman tidak valid.");
                return;
            }
            
            // Get customer's cart
            Cart cart = cartDAO.getOrCreateCartForCustomer(user.getUserId());
            
            if (cart == null || cart.getItems().isEmpty()) {
                ErrorHandler.handleValidationError(request, response, 
                    "Keranjang belanja kosong.");
                return;
            }
            
            // Check if customer has default address - UPDATED METHOD NAME
            Address defaultAddress = addressDAO.getDefaultAddressByUserId(user.getUserId());
            
            // Check for DAO errors
            if (addressDAO.getMessage() != null && addressDAO.getMessage().contains("Error")) {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Terjadi kesalahan saat memuat alamat pengiriman: " + addressDAO.getMessage(), null);
                return;
            }
            
            if (defaultAddress == null) {
                ErrorHandler.handleValidationError(request, response, 
                    "Alamat pengiriman belum dipilih.");
                return;
            }
            
            // Get shipping method details
            ShippingMethod selectedShippingMethod = shippingMethodDAO.getShippingMethodByName(shippingMethodName);
            
            // Check for DAO errors
            if (shippingMethodDAO.getMessage() != null && shippingMethodDAO.getMessage().contains("Error")) {
                ErrorHandler.handleDatabaseError(request, response, 
                    "Terjadi kesalahan saat memuat detail pengiriman: " + shippingMethodDAO.getMessage(), null);
                return;
            }
            
            if (selectedShippingMethod == null) {
                ErrorHandler.handleValidationError(request, response, 
                    "Metode pengiriman tidak ditemukan.");
                return;
            }
            
            // Calculate totals
            double subtotal = cart.calculateTotal();
            double shippingCost = selectedShippingMethod.getCost();
            double total = subtotal + shippingCost;
            
            // Store order details in session for payment processing
            session.setAttribute("orderDetails", new OrderDetails(
                cart, defaultAddress, selectedShippingMethod, paymentMethod, 
                subtotal, shippingCost, total
            ));
            
            // For now, redirect to a success page or payment gateway
            // In a real implementation, you would integrate with payment gateway here
            session.setAttribute("message", 
                "Pesanan berhasil diproses! Total pembayaran: Rp" + String.format("%,d", (int)total));
            
            // Clear cart after successful order
            boolean cartCleared = cartDAO.clearCart(cart.getCart_id());
            if (cartCleared) {
                session.setAttribute("cartItemCount", 0);
            }
            
            response.sendRedirect("order-success.jsp");
            
        } catch (NumberFormatException e) {
            ErrorHandler.handleValidationError(request, response, 
                "Format parameter tidak valid.");
        } catch (Exception e) {
            ErrorHandler.handleDatabaseError(request, response, 
                "Terjadi kesalahan saat memproses pesanan.", e);
        }
    }

    // Helper class to store order details
    public static class OrderDetails {
        private Cart cart;
        private Address address;
        private ShippingMethod shippingMethod;
        private String paymentMethod;
        private double subtotal;
        private double shippingCost;
        private double total;
        
        public OrderDetails(Cart cart, Address address, ShippingMethod shippingMethod, 
                          String paymentMethod, double subtotal, double shippingCost, double total) {
            this.cart = cart;
            this.address = address;
            this.shippingMethod = shippingMethod;
            this.paymentMethod = paymentMethod;
            this.subtotal = subtotal;
            this.shippingCost = shippingCost;
            this.total = total;
        }
        
        // Getters
        public Cart getCart() { return cart; }
        public Address getAddress() { return address; }
        public ShippingMethod getShippingMethod() { return shippingMethod; }
        public String getPaymentMethod() { return paymentMethod; }
        public double getSubtotal() { return subtotal; }
        public double getShippingCost() { return shippingCost; }
        public double getTotal() { return total; }
    }

    @Override
    public String getServletInfo() {
        return "Checkout Servlet for Mugiwara Library - Handles checkout process";
    }
}