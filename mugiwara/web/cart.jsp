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
    <link rel="stylesheet" href="assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .cart-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        
        .cart-header {
            border-bottom: 2px solid #dc3545;
            padding-bottom: 1rem;
            margin-bottom: 2rem;
        }
        
        .cart-header h2 {
            color: #dc3545;
            font-weight: 700;
            margin: 0;
        }
        
        .cart-item-card {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
        }
        
        .cart-item-card:hover {
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.15);
            border-color: #dc3545;
        }
        
        .cart-item-card.updating {
            opacity: 0.6;
            pointer-events: none;
        }
        
        .cart-item-image {
            width: 80px;
            height: 120px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .cart-item-details h5 {
            color: #333;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .cart-item-details .author {
            color: #666;
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }
        
        .cart-item-price {
            color: #dc3545;
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .quantity-controls {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin: 1rem 0;
        }
        
        .quantity-btn {
            width: 35px;
            height: 35px;
            border: 2px solid #dc3545;
            background: white;
            color: #dc3545;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: bold;
        }
        
        .quantity-btn:hover:not(:disabled) {
            background: #dc3545;
            color: white;
        }
        
        .quantity-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        
        .quantity-display {
            min-width: 50px;
            text-align: center;
            font-weight: 600;
            font-size: 1.1rem;
            padding: 0.5rem;
            border: 1px solid #ddd;
            border-radius: 8px;
            background: #f8f9fa;
        }
        
        .remove-btn {
            background: #dc3545;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .remove-btn:hover {
            background: #c82333;
            transform: translateY(-2px);
        }
        
        .cart-summary {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.3);
            position: sticky;
            top: 2rem;
        }
        
        .cart-summary h4 {
            margin-bottom: 1.5rem;
            font-weight: 700;
        }
        
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
        }
        
        .summary-row.total {
            border-top: 2px solid rgba(255,255,255,0.3);
            padding-top: 1rem;
            font-weight: 700;
            font-size: 1.2rem;
        }
        
        .checkout-btn {
            width: 100%;
            background: white;
            color: #dc3545;
            border: none;
            padding: 1rem;
            border-radius: 10px;
            font-weight: 700;
            font-size: 1.1rem;
            margin-top: 1.5rem;
            transition: all 0.3s ease;
        }
        
        .checkout-btn:hover:not(:disabled) {
            background: #f8f9fa;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        
        .checkout-btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            background: #6c757d;
            color: white;
        }
        
        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .empty-cart img {
            max-width: 300px;
            margin-bottom: 2rem;
            opacity: 0.8;
        }
        
        .empty-cart h3 {
            color: #666;
            margin-bottom: 1rem;
        }
        
        .empty-cart p {
            color: #999;
            margin-bottom: 2rem;
        }
        
        .shop-now-btn {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            transition: all 0.3s ease;
        }
        
        .shop-now-btn:hover {
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.4);
        }
        
        .cart-actions {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .select-all-container {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .select-all-container input[type="checkbox"] {
            width: 18px;
            height: 18px;
            accent-color: #dc3545;
        }
        
        .clear-cart-btn {
            background: #6c757d;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        
        .clear-cart-btn:hover {
            background: #5a6268;
        }
        
        .recommendations-section {
            margin-top: 3rem;
            padding-top: 2rem;
            border-top: 2px solid #e0e0e0;
        }
        
        .recommendations-title {
            color: #dc3545;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }
        
        .recommendations-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 1rem;
        }
        
        .recommendation-card {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 1rem;
            text-align: center;
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
        }
        
        .recommendation-card:hover {
            border-color: #dc3545;
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.15);
            text-decoration: none;
            color: inherit;
        }
        
        .recommendation-card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 1rem;
        }
        
        .recommendation-card .title {
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
            line-height: 1.3;
        }
        
        .recommendation-card .author {
            color: #666;
            font-size: 0.8rem;
            margin-bottom: 0.5rem;
        }
        
        .recommendation-card .price {
            color: #dc3545;
            font-weight: 700;
        }
        
        .loading-spinner {
            display: none;
            width: 20px;
            height: 20px;
            border: 2px solid #f3f3f3;
            border-top: 2px solid #dc3545;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        .stock-warning {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            color: #856404;
            padding: 0.5rem;
            border-radius: 6px;
            font-size: 0.85rem;
            margin-top: 0.5rem;
        }
        
        .stock-error {
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            padding: 0.5rem;
            border-radius: 6px;
            font-size: 0.85rem;
            margin-top: 0.5rem;
        }
        
        @media (max-width: 768px) {
            .cart-container {
                padding: 0 0.5rem;
            }
            
            .cart-item-card {
                padding: 1rem;
            }
            
            .cart-item-image {
                width: 60px;
                height: 90px;
            }
            
            .recommendations-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
            }
            
            .cart-summary {
                position: static;
                margin-top: 2rem;
            }
        }
    </style>
