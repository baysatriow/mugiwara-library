<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Book"%>
<%@page import="Models.Review"%>
<%@page import="Models.BannerSlide"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mugiwara Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
<%
    // Get data from servlet with null checks (logika dari old)
    ArrayList<Book> latestBooks = (ArrayList<Book>) request.getAttribute("latestBooks");
    ArrayList<Book> bestSellingBooks = (ArrayList<Book>) request.getAttribute("bestSellingBooks");
    ArrayList<Review> customerReviews = (ArrayList<Review>) request.getAttribute("customerReviews");
    ArrayList<BannerSlide> activeBanners = (ArrayList<BannerSlide>) request.getAttribute("activeBanners");
    
    // Initialize if null (logika dari old)
    if (latestBooks == null) latestBooks = new ArrayList<>();
    if (bestSellingBooks == null) bestSellingBooks = new ArrayList<>();
    if (customerReviews == null) customerReviews = new ArrayList<>();
    if (activeBanners == null) activeBanners = new ArrayList<>();
    
    // Number formatter for currency (logika dari old)
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
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

<main>
    <!-- Dynamic Banner Carousel -->
    <div id="AD" class="carousel slide main-ad-carousel" data-bs-ride="carousel">
        <div class="carousel-inner">
            <% 
            if (activeBanners != null && !activeBanners.isEmpty()) {
                // Display dynamic banners from database (logika dari old)
                for (int i = 0; i < activeBanners.size(); i++) {
                    BannerSlide banner = activeBanners.get(i);
                    boolean isActive = i == 0;
            %>
            <div class="carousel-item <%= isActive ? "active" : "" %>">
                <img src="<%= banner.getImagePath() != null ? banner.getImagePath() : "assets/images/default-banner.jpg" %>" 
                     class="d-block carousel-img" 
                     alt="<%= banner.getTitle() != null ? banner.getTitle() : "Banner" %>">
                
                <% if (banner.getTitle() != null || banner.getDescription() != null || 
                       (banner.getLinkUrl() != null && !banner.getLinkUrl().trim().isEmpty())) { %>
                <% } %>
            </div>
            <% 
                }
            } else {
                // Fallback to static banners if no dynamic banners available (logika dari old)
            %>
            <div class="carousel-item active">
                <img src="assets/images/iklan_1.png" class="d-block carousel-img" alt="Promo Spesial">
                <div class="banner-overlay d-flex align-items-center justify-content-center">
                    <div class="text-center text-white">
                        <h3 class="mb-3">Selamat Datang di Mugiwara Library</h3>
                        <p class="mb-3">Temukan koleksi buku terlengkap dengan harga terbaik!</p>
                        <a href="books" class="btn btn-primary">
                            <i class="bi bi-book me-2"></i>Jelajahi Koleksi
                        </a>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <img src="assets/images/iklan_2.png" class="d-block carousel-img" alt="Diskon Besar">
                <div class="banner-overlay d-flex align-items-center justify-content-center">
                    <div class="text-center text-white">
                        <h3 class="mb-3">Diskon Hingga 50%</h3>
                        <p class="mb-3">Dapatkan buku favorit Anda dengan harga spesial!</p>
                        <a href="books?action=bestseller" class="btn btn-primary">
                            <i class="bi bi-tag me-2"></i>Lihat Promo
                        </a>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <img src="assets/images/iklan_3.png" class="d-block carousel-img" alt="Buku Terbaru">
                <div class="banner-overlay d-flex align-items-center justify-content-center">
                    <div class="text-center text-white">
                        <h3 class="mb-3">Koleksi Terbaru</h3>
                        <p class="mb-3">Jangan lewatkan buku-buku terbaru yang telah tersedia!</p>
                        <a href="books?action=latest" class="btn btn-primary">
                            <i class="bi bi-star me-2"></i>Lihat Terbaru
                        </a>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <img src="assets/images/iklan_4.png" class="d-block carousel-img" alt="Gratis Ongkir">
                <div class="banner-overlay d-flex align-items-center justify-content-center">
                    <div class="text-center text-white">
                        <h3 class="mb-3">Gratis Ongkos Kirim</h3>
                        <p class="mb-3">Untuk pembelian minimal Rp 100.000</p>
                        <a href="books" class="btn btn-primary">
                            <i class="bi bi-truck me-2"></i>Belanja Sekarang
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        
        <!-- Carousel Controls -->
        <button class="carousel-control-prev" type="button" data-bs-target="#AD" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#AD" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
        
        <!-- Carousel Indicators -->
        <div class="carousel-indicators">
            <% 
            int totalSlides = (activeBanners != null && !activeBanners.isEmpty()) ? activeBanners.size() : 4;
            for (int i = 0; i < totalSlides; i++) { 
            %>
            <button type="button" data-bs-target="#AD" data-bs-slide-to="<%= i %>" 
                    <%= i == 0 ? "class=\"active\" aria-current=\"true\"" : "" %> 
                    aria-label="Slide <%= i + 1 %>"></button>
            <% } %>
        </div>
    </div>
    
    <!-- Latest Books Section -->
    <div class="section-header">
        <h4>Buku Terbaru</h4>
        <p><a href="books?action=latest">Lihat Semua</a></p>
    </div>

    <% if (latestBooks.isEmpty()) { %>
    <div class="text-center py-5">
        <i class="bi bi-book text-muted" style="font-size: 3rem;"></i>
        <p class="text-muted mt-3">Belum ada data buku terbaru</p>
    </div>
    <% } else { %>
    <div id="terbaru" class="carousel slide book-carousel-container book-terbaru-carousel" data-bs-ride="carousel">
        <div class="carousel-inner">
            <%
                int latestBooksPerSlide = 6;
                int latestSlides = (int) Math.ceil((double) latestBooks.size() / latestBooksPerSlide);
                
                for (int slide = 0; slide < latestSlides; slide++) {
                    boolean isActive = slide == 0;
            %>
            <div class="carousel-item <%= isActive ? "active" : "" %>">
                <div class="book-list">
                    <%
                        int startIndex = slide * latestBooksPerSlide;
                        int endIndex = Math.min(startIndex + latestBooksPerSlide, latestBooks.size());
                        
                        for (int i = startIndex; i < endIndex; i++) {
                            Book book = latestBooks.get(i);
                            if (book != null) {
                    %>
                    <div class="book-card">
                        <a href="books?action=detail&id=<%= book.getBook_id() %>" class="text-decoration-none">
                            <img src="<%= book.getImagePath() != null ? book.getImagePath() : "default-book.jpg" %>" 
                                 class="book-cover" alt="<%= book.getTitle() != null ? book.getTitle() : "Unknown Title" %>">
                            <div class="book-body">
                                <h6 class="book-author"><%= book.getAuthor() != null && book.getAuthor().getName() != null ? book.getAuthor().getName() : "Unknown Author" %></h6>
                                <p class="book-title"><%= book.getTitle() != null ? book.getTitle() : "Unknown Title" %></p>
                                <strong class="book-price">Rp<%= String.format("%,d", book.getPrice()) %></strong>
                            </div>
                        </a>
                    </div>
                    <% 
                            }
                        } 
                    %>
                </div>
            </div>
            <% } %>
        </div>
        <% if (latestSlides > 1) { %>
        <button class="carousel-control-prev" type="button" data-bs-target="#terbaru" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#terbaru" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
        <div class="carousel-indicators">
            <% for (int i = 0; i < latestSlides; i++) { %>
            <button type="button" data-bs-target="#terbaru" data-bs-slide-to="<%= i %>" 
                    <%= i == 0 ? "class=\"active\" aria-current=\"true\"" : "" %> aria-label="Slide <%= i + 1 %>"></button>
            <% } %>
        </div>
        <% } %>
    </div>
    <% } %>

    <!-- Best Selling Books Section -->
    <div class="section-header">
        <h4>Buku Terlaris</h4>
        <p><a href="books?action=bestseller">Lihat Semua</a></p>
    </div>

    <% if (bestSellingBooks.isEmpty()) { %>
    <div class="text-center py-5">
        <i class="bi bi-trophy text-muted" style="font-size: 3rem;"></i>
        <p class="text-muted mt-3">Belum ada data buku terlaris</p>
    </div>
    <% } else { %>
    <div id="terlaris" class="carousel slide book-carousel-container book-terlaris-carousel" data-bs-ride="carousel">
        <div class="carousel-inner">
            <%
                int bestSellingBooksPerSlide = 6;
                int bestSellingSlides = (int) Math.ceil((double) bestSellingBooks.size() / bestSellingBooksPerSlide);
                
                for (int slide = 0; slide < bestSellingSlides; slide++) {
                    boolean isActive = slide == 0;
            %>
            <div class="carousel-item <%= isActive ? "active" : "" %>">
                <div class="book-list">
                    <%
                        int startIndex = slide * bestSellingBooksPerSlide;
                        int endIndex = Math.min(startIndex + bestSellingBooksPerSlide, bestSellingBooks.size());
                        
                        for (int i = startIndex; i < endIndex; i++) {
                            Book book = bestSellingBooks.get(i);
                            if (book != null) {
                    %>
                    <div class="book-card">
                        <a href="books?action=detail&id=<%= book.getBook_id() %>" class="text-decoration-none">
                            <!-- Menggunakan default image path dari old -->
                            <img src="<%= book.getImagePath() != null ? book.getImagePath() : "default-book.jpg" %>" 
                                 class="book-cover" alt="<%= book.getTitle() != null ? book.getTitle() : "Unknown Title" %>">
                            <div class="book-body">
                                <h6 class="book-author"><%= book.getAuthor() != null && book.getAuthor().getName() != null ? book.getAuthor().getName() : "Unknown Author" %></h6>
                                <p class="book-title"><%= book.getTitle() != null ? book.getTitle() : "Unknown Title" %></p>
                                <strong class="book-price">Rp<%= String.format("%,d", book.getPrice()) %></strong>
                            </div>
                        </a>
                    </div>
                    <% 
                            }
                        } 
                    %>
                </div>
            </div>
            <% } %>
        </div>
        <% if (bestSellingSlides > 1) { %>
        <button class="carousel-control-prev" type="button" data-bs-target="#terlaris" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#terlaris" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
        <div class="carousel-indicators">
            <% for (int i = 0; i < bestSellingSlides; i++) { %>
            <button type="button" data-bs-target="#terlaris" data-bs-slide-to="<%= i %>" 
                    <%= i == 0 ? "class=\"active\" aria-current=\"true\"" : "" %> aria-label="Slide <%= i + 1 %>"></button>
            <% } %>
        </div>
        <% } %>
    </div>
    <% } %>
    
    <!-- Customer Testimonials Section -->
    <div class="container d-flex justify-content-center">
        <div class="testimonials-section">
            <h4 class="text-center pt-4 mb-4">Apa Kata Customer</h4>

            <% if (customerReviews.isEmpty()) { %>
            <div class="text-center py-5">
                <i class="bi bi-chat-quote text-muted" style="font-size: 3rem;"></i>
                <p class="text-muted mt-3">Belum ada review dari customer</p>
            </div>
            <% } else { %>
            <div id="customerTestimonials" class="carousel slide testimonial-carousel-container testimonial-carousel" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <%
                        int reviewsPerSlide = 3;
                        int reviewSlides = Math.max(1, (int) Math.ceil((double) customerReviews.size() / reviewsPerSlide));
                        
                        for (int slide = 0; slide < reviewSlides; slide++) {
                            boolean isActive = slide == 0;
                    %>
                    <div class="carousel-item <%= isActive ? "active" : "" %>">
                        <div class="testimonials-wrapper">
                            <%
                                int startIndex = slide * reviewsPerSlide;
                                int endIndex = Math.min(startIndex + reviewsPerSlide, customerReviews.size());
                                
                                for (int i = startIndex; i < endIndex; i++) {
                                    Review review = customerReviews.get(i);
                                    if (review != null) {
                            %>
                            <div class="testimonial-card">
                                <div class="card-body">
                                    <p class="card-text">"<%= review.getComment() != null && !review.getComment().trim().isEmpty() ? review.getComment() : "Pelayanan yang sangat memuaskan!" %>"</p>
                                    <div class="star-rating">
                                        <span>
                                            <%
                                                int rating = review.getRating();
                                                for (int star = 1; star <= 5; star++) {
                                                    if (star <= rating) {
                                                        out.print("★");
                                                    } else {
                                                        out.print("☆");
                                                    }
                                                }
                                            %>
                                        </span>
                                    </div>
                                    <h5><%= review.getUser() != null && review.getUser().getFullName() != null ? review.getUser().getFullName() : "Customer" %></h5>
                                    <% if (review.getBook() != null && review.getBook().getTitle() != null) { %>
                                    <small class="text-muted">Review untuk: <%= review.getBook().getTitle() %></small>
                                    <% } %>
                                </div>
                            </div>
                            <% 
                                    } else {
                                        // Fallback testimonial if review is null (logika dari old)
                            %>
                            <div class="testimonial-card">
                                <div class="card-body">
                                    <p class="card-text">"Terima kasih Mugiwara Library atas pelayanan yang memuaskan!"</p>
                                    <div class="star-rating">
                                        <span>★★★★★</span>
                                    </div>
                                    <h5>Customer</h5>
                                </div>
                            </div>
                            <%
                                    }
                                }
                                
                                // Fill empty slots if needed to maintain layout (logika dari old)
                                for (int i = endIndex; i < startIndex + reviewsPerSlide; i++) { 
                            %>
                            <div class="testimonial-card">
                                <div class="card-body">
                                    <p class="card-text">"Koleksi buku yang lengkap dan pelayanan yang ramah!"</p>
                                    <div class="star-rating">
                                        <span>★★★★★</span>
                                    </div>
                                    <h5>Customer</h5>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% if (reviewSlides > 1) { %>
                <button class="carousel-control-prev" type="button" data-bs-target="#customerTestimonials" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#customerTestimonials" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
                <div class="testimonial-indicators carousel-indicators">
                    <% for (int i = 0; i < reviewSlides; i++) { %>
                    <button type="button" data-bs-target="#customerTestimonials" data-bs-slide-to="<%= i %>" 
                            <%= i == 0 ? "class=\"active\" aria-current=\"true\"" : "" %> aria-label="Slide <%= i + 1 %>"></button>
                    <% } %>
                </div>
                <% } %>
            </div>
            <% } %>
            
            <div class="testimonials-action">
                <!-- Menggunakan link dari old yang mengarah ke "reviews" -->
                <a href="reviews" class="btn-custom-lainnya">
                    Lainnya
                </a>
            </div>
        </div>
    </div>
</main>

<!-- Footer -->
<footer>
    <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
</footer>

<!-- Scripts (struktur dari old) -->
<script>
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

        const categoryItems = document.querySelectorAll('.dropdown-item[href*="category"]');
        const categoryText = document.getElementById('categoryText');
        const categoryButton = document.getElementById('dropdownMenuButton');
        
        categoryItems.forEach(item => {
            item.addEventListener('click', function(e) {
                const selectedCategory = this.textContent.trim();
                categoryText.textContent = selectedCategory;
                categoryButton.classList.add('selected');
            });
        });

        const bannerCarousel = document.getElementById('AD');
        if (bannerCarousel) {
            const carousel = new bootstrap.Carousel(bannerCarousel, {
                interval: 5000, 
                wrap: true
            });

            // Pause on hover
            bannerCarousel.addEventListener('mouseenter', function() {
                carousel.pause();
            });

            // Resume on mouse leave
            bannerCarousel.addEventListener('mouseleave', function() {
                carousel.cycle();
            });
        }

        const bookCarousels = document.querySelectorAll('.book-carousel-container .carousel');
        bookCarousels.forEach(carousel => {
            new bootstrap.Carousel(carousel, {
                interval: 8000,
                wrap: true
            });
        });
        
        const testimonialCarousel = document.getElementById('customerTestimonials');
        if (testimonialCarousel) {
            new bootstrap.Carousel(testimonialCarousel, {
                interval: 6000,
                wrap: true
            });
        }
    });
</script>
</body>
</html>