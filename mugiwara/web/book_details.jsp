<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.Book"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        Book book = (Book) request.getAttribute("book");
        ArrayList<Book> authorBooks = (ArrayList<Book>) request.getAttribute("authorBooks");
        
        if (authorBooks == null) authorBooks = new ArrayList<>();
        
        String bookTitle = book != null ? book.getTitle() : "Book Detail";
    %>
    <title><%= bookTitle %> - Mugiwara Library</title>
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
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-dark">
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

    <% if (book == null) { %>
    <div class="container mt-5">
        <div class="alert alert-danger">
            <h4>Buku tidak ditemukan</h4>
            <p>Maaf, buku yang Anda cari tidak tersedia.</p>
            <a href="books" class="btn btn-primary">Kembali ke Daftar Buku</a>
        </div>
    </div>
    <% } else { %>
    
    <!-- Breadcrumb -->
    <div class="breadcrumb-container">
        <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
            <ol class="breadcrumb d-flex">
                <li class="breadcrumb-item"><a href="home"><strong>Home</strong></a></li>
                <li class="breadcrumb-item active" aria-current="page"><%= book.getTitle() %></li>
            </ol>
        </nav>
    </div>

    <!-- Detail Buku -->
    <section class="container my-4">
        <div class="book-detail-container">
            <div class="d-flex flex-column align-items-center">
                <img src="<%= book.getImagePath() != null ? book.getImagePath() : "default-book.jpg" %>" 
                     alt="Cover <%= book.getTitle() %>" class="book-detail-image" />
                
                <% if (isLoggedIn) { %>
                <form action="cart" method="post" class="mt-3">
                    <input type="hidden" name="action" value="add">
                    <input type="hidden" name="bookId" value="<%= book.getBook_id() %>">
                    <input type="hidden" name="quantity" value="1">
                    <button type="submit" class="btn-primary d-flex align-items-center justify-content-center gap-2">
                        <strong>Tambah ke Keranjang</strong> 
                        <i class="bi bi-cart fs-6"></i>
                    </button>
                </form>
                <% } else { %>
                <a href="login.jsp" class="btn-primary mt-3 d-flex align-items-center justify-content-center gap-2">
                    <strong>Login untuk Membeli</strong> 
                    <i class="bi bi-box-arrow-in-right fs-6"></i>
                </a>
                <% } %>
            </div>
            
            <!-- Detail Buku -->
            <div class="col-md">
                <!-- Judul + Harga -->
                <div class="book-detail-header">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <div>
                            <h3 class="fw-bold mb-1"><%= book.getTitle() %></h3>
                            <div class="fw-bold text-danger small">
                                by <%= book.getAuthor() != null ? book.getAuthor().getName() : "Unknown Author" %>
                            </div>
                        </div>
                        <div class="book-detail-price">
                            <div class="h5 fw-bold">Rp<%= String.format("%,d", book.getPrice()) %></div>
                        </div>
                    </div>
                </div>
                
                <div class="book-detail-section-title">Detail Buku</div>
                <div class="book-meta-grid">
                    <div class="book-meta-item">
                        <div class="book-meta-label">Penerbit</div>
                        <div class="book-meta-value"><%= book.getPublisher() != null ? book.getPublisher().getName() : "Unknown Publisher" %></div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Tanggal Terbit</div>
                        <div class="book-meta-value">
                            <% 
                                if (book.getPublicationDate() != null) {
                                    SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
                                    out.print(sdf.format(book.getPublicationDate()));
                                } else {
                                    out.print("Tidak diketahui");
                                }
                            %>
                        </div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">ISBN</div>
                        <div class="book-meta-value"><%= book.getISBN() != null ? book.getISBN() : "Tidak tersedia" %></div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Kategori</div>
                        <div class="book-meta-value"><%= book.getCategory() != null ? book.getCategory().getName() : "Tidak dikategorikan" %></div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Stok</div>
                        <div class="book-meta-value">
                            <% if (book.getStock() > 0) { %>
                                <span class="text-success"><%= book.getStock() %> tersedia</span>
                            <% } else { %>
                                <span class="text-danger">Stok habis</span>
                            <% } %>
                        </div>
                    </div>
                    <% if (book.getLength() > 0) { %>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Panjang</div>
                        <div class="book-meta-value"><%= book.getLength() %> cm</div>
                    </div>
                    <% } %>
                    <% if (book.getWidth() > 0) { %>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Lebar</div>
                        <div class="book-meta-value"><%= book.getWidth() %> cm</div>
                    </div>
                    <% } %>
                    <% if (book.getWeight() > 0) { %>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Berat</div>
                        <div class="book-meta-value"><%= book.getWeight() %> gram</div>
                    </div>
                    <% } %>
                </div>
            
                <!-- Sinopsis -->
                <div class="book-detail-section-title">Deskripsi Buku</div>   
                
                <p id="sinopsis" class="book-synopsis synopsis-collapsed">
                    <%= book.getDescription() != null ? book.getDescription() : "Deskripsi tidak tersedia untuk buku ini." %>
                </p>
                <button id="toggleBtn" class="toggle-synopsis-btn">
                    <strong>Baca selengkapnya</strong>
                    <i id="toggleIcon" class="bi bi-chevron-down ms-1"></i>
                </button>
            </div>
        </div>
    </section>  

    <!-- Author's Books -->
    <% if (!authorBooks.isEmpty() && book.getAuthor() != null) { %>
    <section class="container my-5">
        <div class="section-header">
            <h4>Intip Karya <%= book.getAuthor().getName() %> Lainnya...</h4>
            <p><a href="books?querya=<%= book.getAuthor().getAuthor_id() %>">Lihat Semua</a></p>
        </div>
        
        <div id="authorBooks" class="carousel slide book-carousel-container author-books-carousel" data-bs-ride="carousel">
            <div class="carousel-inner">
                <%
                    int booksPerSlide = 6;
                    int slides = (int) Math.ceil((double) authorBooks.size() / booksPerSlide);
                    
                    for (int slide = 0; slide < slides; slide++) {
                        boolean isActive = slide == 0;
                %>
                <div class="carousel-item <%= isActive ? "active" : "" %>">
                    <div class="book-list">
                        <%
                            int startIndex = slide * booksPerSlide;
                            int endIndex = Math.min(startIndex + booksPerSlide, authorBooks.size());
                            
                            for (int i = startIndex; i < endIndex; i++) {
                                Book authorBook = authorBooks.get(i);
                                if (authorBook.getBook_id() != book.getBook_id()) { // Don't show current book
                        %>
                        <div class="book-card">
                            <a href="books?action=detail&id=<%= authorBook.getBook_id() %>" class="text-decoration-none">
                                <img src="<%= authorBook.getImagePath() != null ? authorBook.getImagePath() : "default-book.jpg" %>" 
                                     class="book-cover" alt="<%= authorBook.getTitle() %>">
                                <div class="book-body">
                                    <h6 class="book-author"><%= authorBook.getAuthor() != null ? authorBook.getAuthor().getName() : "Unknown Author" %></h6>
                                    <p class="book-title"><%= authorBook.getTitle() %></p>
                                    <strong class="book-price">Rp<%= String.format("%,d", authorBook.getPrice()) %></strong>
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
            <% if (slides > 1) { %>
            <button class="carousel-control-prev" type="button" data-bs-target="#authorBooks" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#authorBooks" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
            <div class="carousel-indicators">
                <% for (int i = 0; i < slides; i++) { %>
                <button type="button" data-bs-target="#authorBooks" data-bs-slide-to="<%= i %>" 
                        <%= i == 0 ? "class=\"active\" aria-current=\"true\"" : "" %> aria-label="Slide <%= i + 1 %>"></button>
                <% } %>
            </div>
            <% } %>
        </div>
    </section>  
    <% } %>
    
    <% } %>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <!-- Scripts -->
    <script>
        const sinopsis = document.getElementById("sinopsis");
        const toggleBtn = document.getElementById("toggleBtn");
        const toggleIcon = document.getElementById("toggleIcon");
        
        if (sinopsis && toggleBtn && toggleIcon) {
            toggleBtn.addEventListener("click", () => {
                const isCollapsed = sinopsis.classList.contains("synopsis-collapsed");
                sinopsis.classList.toggle("synopsis-collapsed", !isCollapsed);
                sinopsis.classList.toggle("synopsis-expanded", isCollapsed);
                toggleBtn.querySelector("strong").textContent = isCollapsed ? "Sembunyikan" : "Baca selengkapnya";
                toggleIcon.className = isCollapsed ? "bi bi-chevron-up ms-1" : "bi bi-chevron-down ms-1";
            });
        }
    </script>
</body>
</html>