</head>
<body>
    <%
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
        
        String message = (String) session.getAttribute("message");
        String error = (String) session.getAttribute("error");
        
        // Clear messages after displaying
        session.removeAttribute("message");
        session.removeAttribute("error");
    %>

    <!-- Header -->
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
                <a href="<%= isLoggedIn ? "cart" : "login.jsp" %>" class="text-white-icon me-3 position-relative">
                    <img src="assets/images/cart.png" alt="cart" class="cart-icon">
                    <% 
                        Integer cartItemCount = (Integer) session.getAttribute("cartItemCount");
                        if (cartItemCount != null && cartItemCount > 0) {
                    %>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                        <%= cartItemCount %>
                    </span>
                    <% } %>
                </a>
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

    <!-- Breadcrumb -->
    <div class="breadcrumb-container">
        <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
            <ol class="breadcrumb d-flex">
                <li class="breadcrumb-item"><a href="home"><strong>Home</strong></a></li>
                <li class="breadcrumb-item active" aria-current="page">Keranjang Belanja</li>
            </ol>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="cart-container">
        <!-- Cart Header -->
        <div class="cart-header">
            <h2><i class="bi bi-cart3"></i> Keranjang Belanja</h2>
        </div>
        
        <!-- Messages -->
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
        <!-- Empty Cart Section -->
        <div class="empty-cart">
            <img src="assets/images/emptyCartFeedback.png" alt="Keranjang Kosong" />
            <h3>Keranjang Kamu Kosong :(</h3>
            <p>Kami punya banyak buku menarik yang siap memberi kamu kebahagiaan.</p>
            <p>Yuk, mulai belanja sekarang!</p>
            <a href="books" class="shop-now-btn">
                <i class="bi bi-book"></i> Mulai Belanja
            </a>
        </div>
        <% } else { %>
        
        <!-- Cart Actions -->
        <div class="cart-actions">
            <div class="select-all-container">
                <input type="checkbox" id="selectAll" />
                <label for="selectAll"><strong>Pilih Semua (<span id="totalItems"><%= cart.getTotalItems() %></span> item)</strong></label>
            </div>
            <form action="cart" method="post" style="display: inline;">
                <input type="hidden" name="action" value="clear">
                <button type="submit" class="clear-cart-btn" 
                        onclick="return confirm('Yakin ingin mengosongkan keranjang?')">
                    <i class="bi bi-trash"></i> Kosongkan Keranjang
                </button>
            </form>
        </div>
        
        <!-- Cart Content -->
        <div class="row">
            <div class="col-lg-8">
                <!-- Cart Items -->
                <% for (CartItem item : cart.getItems()) { 
                    Book book = item.getBook();
                    if (book != null) {
                %>
                <div class="cart-item-card" data-book-id="<%= book.getBook_id() %>" id="cart-item-<%= book.getBook_id() %>">
                    <div class="row align-items-center">
                        <div class="col-auto">
                            <input type="checkbox" class="item-checkbox" checked />
                        </div>
                        <div class="col-auto">
                            <img src="<%= book.getImagePath() != null ? book.getImagePath() : "assets/images/default-book.jpg" %>" 
                                 alt="<%= book.getTitle() %>" class="cart-item-image" />
                        </div>
                        <div class="col">
                            <div class="cart-item-details">
                                <h5><a href="books?action=detail&id=<%= book.getBook_id() %>" class="text-decoration-none"><%= book.getTitle() %></a></h5>
                                <div class="author">oleh <%= book.getAuthor() != null ? book.getAuthor().getName() : "Unknown Author" %></div>
                                <div class="cart-item-price">Rp<%= String.format("%,d", (int) item.getHarga()) %></div>
                                
                                <!-- Stock Info -->
                                <% if (book.getStock() <= 0) { %>
                                <div class="stock-error">
                                    <i class="bi bi-exclamation-triangle"></i> 
                                    Stok habis - Item akan dihapus saat checkout
                                </div>
                                <% } else if (book.getStock() <= 5) { %>
                                <div class="stock-warning">
                                    <i class="bi bi-exclamation-triangle"></i> 
                                    Stok terbatas: <%= book.getStock() %> tersisa
                                </div>
                                <% } %>
                                
                                <!-- Quantity over stock warning -->
                                <% if (item.getQuantity() > book.getStock()) { %>
                                <div class="stock-error">
                                    <i class="bi bi-exclamation-triangle"></i> 
                                    Jumlah melebihi stok tersedia (<%= book.getStock() %>)
                                </div>
                                <% } %>
                            </div>
                            
                            <!-- Quantity Controls -->
                            <div class="quantity-controls">
                                <button type="button" class="quantity-btn" 
                                        onclick="updateQuantity(<%= book.getBook_id() %>, <%= item.getQuantity() - 1 %>)"
                                        <%= item.getQuantity() <= 1 ? "disabled" : "" %>>
                                    <i class="bi bi-dash"></i>
                                </button>
                                <div class="quantity-display" id="qty-<%= book.getBook_id() %>"><%= item.getQuantity() %></div>
                                <button type="button" class="quantity-btn" 
                                        onclick="updateQuantity(<%= book.getBook_id() %>, <%= item.getQuantity() + 1 %>)"
                                        <%= (item.getQuantity() >= book.getStock() || book.getStock() <= 0) ? "disabled" : "" %>>
                                    <i class="bi bi-plus"></i>
                                </button>
                                <div class="loading-spinner" id="loading-<%= book.getBook_id() %>"></div>
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="button" class="remove-btn" 
                                    onclick="removeItem(<%= book.getBook_id() %>, '<%= book.getTitle().replace("'", "\\'") %>')">
                                <i class="bi bi-trash"></i> Hapus
                            </button>
                        </div>
                    </div>
                </div>
                <% 
                    }
                } %>
            </div>
            
            <!-- Cart Summary -->
            <div class="col-lg-4">
                <div class="cart-summary">
                    <h4><i class="bi bi-receipt"></i> Ringkasan Pesanan</h4>
                    
                    <div class="summary-row">
                        <span>Subtotal (<span id="selectedItems"><%= cart.getTotalItems() %></span> item)</span>
                        <span>Rp<span id="subtotalAmount"><%= String.format("%,d", subtotal.intValue()) %></span></span>
                    </div>
                    
                    <div class="summary-row">
                        <span>Ongkos Kirim</span>
                        <span id="shippingAmount">
                            <% if (shipping > 0) { %>
                            Rp<%= String.format("%,d", shipping.intValue()) %>
                            <% } else { %>
                            <span class="text-success">GRATIS</span>
                            <% } %>
                        </span>
                    </div>
                    
                    <% if (subtotal >= 100000) { %>
                    <small class="text-light">
                        <i class="bi bi-truck"></i> Gratis ongkir untuk pembelian di atas Rp100.000
                    </small>
                    <% } else { %>
                    <small class="text-light">
                        <i class="bi bi-info-circle"></i> Tambah Rp<%= String.format("%,d", (100000 - subtotal.intValue())) %> lagi untuk gratis ongkir
                    </small>
                    <% } %>
                    
                    <div class="summary-row total">
                        <span>Total Pembayaran</span>
                        <span>Rp<span id="totalAmount"><%= String.format("%,d", total.intValue()) %></span></span>
                    </div>
                    
                    <button type="button" class="checkout-btn" onclick="proceedToCheckout()" 
                            <%= cart.getTotalItems() == 0 ? "disabled" : "" %> id="checkoutButton">
                        <i class="bi bi-credit-card"></i> Lanjut ke Pembayaran
                    </button>
                    
                    <div class="mt-3 text-center">
                        <small class="text-light">
                            <i class="bi bi-shield-check"></i> Pembayaran aman dan terpercaya
                        </small>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
        
        <!-- Recommendations Section -->
        <% if (!recommendations.isEmpty()) { %>
        <div class="recommendations-section">
            <h3 class="recommendations-title">
                <i class="bi bi-lightbulb"></i> Rekomendasi Untuk Kamu
            </h3>
            <div class="recommendations-grid">
                <% for (Book book : recommendations) { %>
                <a href="books?action=detail&id=<%= book.getBook_id() %>" class="recommendation-card">
                    <img src="<%= book.getImagePath() != null ? book.getImagePath() : "assets/images/default-book.jpg" %>" 
                         alt="<%= book.getTitle() %>" />
                    <div class="title"><%= book.getTitle() %></div>
                    <div class="author"><%= book.getAuthor() != null ? book.getAuthor().getName() : "Unknown Author" %></div>
                    <div class="price">Rp<%= String.format("%,d", book.getPrice()) %></div>
                </a>
                <% } %>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <!-- Hidden forms for cart operations -->
    <form id="updateQuantityForm" action="cart" method="post" style="display: none;">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="bookId" id="updateBookId">
        <input type="hidden" name="quantity" id="updateQuantity">
    </form>
    
    <form id="removeItemForm" action="cart" method="post" style="display: none;">
        <input type="hidden" name="action" value="remove">
        <input type="hidden" name="bookId" id="removeBookId">
    </form>

    <!-- Scripts -->
    <script>
        // Global variables
        let isUpdating = false;
        
        // Update quantity function
        function updateQuantity(bookId, newQuantity) {
            if (isUpdating || newQuantity < 0) return;
            
            isUpdating = true;
            
            // Show loading spinner
            const loadingSpinner = document.getElementById('loading-' + bookId);
            const cartItem = document.getElementById('cart-item-' + bookId);
            
            if (loadingSpinner) loadingSpinner.style.display = 'inline-block';
            if (cartItem) cartItem.classList.add('updating');
            
            // Update form and submit
            document.getElementById('updateBookId').value = bookId;
            document.getElementById('updateQuantity').value = newQuantity;
            document.getElementById('updateQuantityForm').submit();
        }
        
        // Remove item function
        function removeItem(bookId, bookTitle) {
            if (isUpdating) return;
            
            if (confirm(`Hapus "${bookTitle}" dari keranjang?`)) {
                isUpdating = true;
                document.getElementById('removeBookId').value = bookId;
                document.getElementById('removeItemForm').submit();
            }
        }
        
        // Proceed to checkout - UPDATED FUNCTION
        function proceedToCheckout() {
            if (isUpdating) return;
            
            const selectedItems = document.querySelectorAll('.item-checkbox:checked');
            if (selectedItems.length === 0) {
                alert('Pilih minimal satu item untuk checkout!');
                return;
            }
            
            // Check for out of stock items
            const outOfStockItems = document.querySelectorAll('.stock-error');
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
            
            // Set timeout to reset button if something goes wrong
            const timeoutId = setTimeout(function() {
                checkoutButton.disabled = false;
                checkoutButton.innerHTML = originalText;
                isUpdating = false;
            }, 10000); // 10 second timeout
            
            // Redirect to checkout
            try {
                window.location.href = 'checkout';
            } catch (error) {
                clearTimeout(timeoutId);
                checkoutButton.disabled = false;
                checkoutButton.innerHTML = originalText;
                isUpdating = false;
                alert('Terjadi kesalahan. Silakan coba lagi.');
            }
        }
        
        // Select all functionality
        document.getElementById('selectAll').addEventListener('change', function() {
            const isChecked = this.checked;
            const itemCheckboxes = document.querySelectorAll('.item-checkbox');
            
            itemCheckboxes.forEach(checkbox => {
                checkbox.checked = isChecked;
            });
            
            updateSummary();
            updateCheckoutButtonState();
        });
        
        // Individual item checkbox change
        document.querySelectorAll('.item-checkbox').forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                updateSelectAllState();
                updateSummary();
                updateCheckoutButtonState();
            });
        });
        
        // Update select all state
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
        
        // Update summary based on selected items
        function updateSummary() {
            const checkedBoxes = document.querySelectorAll('.item-checkbox:checked');
            const selectedItemsSpan = document.getElementById('selectedItems');
            
            if (selectedItemsSpan) {
                selectedItemsSpan.textContent = checkedBoxes.length;
            }
        }
        
        // Update checkout button state
        function updateCheckoutButtonState() {
            const checkedBoxes = document.querySelectorAll('.item-checkbox:checked');
            const checkoutButton = document.getElementById('checkoutButton');
            
            if (checkedBoxes.length === 0) {
                checkoutButton.disabled = true;
                checkoutButton.classList.add('btn-secondary');
                checkoutButton.classList.remove('btn-primary');
            } else {
                checkoutButton.disabled = false;
                checkoutButton.classList.remove('btn-secondary');
                checkoutButton.classList.add('btn-primary');
            }
        }
        
        // Auto-hide alerts after 5 seconds
        setTimeout(function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                if (alert.classList.contains('show')) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }
            });
        }, 5000);
        
        // Category search functionality
        document.addEventListener('DOMContentLoaded', function () {
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
            
            // Initialize states
            updateSelectAllState();
            updateCheckoutButtonState();
        });
        
        // Handle page unload
        window.addEventListener('beforeunload', function() {
            isUpdating = false;
        });
        
        // Handle form submission errors with timeout
        document.addEventListener('submit', function(e) {
            if (isUpdating) {
                setTimeout(function() {
                    isUpdating = false;
                    document.querySelectorAll('.loading-spinner').forEach(spinner => {
                        spinner.style.display = 'none';
                    });
                    document.querySelectorAll('.updating').forEach(item => {
                        item.classList.remove('updating');
                    });
                }, 10000); // 10 second timeout
            }
        });
        
        // Error handling for network issues
        window.addEventListener('error', function(e) {
            console.error('JavaScript Error:', e.error);
            isUpdating = false;
        });
    </script>
</body>
</html>