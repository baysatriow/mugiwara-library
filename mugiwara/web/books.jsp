<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Book"%>
<%@page import="Models.Category"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= request.getAttribute("pageTitle") != null ? request.getAttribute("pageTitle") : "Daftar Buku" %> - Mugiwara Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/css/iziToast.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <%
      
        ArrayList<Book> books = (ArrayList<Book>) request.getAttribute("books");
        ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
        String pageTitle = (String) request.getAttribute("pageTitle");
        String pageDescription = (String) request.getAttribute("pageDescription");
        String searchQuery = (String) request.getAttribute("searchQuery");
        String selectedCategory = (String) request.getAttribute("selectedCategory");
        String selectedSort = (String) request.getAttribute("selectedSort");
        Integer totalBooks = (Integer) request.getAttribute("totalBooks");
        Integer currentPage = (Integer) request.getAttribute("currentPage");
        Integer totalPages = (Integer) request.getAttribute("totalPages");
        Integer booksPerPage = (Integer) request.getAttribute("booksPerPage");
        
       
        if (books == null) books = new ArrayList<>();
        if (categories == null) categories = new ArrayList<>();
        if (pageTitle == null) pageTitle = "Daftar Buku";
        if (pageDescription == null) pageDescription = "Jelajahi koleksi lengkap buku kami";
        if (totalBooks == null) totalBooks = books.size();
        if (currentPage == null) currentPage = 1;
        if (totalPages == null) totalPages = 1;
        if (booksPerPage == null) booksPerPage = 12;
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
                        <span id="categoryText"><%= selectedCategory != null ? selectedCategory : "Kategori" %></span>
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <li class="category-search-li"> 
                            <input class="form-control" type="text" placeholder="Cari Kategori..." id="categorySearchInputInDropdown">
                        </li>
                        <li><a class="dropdown-item" href="books">Semua Kategori</a></li>
                        <% for (Category cat : categories) { %>
                        <li><a class="dropdown-item" href="books?category=<%= cat.getName() %>"><%= cat.getName() %></a></li>
                        <% } %>
                    </ul>
                </div>
                <form class="form-inline flex-grow-1" action="books" method="get"> 
                    <div class="search-input-group">
                        <input class="form-control search-input" type="search" name="query" 
                               value="<%= searchQuery != null ? searchQuery : "" %>"
                               placeholder="Mau cari apa hari ini?" aria-label="Search">
                        <button class="search-btn" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                    <% if (selectedCategory != null && !selectedCategory.isEmpty()) { %>
                    <input type="hidden" name="category" value="<%= selectedCategory %>">
                    <% } %>
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

    <!-- Breadcrumb -->
    <div class="breadcrumb-container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="home">Home</a></li>
                <!-- Alur program dari old - breadcrumb sederhana -->
                <li class="breadcrumb-item active" aria-current="page"><%= pageTitle %></li>
            </ol>
        </nav>
    </div>

    <!-- Main Content  -->
    <main>
        <div class="container">
            <!-- Page Header -->
            <div class="cart-header">
                <h2>
                    <i class="bi bi-book me-3"></i>
                    <%= pageTitle %>
                </h2>
                <p class="text-muted mb-0"><%= pageDescription %></p>
            </div>
            <% if (searchQuery != null && !searchQuery.trim().isEmpty()) { %>
            <div class="alert alert-info">
                Hasil pencarian untuk: "<strong><%= searchQuery %></strong>"
                <% if (selectedCategory != null && !selectedCategory.isEmpty()) { %>
                dalam kategori "<strong><%= selectedCategory %></strong>"
                <% } %>
            </div>
            <% } %>

            <!-- Filter and Sort Bar -->
            <div class="filter-bar">
                <div class="d-flex align-items-center gap-3">
                    <!-- Category Filter -->
                    <select class="form-select" id="categoryFilter" onchange="filterByCategory()">
                        <option value="">Semua Kategori</option>
                        <% for (Category category : categories) { %>
                        <option value="<%= category.getName() %>" 
                                <%= (selectedCategory != null && selectedCategory.equals(category.getName())) ? "selected" : "" %>>
                            <%= category.getName() %>
                        </option>
                        <% } %>
                    </select>
                    
                    <!-- Sort Options -->
                    <select class="form-select" id="sortFilter" onchange="applySorting()">
                        <option value="">Paling Relevan</option>
                        <option value="title" <%= "title".equals(selectedSort) ? "selected" : "" %>>Judul A-Z</option>
                        <option value="author" <%= "author".equals(selectedSort) ? "selected" : "" %>>Penulis A-Z</option>
                        <option value="price_asc" <%= "price_asc".equals(selectedSort) ? "selected" : "" %>>Harga Terendah</option>
                        <option value="price_desc" <%= "price_desc".equals(selectedSort) ? "selected" : "" %>>Harga Tertinggi</option>
                    </select>
                </div>
                <div class="sort-info">
                    Menampilkan <%= Math.min(booksPerPage, books.size()) %> dari <%= totalBooks %> buku (Halaman <%= currentPage %> dari <%= totalPages %>)
                </div>
            </div>

            <!-- Books Grid -->
            <% if (books.isEmpty()) { %>
            <!-- No Books Found -->
            <div class="empty-cart">
                <i class="bi bi-book display-1 text-muted"></i>
                <h3>Tidak ada buku ditemukan</h3>
                <p>
                    <% if (searchQuery != null && !searchQuery.trim().isEmpty()) { %>
                        Coba ubah kata kunci pencarian atau kategori
                    <% } else { %>
                        Belum ada buku dalam koleksi ini
                    <% } %>
                </p>
                <div class="d-flex gap-2 justify-content-center">
                    <a href="books" class="btn btn-primary">
                        <i class="bi bi-arrow-left me-2"></i>Lihat Semua Buku
                    </a>
                    <a href="home" class="btn btn-outline-primary">
                        <i class="bi bi-house me-2"></i>Kembali ke Beranda
                    </a>
                </div>
            </div>
            <% } else { %>
            <!-- Books Grid -->
            <div class="book-grid">
                <% for (Book book : books) { %>
                <div class="book-card">
                    <a href="books?action=detail&id=<%= book.getBook_id() %>" class="text-decoration-none">
                        <img src="<%= book.getImagePath() != null ? book.getImagePath() : "default-book.jpg" %>" 
                             class="book-cover" alt="<%= book.getTitle() != null ? book.getTitle() : "Unknown Title" %>">
                        <div class="book-body">
                            <h6 class="book-author">
                                <%= book.getAuthor() != null ? book.getAuthor().getName() : "Unknown Author" %>
                            </h6>
                            <p class="book-title"><%= book.getTitle() != null ? book.getTitle() : "Unknown Title" %></p>
                            <strong class="book-price">Rp<%= String.format("%,d", book.getPrice()) %></strong>
                            
                            <!-- Stock indicator -->
                            <% if (book.getStock() <= 0) { %>
                            <div class="mt-2">
                                <span class="badge bg-danger">Stok Habis</span>
                            </div>
                            <% } else if (book.getStock() <= 5) { %>
                            <div class="mt-2">
                                <span class="badge bg-warning text-dark">Stok Terbatas</span>
                            </div>
                            <% } %>
                        </div>
                    </a>
                    <div class="text-center mt-2">
                        <% if (book.getStock() > 0) { %>
                        <a href="books?action=detail&id=<%= book.getBook_id() %>" class="btn btn-primary btn-sm">
                            <i class="bi bi-eye me-1"></i>Lihat Detail
                        </a>
                        <% } else { %>
                        <button class="btn btn-secondary btn-sm" disabled>
                            <i class="bi bi-x-circle me-1"></i>Stok Habis
                        </button>
                        <% } %>
                    </div>
                </div>
                <% } %>
            </div>
            <% } %>

            <!-- Pagination -->
            <% if (totalPages > 1) { %>
            <nav aria-label="Page navigation" class="pagination-container">
                <ul class="pagination">
                    <!-- Previous Button -->
                    <% if (currentPage > 1) { %>
                    <li class="page-item">
                        <a class="page-link" href="<%= buildPageUrl(request, currentPage - 1) %>">Previous</a>
                    </li>
                    <% } else { %>
                    <li class="page-item disabled">
                        <span class="page-link">Previous</span>
                    </li>
                    <% } %>
                    
                    <!-- Page Numbers -->
                    <%
                        int startPage = Math.max(1, currentPage - 2);
                        int endPage = Math.min(totalPages, currentPage + 2);
                        
                        // Show first page if not in range
                        if (startPage > 1) {
                    %>
                    <li class="page-item">
                        <a class="page-link" href="<%= buildPageUrl(request, 1) %>">1</a>
                    </li>
                    <% if (startPage > 2) { %>
                    <li class="page-item disabled">
                        <span class="page-link">...</span>
                    </li>
                    <% } %>
                    <% } %>
                    
                    <!-- Current range -->
                    <% for (int i = startPage; i <= endPage; i++) { %>
                    <li class="page-item <%= i == currentPage ? "active" : "" %>">
                        <% if (i == currentPage) { %>
                        <span class="page-link"><%= i %></span>
                        <% } else { %>
                        <a class="page-link" href="<%= buildPageUrl(request, i) %>"><%= i %></a>
                        <% } %>
                    </li>
                    <% } %>
                    <% if (endPage < totalPages) { %>
                    <% if (endPage < totalPages - 1) { %>
                    <li class="page-item disabled">
                        <span class="page-link">...</span>
                    </li>
                    <% } %>
                    <li class="page-item">
                        <a class="page-link" href="<%= buildPageUrl(request, totalPages) %>"><%= totalPages %></a>
                    </li>
                    <% } %>
                    
                    <!-- Next Button -->
                    <% if (currentPage < totalPages) { %>
                    <li class="page-item">
                        <a class="page-link" href="<%= buildPageUrl(request, currentPage + 1) %>">Next</a>
                    </li>
                    <% } else { %>
                    <li class="page-item disabled">
                        <span class="page-link">Next</span>
                    </li>
                    <% } %>
                </ul>
            </nav>
            <% } %>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <%!
        // Alur program dari old - helper method tetap sama
        private String buildPageUrl(HttpServletRequest request, int page) {
            StringBuilder url = new StringBuilder("books?page=" + page);
            
            String query = request.getParameter("query");
            if (query != null && !query.trim().isEmpty()) {
                url.append("&query=").append(java.net.URLEncoder.encode(query, java.nio.charset.StandardCharsets.UTF_8));
            }
            
            String category = request.getParameter("category");
            if (category != null && !category.trim().isEmpty()) {
                url.append("&category=").append(java.net.URLEncoder.encode(category, java.nio.charset.StandardCharsets.UTF_8));
            }
            
            String sort = request.getParameter("sort");
            if (sort != null && !sort.trim().isEmpty()) {
                url.append("&sort=").append(sort);
            }
            
            String action = request.getParameter("action");
            if (action != null && !action.trim().isEmpty()) {
                url.append("&action=").append(action);
            }
            
            return url.toString();
        }
    %>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/js/iziToast.min.js"></script>

    <script>
        function applySorting() {
            const sortValue = document.getElementById('sortFilter').value;
            const currentUrl = new URL(window.location);
            
            if (sortValue) {
                currentUrl.searchParams.set('sort', sortValue);
            } else {
                currentUrl.searchParams.delete('sort');
            }
            
            currentUrl.searchParams.set('page', '1');
            
            window.location.href = currentUrl.toString();
        }

        function filterByCategory() {
            const categorySelect = document.getElementById('categoryFilter');
            const selectedCategory = categorySelect.value;
            const currentUrl = new URL(window.location);
            
            if (selectedCategory) {
                currentUrl.searchParams.set('category', selectedCategory);
            } else {
                currentUrl.searchParams.delete('category');
            }
            
            const searchQuery = '<%= searchQuery != null ? searchQuery : "" %>';
            if (searchQuery) {
                currentUrl.searchParams.set('query', searchQuery);
            }
            
            currentUrl.searchParams.set('page', '1');
            
            window.location.href = currentUrl.toString();
        }

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

            const bookCards = document.querySelectorAll('.book-card');
            
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, {
                threshold: 0.1
            });

            bookCards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = `opacity 0.6s ease ${index * 0.1}s, transform 0.6s ease ${index * 0.1}s`;
                observer.observe(card);
            });
        });
    </script>
</body>
</html>