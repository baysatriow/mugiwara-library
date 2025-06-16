<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="session.jsp" %>
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
                                    <p><b>Nama Lengkap</b><br><span id="detail-nama">Jamaludin Isekai</span></p>
                                    <p><b>Email</b><br><span id="detail-email">isekaijamaludin@gmail.com</span></p>
                                    <p><b>Jenis Kelamin</b><br><span id="detail-gender">Perempuan</span></p>
                                    <p><b>Tanggal Lahir</b><br><span id="detail-dob">30 Februari 2000</span></p>
                                    <p><b>No Telepon</b><br><span id="detail-phone">+62 81234567890</span></p>
                                    <div class="button-group">
                                        <button class="btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editProfileModal">Edit Profil</button>
                                        <button class="btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#changePasswordModal">Atur Kata Sandi</button>
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
                                    <button class="btn-primary btn-xs" data-bs-toggle="modal" data-bs-target="#orderDetailModal">Detail Pesanan</button>
                                </div>
                            </div>
                        </div>
                        <!-- More transaction cards here -->
                    </div>

                    <!-- Address Section -->
                    <div id="alamat" style="display: none">
                        <div class="up">
                            <h2>Alamat</h2>
                            <button class="btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#addressModal" data-mode="add">+ Alamat Baru</button>
                        </div>
                        <div class="address-card">
                            <p><b>Jamaludin Isekai</b> | +62 81234567890</p>
                            <p class="text-muted">Jl. Contoh Alamat No. 123, Kelurahan Contoh, Kecamatan Contoh, Kota Contoh, Provinsi Contoh, 12345</p>
                            <div class="address-actions">
                                <button class="btn-text" data-bs-toggle="modal" data-bs-target="#addressModal" data-mode="edit">Ubah</button>
                                <span class="divider">|</span>
                                <button class="btn-text" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal">Hapus</button>
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
    
    <!-- All Modals Below -->

    <!-- Edit Profile Modal -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProfileModalLabel">Edit Profil</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editProfileForm">
                        <div class="mb-3">
                            <label for="profileName" class="form-label">Nama Lengkap</label>
                            <input type="text" class="form-control" id="profileName" value="Jamaludin Isekai">
                        </div>
                        <div class="mb-3">
                            <label for="profileEmail" class="form-label">Email</label>
                            <input type="email" class="form-control" id="profileEmail" value="isekaijamaludin@gmail.com" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="profileGender" class="form-label">Jenis Kelamin</label>
                            <select class="form-select" id="profileGender">
                                <option value="Laki-laki">Laki-laki</option>
                                <option value="Perempuan" selected>Perempuan</option>
                            </select>
                        </div>
                         <div class="mb-3">
                            <label for="profileDob" class="form-label">Tanggal Lahir</label>
                            <input type="date" class="form-control" id="profileDob" value="2000-02-30">
                        </div>
                        <div class="mb-3">
                            <label for="profilePhone" class="form-label">No. Telepon</label>
                            <input type="tel" class="form-control" id="profilePhone" value="+6281234567890">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="button" class="btn btn-primary" id="saveProfileChanges">Simpan Perubahan</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Change Password Modal -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="changePasswordModalLabel">Atur Kata Sandi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="changePasswordForm">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Kata Sandi Saat Ini</label>
                            <input type="password" class="form-control" id="currentPassword">
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Kata Sandi Baru</label>
                            <input type="password" class="form-control" id="newPassword">
                        </div>
                        <div class="mb-3">
                            <label for="confirmNewPassword" class="form-label">Konfirmasi Kata Sandi Baru</label>
                            <input type="password" class="form-control" id="confirmNewPassword">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="button" class="btn btn-primary">Simpan</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Order Detail Modal -->
    <div class="modal fade" id="orderDetailModal" tabindex="-1" aria-labelledby="orderDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="orderDetailModalLabel">Detail Pesanan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body order-detail-modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <strong>ID Pesanan:</strong> ID0987654321
                        </div>
                        <div class="col-md-6 text-md-end">
                            <strong>Tanggal:</strong> 30 Februari 2025
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <strong>Status:</strong> <span class="badge bg-success">Pesanan Selesai</span>
                        </div>
                    </div>
                    <hr>
                    <h6>Alamat Pengiriman</h6>
                    <p class="text-muted">
                        <strong>Jamaludin Isekai</strong> (+6281234567890)<br>
                        Jl. Contoh Alamat No. 123, Kelurahan Contoh, Kecamatan Contoh, Kota Contoh, Provinsi Contoh, 12345
                    </p>
                    <hr>
                    <h6>Produk Dipesan</h6>
                    <div class="item-list">
                         <div class="d-flex align-items-center mb-3">
                            <img src="assets/images/Laut Bercerita.jpg" alt="Book" class="me-3">
                            <div class="flex-grow-1">
                                <strong>Laut Bercerita</strong>
                                <div class="text-muted">1 x Rp125.000</div>
                            </div>
                            <div><strong>Rp125.000</strong></div>
                        </div>
                    </div>
                    <hr>
                    <h6>Rincian Pembayaran</h6>
                    <div class="row">
                        <div class="col">Subtotal Produk:</div>
                        <div class="col text-end">Rp125.000</div>
                    </div>
                    <div class="row">
                        <div class="col">Ongkos Kirim:</div>
                        <div class="col text-end">Rp0</div>
                    </div>
                    <hr>
                    <div class="row fw-bold fs-5">
                        <div class="col">Total Pembayaran:</div>
                        <div class="col text-end">Rp125.000</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Address Modal (Add/Edit) -->
    <div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addressModalLabel">...</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addressForm">
                        <input type="hidden" id="addressId">
                        <div class="mb-3">
                            <label for="addressName" class="form-label">Nama Penerima</label>
                            <input type="text" class="form-control" id="addressName" required>
                        </div>
                        <div class="mb-3">
                            <label for="addressPhone" class="form-label">No. Telepon</label>
                            <input type="tel" class="form-control" id="addressPhone" required>
                        </div>
                        <div class="mb-3">
                            <label for="addressDetail" class="form-label">Alamat Lengkap</label>
                            <textarea class="form-control" id="addressDetail" rows="3" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" form="addressForm" class="btn btn-primary" id="saveAddressButton">Simpan</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-labelledby="deleteConfirmModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-sm modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteConfirmModalLabel">Hapus Alamat</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Anda yakin ingin menghapus alamat ini?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="button" class="btn btn-danger">Ya, Hapus</button>
                </div>
            </div>
        </div>
    </div>
    
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
