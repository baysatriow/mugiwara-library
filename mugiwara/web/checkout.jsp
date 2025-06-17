<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Cart"%>
<%@page import="Models.CartItem"%>
<%@page import="Models.Book"%>
<%@page import="Models.Address"%>
<%@page import="Models.ShippingMethod"%>
<%@page import="Models.Users"%>
<%@page import="Models.UserRoles"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Checkout - Mugiwara Library</title>
    <link rel="stylesheet" href="assets/css/style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .checkout-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        
        .checkout-section {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .checkout-section h6 {
            color: #dc3545;
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .order-info-left {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .order-info-left img {
            width: 60px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
        }
        
        .item-details .book-title {
            font-weight: 600;
            margin-bottom: 0.25rem;
        }
        
        .item-details .book-qty {
            font-size: 0.9rem;
            color: #666;
        }
        
        .order-price {
            font-weight: 700;
            color: #dc3545;
        }
        
        .address-card {
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .address-card:hover {
            border-color: #dc3545;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.15);
        }
        
        .address-card.selected {
            border-color: #dc3545;
            background-color: #fff5f5;
        }
        
        .address-card input[type="radio"] {
            margin-right: 0.75rem;
            accent-color: #dc3545;
        }
        
        .shipping-method-card {
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .shipping-method-card:hover {
            border-color: #dc3545;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.15);
        }
        
        .shipping-method-card.selected {
            border-color: #dc3545;
            background-color: #fff5f5;
        }
        
        .shipping-method-card input[type="radio"] {
            margin-right: 0.75rem;
            accent-color: #dc3545;
        }
        
        .shipping-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .shipping-cost {
            font-weight: 700;
            color: #dc3545;
        }
        
        .payment-methods {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }
        
        .payment-option {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .payment-option:hover {
            border-color: #dc3545;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.15);
        }
        
        .payment-option input[type="radio"]:checked + .payment-left {
            color: #dc3545;
        }
        
        .payment-left {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .payment-left img {
            width: 40px;
            height: 30px;
            object-fit: contain;
        }
        
        .checkout-summary {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.3);
            position: sticky;
            top: 2rem;
        }
        
        .checkout-summary h6 {
            color: white;
            margin-bottom: 1.5rem;
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
        
        .btn-primary {
            background: white;
            color: #dc3545;
            border: none;
            padding: 1rem 2rem;
            border-radius: 10px;
            font-weight: 700;
            width: 100%;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover:not(:disabled) {
            background: #f8f9fa;
            color: #dc3545;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.2);
        }
        
        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            background: #6c757d;
            color: white;
        }
        
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: #666;
        }
        
        .empty-state img {
            max-width: 200px;
            margin-bottom: 1rem;
            opacity: 0.7;
        }
        
        @media (max-width: 768px) {
            .checkout-container {
                padding: 0 0.5rem;
            }
            
            .checkout-summary {
                position: static;
                margin-top: 2rem;
            }
            
            .order-info-left {
                gap: 0.5rem;
            }
            
            .order-info-left img {
                width: 50px;
                height: 70px;
            }
        }
    </style>
</head>
<body>
    <%
        // Get data from servlet
        Cart cart = (Cart) request.getAttribute("cart");
        ArrayList<Address> addresses = (ArrayList<Address>) request.getAttribute("addresses");
        Address defaultAddress = (Address) request.getAttribute("defaultAddress");
        ArrayList<ShippingMethod> shippingMethods = (ArrayList<ShippingMethod>) request.getAttribute("shippingMethods");
        Double subtotal = (Double) request.getAttribute("subtotal");
        Double defaultShippingCost = (Double) request.getAttribute("defaultShippingCost");
        Double total = (Double) request.getAttribute("total");
        
        // Default values
        if (cart == null) cart = new Cart();
        if (addresses == null) addresses = new ArrayList<>();
        if (shippingMethods == null) shippingMethods = new ArrayList<>();
        if (subtotal == null) subtotal = 0.0;
        if (defaultShippingCost == null) defaultShippingCost = 0.0;
        if (total == null) total = subtotal + defaultShippingCost;
        
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
                <a href="cart" class="text-white-icon me-3 position-relative">
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
                        <li><h6 class="dropdown-header">Halo, <%= fullName %></h6></li>
                        <li><a class="dropdown-item" href="profile.jsp"><i class="bi bi-person-circle"></i> Akun Saya</a></li>
                        <li><a class="dropdown-item" href="profile.jsp#transaksi"><i class="bi bi-receipt"></i> Pesanan</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout.jsp"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
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
                <li class="breadcrumb-item"><a href="cart"><strong>Keranjang</strong></a></li>
                <li class="breadcrumb-item active" aria-current="page">Checkout</li>
            </ol>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="checkout-container">
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

        <h4 class="mb-4"><i class="bi bi-credit-card"></i> Checkout</h4>
        
        <form id="checkoutForm" method="POST" action="checkout">
            <input type="hidden" name="action" value="process_order">
            
            <div class="row g-4">
                <!-- Left Column: Details -->
                <div class="col-lg-8">
                    <!-- Address Section -->
                    <div class="checkout-section">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6><i class="bi bi-geo-alt"></i> Alamat Pengiriman</h6>
                            <button type="button" class="btn btn-outline-danger btn-sm" data-bs-toggle="modal" data-bs-target="#modalPilihAlamat">
                                <i class="bi bi-pencil"></i> Ubah Alamat
                            </button>
                        </div>
                        
                        <% if (defaultAddress != null) { %>
                        <div class="address-display">
                            <p class="mb-1"><strong>Alamat Terpilih:</strong></p>
                            <p class="mb-0">
                                <%= defaultAddress.getFullAddress() %><br>
                                <%= defaultAddress.getDistrict() %>, <%= defaultAddress.getCity() %>, <%= defaultAddress.getProvince() %> <%= defaultAddress.getPostalCode() %>
                            </p>
                        </div>
                        <% } else { %>
                        <div class="empty-state">
                            <p class="text-muted">Belum ada alamat pengiriman yang dipilih.</p>
                            <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalPilihAlamat">
                                <i class="bi bi-plus-circle"></i> Pilih Alamat
                            </button>
                        </div>
                        <% } %>
                    </div>

                    <!-- Order Items Section -->
                    <div class="checkout-section">
                        <h6><i class="bi bi-bag"></i> Pesanan Anda (<%= cart.getTotalItems() %> item)</h6>
                        
                        <% for (CartItem item : cart.getItems()) { 
                            Book book = item.getBook();
                            if (book != null) {
                        %>
                        <div class="order-item">
                            <div class="order-info-left">
                                <img src="<%= book.getImagePath() != null ? book.getImagePath() : "assets/images/default-book.jpg" %>" 
                                     alt="<%= book.getTitle() %>" />
                                <div class="item-details">
                                    <div class="book-title"><%= book.getTitle() %></div>
                                    <div class="book-qty"><%= item.getQuantity() %> barang</div>
                                </div>
                            </div>
                            <div class="order-price">
                                Rp<%= String.format("%,d", (int) (item.getHarga() * item.getQuantity())) %>
                            </div>
                        </div>
                        <% 
                            }
                        } %>
                    </div>

                    <!-- Shipping Method Section -->
                    <div class="checkout-section">
                        <h6><i class="bi bi-truck"></i> Pilih Kurir</h6>
                        
                        <% if (!shippingMethods.isEmpty()) { %>
                        <div class="shipping-methods">
                            <% for (int i = 0; i < shippingMethods.size(); i++) { 
                                ShippingMethod method = shippingMethods.get(i);
                            %>
                            <label class="shipping-method-card" onclick="selectShippingMethod('<%= method.getName() %>', <%= method.getCost() %>)">
                                <div class="shipping-info">
                                    <input type="radio" name="shippingMethod" value="<%= method.getName() %>" 
                                           <%= i == 0 ? "checked" : "" %> />
                                    <div>
                                        <div class="fw-bold"><%= method.getName() %></div>
                                        <small class="text-muted">Estimasi 2-3 hari kerja</small>
                                    </div>
                                </div>
                                <div class="shipping-cost">
                                    <% if (method.getCost() > 0) { %>
                                    Rp<%= String.format("%,d", (int) method.getCost()) %>
                                    <% } else { %>
                                    <span class="text-success">GRATIS</span>
                                    <% } %>
                                </div>
                            </label>
                            <% } %>
                        </div>
                        <% } else { %>
                        <div class="empty-state">
                            <p class="text-muted">Tidak ada metode pengiriman yang tersedia.</p>
                        </div>
                        <% } %>
                    </div>

                    <!-- Payment Method Section -->
                    <div class="checkout-section">
                        <h6><i class="bi bi-credit-card"></i> Metode Pembayaran</h6>
                        <div class="payment-methods">
                            <label class="payment-option">
                                <div class="payment-left">
                                    <img src="assets/images/bca.png" alt="BCA" />
                                    <span>BCA Virtual Account</span>
                                </div>
                                <input type="radio" name="paymentMethod" value="BCA_VA" />
                            </label>
                            <label class="payment-option">
                                <div class="payment-left">
                                    <img src="assets/images/bri.png" alt="BRI" />
                                    <span>BRI Virtual Account</span>
                                </div>
                                <input type="radio" name="paymentMethod" value="BRI_VA" />
                            </label>
                            <label class="payment-option">
                                <div class="payment-left">
                                    <img src="assets/images/mandiri.png" alt="Mandiri" />
                                    <span>Mandiri Virtual Account</span>
                                </div>
                                <input type="radio" name="paymentMethod" value="MANDIRI_VA" />
                            </label>
                            <label class="payment-option">
                                <div class="payment-left">
                                    <img src="assets/images/qris.png" alt="QRIS" />
                                    <span>QRIS</span>
                                </div>
                                <input type="radio" name="paymentMethod" value="QRIS" />
                            </label>
                        </div>
                    </div>
                </div>
                
                <!-- Right Column: Summary -->
                <div class="col-lg-4">
                    <div class="checkout-summary">
                        <h6><i class="bi bi-receipt"></i> Ringkasan Belanja</h6>
                        
                        <div class="summary-row">
                            <span>Total Harga (<span id="item-count"><%= cart.getTotalItems() %></span> Barang)</span>
                            <span>Rp<span id="subtotal-amount"><%= String.format("%,d", subtotal.intValue()) %></span></span>
                        </div>
                        
                        <div class="summary-row">
                            <span>Biaya Pengiriman</span>
                            <span>Rp<span id="shipping-cost"><%= String.format("%,d", defaultShippingCost.intValue()) %></span></span>
                        </div>
                        
                        <div class="summary-row total">
                            <span>Total Pembayaran</span>
                            <span>Rp<span id="total-amount"><%= String.format("%,d", total.intValue()) %></span></span>
                        </div>
                        
                        <button type="submit" id="payButton" class="btn-primary mt-3" 
                                <%= (defaultAddress == null || shippingMethods.isEmpty()) ? "disabled" : "" %>>
                            <i class="bi bi-credit-card"></i> Bayar Sekarang
                        </button>
                        
                        <div class="mt-3 text-center">
                            <small class="text-light">
                                <i class="bi bi-shield-check"></i> Pembayaran aman dan terpercaya
                            </small>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <!-- Modal Pilih Alamat -->
    <div class="modal fade" id="modalPilihAlamat" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Pilih Alamat Pengiriman</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <% if (!addresses.isEmpty()) { %>
                    <div id="daftar-alamat" class="d-flex flex-column gap-2">
                        <% for (int i = 0; i < addresses.size(); i++) { 
                            Address addr = addresses.get(i);
                        %>
                        <label class="address-card <%= addr.isIsDefault() ? "selected" : "" %>">
                            <input type="radio" name="alamatRadio" value="<%= i %>" 
                                   <%= addr.isIsDefault() ? "checked" : "" %> />
                            <div>
                                <div class="fw-bold">
                                    <%= addr.getFullAddress() %>
                                    <% if (addr.isIsDefault()) { %>
                                    <span class="badge bg-danger ms-2">Default</span>
                                    <% } %>
                                </div>
                                <div class="text-muted">
                                    <%= addr.getDistrict() %>, <%= addr.getCity() %>, <%= addr.getProvince() %> <%= addr.getPostalCode() %>
                                </div>
                            </div>
                        </label>
                        <% } %>
                    </div>
                    <% } else { %>
                    <div class="empty-state">
                        <img src="assets/images/emptyCartFeedback.png" alt="Alamat kosong" width="150">
                        <p class="mt-3 text-muted">Belum ada alamat tersimpan. Tambahkan dulu ya!</p>
                    </div>
                    <% } %>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalTambahAlamat">
                        <i class="bi bi-plus-circle"></i> Tambah Alamat
                    </button>
                    <% if (!addresses.isEmpty()) { %>
                    <button type="button" class="btn btn-danger" id="btnGunakanAlamat">
                        Gunakan Alamat Ini
                    </button>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Tambah Alamat -->
    <div class="modal fade" id="modalTambahAlamat" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <form id="formTambahAlamat" class="modal-content" method="POST" action="checkout">
                <input type="hidden" name="action" value="add_address">
                <div class="modal-header">
                    <h5 class="modal-title">Tambah Alamat Baru</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Provinsi</label>
                            <input type="text" class="form-control" name="province" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Kota/Kabupaten</label>
                            <input type="text" class="form-control" name="city" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Kecamatan</label>
                            <input type="text" class="form-control" name="district" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Kode Pos</label>
                            <input type="text" class="form-control" name="postalCode" pattern="[0-9]{5}" maxlength="5" required>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Alamat Lengkap</label>
                            <textarea class="form-control" name="fullAddress" rows="3" required></textarea>
                        </div>
                        <div class="col-12">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="isDefault" value="true" id="setDefault">
                                <label class="form-check-label" for="setDefault">
                                    Jadikan alamat utama
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-danger">Simpan Alamat</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        // Global variables
        let currentSubtotal = <%= subtotal %>;
        
        // Select shipping method and update costs
        function selectShippingMethod(methodName, cost) {
            const shippingCostElement = document.getElementById('shipping-cost');
            const totalAmountElement = document.getElementById('total-amount');
            
            // Update shipping cost display
            if (cost > 0) {
                shippingCostElement.textContent = cost.toLocaleString('id-ID');
            } else {
                shippingCostElement.innerHTML = '<span class="text-success">GRATIS</span>';
            }
            
            // Update total
            const newTotal = currentSubtotal + cost;
            totalAmountElement.textContent = newTotal.toLocaleString('id-ID');
            
            // Update selected shipping method card
            document.querySelectorAll('.shipping-method-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            const selectedCard = document.querySelector(`input[value="${methodName}"]`).closest('.shipping-method-card');
            selectedCard.classList.add('selected');
            
            updatePayButtonState();
        }
        
        // Update pay button state
        function updatePayButtonState() {
            const payButton = document.getElementById('payButton');
            const hasAddress = <%= defaultAddress != null ? "true" : "false" %>;
            const hasShipping = document.querySelector('input[name="shippingMethod"]:checked') !== null;
            const hasPayment = document.querySelector('input[name="paymentMethod"]:checked') !== null;
            
            if (hasAddress && hasShipping && hasPayment) {
                payButton.disabled = false;
                payButton.classList.remove('btn-secondary');
                payButton.classList.add('btn-primary');
            } else {
                payButton.disabled = true;
                payButton.classList.remove('btn-primary');
                payButton.classList.add('btn-secondary');
            }
        }
        
        // Handle address selection in modal
        document.getElementById('btnGunakanAlamat')?.addEventListener('click', function() {
            const selectedAddress = document.querySelector('input[name="alamatRadio"]:checked');
            if (!selectedAddress) {
                alert('Pilih alamat terlebih dahulu!');
                return;
            }
            
            // Submit form to update default address
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'checkout';
            form.style.display = 'none';
            
            const actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'select_address';
            
            const addressIdInput = document.createElement('input');
            addressIdInput.type = 'hidden';
            addressIdInput.name = 'addressId';
            addressIdInput.value = selectedAddress.value;
            
            form.appendChild(actionInput);
            form.appendChild(addressIdInput);
            
            document.body.appendChild(form);
            form.submit();
        });
        
        // Handle payment method selection
        document.querySelectorAll('input[name="paymentMethod"]').forEach(radio => {
            radio.addEventListener('change', function() {
                // Update payment option styling
                document.querySelectorAll('.payment-option').forEach(option => {
                    option.classList.remove('selected');
                });
                
                this.closest('.payment-option').classList.add('selected');
                updatePayButtonState();
            });
        });
        
        // Handle shipping method selection
        document.querySelectorAll('input[name="shippingMethod"]').forEach(radio => {
            radio.addEventListener('change', function() {
                const methodName = this.value;
                const cost = parseFloat(this.closest('.shipping-method-card').querySelector('.shipping-cost').textContent.replace(/[^\d]/g, '')) || 0;
                selectShippingMethod(methodName, cost);
            });
        });
        
        // Handle address card selection in modal
        document.querySelectorAll('input[name="alamatRadio"]').forEach(radio => {
            radio.addEventListener('change', function() {
                document.querySelectorAll('.address-card').forEach(card => {
                    card.classList.remove('selected');
                });
                
                this.closest('.address-card').classList.add('selected');
            });
        });
        
        // Form validation before submit
        document.getElementById('checkoutForm').addEventListener('submit', function(e) {
            const hasAddress = <%= defaultAddress != null ? "true" : "false" %>;
            const hasShipping = document.querySelector('input[name="shippingMethod"]:checked') !== null;
            const hasPayment = document.querySelector('input[name="paymentMethod"]:checked') !== null;
            
            if (!hasAddress) {
                e.preventDefault();
                alert('Silakan pilih alamat pengiriman terlebih dahulu!');
                return;
            }
            
            if (!hasShipping) {
                e.preventDefault();
                alert('Silakan pilih metode pengiriman terlebih dahulu!');
                return;
            }
            
            if (!hasPayment) {
                e.preventDefault();
                alert('Silakan pilih metode pembayaran terlebih dahulu!');
                return;
            }
            
            // Show loading state
            const submitButton = this.querySelector('button[type="submit"]');
            submitButton.disabled = true;
            submitButton.innerHTML = '<i class="bi bi-hourglass-split"></i> Memproses...';
        });
        
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
        
        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            updatePayButtonState();
            
            // Initialize first shipping method as selected
            const firstShippingMethod = document.querySelector('input[name="shippingMethod"]:checked');
            if (firstShippingMethod) {
                const cost = <%= defaultShippingCost %>;
                selectShippingMethod(firstShippingMethod.value, cost);
            }
        });
    </script>
</body>
</html>