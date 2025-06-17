<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Mugiwara Library</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .error-container {
            min-height: 60vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
        }
        .error-content {
            text-align: center;
            max-width: 600px;
            padding: 2rem;
        }
        .error-icon {
            font-size: 6rem;
            color: #dc3545;
            margin-bottom: 1rem;
        }
        .error-code {
            font-size: 4rem;
            font-weight: bold;
            color: #dc3545;
            margin-bottom: 0.5rem;
        }
        .error-message {
            font-size: 1.5rem;
            color: #6c757d;
            margin-bottom: 1rem;
        }
        .error-description {
            color: #6c757d;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        .error-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
        }
        .btn-home {
            background-color: #007bff;
            border-color: #007bff;
            color: white;
            padding: 0.75rem 2rem;
            border-radius: 0.5rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        .btn-home:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }
        .btn-back {
            background-color: #6c757d;
            border-color: #6c757d;
            color: white;
            padding: 0.75rem 2rem;
            border-radius: 0.5rem;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
        }
        .btn-back:hover {
            background-color: #545b62;
            border-color: #545b62;
            color: white;
            text-decoration: none;
            transform: translateY(-2px);
        }
        .error-details {
            background-color: #f8f9fa;
            border: 1px solid #dee2e6;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-top: 2rem;
            text-align: left;
        }
        .error-details summary {
            cursor: pointer;
            font-weight: bold;
            color: #495057;
            margin-bottom: 0.5rem;
        }
        .error-details pre {
            background-color: #e9ecef;
            padding: 0.75rem;
            border-radius: 0.25rem;
            font-size: 0.875rem;
            overflow-x: auto;
            margin: 0;
        }
    </style>
