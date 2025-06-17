<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Review"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Apa Kata Customer - Mugiwara Library</title>
    <link rel="stylesheet" href="assets/css/style.css" />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        :root {
            --primary-red: #dc3545;
            --secondary-red: #c82333;
            --light-red: #f8d7da;
            --dark-red: #721c24;
        }
        
        .review-stats {
            background: linear-gradient(135deg, var(--primary-red) 0%, var(--secondary-red) 100%);
            color: white;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.3);
        }
        
        .review-item {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-left: 4px solid var(--primary-red);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        
        .review-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 15px rgba(220, 53, 69, 0.2);
        }
        
        .reviewer-info {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }
        
        .reviewer-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-red) 0%, var(--secondary-red) 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
            margin-right: 1rem;
        }
        
        .reviewer-details h6 {
            margin: 0;
            color: #333;
            font-weight: 600;
        }
        
        .reviewer-details small {
            color: #666;
        }
        
        .rating-stars {
            color: #ffc107;
            font-size: 1.2rem;
            margin: 0.5rem 0;
        }
        
        .review-comment {
            background: var(--light-red);
            padding: 1rem;
            border-radius: 10px;
            margin: 1rem 0;
            font-style: italic;
            border-left: 3px solid var(--primary-red);
        }
        
        .book-info {
            display: flex;
            align-items: center;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid #eee;
        }
        
        .book-cover-small {
            width: 40px;
            height: 60px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 1rem;
        }
        
        .book-title {
            color: var(--primary-red);
            font-weight: 600;
            text-decoration: none;
        }
        
        .book-title:hover {
            color: var(--secondary-red);
            text-decoration: underline;
        }
        
        .empty-reviews {
            text-align: center;
            padding: 3rem;
            color: #666;
        }
        
        .empty-reviews i {
            font-size: 4rem;
            color: var(--light-red);
            margin-bottom: 1rem;
        }
        
        .filter-tabs {
            margin-bottom: 2rem;
        }
        
        .filter-tabs .nav-link {
            color: var(--primary-red);
            border: 2px solid transparent;
            border-radius: 25px;
            padding: 0.5rem 1.5rem;
            margin-right: 0.5rem;
        }
        
        .filter-tabs .nav-link.active {
            background: var(--primary-red);
            color: white;
            border-color: var(--primary-red);
        }
        
        .filter-tabs .nav-link:hover {
            background: var(--light-red);
            color: var(--dark-red);
        }
        
        .btn-primary {
            background-color: var(--primary-red);
            border-color: var(--primary-red);
        }
        
        .btn-primary:hover {
            background-color: var(--secondary-red);
            border-color: var(--secondary-red);
        }
        
        .btn-outline-primary {
            color: var(--primary-red);
            border-color: var(--primary-red);
        }
        
        .btn-outline-primary:hover {
            background-color: var(--primary-red);
            border-color: var(--primary-red);
        }
        
        .review-date {
            color: var(--primary-red);
            font-weight: 500;
        }
        
        .review-rating-badge {
            background: var(--primary-red);
            color: white;
            padding: 0.25rem 0.5rem;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%
        ArrayList<Review> allReviews = (ArrayList<Review>) request.getAttribute("allReviews");
        Integer totalReviews = (Integer) request.getAttribute("totalReviews");
        Double averageRating = (Double) request.getAttribute("averageRating");
        String pageTitle = (String) request.getAttribute("pageTitle");
        String pageDescription = (String) request.getAttribute("pageDescription");
        
        if (allReviews == null) allReviews = new ArrayList<>();
        if (totalReviews == null) totalReviews = 0;
        if (averageRating == null) averageRating = 0.0;
        if (pageTitle == null) pageTitle = "Apa Kata Customer";
        if (pageDescription == null) pageDescription = "Review dari customer kami";
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
        DecimalFormat df = new DecimalFormat("#.#");
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
                <li class="breadcrumb-item active" aria-current="page"><%= pageTitle %></li>
            </ol>
        </nav>
    </div>

    <!-- Reviews Content -->
    <main class="container my-4">
        <!-- Page Header -->
        <div class="text-center mb-4">
            <h2 style="color: var(--primary-red);"><%= pageTitle %></h2>
            <p class="text-muted"><%= pageDescription %></p>
        </div>

        <!-- Review Statistics -->
        <% if (totalReviews > 0) { %>
        <div class="review-stats">
            <div class="row text-center">
                <div class="col-md-4">
                    <h3><%= totalReviews %></h3>
                    <p class="mb-0">Total Review</p>
                </div>
                <div class="col-md-4">
                    <h3><%= df.format(averageRating) %> <i class="bi bi-star-fill"></i></h3>
                    <p class="mb-0">Rating Rata-rata</p>
                </div>
                <div class="col-md-4">
                    <h3>
                        <%
                            String ratingText = "Sangat Baik";
                            if (averageRating < 2) ratingText = "Kurang";
                            else if (averageRating < 3) ratingText = "Cukup";
                            else if (averageRating < 4) ratingText = "Baik";
                        %>
                        <%= ratingText %>
                    </h3>
                    <p class="mb-0">Kualitas Layanan</p>
                </div>
            </div>
        </div>
        <% } %>

        <!-- Filter Tabs -->
        <ul class="nav nav-pills filter-tabs justify-content-center">
            <li class="nav-item">
                <a class="nav-link <%= request.getParameter("action") == null ? "active" : "" %>" href="reviews">Semua Review</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%= "latest".equals(request.getParameter("action")) ? "active" : "" %>" href="reviews?action=latest">Terbaru</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="books">Lihat Buku</a>
            </li>
        </ul>

        <!-- Reviews List -->
        <div class="reviews-container">
            <% if (allReviews.isEmpty()) { %>
            <div class="empty-reviews">
                <i class="bi bi-chat-quote"></i>
                <h4>Belum ada review</h4>
                <p>Jadilah yang pertama memberikan review untuk buku favorit Anda!</p>
                <a href="books" class="btn btn-primary">
                    <i class="bi bi-book"></i> Lihat Koleksi Buku
                </a>
            </div>
            <% } else { %>
            
            <div class="review-list">
                <% for (Review review : allReviews) { %>
                <div class="review-item">
                    <!-- Reviewer Info -->
                    <div class="reviewer-info">
                        <div class="reviewer-avatar">
                            <%= review.getUser() != null && review.getUser().getFullName() != null ? 
                                review.getUser().getFullName().substring(0, 1).toUpperCase() : "?" %>
                        </div>
                        <div class="reviewer-details">
                            <h6><%= review.getUser() != null && review.getUser().getFullName() != null ? 
                                review.getUser().getFullName() : "Anonymous User" %></h6>
                            <small class="text-muted">
                                <i class="bi bi-person-circle"></i>
                                <%= review.getUser() != null && review.getUser().getUsername() != null ? 
                                    "@" + review.getUser().getUsername() : "Customer" %>
                            </small>
                        </div>
                        <div class="ms-auto d-flex flex-column align-items-end">
                            <small class="review-date">
                                <i class="bi bi-calendar3"></i>
                                <%= review.getReview_date() != null ? sdf.format(review.getReview_date()) : "Baru saja" %>
                            </small>
                            <span class="review-rating-badge mt-1">
                                <%= review.getRating() %>/5 ★
                            </span>
                        </div>
                    </div>
                    
                    <!-- Rating Stars -->
                    <div class="rating-stars">
                        <%
                            int rating = review.getRating();
                            for (int i = 1; i <= 5; i++) {
                                if (i <= rating) {
                                    out.print("<i class='bi bi-star-fill'></i>");
                                } else {
                                    out.print("<i class='bi bi-star'></i>");
                                }
                            }
                        %>
                        <span class="ms-2 text-muted">(<%= rating %>/5) - <%= review.getRatingText() %></span>
                    </div>
                    
                    <!-- Review Comment -->
                    <div class="review-comment">
                        <i class="bi bi-quote"></i>
                        <%= review.getComment() != null && !review.getComment().trim().isEmpty() ? 
                            review.getComment() : "Customer memberikan rating tanpa komentar." %>
                    </div>
                    
                    <!-- Book Info -->
                    <% if (review.getBook() != null) { %>
                    <div class="book-info">
                        <img src="<%= review.getBook().getImagePath() != null ? 
                                review.getBook().getImagePath() : "default-book.jpg" %>" 
                             class="book-cover-small" alt="Book Cover">
                        <div>
                            <small class="text-muted">Review untuk:</small><br>
                            <a href="books?action=detail&id=<%= review.getBook_id() %>" class="book-title">
                                <i class="bi bi-book"></i>
                                <%= review.getBook().getTitle() %>
                            </a>
                        </div>
                        <div class="ms-auto">
                            <a href="books?action=detail&id=<%= review.getBook_id() %>" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-eye"></i> Lihat Buku
                            </a>
                        </div>
                    </div>
                    <% } %>
                </div>
                <% } %>
            </div>
            
            <!-- Load More Button -->
            <% if (allReviews.size() >= 20) { %>
            <div class="text-center mt-4">
                <button class="btn btn-outline-primary" onclick="loadMoreReviews()">
                    <i class="bi bi-arrow-down-circle"></i> Muat Lebih Banyak
                </button>
            </div>
            <% } %>
            
            <% } %>
        </div>

        <!-- Call to Action -->
        <div class="text-center mt-5 p-4" style="background: var(--light-red); border-radius: 15px; border: 1px solid var(--primary-red);">
            <h5 style="color: var(--dark-red);">Punya pengalaman berbelanja di Mugiwara Library?</h5>
            <p class="text-muted">Bagikan pengalaman Anda dan bantu customer lain membuat keputusan yang tepat!</p>
            <a href="books" class="btn btn-primary">
                <i class="bi bi-star"></i> Berikan Review
            </a>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <!-- Scripts -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
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

            // Animate review items on scroll
            const observerOptions = {
                threshold: 0.1,
                rootMargin: '0px 0px -50px 0px'
            };

            const observer = new IntersectionObserver(function(entries) {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.style.opacity = '1';
                        entry.target.style.transform = 'translateY(0)';
                    }
                });
            }, observerOptions);

            // Apply animation to review items
            document.querySelectorAll('.review-item').forEach((item, index) => {
                item.style.opacity = '0';
                item.style.transform = 'translateY(20px)';
                item.style.transition = `opacity 0.6s ease ${index * 0.1}s, transform 0.6s ease ${index * 0.1}s`;
                observer.observe(item);
            });
        });

        function loadMoreReviews() {
            // This would typically load more reviews via AJAX
            alert('Fitur load more akan segera tersedia!');
        }
    </script>
</body>
</html>
