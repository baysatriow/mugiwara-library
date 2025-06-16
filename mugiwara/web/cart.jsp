<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - Mugiwara Library</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

    <!-- Header -->
    <header>
        <nav>
            <div class="logo-container">
                <a href=".">
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
                        <li><a class="dropdown-item" href="books.jsp?category=Novel">Novel</a></li>
                        <li><a class="dropdown-item" href="books.jsp?category=Majalah">Majalah</a></li>
                        <li><a class="dropdown-item" href="books.jsp?category=Komik">Komik</a></li>
                        <li><a class="dropdown-item" href="books.jsp">Semua Kategori</a></li>
                    </ul>
                </div>
                <form class="form-inline flex-grow-1" action="books.jsp" method="get"> 
                    <div class="search-input-group">
                        <input class="form-control search-input" type="search" name="query" placeholder="Mau cari apa hari ini?" aria-label="Search">
                        <button class="search-btn" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>
            </div>
            <div class="user-menu">
                <!-- Tombol Keranjang -->
                <a href="<%= isLoggedIn ? "cart.jsp" : "login.jsp" %>" class="text-white-icon me-3">
                    <img src="assets/images/cart.png" alt="cart" class="cart-icon">
                </a>

                <!-- Menu Pengguna Dropdown -->
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

    <div class="cart-container">
        <h4>Keranjang</h4>
        
        <!-- Cart Items Section -->
        <div id="cart-section" class="row">
            <div class="form-box d-flex justify-content-between align-items-center border rounded p-2 mb-3">
                <div class="form-check d-flex align-items-center">
                    <input class="form-check-input me-2" type="checkbox" id="selectAll" />
                    <label class="form-check-label" for="selectAll">
                        Semua
                    </label>
                </div>
                <button class="btn btn-outline-danger btn-sm" id="deleteSelected">
                    <i class="bi bi-trash"></i> Hapus
                </button>
            </div>
            
            <div class="col-md-8">
                <div class="cart-box d-flex align-items-center justify-content-between mb-3">
                    <div class="cart-item d-flex align-items-center">
                        <input class="form-check-input me-3" type="checkbox" checked />
                        <img src="assets/images/Laut Bercerita.jpg" alt="Book" class="me-3" />
                        <div>
                            <div><a href="book_details.jsp"><strong>Laut Bercerita</strong></a></div>
                            <div>Rp142.500</div>
                        </div>
                    </div>
                    <div class="d-flex align-items-center">
                        <button class="btn btn-outline-danger btn-sm me-2"><i class="bi bi-trash"></i></button>
                        <button class="btn btn-outline-secondary btn-sm" onclick="decreaseQuantity(this)">-</button>
                        <span class="mx-2 quantity-display">1</span>
                        <button class="btn btn-outline-secondary btn-sm" onclick="increaseQuantity(this)">+</button>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="cart-box">
                    <h6 class="mb-3"><strong>Ringkasan Barang</strong></h6>
                    <div class="d-flex justify-content-between">
                        <span>Total Harga (<span id="item-count">1 Barang</span>)</span>
                        <span>Rp<span id="total-price">142.500</span></span>
                    </div>
                    <div class="d-flex justify-content-between text-danger mb-2">
                        <span>Diskon Belanja</span>
                        <span>-Rp<span id="discount">0</span></span>
                    </div>
                    <hr />
                    <div class="d-flex justify-content-between fw-bold">
                        <span>Subtotal</span>
                        <span>Rp<span id="subtotal">142.500</span></span>
                    </div>
                    <a href="checkout.jsp">
                        <button class="btn-primary btn-block mt-3">Checkout</button>
                    </a>
                </div>
            </div>
        </div>
        
        <!-- Empty Cart Section -->
        <div id="empty-cart-section" class="empty-cart d-none">
            <img src="assets/images/emptyCartFeedback.png" alt="Empty Cart" />
            <div class="empty-cart-desc">
                <h5>Keranjang Kamu Kosong :(</h5>
                <p>Kami punya banyak barang yang siap memberi kamu kebahagiaan.</p>
                <p>Yuk, belanja sekarang!</p>
                <a href="." class="btn-primary">Mulai Belanja</a>
            </div>
        </div>
        
        <!-- Recommendations Section -->
        <div class="cart-recommendations">
            <h4>Rekomendasi Untukmu</h4>
            <div class="recommendations-carousel">
                <button class="carousel-nav-btn prev" onclick="scrollRecommendations(-1)">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                </button>
                <div class="recommendations-track" id="recommendationsTrack">
                    <div class="recommendation-card">
                        <img src="assets/images/Laut Bercerita.jpg" alt="Laut Bercerita" />
                        <p class="author">Leila S. Chudori</p>
                        <p class="title">Laut Bercerita</p>
                        <p class="price">Rp142.500</p>
                    </div>
                    <div class="recommendation-card">
                        <img src="assets/images/Seperti Dendam.jpg" alt="Seperti Dendam" />
                        <p class="author">Eka Kurniawan</p>
                        <p class="title">Seperti Dendam, Rindu Harus Dibayar Tuntas</p>
                        <p class="price">Rp56.250</p>
                    </div>
                    <div class="recommendation-card">
                        <img src="assets/images/Gadis Kretek.jpg" alt="Gadis Kretek" />
                        <p class="author">Ratih Kumala</p>
                        <p class="title">Gadis Kretek (Sampul Netflix)</p>
                        <p class="price">Rp56.250</p>
                    </div>
                    <div class="recommendation-card">
                        <img src="assets/images/Cantik Luka.jpg" alt="Cantik Itu Luka" />
                        <p class="author">Eka Kurniawan</p>
                        <p class="title">Novel Cantik Itu Luka</p>
                        <p class="price">Rp93.750</p>
                    </div>
                    <div class="recommendation-card">
                        <img src="assets/images/Bagaimana Demokrasi Mati.jpg" alt="Bagaimana Demokrasi Mati" />
                        <p class="author">Steven Levitsky & Daniel Ziblatt</p>
                        <p class="title">Bagaimana Demokrasi Mati</p>
                        <p class="price">Rp73.500</p>
                    </div>
                </div>
                <button class="carousel-nav-btn next" onclick="scrollRecommendations(1)">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                </button>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <!-- Scripts -->
    <script>
        let cartItems = 1;
        const pricePerItem = 142500;

        function updateCartSummary() {
            const totalPrice = cartItems * pricePerItem;
            document.getElementById('item-count').textContent = `${cartItems} Barang`;
            document.getElementById('total-price').textContent = totalPrice.toLocaleString('id-ID');
            document.getElementById('subtotal').textContent = totalPrice.toLocaleString('id-ID');
        }

        function increaseQuantity(button) {
            const quantityDisplay = button.previousElementSibling;
            cartItems = parseInt(quantityDisplay.textContent) + 1;
            quantityDisplay.textContent = cartItems;
            updateCartSummary();
        }

        function decreaseQuantity(button) {
            const quantityDisplay = button.nextElementSibling;
            if (cartItems > 1) {
                cartItems = parseInt(quantityDisplay.textContent) - 1;
                quantityDisplay.textContent = cartItems;
                updateCartSummary();
            }
        }

        function checkCartEmpty() {
            const cartSection = document.getElementById('cart-section');
            const emptyCartSection = document.getElementById('empty-cart-section');
            const hasItems = document.querySelectorAll('.cart-item').length > 0;
            
            if (!hasItems) {
                cartSection.classList.add('d-none');
                emptyCartSection.classList.remove('d-none');
            }
        }

        function scrollRecommendations(direction) {
            const track = document.getElementById('recommendationsTrack');
            const scrollAmount = 200;
            track.scrollBy({
                left: direction * scrollAmount,
                behavior: 'smooth'
            });
        }

        // Event Listeners
        document.getElementById('selectAll').addEventListener('change', function() {
            const isChecked = this.checked;
            document.querySelectorAll('.cart-item input[type="checkbox"]').forEach(cb => {
                cb.checked = isChecked;
            });
        });

        document.getElementById('deleteSelected').addEventListener('click', function() {
            const checkedItems = document.querySelectorAll('.cart-item input[type="checkbox"]:checked');
            checkedItems.forEach(item => {
                item.closest('.cart-box').remove();
            });
            checkCartEmpty();
        });

        // Delete individual items
        document.querySelectorAll('.btn-outline-danger').forEach(button => {
            if (button.querySelector('.bi-trash')) {
                button.addEventListener('click', function() {
                    this.closest('.cart-box').remove();
                    checkCartEmpty();
                });
            }
        });

        // Category functionality
        document.addEventListener('DOMContentLoaded', function () {
            const categoryItems = document.querySelectorAll('.dropdown-item[data-category]');
            const categoryText = document.getElementById('categoryText');
            const categoryButton = document.getElementById('dropdownMenuButton');
            
            categoryItems.forEach(item => {
                item.addEventListener('click', function(e) {
                    e.preventDefault();
                    const selectedCategory = this.getAttribute('data-category');
                    categoryText.textContent = selectedCategory;
                    categoryButton.classList.add('selected');
                    
                    const dropdown = bootstrap.Dropdown.getInstance(categoryButton);
                    if (dropdown) {
                        dropdown.hide();
                    }
                });
            });

            // Search functionality
            const searchForm = document.querySelector('.form-inline');
            const searchInput = document.getElementById('searchInput');
            
            searchForm.addEventListener('submit', function(e) {
                e.preventDefault();
                const searchTerm = searchInput.value.trim();
                if (searchTerm) {
                    console.log('Searching for:', searchTerm);
                    alert(`Mencari: "${searchTerm}"`);
                }
            });
        });

        // Initialize
        updateCartSummary();
    </script>
</body>
</html>
