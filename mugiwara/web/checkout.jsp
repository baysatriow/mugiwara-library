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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Mugiwara Library</title>>
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
        ArrayList<Address> addresses = (ArrayList<Address>) request.getAttribute("addresses");
        Address defaultAddress = (Address) request.getAttribute("defaultAddress");
        ArrayList<ShippingMethod> shippingMethods = (ArrayList<ShippingMethod>) request.getAttribute("shippingMethods");
        Double subtotal = (Double) request.getAttribute("subtotal");
        Double defaultShippingCost = (Double) request.getAttribute("defaultShippingCost");
        Double total = (Double) request.getAttribute("total");
        
        // Default values - alur program dari old
        if (cart == null) cart = new Cart();
        if (addresses == null) addresses = new ArrayList<>();
        if (shippingMethods == null) shippingMethods = new ArrayList<>();
        if (subtotal == null) subtotal = 0.0;
        if (defaultShippingCost == null) defaultShippingCost = 0.0;
        if (total == null) total = subtotal + defaultShippingCost;
        
        // Alur program dari old - message handling via session
        String message = (String) session.getAttribute("message");
        String error = (String) session.getAttribute("error");
        
        // Clear messages after displaying
        session.removeAttribute("message");
        session.removeAttribute("error");
        
        // Calculate totals for display - alur program dari old
        int totalItems = cart.getTotalItems();
        long shippingCost = defaultShippingCost.longValue();
        long tax = (long) (subtotal * 0.11); // 11% tax
        long finalTotal = subtotal.longValue() + shippingCost + tax;
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
                <!-- Cart Button -->
                <a href="cart" class="text-white-icon me-3 position-relative">
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

    <!-- Breadcrumb  -->
    <div class="breadcrumb-container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="home">Home</a></li>
                <li class="breadcrumb-item"><a href="cart">Keranjang</a></li>
                <li class="breadcrumb-item active" aria-current="page">Checkout</li>
            </ol>
        </nav>
    </div>

    <!-- Main Content  -->
    <main>
        <div class="checkout-container">
            <div class="cart-header">
                <h2><i class="bi bi-credit-card me-3"></i>Checkout</h2>
                <p class="text-muted mb-0">Lengkapi informasi untuk menyelesaikan pesanan Anda</p>
            </div>

            <!-- Messages  -->
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
            <!-- Empty Cart  -->
            <div class="empty-cart">
                <img src="assets/images/empty-cart.svg" alt="Keranjang Kosong" style="max-width: 300px; opacity: 0.7;">
                <h3>Tidak Ada Item untuk Checkout</h3>
                <p>Silakan tambahkan item ke keranjang terlebih dahulu.</p>
                <a href="books" class="btn btn-primary">
                    <i class="bi bi-book me-2"></i>Mulai Belanja
                </a>
            </div>
            <% } else { %>
            
            <!-- server-side form submission -->
            <form id="checkoutForm" method="POST" action="checkout">
                <input type="hidden" name="action" value="process_order">
                
                <div class="row">
                    <!-- Left Column: Details  -->
                    <div class="col-lg-8">
                        <!-- Address Section  -->
                        <div class="checkout-section">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h6><i class="bi bi-geo-alt me-2"></i>Alamat Pengiriman</h6>
                                <button type="button" class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#modalPilihAlamat">
                                    <i class="bi bi-pencil me-1"></i>Ubah Alamat
                                </button>
                            </div>
                            
                            <!-- defaultAddress logic -->
                            <% if (defaultAddress != null) { %>
                            <div class="address-card selected">
                                <div>
                                    <h6>Alamat Terpilih</h6>
                                    <p class="mb-1"><strong><%= defaultAddress.getFullAddress() %></strong></p>
                                    <p class="mb-0">
                                        <%= defaultAddress.getDistrict() %>, <%= defaultAddress.getCity() %>, <%= defaultAddress.getProvince() %> <%= defaultAddress.getPostalCode() %>
                                    </p>
                                </div>
                            </div>
                            <% } else { %>
                            <div class="text-center py-4">
                                <i class="bi bi-geo-alt text-muted" style="font-size: 2rem;"></i>
                                <p class="text-muted mt-2">Belum ada alamat pengiriman yang dipilih.</p>
                                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalPilihAlamat">
                                    <i class="bi bi-plus-circle me-2"></i>Pilih Alamat
                                </button>
                            </div>
                            <% } %>
                        </div>

                        <!-- Order Items Section -->
                        <div class="checkout-section">
                            <h6><i class="bi bi-list-ul me-2"></i>Ringkasan Pesanan (<%= cart.getTotalItems() %> item)</h6>
                            
                            <% for (CartItem item : cart.getItems()) { 
                                Book book = item.getBook();
                                if (book != null) {
                            %>
                            <div class="order-item">
                                <div class="order-info-left">
                                    <!-- default image path -->
                                    <img src="<%= book.getImagePath() != null ? book.getImagePath() : "assets/images/default-book.jpg" %>" 
                                         alt="<%= book.getTitle() %>">
                                    <div class="item-details">
                                        <div class="book-title"><%= book.getTitle() %></div>
                                        <div class="book-qty">Qty: <%= item.getQuantity() %></div>
                                        <!-- menggunakan item.getHarga() -->
                                        <div class="order-price">Rp<%= String.format("%,d", (int) (item.getHarga() * item.getQuantity())) %></div>
                                    </div>
                                </div>
                            </div>
                            <% 
                                }
                            } %>
                        </div>

                        <!-- Shipping Method Section -->
                        <div class="checkout-section">
                            <h6><i class="bi bi-truck me-2"></i>Metode Pengiriman</h6>
                            
                            <!-- menggunakan shippingMethods dari database -->
                            <% if (!shippingMethods.isEmpty()) { %>
                            <% for (int i = 0; i < shippingMethods.size(); i++) { 
                                ShippingMethod method = shippingMethods.get(i);
                            %>
                            <div class="shipping-method-card <%= i == 0 ? "selected" : "" %>" onclick="selectShippingMethod(this, '<%= method.getName() %>', <%= method.getCost() %>)">
                                <div class="shipping-info">
                                    <input type="radio" name="shippingMethod" value="<%= method.getName() %>" 
                                           <%= i == 0 ? "checked" : "" %>>
                                    <div>
                                        <strong><%= method.getName() %></strong>
                                        <p class="mb-0 text-muted">Estimasi 2-3 hari kerja</p>
                                    </div>
                                </div>
                                <div class="shipping-cost">
                                    <% if (method.getCost() > 0) { %>
                                    Rp<%= String.format("%,d", (int) method.getCost()) %>
                                    <% } else { %>
                                    <span class="text-success">GRATIS</span>
                                    <% } %>
                                </div>
                            </div>
                            <% } %>
                            <% } else { %>
                            <div class="text-center py-4">
                                <i class="bi bi-truck text-muted" style="font-size: 2rem;"></i>
                                <p class="text-muted mt-2">Tidak ada metode pengiriman yang tersedia.</p>
                            </div>
                            <% } %>
                        </div>

                        <!-- Payment Method Section -->
                        <div class="checkout-section">
                            <h6><i class="bi bi-credit-card me-2"></i>Metode Pembayaran</h6>
                            <div class="payment-methods">
                                <!-- payment options -->
                                <div class="payment-option selected" onclick="selectPaymentMethod(this)">
                                    <input type="radio" name="paymentMethod" value="BCA_VA" checked>
                                    <div class="payment-left">
                                        <img src="assets/images/bca.png" alt="BCA">
                                        <div>
                                            <strong>BCA Virtual Account</strong>
                                            <p class="mb-0 text-muted">Transfer melalui BCA</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="payment-option" onclick="selectPaymentMethod(this)">
                                    <input type="radio" name="paymentMethod" value="BRI_VA">
                                    <div class="payment-left">
                                        <img src="assets/images/bri.png" alt="BRI">
                                        <div>
                                            <strong>BRI Virtual Account</strong>
                                            <p class="mb-0 text-muted">Transfer melalui BRI</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="payment-option" onclick="selectPaymentMethod(this)">
                                    <input type="radio" name="paymentMethod" value="MANDIRI_VA">
                                    <div class="payment-left">
                                        <img src="assets/images/mandiri.png" alt="Mandiri">
                                        <div>
                                            <strong>Mandiri Virtual Account</strong>
                                            <p class="mb-0 text-muted">Transfer melalui Mandiri</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="payment-option" onclick="selectPaymentMethod(this)">
                                    <input type="radio" name="paymentMethod" value="QRIS">
                                    <div class="payment-left">
                                        <img src="assets/images/qris.png" alt="QRIS">
                                        <div>
                                            <strong>QRIS</strong>
                                            <p class="mb-0 text-muted">Bayar dengan scan QR</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Right Column: Summary -->
                    <div class="col-lg-4">
                        <div class="cart-summary">
                            <h4><i class="bi bi-receipt me-2"></i>Total Pembayaran</h4>
                            
                            <div class="summary-row">
                                <span>Subtotal (<span id="item-count"><%= cart.getTotalItems() %></span> item)</span>
                                <span>Rp<span id="subtotal-amount"><%= String.format("%,d", subtotal.intValue()) %></span></span>
                            </div>
                            
                            <div class="summary-row">
                                <span>Ongkos Kirim</span>
                                <span id="shippingCostDisplay">Rp<span id="shipping-cost"><%= String.format("%,d", defaultShippingCost.intValue()) %></span></span>
                            </div>
                            
                            <div class="summary-row">
                                <span>Pajak (11%)</span>
                                <span>Rp<%= String.format("%,d", tax) %></span>
                            </div>
                            
                            <div class="summary-row total">
                                <span>Total</span>
                                <span>Rp<span id="total-amount"><%= String.format("%,d", finalTotal) %></span></span>
                            </div>
                            
                            <!-- validation logic -->
                            <button type="submit" id="payButton" class="checkout-btn" 
                                    <%= (defaultAddress == null || shippingMethods.isEmpty()) ? "disabled" : "" %>>
                                <i class="bi bi-check-circle me-2"></i>Buat Pesanan
                            </button>
                            
                            <div class="text-center mt-3">
                                <a href="cart" class="btn btn-outline-primary">
                                    <i class="bi bi-arrow-left me-2"></i>Kembali ke Keranjang
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <% } %>
        </div>
    </main>

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
                        <div class="address-card <%= addr.isIsDefault() ? "selected" : "" %>">
                            <input type="radio" name="alamatRadio" value="<%= i %>" 
                                   <%= addr.isIsDefault() ? "checked" : "" %>>
                            <div>
                                <h6>
                                    <%= addr.getFullAddress() %>
                                    <% if (addr.isIsDefault()) { %>
                                    <span class="badge bg-primary ms-2">Default</span>
                                    <% } %>
                                </h6>
                                <p class="mb-0 text-muted">
                                    <%= addr.getDistrict() %>, <%= addr.getCity() %>, <%= addr.getProvince() %> <%= addr.getPostalCode() %>
                                </p>
                            </div>
                        </div>
                        <% } %>
                    </div>
                    <% } else { %>
                    <div class="text-center py-4">
                        <!-- menggunakan image path dari old -->
                        <img src="assets/images/emptyCartFeedback.png" alt="Alamat kosong" width="150">
                        <p class="mt-3 text-muted">Belum ada alamat tersimpan. Tambahkan dulu ya!</p>
                    </div>
                    <% } %>
                </div>
                <div class="modal-footer justify-content-between">
                    <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalTambahAlamat">
                        <i class="bi bi-plus-circle me-1"></i>Tambah Alamat
                    </button>
                    <% if (!addresses.isEmpty()) { %>
                    <button type="button" class="btn btn-primary" id="btnGunakanAlamat">
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
                    <button type="submit" class="btn btn-primary">Simpan Alamat</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/js/iziToast.min.js"></script>

    <script>
        let currentSubtotal = <%= subtotal %>;
         
        function selectShippingMethod(element, methodName, cost) {
            document.querySelectorAll('.shipping-method-card').forEach(card => {
                card.classList.remove('selected');
            });
            
            element.classList.add('selected');
            
          
            element.querySelector('input[type="radio"]').checked = true;
            
            const shippingCostElement = document.getElementById('shipping-cost');
            const totalAmountElement = document.getElementById('total-amount');
            
            // Update shipping cost display
            if (cost > 0) {
                shippingCostElement.textContent = cost.toLocaleString('id-ID');
            } else {
                document.getElementById('shippingCostDisplay').innerHTML = '<span class="text-success">GRATIS</span>';
            }
            
            // Update total
            const tax = <%= tax %>;
            const newTotal = currentSubtotal + cost + tax;
            totalAmountElement.textContent = newTotal.toLocaleString('id-ID');
            
            updatePayButtonState();
        }
        
        // Select payment method 
        function selectPaymentMethod(element) {
            document.querySelectorAll('.payment-option').forEach(card => {
                card.classList.remove('selected');
            });
            
            element.classList.add('selected');
        
            element.querySelector('input[type="radio"]').checked = true;
            
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
            } else {
                payButton.disabled = true;
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
            
            const submitButton = this.querySelector('button[type="submit"]');
            submitButton.disabled = true;
            submitButton.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Memproses...';
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
        
        // Category search functionality 
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
        
        // Initialize 
        document.addEventListener('DOMContentLoaded', function() {
            updatePayButtonState();
            
            const firstShippingMethod = document.querySelector('input[name="shippingMethod"]:checked');
            if (firstShippingMethod) {
                const cost = <%= defaultShippingCost %>;
                const methodName = firstShippingMethod.value;
                
            }
        });
    </script>
</body>
</html>