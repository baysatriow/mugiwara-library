<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Buku - Mugiwara Library</title>
    <!-- Main Stylesheet -->
    <link rel="stylesheet" href="assets/css/style.css">
    <!-- Page-specific Stylesheet -->
    <link rel="stylesheet" href="assets/css/book-list.css">
    
    <!-- Libraries and Fonts -->
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
                <a href="<%= isLoggedIn ? "cart.jsp" : "login.jsp" %>" class="text-white-icon me-3">
                    <img src="assets/images/cart.png" alt="cart" class="cart-icon">
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
    
    <!-- Main Content -->
    <main class="container">
        <div class="breadcrumb-container">
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="."><strong>Home</strong></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Daftar Buku</li>
                </ol>
            </nav>
        </div>

        <h2>Daftar Buku</h2>
        <p>Tampilkan semua koleksi buku kami.</p>

        <!-- Filter and Sort Bar -->
        <div class="filter-bar">
            <span>Menampilkan 12 dari 100+ buku</span>
            <div class="d-flex align-items-center gap-2">
                <label for="sortOrder" class="col-form-label">Urutkan:</label>
                <select class="form-select form-select-sm" id="sortOrder">
                    <option selected>Paling Relevan</option>
                    <option value="1">Terbaru</option>
                    <option value="2">Harga Terendah</option>
                    <option value="3">Harga Tertinggi</option>
                </select>
            </div>
        </div>

        <!-- Book Grid -->
        <div class="book-grid">
            <!-- Placeholder Book Cards -->
            <!-- Di aplikasi nyata, bagian ini akan di-generate dari database -->
            <% 
                String[] titles = {"Laut Bercerita", "Atomic Habits", "Gadis Kretek", "Seperti Dendam", "Funiculi Funicula", "Sang Alkemis", "Cantik Itu Luka", "Demokrasi Mati", "Pulang", "9 dari Nadira", "Rumah Kaca", "Jejak Langkah"};
                String[] authors = {"Leila S. Chudori", "James Clear", "Ratih Kumala", "Eka Kurniawan", "Toshikazu Kawaguchi", "Paulo Coelho", "Eka Kurniawan", "Steven Levitsky", "Leila S. Chudori", "Leila S. Chudori", "Leila S. Chudori", "Leila S. Chudori"};
                String[] images = {"Laut Bercerita.jpg", "9786020633176_.Atomic_Habit.avif", "Gadis Kretek.jpg", "Seperti Dendam.jpg", "9786020651927_Funiculi_Funicula_cov.avif", "9786020656069_Sang_Alkemis_cov.avif", "Cantik Luka.jpg", "Bagaimana Demokrasi Mati.jpg", "Laut Bercerita.jpg", "Laut Bercerita.jpg", "Laut Bercerita.jpg", "Laut Bercerita.jpg"};
                for(int i = 0; i < 12; i++) { 
            %>
            <div class="book-card">
                <a href="book_details.jsp" class="text-decoration-none">
                    <img src="assets/images/<%= images[i] %>" class="book-cover" alt="<%= titles[i] %>">
                    <div class="book-body">
                        <h6 class="book-author"><%= authors[i] %></h6>
                        <p class="book-title"><%= titles[i] %></p>
                        <strong class="book-price">Rp99.000</strong>
                    </div>
                </a>
            </div>
            <% } %>
        </div>

        <!-- Pagination -->
        <nav aria-label="Page navigation" class="pagination-container">
            <ul class="pagination">
                <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a></li>
                <li class="page-item active" aria-current="page"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">...</a></li>
                <li class="page-item"><a class="page-link" href="#">8</a></li>
                <li class="page-item">
                    <a class="page-link" href="#">Next</a>
                </li>
            </ul>
        </nav>
    </main>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

</body>
</html>