</head>
<body>
    <%
        // Get error information from request attributes or parameters
        String errorMessage = (String) request.getAttribute("errorMessage");
        String errorType = (String) request.getAttribute("errorType");
        String statusCodeStr = (String) request.getAttribute("statusCode");
        String requestURI = (String) request.getAttribute("requestURI");
        String exceptionMessage = (String) request.getAttribute("exceptionMessage");
        String stackTrace = (String) request.getAttribute("stackTrace");
        
        // Also check URL parameters (for direct access)
        if (errorMessage == null) errorMessage = request.getParameter("message");
        if (errorType == null) errorType = request.getParameter("type");
        if (statusCodeStr == null) statusCodeStr = request.getParameter("code");
        
        // Default values
        if (errorMessage == null) {
            errorMessage = "Terjadi kesalahan yang tidak terduga";
        }
        
        int statusCode = 500;
        try {
            if (statusCodeStr != null) {
                statusCode = Integer.parseInt(statusCodeStr);
            }
        } catch (NumberFormatException e) {
            statusCode = 500;
        }
        
        if (requestURI == null) {
            requestURI = request.getRequestURI();
        }
        
        // Determine error type and message based on status code or error type
        String errorTitle = "Error";
        String errorDesc = "Mohon maaf, terjadi kesalahan pada sistem kami.";
        String iconClass = "bi-exclamation-triangle-fill";
        
        if ("database".equals(errorType)) {
            errorTitle = "Database Error";
            errorDesc = "Terjadi masalah koneksi dengan database. Tim kami sedang memperbaikinya.";
            iconClass = "bi-database-exclamation";
            statusCode = 500;
        } else if ("validation".equals(errorType)) {
            errorTitle = "Validation Error";
            errorDesc = "Data yang Anda masukkan tidak valid. Silakan periksa kembali.";
            iconClass = "bi-exclamation-circle";
            statusCode = 400;
        } else if ("authentication".equals(errorType)) {
            errorTitle = "Authentication Required";
            errorDesc = "Anda perlu login untuk mengakses halaman ini.";
            iconClass = "bi-shield-exclamation";
            statusCode = 401;
        } else if ("authorization".equals(errorType)) {
            errorTitle = "Access Denied";
            errorDesc = "Anda tidak memiliki izin untuk mengakses halaman ini.";
            iconClass = "bi-shield-x";
            statusCode = 403;
        } else if ("notfound".equals(errorType)) {
            errorTitle = "Halaman Tidak Ditemukan";
            errorDesc = "Halaman yang Anda cari tidak dapat ditemukan.";
            iconClass = "bi-file-earmark-x";
            statusCode = 404;
        } else {
            // Determine by status code
            switch (statusCode) {
                case 400:
                    errorTitle = "Bad Request";
                    errorDesc = "Permintaan yang Anda kirim tidak valid atau tidak dapat diproses.";
                    iconClass = "bi-x-circle-fill";
                    break;
                case 401:
                    errorTitle = "Unauthorized";
                    errorDesc = "Anda tidak memiliki akses untuk mengakses halaman ini. Silakan login terlebih dahulu.";
                    iconClass = "bi-shield-exclamation";
                    break;
                case 403:
                    errorTitle = "Forbidden";
                    errorDesc = "Anda tidak memiliki izin untuk mengakses halaman ini.";
                    iconClass = "bi-shield-x";
                    break;
                case 404:
                    errorTitle = "Halaman Tidak Ditemukan";
                    errorDesc = "Halaman yang Anda cari tidak dapat ditemukan. Mungkin halaman telah dipindahkan atau dihapus.";
                    iconClass = "bi-file-earmark-x";
                    break;
                case 405:
                    errorTitle = "Method Not Allowed";
                    errorDesc = "Metode yang digunakan tidak diizinkan untuk halaman ini.";
                    iconClass = "bi-x-circle-fill";
                    break;
                case 500:
                    errorTitle = "Internal Server Error";
                    errorDesc = "Terjadi kesalahan pada server. Tim kami sedang bekerja untuk memperbaikinya.";
                    iconClass = "bi-exclamation-triangle-fill";
                    break;
                case 502:
                    errorTitle = "Bad Gateway";
                    errorDesc = "Server tidak dapat terhubung dengan layanan yang diperlukan.";
                    iconClass = "bi-wifi-off";
                    break;
                case 503:
                    errorTitle = "Service Unavailable";
                    errorDesc = "Layanan sedang tidak tersedia. Silakan coba lagi nanti.";
                    iconClass = "bi-tools";
                    break;
                default:
                    errorTitle = "Error " + statusCode;
                    break;
            }
        }
        
        // Check if in development mode
        boolean isDevelopment = "development".equals(System.getProperty("environment", "development"));
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
                <a href="<%= isLoggedIn ? "cart" : "login.jsp" %>" class="text-white-icon me-3">
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

    <!-- Main Error Content -->
    <main>
        <div class="container">
            <div class="error-container">
                <div class="error-content">
                    <!-- Error Icon -->
                    <div class="error-icon">
                        <i class="bi <%= iconClass %>"></i>
                    </div>
                    
                    <!-- Error Code -->
                    <div class="error-code"><%= statusCode %></div>
                    
                    <!-- Error Message -->
                    <div class="error-message"><%= errorTitle %></div>
                    
                    <!-- Error Description -->
                    <div class="error-description">
                        <%= errorDesc %>
                        <% if (errorMessage != null && !errorMessage.equals("Terjadi kesalahan yang tidak terduga")) { %>
                        <br><br>
                        <strong>Detail:</strong> <%= errorMessage %>
                        <% } %>
                    </div>
                    
                    <!-- Action Buttons -->
                    <div class="error-actions">
                        <a href="home" class="btn-home">
                            <i class="bi bi-house-fill"></i>
                            Kembali ke Beranda
                        </a>
                        <a href="javascript:history.back()" class="btn-back">
                            <i class="bi bi-arrow-left"></i>
                            Halaman Sebelumnya
                        </a>
                    </div>
                    
                    <!-- Additional Help -->
                    <div class="mt-4">
                        <p class="text-muted">
                            Jika masalah terus berlanjut, silakan hubungi 
                            <a href="mailto:support@mugiwara-library.com" class="text-primary">tim support kami</a>
                        </p>
                    </div>
                    
                    <!-- Error Details (for debugging - only show in development) -->
                    <% if (isDevelopment && (exceptionMessage != null || stackTrace != null || requestURI != null)) { %>
                    <div class="error-details">
                        <details>
                            <summary>Detail Teknis (Development Mode)</summary>
                            <div class="mt-2">
                                <% if (requestURI != null) { %>
                                <p><strong>Request URI:</strong> <%= requestURI %></p>
                                <% } %>
                                
                                <% if (errorType != null) { %>
                                <p><strong>Error Type:</strong> <%= errorType %></p>
                                <% } %>
                                
                                <% if (exceptionMessage != null) { %>
                                <p><strong>Exception Message:</strong></p>
                                <pre><%= exceptionMessage %></pre>
                                <% } %>
                                
                                <% if (stackTrace != null) { %>
                                <p><strong>Stack Trace:</strong></p>
                                <pre><%= stackTrace %></pre>
                                <% } %>
                            </div>
                        </details>
                    </div>
                    <% } %>
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
            // Auto-refresh for 503 errors (service unavailable)
            <% if (statusCode == 503) { %>
            setTimeout(function() {
                if (confirm('Layanan mungkin sudah tersedia kembali. Ingin mencoba memuat ulang halaman?')) {
                    window.location.reload();
                }
            }, 30000); // 30 seconds
            <% } %>
            
            // Log error for analytics (in production)
            <% if (!isDevelopment) { %>
            try {
                console.log('Error logged:', {
                    statusCode: <%= statusCode %>,
                    errorType: '<%= errorType %>',
                    requestURI: '<%= requestURI %>',
                    userAgent: navigator.userAgent,
                    timestamp: new Date().toISOString()
                });
            } catch (e) {
                // Ignore analytics errors
            }
            <% } %>
        });
        
        // Add some interactive feedback
        document.querySelectorAll('.btn-home, .btn-back').forEach(function(btn) {
            btn.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-2px)';
            });
            
            btn.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });
    </script>
</body>
</html>
