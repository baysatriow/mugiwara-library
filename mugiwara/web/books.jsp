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
    
    <!-- Main Content -->
    <main class="container">
        <div class="breadcrumb-container">
            <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="home"><strong>Home</strong></a></li>
                    <li class="breadcrumb-item active" aria-current="page"><%= pageTitle %></li>
                </ol>
            </nav>
        </div>
        
        <h2><%= pageTitle %></h2>
        <p><%= pageDescription %></p>
        
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
            <span>Menampilkan <%= Math.min(booksPerPage, books.size()) %> dari <%= totalBooks %> buku (Halaman <%= currentPage %> dari <%= totalPages %>)</span>
            <div class="d-flex align-items-center gap-2">
                <label for="sortOrder" class="col-form-label">Urutkan:</label>
                <select class="form-select form-select-sm" id="sortOrder" onchange="applySorting()">
                    <option value="">Paling Relevan</option>
                    <option value="title" <%= "title".equals(selectedSort) ? "selected" : "" %>>Judul A-Z</option>
                    <option value="author" <%= "author".equals(selectedSort) ? "selected" : "" %>>Penulis A-Z</option>
                    <option value="price_asc" <%= "price_asc".equals(selectedSort) ? "selected" : "" %>>Harga Terendah</option>
                    <option value="price_desc" <%= "price_desc".equals(selectedSort) ? "selected" : "" %>>Harga Tertinggi</option>
                </select>
            </div>
        </div>

        <!-- Book Grid -->
        <div class="book-grid">
            <% if (books.isEmpty()) { %>
            <div class="col-12 text-center py-5">
                <i class="bi bi-book display-1 text-muted"></i>
                <h4 class="mt-3">Tidak ada buku ditemukan</h4>
                <p class="text-muted">Coba ubah kata kunci pencarian atau kategori</p>
                <a href="books" class="btn btn-primary">Lihat Semua Buku</a>
            </div>
            <% } else { %>
                <% for (Book book : books) { %>
                <div class="book-card">
                    <a href="books?action=detail&id=<%= book.getBook_id() %>" class="text-decoration-none">
                        <img src="<%= book.getImagePath() != null ? book.getImagePath() : "default-book.jpg" %>" 
                             class="book-cover" alt="<%= book.getTitle() %>">
                        <div class="book-body">
                            <h6 class="book-author"><%= book.getAuthor() != null ? book.getAuthor().getName() : "Unknown Author" %></h6>
                            <p class="book-title"><%= book.getTitle() %></p>
                            <strong class="book-price">Rp<%= String.format("%,d", book.getPrice()) %></strong>
                        </div>
                    </a>
                </div>
                <% } %>
            <% } %>
        </div>

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
                
                <!-- Show last page if not in range -->
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
    </main>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <%!
        // Helper method to build page URL with existing parameters
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

    <script>
        function applySorting() {
            const sortValue = document.getElementById('sortOrder').value;
            const currentUrl = new URL(window.location);
            
            if (sortValue) {
                currentUrl.searchParams.set('sort', sortValue);
            } else {
                currentUrl.searchParams.delete('sort');
            }
            
            // Reset to page 1 when sorting
            currentUrl.searchParams.set('page', '1');
            
            window.location.href = currentUrl.toString();
        }

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
        });
    </script>
</body>
</html>
