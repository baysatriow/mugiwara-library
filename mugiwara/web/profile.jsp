<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Profile - Mugiwara Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/css/iziToast.min.css">
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
                            <li><a class="dropdown-item" href="profile"><i class="bi bi-person-circle"></i> Akun Saya</a></li>
                            <li><a class="dropdown-item" href="profile#transaksi"><i class="bi bi-receipt"></i> Pesanan</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="Login?action=logout"><i class="bi bi-box-arrow-right"></i> Logout</a></li>
                        <% } else { %>
                            <li><a class="dropdown-item" href="login.jsp"><i class="bi bi-box-arrow-in-right"></i> Login</a></li>
                            <li><a class="dropdown-item" href="register.jsp"><i class="bi bi-person-plus-fill"></i> Registrasi</a></li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <!-- Loading Overlay -->
    <div id="loadingOverlay" class="loading-overlay" style="display: none;">
        <div class="spinner-border text-primary" role="status" style="width: 3rem; height: 3rem;">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>

    <!-- Main content -->
    <main>
        <div class="profile-container">
            <div class="profile-layout">
                <!-- Navigation Sidebar  -->
                <nav class="profile-sidebar">
                    <div class="profile-user-info">
                        <img id="sidebarProfileImage" src="assets/images/userPfp.jpeg" alt="Profile Picture" />
                        <p>
                            <b id="sidebarFullName"><%= fullName != null ? fullName : "Loading..." %></b><br />
                            <small id="sidebarEmail"><%= email != null ? email : "Loading..." %></small>
                        </p>
                    </div>
                    <ul class="profile-nav">
                        <li class="profile-nav-item active" onclick="showSection('akun')">
                            <i class="bi bi-person-circle me-2"></i>Akun
                        </li>
                        <li class="profile-nav-item" onclick="showSection('transaksi')">
                            <i class="bi bi-receipt me-2"></i>Transaksi
                        </li>
                        <li class="profile-nav-item" onclick="showSection('alamat')">
                            <i class="bi bi-geo-alt me-2"></i>Alamat
                        </li>
                    </ul>
                </nav>

                <!-- Content Area  -->
                <div class="profile-content">
                    <!-- Account Section -->
                    <div id="akun">
                        <div class="up">
                            <h2>Pengaturan Akun</h2>
                        </div>
                        <div class="profile-card">
                            <div class="profile-info-layout">
                                <div class="profile-image">
                                    <img id="mainProfileImage" src="assets/images/userPfp.jpeg" alt="Profile Picture" />
                                </div>
                                <div class="profile-details">
                                    <p><b>Nama Lengkap</b><br><span id="detail-nama"><%= fullName != null ? fullName : "-" %></span></p>
                                    <p><b>Email</b><br><span id="detail-email"><%= email != null ? email : "-" %></span></p>
                                    <p><b>Jenis Kelamin</b><br><span id="detail-gender">-</span></p>
                                    <p><b>Tanggal Lahir</b><br><span id="detail-dob">-</span></p>
                                    <p><b>No Telepon</b><br><span id="detail-phone">-</span></p>
                                </div>
                            </div>
                        
                            <div class="button-group">
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editProfileModal">
                                    <i class="bi bi-pencil-square me-2"></i>Edit Profil
                                </button>
                                <button class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                    <i class="bi bi-key me-2"></i>Atur Kata Sandi
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Transaction Section  -->
                    <div id="transaksi" style="display: none">
                        <div class="up">
                            <h2>Riwayat Transaksi</h2>
                        </div>
                        <div class="profile-card">
                            <div id="transactionContainer">
                                <div class="text-center py-5">
                                    <i class="bi bi-receipt text-muted" style="font-size: 3rem;"></i>
                                    <h5 class="mt-3 text-muted">Belum ada transaksi</h5>
                                    <p class="text-muted">Transaksi Anda akan muncul di sini setelah melakukan pembelian.</p>
                                    <a href="books" class="btn btn-primary">
                                        <i class="bi bi-book me-2"></i>Mulai Belanja
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Address Section  -->
                    <div id="alamat" style="display: none">
                        <div class="up">
                            <h2>Alamat Saya</h2>
                        </div>
                        <div class="profile-card">
                            <div class="d-flex justify-content-between align-items-center mb-4">
                                <h6>Daftar Alamat</h6>
                                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addressModal" onclick="openAddressModal('add')">
                                    <i class="bi bi-plus-circle me-2"></i>Tambah Alamat
                                </button>
                            </div>
                            <div id="addressContainer">
                                <div class="text-center py-5">
                                    <i class="bi bi-geo-alt text-muted" style="font-size: 3rem;"></i>
                                    <h5 class="mt-3 text-muted">Belum ada alamat tersimpan</h5>
                                    <p class="text-muted">Tambahkan alamat untuk mempermudah proses checkout.</p>
                                </div>
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

    <!-- Edit Profile Modal -->
    <div class="modal fade" id="editProfileModal" tabindex="-1" aria-labelledby="editProfileModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProfileModalLabel">Edit Profil</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="editProfileForm">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="profileName" class="form-label">Nama Lengkap <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="profileName" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="profileEmail" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="profileEmail" disabled>
                                    <small class="form-text text-muted">Email tidak dapat diubah</small>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="profileGender" class="form-label">Jenis Kelamin</label>
                                    <select class="form-select" id="profileGender">
                                        <option value="">Pilih Jenis Kelamin</option>
                                        <option value="Laki-laki">Laki-laki</option>
                                        <option value="Perempuan">Perempuan</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="profileDob" class="form-label">Tanggal Lahir</label>
                                    <input type="date" class="form-control" id="profileDob">
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="profilePhone" class="form-label">No. Telepon <span class="text-danger">*</span></label>
                            <input type="tel" class="form-control" id="profilePhone" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="button" class="btn btn-primary" id="saveProfileChanges">
                        <span class="spinner-border spinner-border-sm d-none" role="status"></span>
                        <i class="bi bi-check-circle me-2"></i>Simpan Perubahan
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Change Password Modal -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="changePasswordModalLabel">Atur Kata Sandi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="changePasswordForm">
                        <div class="mb-3">
                            <label for="currentPassword" class="form-label">Kata Sandi Saat Ini <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="currentPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">Kata Sandi Baru <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="newPassword" required>
                            <small class="form-text text-muted">Minimal 6 karakter, harus mengandung huruf dan angka</small>
                        </div>
                        <div class="mb-3">
                            <label for="confirmNewPassword" class="form-label">Konfirmasi Kata Sandi Baru <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="confirmNewPassword" required>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" form="changePasswordForm" class="btn btn-primary" id="changePasswordBtn">
                        <span class="spinner-border spinner-border-sm d-none" role="status"></span>
                        <i class="bi bi-key me-2"></i>Simpan
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Address Modal (Add/Edit)-->
    <div class="modal fade" id="addressModal" tabindex="-1" aria-labelledby="addressModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addressModalLabel">Tambah Alamat</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="addressForm">
                        <input type="hidden" id="addressId">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="addressProvince" class="form-label">Provinsi</label>
                                <input type="text" class="form-control" id="addressProvince">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="addressCity" class="form-label">Kota/Kabupaten</label>
                                <input type="text" class="form-control" id="addressCity">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="addressDistrict" class="form-label">Kecamatan</label>
                                <input type="text" class="form-control" id="addressDistrict">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="addressPostalCode" class="form-label">Kode Pos</label>
                                <input type="text" class="form-control" id="addressPostalCode">
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="addressDetail" class="form-label">Alamat Lengkap <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="addressDetail" rows="3" required placeholder="Contoh: Jl. Merdeka No. 123, RT 01/RW 02"></textarea>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="addressIsDefault">
                            <label class="form-check-label" for="addressIsDefault">
                                Jadikan alamat utama
                            </label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" form="addressForm" class="btn btn-primary" id="saveAddressButton">
                        <span class="spinner-border spinner-border-sm d-none" role="status"></span>
                        <i class="bi bi-geo-alt me-2"></i>Simpan
                    </button>
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
                    <button type="button" class="btn btn-danger" id="confirmDeleteBtn">
                        <span class="spinner-border spinner-border-sm d-none" role="status"></span>
                        Ya, Hapus
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/js/iziToast.min.js"></script>

    <script>
        var currentAddressId = null;
        
        // Initialize page 
        document.addEventListener('DOMContentLoaded', function() {
            // Check URL hash for direct navigation
            var hash = window.location.hash.substring(1);
            if (hash && ['akun', 'transaksi', 'alamat'].indexOf(hash) !== -1) {
                showSection(hash);
            }
            
            // Load data 
            loadProfileData();
            loadAddresses();
            initializeFormHandlers();
        });
        
        function showLoading(show) {
            if (show === undefined) show = true;
            var overlay = document.getElementById('loadingOverlay');
            if (overlay) {
                overlay.style.display = show ? 'flex' : 'none';
            }
        }
        
        function showButtonLoading(buttonId, show) {
            if (show === undefined) show = true;
            var button = document.getElementById(buttonId);
            if (!button) return;
            
            var spinner = button.querySelector('.spinner-border');
            
            if (show) {
                button.disabled = true;
                if (spinner) spinner.classList.remove('d-none');
            } else {
                button.disabled = false;
                if (spinner) spinner.classList.add('d-none');
            }
        }
        
        // Load profile data 
        function loadProfileData() {
            fetch('profile?action=getProfile')
                .then(function(response) { return response.json(); })
                .then(function(data) {
                    if (data.success) {
                        populateProfileData(data.data);
                    } else {
                        console.error('Failed to load profile:', data.message);
                    }
                })
                .catch(function(error) {
                    console.error('Error loading profile:', error);
                });
        }
        
        function populateProfileData(profileData) {
            // Update sidebar
            var sidebarName = document.getElementById('sidebarFullName');
            var sidebarEmail = document.getElementById('sidebarEmail');
            
            if (sidebarName) sidebarName.textContent = profileData.fullName || 'Nama tidak tersedia';
            if (sidebarEmail) sidebarEmail.textContent = profileData.email || 'Email tidak tersedia';
            
            // Update main profile display
            var elements = {
                'detail-nama': profileData.fullName || '-',
                'detail-email': profileData.email || '-',
                'detail-gender': profileData.gender || '-',
                'detail-dob': formatDate(profileData.birthDate) || '-',
                'detail-phone': profileData.phone || '-'
            };
            
            for (var id in elements) {
                var element = document.getElementById(id);
                if (element) element.textContent = elements[id];
            }
            
            // Update form fields
            var formElements = {
                'profileName': profileData.fullName || '',
                'profileEmail': profileData.email || '',
                'profileGender': profileData.gender || '',
                'profileDob': profileData.birthDate || '',
                'profilePhone': profileData.phone || ''
            };
            
            for (var id in formElements) {
                var element = document.getElementById(id);
                if (element) element.value = formElements[id];
            }
            
            // Update profile images if available
            if (profileData.imagePath) {
                var sidebarImg = document.getElementById('sidebarProfileImage');
                var mainImg = document.getElementById('mainProfileImage');
                if (sidebarImg) sidebarImg.src = profileData.imagePath;
                if (mainImg) mainImg.src = profileData.imagePath;
            }
        }
        
        // Initialize form handlers 
        function initializeFormHandlers() {
            // Edit Profile Form 
            var saveProfileBtn = document.getElementById('saveProfileChanges');
            if (saveProfileBtn) {
                saveProfileBtn.addEventListener('click', function() {
                    var form = document.getElementById('editProfileForm');
                    
                    if (!form.checkValidity()) {
                        form.reportValidity();
                        return;
                    }
                    
                    showButtonLoading('saveProfileChanges', true);
                    
                    var formData = new FormData();
                    formData.append('action', 'updateProfile');
                    formData.append('fullName', document.getElementById('profileName').value.trim());
                    formData.append('gender', document.getElementById('profileGender').value);
                    formData.append('birthDate', document.getElementById('profileDob').value);
                    formData.append('phone', document.getElementById('profilePhone').value.trim());
                    
                    fetch('profile', {
                        method: 'POST',
                        body: formData
                    })
                    .then(function(response) { return response.json(); })
                    .then(function(data) {
                        if (data.success) {
                            iziToast.success({
                                title: 'Berhasil',
                                message: data.message,
                                position: 'topRight'
                            });
                            
                            // Close modal and reload data
                            var modal = bootstrap.Modal.getInstance(document.getElementById('editProfileModal'));
                            if (modal) modal.hide();
                            loadProfileData();
                        } else {
                            iziToast.error({
                                title: 'Error',
                                message: data.message,
                                position: 'topRight'
                            });
                        }
                    })
                    .catch(function(error) {
                        console.error('Error updating profile:', error);
                        iziToast.error({
                            title: 'Error',
                            message: 'Gagal memperbarui profil',
                            position: 'topRight'
                        });
                    })
                    .finally(function() {
                        showButtonLoading('saveProfileChanges', false);
                    });
                });
            }
            
            // Change Password Form
            var passwordForm = document.getElementById('changePasswordForm');
            if (passwordForm) {
                passwordForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    var currentPassword = document.getElementById('currentPassword').value;
                    var newPassword = document.getElementById('newPassword').value;
                    var confirmPassword = document.getElementById('confirmNewPassword').value;
                    
                    if (newPassword !== confirmPassword) {
                        iziToast.error({
                            title: 'Error',
                            message: 'Konfirmasi kata sandi tidak cocok',
                            position: 'topRight'
                        });
                        return;
                    }
                    
                    if (newPassword.length < 6) {
                        iziToast.error({
                            title: 'Error',
                            message: 'Kata sandi minimal 6 karakter',
                            position: 'topRight'
                        });
                        return;
                    }
                    
                    showButtonLoading('changePasswordBtn', true);
                    
                    var formData = new FormData();
                    formData.append('action', 'changePassword');
                    formData.append('currentPassword', currentPassword);
                    formData.append('newPassword', newPassword);
                    formData.append('confirmPassword', confirmPassword);
                    
                    fetch('profile', {
                        method: 'POST',
                        body: formData
                    })
                    .then(function(response) { return response.json(); })
                    .then(function(data) {
                        if (data.success) {
                            iziToast.success({
                                title: 'Berhasil',
                                message: data.message,
                                position: 'topRight'
                            });
                            
                            // Close modal and reset form
                            var modal = bootstrap.Modal.getInstance(document.getElementById('changePasswordModal'));
                            if (modal) modal.hide();
                            passwordForm.reset();
                        } else {
                            iziToast.error({
                                title: 'Error',
                                message: data.message,
                                position: 'topRight'
                            });
                        }
                    })
                    .catch(function(error) {
                        console.error('Error changing password:', error);
                        iziToast.error({
                            title: 'Error',
                            message: 'Gagal mengubah kata sandi',
                            position: 'topRight'
                        });
                    })
                    .finally(function() {
                        showButtonLoading('changePasswordBtn', false);
                    });
                });
            }
            
            // Address Form 
            var addressForm = document.getElementById('addressForm');
            if (addressForm) {
                addressForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    
                    var addressId = document.getElementById('addressId').value;
                    var isEdit = addressId && addressId !== '';
                    
                    showButtonLoading('saveAddressButton', true);
                    
                    var formData = new FormData();
                    formData.append('action', isEdit ? 'updateAddress' : 'addAddress');
                    if (isEdit) {
                        formData.append('addressId', addressId);
                    }
                    formData.append('province', document.getElementById('addressProvince').value.trim());
                    formData.append('city', document.getElementById('addressCity').value.trim());
                    formData.append('district', document.getElementById('addressDistrict').value.trim());
                    formData.append('postalCode', document.getElementById('addressPostalCode').value.trim());
                    formData.append('fullAddress', document.getElementById('addressDetail').value.trim());
                    formData.append('isDefault', document.getElementById('addressIsDefault').checked);
                    
                    fetch('profile', {
                        method: 'POST',
                        body: formData
                    })
                    .then(function(response) { return response.json(); })
                    .then(function(data) {
                        if (data.success) {
                            iziToast.success({
                                title: 'Berhasil',
                                message: data.message,
                                position: 'topRight'
                            });
                            
                            // Close modal and reload addresses
                            var modal = bootstrap.Modal.getInstance(document.getElementById('addressModal'));
                            if (modal) modal.hide();
                            loadAddresses();
                        } else {
                            iziToast.error({
                                title: 'Error',
                                message: data.message,
                                position: 'topRight'
                            });
                        }
                    })
                    .catch(function(error) {
                        console.error('Error saving address:', error);
                        iziToast.error({
                            title: 'Error',
                            message: 'Gagal menyimpan alamat',
                            position: 'topRight'
                        });
                    })
                    .finally(function() {
                        showButtonLoading('saveAddressButton', false);
                    });
                });
            }
            
            // Delete confirmation 
            var confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
            if (confirmDeleteBtn) {
                confirmDeleteBtn.addEventListener('click', function() {
                    if (currentAddressId) {
                        deleteAddressConfirmed(currentAddressId);
                    }
                });
            }
        }
        
        // Load addresses 
        function loadAddresses() {
            fetch('profile?action=getAddresses')
                .then(function(response) { return response.json(); })
                .then(function(data) {
                    if (data.success) {
                        displayAddresses(data.data);
                    } else {
                        console.error('Failed to load addresses:', data.message);
                        displayAddresses([]);
                    }
                })
                .catch(function(error) {
                    console.error('Error loading addresses:', error);
                    displayAddresses([]);
                });
        }
        
        function displayAddresses(addresses) {
            var container = document.getElementById('addressContainer');
            if (!container) return;
            
            container.innerHTML = '';
            
            if (addresses.length === 0) {
                // Menggunakan empty state dari new
                container.innerHTML = 
                    '<div class="text-center py-5">' +
                        '<i class="bi bi-geo-alt text-muted" style="font-size: 3rem;"></i>' +
                        '<h5 class="mt-3 text-muted">Belum ada alamat tersimpan</h5>' +
                        '<p class="text-muted">Tambahkan alamat untuk mempermudah proses checkout.</p>' +
                    '</div>';
                return;
            }
            
            for (var i = 0; i < addresses.length; i++) {
                var addressCard = createAddressCard(addresses[i]);
                container.appendChild(addressCard);
            }
        }
        
        function createAddressCard(address) {
            var card = document.createElement('div');
            card.className = 'address-card';
            
            var addressParts = [
                address.fullAddress,
                address.district,
                address.city,
                address.province,
                address.postalCode
            ];
            
            var fullAddressText = '';
            for (var i = 0; i < addressParts.length; i++) {
                if (addressParts[i] && addressParts[i].trim() !== '') {
                    if (fullAddressText !== '') fullAddressText += ', ';
                    fullAddressText += addressParts[i];
                }
            }
            
            var badgeHtml = address.isDefault ? '<span class="badge bg-primary mt-2">Alamat Utama</span>' : '';
            
            card.innerHTML = 
                '<div class="d-flex justify-content-between align-items-start">' +
                    '<div class="flex-grow-1">' +
                        '<h6>' + (address.fullAddress || 'Alamat tidak tersedia') + '</h6>' +
                        '<p class="mb-1 text-muted">' + fullAddressText + '</p>' +
                        badgeHtml +
                    '</div>' +
                    '<div class="dropdown">' +
                        '<button class="btn btn-outline-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown">' +
                            '<i class="bi bi-three-dots-vertical"></i>' +
                        '</button>' +
                        '<ul class="dropdown-menu">' +
                            '<li><a class="dropdown-item" href="#" onclick="editAddress(' + address.addressId + ')"><i class="bi bi-pencil me-2"></i>Edit</a></li>' +
                            (address.isDefault ? '' : '<li><a class="dropdown-item" href="#" onclick="setDefaultAddress(' + address.addressId + ')"><i class="bi bi-star me-2"></i>Jadikan Utama</a></li>') +
                            (address.isDefault ? '' : '<li><a class="dropdown-item text-danger" href="#" onclick="deleteAddress(' + address.addressId + ')"><i class="bi bi-trash me-2"></i>Hapus</a></li>') +
                        '</ul>' +
                    '</div>' +
                '</div>';
            
            return card;
        }
   
        function openAddressModal(mode, addressData) {
            var modal = document.getElementById('addressModal');
            var modalTitle = document.getElementById('addressModalLabel');
            var form = document.getElementById('addressForm');
            
            if (!modal || !modalTitle || !form) return;
            
            // Reset form
            form.reset();
            document.getElementById('addressId').value = '';
            
            if (mode === 'add') {
                modalTitle.textContent = 'Tambah Alamat';
            } else if (mode === 'edit' && addressData) {
                modalTitle.textContent = 'Edit Alamat';
                document.getElementById('addressId').value = addressData.addressId;
                document.getElementById('addressProvince').value = addressData.province || '';
                document.getElementById('addressCity').value = addressData.city || '';
                document.getElementById('addressDistrict').value = addressData.district || '';
                document.getElementById('addressPostalCode').value = addressData.postalCode || '';
                document.getElementById('addressDetail').value = addressData.fullAddress || '';
                document.getElementById('addressIsDefault').checked = addressData.isDefault || false;
            }
        }
        
        function editAddress(addressId) {
            fetch('profile?action=getAddresses')
                .then(function(response) { return response.json(); })
                .then(function(data) {
                    if (data.success) {
                        var address = null;
                        for (var i = 0; i < data.data.length; i++) {
                            if (data.data[i].addressId === addressId) {
                                address = data.data[i];
                                break;
                            }
                        }
                        if (address) {
                            openAddressModal('edit', address);
                            new bootstrap.Modal(document.getElementById('addressModal')).show();
                        }
                    }
                })
                .catch(function(error) {
                    console.error('Error loading address:', error);
                    iziToast.error({
                        title: 'Error',
                        message: 'Gagal memuat data alamat',
                        position: 'topRight'
                    });
                });
        }
        
        function deleteAddress(addressId) {
            currentAddressId = addressId;
            new bootstrap.Modal(document.getElementById('deleteConfirmModal')).show();
        }
        
        function deleteAddressConfirmed(addressId) {
            showButtonLoading('confirmDeleteBtn', true);
            
            var formData = new FormData();
            formData.append('action', 'deleteAddress');
            formData.append('addressId', addressId);
            
            fetch('profile', {
                method: 'POST',
                body: formData
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success) {
                    iziToast.success({
                        title: 'Berhasil',
                        message: data.message,
                        position: 'topRight'
                    });
                    var modal = bootstrap.Modal.getInstance(document.getElementById('deleteConfirmModal'));
                    if (modal) modal.hide();
                    loadAddresses();
                } else {
                    iziToast.error({
                        title: 'Error',
                        message: data.message,
                        position: 'topRight'
                    });
                }
            })
            .catch(function(error) {
                console.error('Error deleting address:', error);
                iziToast.error({
                    title: 'Error',
                    message: 'Gagal menghapus alamat',
                    position: 'topRight'
                });
            })
            .finally(function() {
                showButtonLoading('confirmDeleteBtn', false);
                currentAddressId = null;
            });
        }
        
        function setDefaultAddress(addressId) {
            var formData = new FormData();
            formData.append('action', 'setDefaultAddress');
            formData.append('addressId', addressId);
            
            fetch('profile', {
                method: 'POST',
                body: formData
            })
            .then(function(response) { return response.json(); })
            .then(function(data) {
                if (data.success) {
                    iziToast.success({
                        title: 'Berhasil',
                        message: data.message,
                        position: 'topRight'
                    });
                    loadAddresses();
                } else {
                    iziToast.error({
                        title: 'Error',
                        message: data.message,
                        position: 'topRight'
                    });
                }
            })
            .catch(function(error) {
                console.error('Error setting default address:', error);
                iziToast.error({
                    title: 'Error',
                    message: 'Gagal mengatur alamat utama',
                    position: 'topRight'
                });
            });
        }
        
        // Navigation 
        function showSection(section) {
            var sections = ["akun", "transaksi", "alamat"];
            for (var i = 0; i < sections.length; i++) {
                var element = document.getElementById(sections[i]);
                if (element) {
                    element.style.display = sections[i] === section ? "block" : "none";
                }
            }
            
            var navItems = document.querySelectorAll(".profile-nav-item");
            for (var i = 0; i < navItems.length; i++) {
                navItems[i].classList.remove("active");
                if (navItems[i].textContent.toLowerCase().trim().includes(section)) {
                    navItems[i].classList.add("active");
                }
            }
            
            // Update URL hash
            window.history.replaceState(null, null, '#' + section);
            
            // Load addresses when alamat section is shown
            if (section === 'alamat') {
                loadAddresses();
            }
        }
        
        function formatDate(dateString) {
            if (!dateString) return '';
            try {
                var date = new Date(dateString);
                return date.toLocaleDateString('id-ID', {
                    day: 'numeric',
                    month: 'long',
                    year: 'numeric'
                });
            } catch (error) {
                return dateString;
            }
        }
        
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
    </script>
</body>
</html>