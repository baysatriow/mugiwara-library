<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.*"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mugiwara Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="assets/css/style.css">
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
                        <%
                        ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
                        if (categories != null) {
                            for (Category category : categories) {
                        %>
                        <li><a class="dropdown-item" href="#" data-category="<%= category.getName() %>" data-category-id="<%= category.getCategory_id() %>"><%= category.getName() %></a></li>
                        <%
                            }
                        }
                        %>
                        <li><a class="dropdown-item" href="#" data-category="Semua" data-category-id="">Semua Kategori</a></li>
                    </ul>
                </div>
                <form class="form-inline flex-grow-1" action="CustomerContent" method="get"> 
                    <div class="search-input-group">
                        <input class="form-control search-input" type="search" name="search" placeholder="Mau cari apa hari ini?" aria-label="Search" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                        <input type="hidden" name="action" value="search">
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
                    <span class="cart-count badge bg-danger rounded-pill">${cartCount != null ? cartCount : 0}</span>
                </a>

                <!-- Menu Pengguna Dropdown -->
                <div class="dropdown">
                    <a href="#" class="dropdown-toggle" id="userMenuDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="assets/images/profile.png" alt="profile" class="profile-icon">
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="userMenuDropdown">
                        <% if (isLoggedIn) { %>
                            <li><h6 class="dropdown-header">Halo, <%= username %></h6></li>
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
        <!-- AD Carousel -->
        <div id="AD" class="carousel slide main-ad-carousel" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#AD" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#AD" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#AD" data-bs-slide-to="2" aria-label="Slide 3"></button>
                <button type="button" data-bs-target="#AD" data-bs-slide-to="3" aria-label="Slide 4"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="assets/images/iklan_1.png" class="d-block carousel-img" alt="Iklan 1">
                </div>
                <div class="carousel-item">
                    <img src="assets/images/iklan_2.png" class="d-block carousel-img" alt="Iklan 2">
                </div>
                <div class="carousel-item">
                    <img src="assets/images/iklan_3.png" class="d-block carousel-img" alt="Iklan 3">
                </div>
                <div class="carousel-item">
                    <img src="assets/images/iklan_4.png" class="d-block carousel-img" alt="Iklan 4">
                </div>
            </div>
            <!-- Custom Arrow Controls -->
            <button class="carousel-control-prev" type="button" data-bs-target="#AD" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#AD" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        
        <!-- Buku Terbaru -->
        <div class="section-header">
            <h4>Buku Terbaru</h4>
            <p><a href="CustomerContent?action=latest">Lihat Semua</a></p>
        </div>
        
        <div id="terbaru" class="carousel slide book-carousel-container book-terbaru-carousel" data-bs-ride="carousel">
            <div class="carousel-inner">
                <%
                ArrayList<Book> latestBooks = (ArrayList<Book>) request.getAttribute("latestBooks");
                if (latestBooks != null && !latestBooks.isEmpty()) {
                    int itemsPerSlide = 6;
                    int totalSlides = (int) Math.ceil((double) latestBooks.size() / itemsPerSlide);
                    
                    for (int slide = 0; slide < totalSlides; slide++) {
                        boolean isActive = slide == 0;
                %>
                <div class="carousel-item <%= isActive ? "active" : "" %>">
                    <div class="book-list">
                        <%
                        int startIndex = slide * itemsPerSlide;
                        int endIndex = Math.min(startIndex + itemsPerSlide, latestBooks.size());
                        
                        for (int i = startIndex; i < endIndex; i++) {
                            Book book = latestBooks.get(i);
                        %>
                        <div class="book-card" onclick="viewBookDetail(<%= book.getBook_id() %>)">
                            <img src="<%= book.getImagePath() != null ? book.getImagePath() : "assets/images/default-book.jpg" %>" 
                                 class="book-cover" alt="<%= book.getTitle() %>">
                            <div class="book-body">
                                <h6 class="book-author"><%= book.getAuthor() != null ? book.getAuthor().getName() : "Unknown Author" %></h6>
                                <p class="book-title"><%= book.getTitle() %></p>
                                <strong class="book-price"><%= book.getFormattedPrice() %></strong>
                                <% if (book.getStock() == 0) { %>
                                <div class="stock-status out-of-stock">Stok Habis</div>
                                <% } else if (book.getStock() <= 5) { %>
                                <div class="stock-status low-stock">Stok Terbatas</div>
                                <% } %>
                            </div>
                        </div>
                        <%
                        }
                        %>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="carousel-item active">
                    <div class="book-list">
                        <div class="no-books-message">
                            <p>Belum ada buku terbaru tersedia</p>
                        </div>
                    </div>
                </div>
                <%
                }
                %>
            </div>
            <% if (latestBooks != null && latestBooks.size() > 6) { %>
            <button class="carousel-control-prev" type="button" data-bs-target="#terbaru" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#terbaru" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
            <div class="carousel-indicators">
                <%
                int totalSlides = (int) Math.ceil((double) latestBooks.size() / 6);
                for (int i = 0; i < totalSlides; i++) {
                %>
                <button type="button" data-bs-target="#terbaru" data-bs-slide-to="<%= i %>" 
                        <%= i == 0 ? "class=\"active\" aria-current=\"true\"" : "" %> aria-label="Slide <%= i + 1 %>"></button>
                <%
                }
                %>
            </div>
            <% } %>
        </div>

        <!-- Buku Terlaris -->
        <div class="section-header">
            <h4>Buku Terlaris</h4>
            <p><a href="CustomerContent?action=bestseller">Lihat Semua</a></p>
        </div>
        
        <div id="terlaris" class="carousel slide book-carousel-container book-terlaris-carousel" data-bs-ride="carousel">
            <div class="carousel-inner">
                <%
                ArrayList<Book> bestsellerBooks = (ArrayList<Book>) request.getAttribute("bestsellerBooks");
                if (bestsellerBooks != null && !bestsellerBooks.isEmpty()) {
                    int itemsPerSlide = 6;
                    int totalSlides = (int) Math.ceil((double) bestsellerBooks.size() / itemsPerSlide);
                    
                    for (int slide = 0; slide < totalSlides; slide++) {
                        boolean isActive = slide == 0;
                %>
                <div class="carousel-item <%= isActive ? "active" : "" %>">
                    <div class="book-list">
                        <%
                        int startIndex = slide * itemsPerSlide;
                        int endIndex = Math.min(startIndex + itemsPerSlide, bestsellerBooks.size());
                        
                        for (int i = startIndex; i < endIndex; i++) {
                            Book book = bestsellerBooks.get(i);
                        %>
                        <div class="book-card" onclick="viewBookDetail(<%= book.getBook_id() %>)">
                            <img src="<%= book.getImagePath() != null ? book.getImagePath() : "assets/images/default-book.jpg" %>" 
                                 class="book-cover" alt="<%= book.getTitle() %>">
                            <div class="book-body">
                                <h6 class="book-author"><%= book.getAuthor() != null ? book.getAuthor().getName() : "Unknown Author" %></h6>
                                <p class="book-title"><%= book.getTitle() %></p>
                                <strong class="book-price"><%= book.getFormattedPrice() %></strong>
                                <% if (book.getAverageRating() > 0) { %>
                                <div class="book-rating">
                                    <span class="stars">
                                        <%
                                        double rating = book.getAverageRating();
                                        for (int star = 1; star <= 5; star++) {
                                            if (star <= rating) {
                                        %>
                                        ★
                                        <%
                                            } else {
                                        %>
                                        ☆
                                        <%
                                            }
                                        }
                                        %>
                                    </span>
                                    <span class="rating-count">(<%= book.getReviewCount() %>)</span>
                                </div>
                                <% } %>
                                <% if (book.getStock() == 0) { %>
                                <div class="stock-status out-of-stock">Stok Habis</div>
                                <% } else if (book.getStock() <= 5) { %>
                                <div class="stock-status low-stock">Stok Terbatas</div>
                                <% } %>
                            </div>
                        </div>
                        <%
                        }
                        %>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="carousel-item active">
                    <div class="book-list">
                        <div class="no-books-message">
                            <p>Belum ada buku terlaris tersedia</p>
                        </div>
                    </div>
                </div>
                <%
                }
                %>
            </div>
            <% if (bestsellerBooks != null && bestsellerBooks.size() > 6) { %>
            <button class="carousel-control-prev" type="button" data-bs-target="#terlaris" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#terlaris" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
            <div class="carousel-indicators">
                <%
                int totalSlides = (int) Math.ceil((double) bestsellerBooks.size() / 6);
                for (int i = 0; i < totalSlides; i++) {
                %>
                <button type="button" data-bs-target="#terlaris" data-bs-slide-to="<%= i %>" 
                        <%= i == 0 ? "class=\"active\" aria-current=\"true\"" : "" %> aria-label="Slide <%= i + 1 %>"></button>
                <%
                }
                %>
            </div>
            <% } %>
        </div>
        
        <!-- Apa Kata Customer Carousel -->
        <div class="container d-flex justify-content-center">
            <div class="testimonials-section">
                <h4 class="text-center pt-4 mb-4">Apa Kata Customer</h4>
                
                <div id="customerTestimonials" class="carousel slide testimonial-carousel-container testimonial-carousel" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <%
                        ArrayList<Review> customerReviews = (ArrayList<Review>) request.getAttribute("customerReviews");
                        if (customerReviews != null && !customerReviews.isEmpty()) {
                            int reviewsPerSlide = 3;
                            int totalSlides = (int) Math.ceil((double) customerReviews.size() / reviewsPerSlide);
                            
                            for (int slide = 0; slide < totalSlides; slide++) {
                                boolean isActive = slide == 0;
                        %>
                        <div class="carousel-item <%= isActive ? "active" : "" %>">
                            <div class="testimonials-wrapper">
                                <%
                                int startIndex = slide * reviewsPerSlide;
                                int endIndex = Math.min(startIndex + reviewsPerSlide, customerReviews.size());
                                
                                for (int i = startIndex; i < endIndex; i++) {
                                    Review review = customerReviews.get(i);
                                %>
                                <div class="testimonial-card">
                                    <div class="card-body">
                                        <p class="card-text">"<%= review.getComment() %>"</p>
                                        <div class="star-rating">
                                            <span>
                                                <%
                                                for (int star = 1; star <= 5; star++) {
                                                    if (star <= review.getRating()) {
                                                %>
                                                ★
                                                <%
                                                    } else {
                                                %>
                                                ☆
                                                <%
                                                    }
                                                }
                                                %>
                                            </span>
                                        </div>
                                        <h5><%= review.getUser() != null ? review.getUser().getFullName() : "Anonymous" %></h5>
                                        <small class="text-muted">untuk "<%= review.getBook() != null ? review.getBook().getTitle() : "Unknown Book" %>"</small>
                                    </div>
                                </div>
                                <%
                                }
                                %>
                            </div>
                        </div>
                        <%
                            }
                        } else {
                        %>
                        <div class="carousel-item active">
                            <div class="testimonials-wrapper">
                                <div class="testimonial-card">
                                    <div class="card-body">
                                        <p class="card-text">"Buku-buku nya sangat wow sekali, proses checkout juga sangat mudah, desain websitenya juga mudah dimengerti...."</p>
                                        <div class="star-rating">
                                            <span>★★★★★</span>
                                        </div>
                                        <h5>Sakamoto Taro</h5>
                                    </div>
                                </div>
                                <div class="testimonial-card">
                                    <div class="card-body">
                                        <p class="card-text">"Pelayanan sangat memuaskan, buku-buku berkualitas tinggi dan pengiriman cepat. Sangat direkomendasikan!"</p>
                                        <div class="star-rating">
                                            <span>★★★★★</span>
                                        </div>
                                        <h5>Yuki Tanaka</h5>
                                    </div>
                                </div>
                                <div class="testimonial-card">
                                    <div class="card-body">
                                        <p class="card-text">"Website yang user-friendly dengan koleksi buku yang sangat lengkap. Proses pembelian mudah dan aman."</p>
                                        <div class="star-rating">
                                            <span>★★★★☆</span>
                                        </div>
                                        <h5>Hiroshi Sato</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                        }
                        %>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#customerTestimonials" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#customerTestimonials" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                    <div class="testimonial-indicators carousel-indicators">
                        <%
                        if (customerReviews != null && !customerReviews.isEmpty()) {
                            int totalSlides = (int) Math.ceil((double) customerReviews.size() / 3);
                            for (int i = 0; i < totalSlides; i++) {
                        %>
                        <button type="button" data-bs-target="#customerTestimonials" data-bs-slide-to="<%= i %>" 
                                <%= i == 0 ? "class=\"active\" aria-current=\"true\"" : "" %> aria-label="Slide <%= i + 1 %>"></button>
                        <%
                            }
                        } else {
                        %>
                        <button type="button" data-bs-target="#customerTestimonials" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                        <%
                        }
                        %>
                    </div>
                </div>
                
                <div class="testimonials-action">
                    <a href="ratings.jsp" class="btn-custom-lainnya">
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

            // Category selection functionality
            const categoryItems = document.querySelectorAll('.dropdown-item[data-category]');
            const categoryText = document.getElementById('categoryText');
            const categoryButton = document.getElementById('dropdownMenuButton');
            
            categoryItems.forEach(item => {
                item.addEventListener('click', function(e) {
                    e.preventDefault();
                    const selectedCategory = this.getAttribute('data-category');
                    const categoryId = this.getAttribute('data-category-id');
                    categoryText.textContent = selectedCategory;
                    
                    // Add selected class to button
                    categoryButton.classList.add('selected');
                    
                    // Redirect to filtered results
                    if (categoryId) {
                        window.location.href = 'CustomerContent?action=filter&category=' + categoryId;
                    } else {
                        window.location.href = 'CustomerContent';
                    }
                    
                    // Close dropdown
                    const dropdown = bootstrap.Dropdown.getInstance(categoryButton);
                    if (dropdown) {
                        dropdown.hide();
                    }
                });
            });
        });

        function viewBookDetail(bookId) {
            window.location.href = 'book-detail.jsp?id=' + bookId;
        }

        function addToCart(bookId) {
            <% if (isLoggedIn) { %>
            fetch('cart', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'action=add&bookId=' + bookId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    updateCartCount();
                    showNotification('Buku berhasil ditambahkan ke keranjang!', 'success');
                } else {
                    showNotification('Gagal menambahkan buku ke keranjang', 'error');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showNotification('Terjadi kesalahan', 'error');
            });
            <% } else { %>
            window.location.href = 'login.jsp';
            <% } %>
        }

        function updateCartCount() {
            fetch('cart?action=count')
            .then(response => response.json())
            .then(data => {
                document.querySelector('.cart-count').textContent = data.count;
            });
        }

        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.className = `alert alert-${type === 'success' ? 'success' : 'danger'} position-fixed`;
            notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; max-width: 300px;';
            notification.textContent = message;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.remove();
            }, 3000);
        }
    </script>
</body>
</html>
