<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Profile - Mugiwara Library</title>
    <link rel="stylesheet" href="assets/css/style.css" />
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
                        <li><a class="dropdown-item" href="#" data-category="Novel">Novel</a></li>
                        <li><a class="dropdown-item" href="#" data-category="Majalah">Majalah</a></li>
                        <li><a class="dropdown-item" href="#" data-category="Komik">Komik</a></li>
                        <li><a class="dropdown-item" href="#" data-category="Semua">Semua Kategori</a></li>
                    </ul>
                </div>
                <form class="form-inline flex-grow-1"> 
                    <div class="search-input-group">
                        <input class="form-control search-input" type="search" placeholder="Mau cari apa hari ini?" aria-label="Search" id="searchInput">
                        <button class="search-btn" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>
            </div>
            <div class="user-menu">
                <span class="user-name">Jamaludin Isekai</span>
                <a href="cart.jsp" class="text-white-icon me-3">
                    <img src="assets/images/cart.png" alt="cart" class="cart-icon">
                </a>
                <a href="profile.jsp" class="text-white-icon">
                    <img src="assets/images/profile.png" alt="profile" class="profile-icon">
                </a>
            </div>
        </nav>
    </header>

    <!-- Main content -->
    <main>
        <div class="profile-container">
            <div class="profile-layout">
                <!-- Navigation Sidebar -->
                <nav class="profile-sidebar">
                    <div class="profile-user-info">
                        <img src="assets/images/userPfp.jpeg" alt="Profile Picture" />
                        <p>
                            <b>Jamaludin Isekai</b><br />
                            <small>isekaijamaludin@gmail.com</small>
                        </p>
                    </div>
                    <ul class="profile-nav">
                        <li class="profile-nav-item active" onclick="showSection('akun')">Akun</li>
                        <li class="profile-nav-item" onclick="showSection('transaksi')">Transaksi</li>
                        <li class="profile-nav-item" onclick="showSection('alamat')">Alamat</li>
                    </ul>
                </nav>

                <!-- Content Area -->
                <div class="profile-content">
                    <!-- Account Section -->
                    <div id="akun">
                        <div class="up">
                            <h2>Pengaturan Akun</h2>
                        </div>
                        <div class="profile-card">
                            <div class="profile-info-layout">
                                <div class="profile-image">
                                    <img src="assets/images/userPfp.jpeg" alt="Profile Picture" />
                                </div>
                                <div class="profile-details">
                                    <p>
                                        <b>Nama Lengkap</b><br>
                                        Jamaludin Isekai
                                    </p>
                                    <p>
                                        <b>Email</b><br>
                                        isekaijamaludin@gmail.com
                                    </p>
                                    <p>
                                        <b>Jenis Kelamin</b><br>
                                        Perempuan
                                    </p>
                                    <p>
                                        <b>Tanggal Lahir</b><br>
                                        30 Februari 2000
                                    </p>
                                    <p>
                                        <b>No Telepon</b><br>
                                        +62 81234567890
                                    </p>
                                    <div class="button-group">
                                        <button class="btn-primary btn-sm">Edit Profil</button>
                                        <button class="btn-primary btn-sm">Atur Kata Sandi</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Transaction Section -->
                    <div id="transaksi" style="display: none">
                        <div class="up">
                            <h2>Daftar Transaksi</h2>
                        </div>
                        <div class="transaction-card">
                            <div class="transaction-header">
                                <span><b>Senin, 30 Februari 2025</b> | ID0987654321</span>
                                <span class="status-text">Pesanan telah sampai</span>
                            </div>
                            <div class="transaction-body">
                                <div class="transaction-book-info">
                                    <img src="assets/images/Laut Bercerita.jpg" alt="Laut Bercerita" />
                                    <div class="transaction-book-details">
                                        <p class="book-title">Laut Bercerita</p>
                                        <p class="book-quantity">1 Barang</p>
                                    </div>
                                </div>
                                <div class="transaction-payment-info">
                                    <p class="total-label">Total Pembayaran</p>
                                    <p class="total-amount">Rp125.000</p>
                                    <button class="btn-primary btn-xs">Detail Pesanan</button>
                                </div>
                            </div>
                        </div>
                        <div class="transaction-card">
                            <div class="transaction-header">
                                <span><b>Rabu, 21 Januari 2025</b> | ID0987656666</span>
                                <span class="status-text">Pesanan telah sampai</span>
                            </div>
                            <div class="transaction-body">
                                <div class="transaction-book-info">
                                    <img src="assets/images/Seperti Dendam.jpg" alt="Seperti Dendam" />
                                    <div class="transaction-book-details">
                                        <p class="book-title">Seperti Dendam, Rindu Harus Dibayar Tuntas</p>
                                        <p class="book-quantity">1 Barang</p>
                                    </div>
                                </div>
                                <div class="transaction-payment-info">
                                    <p class="total-label">Total Pembayaran</p>
                                    <p class="total-amount">Rp56.250</p>
                                    <button class="btn-primary btn-xs">Detail Pesanan</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Address Section -->
                    <div id="alamat" style="display: none">
                        <div class="up">
                            <h2>Alamat</h2>
                            <button class="btn-primary btn-sm">+ Alamat Baru</button>
                        </div>
                        <div class="profile-card">
                            <p><b>Jamaludin Isekai</b> | +62 81234567890</p>
                            <p>
                                Jl. Contoh Alamat No. 123, Kelurahan Contoh, Kecamatan Contoh, 
                                Kota Contoh, Provinsi Contoh, 12345
                            </p>
                            <div class="action-buttons">
                                <button class="btn-text">Ubah</button>
                                <span class="divider">|</span>
                                <button class="btn-text">Hapus</button>
                            </div>
                        </div>
                    </div>
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
        function showSection(section) {
            const sections = ["akun", "transaksi", "alamat"];
            sections.forEach((id) => {
                document.getElementById(id).style.display = id === section ? "block" : "none";
            });
            
            const navItems = document.querySelectorAll(".profile-nav-item");
            navItems.forEach((li) => {
                li.classList.remove("active");
                if (li.textContent.toLowerCase() === section) {
                    li.classList.add("active");
                }
            });
        }

        // Category and search functionality
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
    </script>
</body>
</html>
