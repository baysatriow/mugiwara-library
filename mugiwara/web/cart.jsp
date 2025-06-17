<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Cart"%>
<%@page import="Models.CartItem"%>
<%@page import="Models.Book"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Keranjang Belanja - Mugiwara Library</title>
    <!-- Menggunakan struktur head dari new -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/css/iziToast.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <%
        // Alur program dari old - semua variabel dan logic tetap sama
        Cart cart = (Cart) request.getAttribute("cart");
        Double subtotal = (Double) request.getAttribute("subtotal");
        Double shipping = (Double) request.getAttribute("shipping");
        Double total = (Double) request.getAttribute("total");
        ArrayList<Book> recommendations = (ArrayList<Book>) request.getAttribute("recommendations");
        
        if (cart == null) {
            cart = new Cart();
        }
        if (subtotal == null) subtotal = 0.0;
        if (shipping == null) shipping = 15000.0;
        if (total == null) total = subtotal + shipping;
        if (recommendations == null) recommendations = new ArrayList<>();
        
        // Alur program dari old - message handling via session
        String message = (String) session.getAttribute("message");
        String error = (String) session.getAttribute("error");
        
        // Clear messages after displaying
        session.removeAttribute("message");
        session.removeAttribute("error");
        
        // Calculate totals for display - alur program dari old
        int totalItems = cart.getTotalItems();
        long shippingCost = subtotal > 100000 ? 0 : shipping.longValue();
        long tax = (long) (subtotal * 0.11); // 11% tax
        long finalTotal = subtotal.longValue() + shippingCost + tax;
    %>

    <!-- Header - menggunakan struktur dari new -->
    <header>
        <nav>
            <div class="logo-container">
                <a href="home">
                    <img src="assets/images/Logo Store.png" alt="logo" class="logo_home"> 
                </a>
            </div>
            <div class="category-search-container">
                <div class="dropdown">
                    <button class="btn dropdown-toggle category-button" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                        <span id="categoryText">Kategori</span>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <li class="category-search-li"> 
                            <input class="form-control" type="text" placeholder="Cari Kategori..." id="categorySearchInputInDropdown">
                        </li>
                        <li><a class="dropdown-item" href="books?category=Novel">Novel</a></li>
                        <li><a class="dropdown-item" href="books?category=Majalah">Majalah</a></li>
                        <li><a class="dropdown-item" href="books?category=Komik">Komik</a></li>
                        <li><a class="dropdown-item" href="books">Semua Kategori</a></li>
                    </ul>
                </div>
                <form class="form-inline flex-grow-1" action="books" method="get"> 
                    <div class="search-input-group">
                        <input class="form-control search-input" type="search" name="query" placeholder="Mau cari apa hari ini?" aria-label="Search">
                        <button class="search-btn" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>
            </div>
            <div class="user-menu">
                <!-- Cart Button -->
                <a href="<%= isLoggedIn ? "cart" : "login.jsp" %>" class="text-white-icon me-3 position-relative">
                    <img src="assets/images/cart.png" alt="cart" class="cart-icon">
                    <% 
                        Integer cartItemCount = (Integer) session.getAttribute("cartItemCount");
                        if (cartItemCount != null && cartItemCount > 0) {
                    %>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-dark">
                        <%= cartItemCount %>
                    </span>
                    <% } %>
                </a>
                <!-- User Menu Dropdown -->
                <div class="dropdown">
                    <a href="#" class="dropdown-toggle" id="userMenuDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="assets/images/profile.png" alt="profile" class="profile-icon">
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="userMenuDropdown">
                        <% if (isLoggedIn) { %>
                            <li><h6 class="dropdown-header">Halo, <%= fullName %></h6></li>
                            <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person-circle"></i> Akun Saya</a></li>
                            <li><a class="dropdown-item" href="profile.jsp#transaksi"><i class="bi bi-receipt"></i> Pesanan</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                        <% } else { %>
                            <li><a class="dropdown-item" href="login.jsp"><i class="bi bi-box-arrow-in-right"></i> Login</a></li>
                            <li><a class="dropdown-item" href="register.jsp"><i class="bi bi-person-plus-fill"></i> Registrasi</a></li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Breadcrumb - menggunakan class dari new -->
    <div class="breadcrumb-container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="home">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">Keranjang Belanja</li>
            </ol>
        </nav>
    </div>

    <!-- Main Content - menggunakan struktur dari new -->
    <main>
        <div class="cart-container">
            <div class="cart-header">
                <h2><i class="bi bi-cart3 me-3"></i>Keranjang Belanja</h2>
                <% if (!cart.getItems().isEmpty()) { %>
                <p class="text-muted mb-0"><%= totalItems %> item dalam keranjang</p>
                <% } %>
            </div>

            <!-- Messages - alur program dari old -->
            <% if (message != null) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle"></i> <%= message %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>
            
            <% if (error != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-triangle"></i> <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>

            <% if (cart.getItems().isEmpty()) { %>
            <!-- Empty Cart - menggunakan class dari new dengan logic dari old -->
            <div class="empty-cart">
                <!-- Alur program dari old - menggunakan image path dari old -->
                <img src="assets/images/emptyCartFeedback.png" alt="Keranjang Kosong" style="max-width: 300px; opacity: 0.7;">
                <h3>Keranjang Belanja Kosong</h3>
                <p>Yuk, isi keranjang belanja Anda dengan buku-buku menarik!</p>
                <a href="books" class="btn btn-primary">
                    <i class="bi bi-book me-2"></i>Mulai Belanja
                </a>
            </div>
            <% } else { %>

            <!-- Cart Actions - alur program dari old dengan styling dari new -->
            <div class="filter-bar">
                <div class="d-flex align-items-center gap-3">
                    <div class="d-flex align-items-center gap-2">
                        <input type="checkbox" id="selectAll" class="form-check-input" />
                        <label for="selectAll" class="form-check-label">
                            <strong>Pilih Semua (<span id="totalItems"><%= cart.getTotalItems() %></span> item)</strong>
                        </label>
                    </div>
                </div>
                <div>
                    <!-- Alur program dari old - clear cart form -->
                    <form action="cart" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="clear">
                        <button type="submit" class="btn btn-outline-danger btn-sm" 
                                onclick="return confirm('Yakin ingin mengosongkan keranjang?')">
                            <i class="bi bi-trash me-1"></i>Kosongkan Keranjang
                        </button>
                    </form>
                </div>
            </div>

            <!-- Cart Items - menggunakan layout dari new -->
            <div class="row">
                <div class="col-lg-8">
                    <% for (CartItem item : cart.getItems()) { 
                        Book book = item.getBook();
                        if (book != null) {
                    %>
                    <div class="cart-item-card" data-book-id="<%= book.getBook_id() %>" id="cart-item-<%= book.getBook_id() %>">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <!-- Alur program dari old - checkbox untuk select item -->
                                <input type="checkbox" class="item-checkbox form-check-input" checked />
                            </div>
                            <div class="col-md-2">
                                <!-- Alur program dari old - default image path -->
                                <img src="<%= book.getImagePath() != null ? book.getImagePath() : "assets/images/default-book.jpg" %>" 
                                     alt="<%= book.getTitle() %>" class="cart-item-image">
                            </div>
                            <div class="col-md-4">
                                <div class="cart-item-details">
                                    <h5><a href="books?action=detail&id=<%= book.getBook_id() %>" class="text-decoration-none"><%= book.getTitle() %></a></h5>
                                    <p class="author text-muted">
                                        oleh <%= book.getAuthor() != null ? book.getAuthor().getName() : "Unknown Author" %>
                                    </p>
                                    <!-- Alur program dari old - menggunakan item.getHarga() -->
                                    <div class="cart-item-price">
                                        Rp<%= String.format("%,d", (int) item.getHarga()) %>
                                    </div>
                                    
                                    <!-- Stock Info - alur program dari old -->
                                    <% if (book.getStock() <= 0) { %>
                                    <div class="stock-warning">
                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                        Stok habis - Item akan dihapus saat checkout
                                    </div>
                                    <% } else if (book.getStock() <= 5) { %>
                                    <div class="stock-warning">
                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                        Stok terbatas: <%= book.getStock() %> tersisa
                                    </div>
                                    <% } %>
                                    
                                    <!-- Quantity over stock warning - alur program dari old -->
                                    <% if (item.getQuantity() > book.getStock()) { %>
                                    <div class="stock-warning">
                                        <i class="bi bi-exclamation-triangle me-1"></i>
                                        Jumlah melebihi stok tersedia (<%= book.getStock() %>)
                                    </div>
                                    <% } %>
                                </div>
                            </div>
                            <div class="col-md-3">
                                <!-- Quantity Controls - menggunakan styling dari new -->
                                <div class="quantity-controls">
                                    <!-- Alur program dari old - server-side form submission -->
                                    <button class="quantity-btn" onclick="updateQuantity(<%= book.getBook_id() %>, <%= item.getQuantity() - 1 %>)" 
                                            <%= item.getQuantity() <= 1 ? "disabled" : "" %>>
                                        <i class="bi bi-dash"></i>
                                    </button>
                                    <div class="quantity-display" id="qty-<%= book.getBook_id() %>">
                                        <%= item.getQuantity() %>
                                    </div>
                                    <button class="quantity-btn" onclick="updateQuantity(<%= book.getBook_id() %>, <%= item.getQuantity() + 1 %>)"
                                            <%= (item.getQuantity() >= book.getStock() || book.getStock() <= 0) ? "disabled" : "" %>>
                                        <i class="bi bi-plus"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="col-md-3 text-end">
                                <div class="fw-bold text-primary mb-2">
                                    Rp<%= String.format("%,d", (long) item.getHarga() * item.getQuantity()) %>
                                </div>
                                <!-- Alur program dari old - server-side remove -->
                                <button class="btn remove-btn btn-sm" onclick="removeItem(<%= book.getBook_id() %>, '<%= book.getTitle().replace("'", "\\'") %>')">
                                    <i class="bi bi-trash me-1"></i>Hapus
                                </button>
                            </div>
                        </div>
                    </div>
                    <% 
                        }
                    } %>
                </div>

                <!-- Cart Summary - menggunakan class dari new dengan logic dari old -->
                <div class="col-lg-4">
                    <div class="cart-summary">
                        <h4><i class="bi bi-receipt me-2"></i>Ringkasan Belanja</h4>
                        
                        <div class="summary-row">
                            <span>Subtotal (<span id="selectedItems"><%= cart.getTotalItems() %></span> item)</span>
                            <span>Rp<span id="subtotalAmount"><%= String.format("%,d", subtotal.intValue()) %></span></span>
                        </div>
                        
                        <div class="summary-row">
                            <span>Ongkos Kirim</span>
                            <span id="shippingAmount">
                                <% if (shippingCost == 0) { %>
                                    <span class="text-success">GRATIS</span>
                                <% } else { %>
                                    Rp<%= String.format("%,d", shippingCost) %>
                                <% } %>
                            </span>
                        </div>
                        
                        <div class="summary-row">
                            <span>Pajak (11%)</span>
                            <span>Rp<%= String.format("%,d", tax) %></span>
                        </div>
                        
                        <div class="summary-row total">
                            <span>Total</span>
                            <span>Rp<span id="totalAmount"><%= String.format("%,d", finalTotal) %></span></span>
                        </div>
                        
                        <!-- Alur program dari old - shipping info -->
                        <% if (subtotal < 100000) { %>
                        <div class="alert alert-info mt-3">
                            <i class="bi bi-info-circle me-2"></i>
                            Belanja Rp<%= String.format("%,d", 100000 - subtotal.intValue()) %> lagi untuk gratis ongkir!
                        </div>
                        <% } %>
                        
                        <!-- Alur program dari old - checkout button dengan validasi -->
                        <button class="checkout-btn" onclick="proceedToCheckout()" 
                                <%= cart.getTotalItems() == 0 ? "disabled" : "" %> id="checkoutButton">
                            <i class="bi bi-credit-card me-2"></i>Lanjut ke Pembayaran
                        </button>
                        
                        <div class="text-center mt-3">
                            <a href="books" class="btn btn-outline-primary">
                                <i class="bi bi-arrow-left me-2"></i>Lanjut Belanja
                            </a>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>

            <!-- Recommendations Section - alur program dari old dengan styling dari new -->
            <% if (!recommendations.isEmpty()) { %>
            <div class="container mt-5">
                <div class="section-header">
                    <h4><i class="bi bi-lightbulb me-2"></i>Rekomendasi Untuk Kamu</h4>
                </div>
                <div class="book-grid">
                    <% for (Book book : recommendations) { %>
                    <div class="book-card">
                        <a href="books?action=detail&id=<%= book.getBook_id() %>" class="text-decoration-none">
                            <!-- Alur program dari old - default image path -->
                            <img src="<%= book.getImagePath() != null ? book.getImagePath() : "assets/images/default-book.jpg" %>" 
                                 class="book-cover" alt="<%= book.getTitle() %>">
                            <div class="book-body">
                                <h6 class="book-author"><%= book.getAuthor() != null ? book.getAuthor().getName() : "Unknown Author" %></h6>
                                <p class="book-title"><%= book.getTitle() %></p>
                                <strong class="book-price">Rp<%= String.format("%,d", book.getPrice()) %></strong>
                            </div>
                        </a>
                    </div>
                    <% } %>
                </div>
            </div>
            <% } %>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <!-- Hidden forms for cart operations - alur program dari old -->
    <form id="updateQuantityForm" action="cart" method="post" style="display: none;">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="bookId" id="updateBookId">
        <input type="hidden" name="quantity" id="updateQuantity">
    </form>
    
    <form id="removeItemForm" action="cart" method="post" style="display: none;">
        <input type="hidden" name="action" value="remove">
        <input type="hidden" name="bookId" id="removeBookId">
    </form>

    <!-- Scripts - menggunakan struktur dari new -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/js/iziToast.min.js"></script>

    <script>
        // Alur program dari old - semua JavaScript logic tetap sama
        let isUpdating = false;
        
        // Update quantity function - alur program dari old (server-side)
        function updateQuantity(bookId, newQuantity) {
            if (isUpdating || newQuantity < 0) return;
            
            isUpdating = true;
            
            // Show loading state
            const cartItem = document.getElementById('cart-item-' + bookId);
            if (cartItem) cartItem.classList.add('updating');
            
            // Update form and submit - alur program dari old
            document.getElementById('updateBookId').value = bookId;
            document.getElementById('updateQuantity').value = newQuantity;
            document.getElementById('updateQuantityForm').submit();
        }
        
        // Remove item function - alur program dari old
        function removeItem(bookId, bookTitle) {
            if (isUpdating) return;
            
            if (confirm(`Hapus "${bookTitle}" dari keranjang?`)) {
                isUpdating = true;
                document.getElementById('removeBookId').value = bookId;
                document.getElementById('removeItemForm').submit();
            }
        }
        
        // Proceed to checkout - alur program dari old dengan validasi
        function proceedToCheckout() {
            if (isUpdating) return;
            
            const selectedItems = document.querySelectorAll('.item-checkbox:checked');
            if (selectedItems.length === 0) {
                alert('Pilih minimal satu item untuk checkout!');
                return;
            }
            
            // Check for out of stock items - alur program dari old
            const outOfStockItems = document.querySelectorAll('.stock-warning');
            if (outOfStockItems.length > 0) {
                if (!confirm('Beberapa item dalam keranjang tidak tersedia atau melebihi stok. Item tersebut akan dihapus saat checkout. Lanjutkan?')) {
                    return;
                }
            }
            
            // Show loading state
            const checkoutButton = document.getElementById('checkoutButton');
            const originalText = checkoutButton.innerHTML;
            checkoutButton.disabled = true;
            checkoutButton.innerHTML = '<i class="bi bi-hourglass-split"></i> Memproses...';
            
            // Redirect to checkout - alur program dari old
            try {
                window.location.href = 'checkout';
            } catch (error) {
                checkoutButton.disabled = false;
                checkoutButton.innerHTML = originalText;
                isUpdating = false;
                alert('Terjadi kesalahan. Silakan coba lagi.');
            }
        }
        
        // Select all functionality - alur program dari old
        document.getElementById('selectAll').addEventListener('change', function() {
            const isChecked = this.checked;
            const itemCheckboxes = document.querySelectorAll('.item-checkbox');
            
            itemCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
            
            updateSummary();
            updateCheckoutButtonState();
        });
        
        // Individual item checkbox change - alur program dari old
        document.querySelectorAll('.item-checkbox').forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                updateSelectAllState();
                updateSummary();
                updateCheckoutButtonState();
            });
        });
        
        // Update select all state - alur program dari old
        function updateSelectAllState() {
            const itemCheckboxes = document.querySelectorAll('.item-checkbox');
            const checkedBoxes = document.querySelectorAll('.item-checkbox:checked');
            const selectAllCheckbox = document.getElementById('selectAll');
            
            if (checkedBoxes.length === 0) {
                selectAllCheckbox.indeterminate = false;
                selectAllCheckbox.checked = false;
            } else if (checkedBoxes.length === itemCheckboxes.length) {
                selectAllCheckbox.indeterminate = false;
                selectAllCheckbox.checked = true;
            } else {
                selectAllCheckbox.indeterminate = true;
            }
        }
        
        // Update summary based on selected items - alur program dari old
        function updateSummary() {
            const checkedBoxes = document.querySelectorAll('.item-checkbox:checked');
            const selectedItemsSpan = document.getElementById('selectedItems');
            
            if (selectedItemsSpan) {
                selectedItemsSpan.textContent = checkedBoxes.length;
            }
        }
        
        // Update checkout button state - alur program dari old
        function updateCheckoutButtonState() {
            const checkedBoxes = document.querySelectorAll('.item-checkbox:checked');
            const checkoutButton = document.getElementById('checkoutButton');
            
            if (checkedBoxes.length === 0) {
                checkoutButton.disabled = true;
            } else {
                checkoutButton.disabled = false;
            }
        }
        
        // Auto-hide alerts after 5 seconds - alur program dari old
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                if (alert.classList.contains('show')) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }
            });
        }, 5000);
        
        // Category search functionality - dari new
        const categorySearchInput = document.getElementById("categorySearchInputInDropdown");
        if (categorySearchInput) {
            const dropdownMenu = categorySearchInput.closest('.dropdown-menu');
            const itemsToFilter = dropdownMenu.querySelectorAll("li:not(.category-search-li) a.dropdown-item");
            
            categorySearchInput.addEventListener("keyup", function() {
                let filter = this.value.toLowerCase();
                
                itemsToFilter.forEach(function(itemLink) {
                    let text = itemLink.textContent.toLowerCase();
                    let listItem = itemLink.parentElement;
                    if (text.includes(filter)) {
                        listItem.style.display = "";
                    } else {
                        listItem.style.display = "none";
                    }
                });
            });
            
            categorySearchInput.addEventListener('click', function (e) {
                e.stopPropagation();
            });
        }
        
        // Initialize states - alur program dari old
        document.addEventListener('DOMContentLoaded', function() {
            updateSelectAllState();
            updateCheckoutButtonState();
        });
        
        // Handle page unload - alur program dari old
        window.addEventListener('beforeunload', function() {
            isUpdating = false;
        });
    </script>
</body>
</html>