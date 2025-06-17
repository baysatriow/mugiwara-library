<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<%@ include file="session.jsp" %>
<%
    // Get error information
    String errorCode = request.getParameter("code");
    String errorMessage = request.getParameter("message");
    
    // Default values if not provided
    if (errorCode == null) {
        errorCode = "500";
    }
    if (errorMessage == null) {
        errorMessage = "Terjadi kesalahan pada server";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error <%= errorCode %> - Mugiwara Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <link rel="stylesheet" href="assets/css/style.css">
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

    <!-- Main Content -->
    <main>
        <div class="error-container">
            <div class="error-content">
                <div class="error-icon">
                    <% if ("404".equals(errorCode)) { %>
                        <i class="bi bi-search"></i>
                    <% } else if ("403".equals(errorCode)) { %>
                        <i class="bi bi-shield-exclamation"></i>
                    <% } else if ("500".equals(errorCode)) { %>
                        <i class="bi bi-exclamation-triangle"></i>
                    <% } else { %>
                        <i class="bi bi-exclamation-circle"></i>
                    <% } %>
                </div>
                
                <div class="error-code"><%= errorCode %></div>
                
                <div class="error-message">
                    <% if ("404".equals(errorCode)) { %>
                        Halaman Tidak Ditemukan
                    <% } else if ("403".equals(errorCode)) { %>
                        Akses Ditolak
                    <% } else if ("500".equals(errorCode)) { %>
                        Kesalahan Server
                    <% } else { %>
                        Terjadi Kesalahan
                    <% } %>
                </div>
                
                <div class="error-description">
                    <% if ("404".equals(errorCode)) { %>
                        Maaf, halaman yang Anda cari tidak dapat ditemukan. Mungkin halaman telah dipindahkan atau URL yang Anda masukkan salah.
                    <% } else if ("403".equals(errorCode)) { %>
                        Anda tidak memiliki izin untuk mengakses halaman ini. Silakan login dengan akun yang sesuai.
                    <% } else if ("500".equals(errorCode)) { %>
                        Terjadi kesalahan pada server kami. Tim teknis sedang bekerja untuk memperbaiki masalah ini.
                    <% } else { %>
                        <%= errorMessage %>
                    <% } %>
                </div>
                
                <div class="error-actions">
                    <a href="home" class="btn-home">
                        <i class="bi bi-house-door me-2"></i>Kembali ke Beranda
                    </a>
                    <button onclick="history.back()" class="btn-back">
                        <i class="bi bi-arrow-left me-2"></i>Halaman Sebelumnya
                    </button>
                </div>
                
                <% if ("404".equals(errorCode)) { %>
                <div class="mt-4">
                    <p class="text-muted">Atau coba cari buku yang Anda inginkan:</p>
                    <form action="books" method="get" class="d-flex justify-content-center">
                        <div class="search-input-group" style="max-width: 400px;">
                            <input class="form-control search-input" type="search" name="query" 
                                   placeholder="Cari buku..." aria-label="Search">
                            <button class="search-btn" type="submit">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </form>
                </div>
                <% } %>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
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

        // Auto-refresh for server errors
        <% if ("500".equals(errorCode)) { %>
        let refreshTimer = 30;
        const refreshElement = document.createElement('div');
        refreshElement.className = 'text-center mt-3';
        refreshElement.innerHTML = `<small class="text-muted">Halaman akan dimuat ulang dalam <span id="refresh-timer">${refreshTimer}</span> detik</small>`;
        document.querySelector('.error-content').appendChild(refreshElement);

        const timer = setInterval(() => {
            refreshTimer--;
            document.getElementById('refresh-timer').textContent = refreshTimer;
            
            if (refreshTimer <= 0) {
                clearInterval(timer);
                window.location.reload();
            }
        }, 1000);
        <% } %>

        // Log error for analytics (if needed)
        console.error('Error <%= errorCode %>: <%= errorMessage %>');
    </script>
</body>
</html>
