<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="session.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Checkout - Mugiwara Library</title>
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

    <main class="container my-4">
        <h4>Checkout</h4>
        
        <div class="row g-4 mt-2">
            <!-- Left Column: Details -->
            <div class="col-lg-8">
                <div class="d-flex flex-column gap-4">
                    <!-- Address Section -->
                    <div id="address-section" class="checkout-section">
                        <div class="d-flex justify-content-between align-items-center mb-2">
                             <h6 class="mb-0"><strong>Alamat Pengiriman</strong></h6>
                             <a href="#" class="fw-bold text-decoration-none" style="color: #ae2831;" data-bs-toggle="modal" data-bs-target="#modalPilihAlamat">Ubah Alamat</a>
                        </div>
                        <div id="selected-address-display">
                            <p class="text-muted">Pilih alamat pengiriman Anda terlebih dahulu.</p>
                        </div>
                    </div>

                    <!-- Order Items Section -->
                    <div class="checkout-section">
                        <h6 class="mb-3"><strong>Pesanan Anda</strong></h6>
                        <div class="order-item">
                            <div class="order-info-left">
                                <img src="assets/images/Laut Bercerita.jpg" alt="Laut Bercerita" />
                                <div class="item-details">
                                    <div class="book-title">Laut Bercerita</div>
                                    <div class="book-qty text-muted">1 barang</div>
                                </div>
                            </div>
                            <div class="order-price">
                                <strong>Rp142.500</strong>
                            </div>
                        </div>
                        <!-- Add more order items here if needed -->
                    </div>

                    <!-- Payment Method Section -->
                    <div class="checkout-section">
                        <h6 class="mb-3"><strong>Metode Pembayaran</strong></h6>
                        <div class="payment-methods">
                            <label class="payment-option">
                                <div class="payment-left">
                                    <img src="assets/images/bca.png" alt="BCA" />
                                    <span>BCA Virtual Account</span>
                                </div>
                                <input type="radio" name="payment" />
                                <span class="custom-radio"></span>
                            </label>
                            <label class="payment-option">
                                <div class="payment-left">
                                    <img src="assets/images/bri.png" alt="BRI" />
                                    <span>BRI Virtual Account</span>
                                </div>
                                <input type="radio" name="payment" />
                                <span class="custom-radio"></span>
                            </label>
                            <label class="payment-option">
                                <div class="payment-left">
                                    <img src="assets/images/mandiri.png" alt="Mandiri" />
                                    <span>Mandiri Virtual Account</span>
                                </div>
                                <input type="radio" name="payment" />
                                <span class="custom-radio"></span>
                            </label>
                            <label class="payment-option">
                                <div class="payment-left">
                                    <img src="assets/images/qris.png" alt="QRIS" />
                                    <span>QRIS</span>
                                </div>
                                <input type="radio" name="payment" />
                                <span class="custom-radio"></span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Right Column: Summary -->
            <div class="col-lg-4">
                <div class="checkout-summary-sticky">
                    <div class="checkout-section">
                        <h6 class="mb-3"><strong>Ringkasan Belanja</strong></h6>
                        <div class="d-flex justify-content-between">
                            <span>Total Harga (<span id="item-count">1 Barang</span>)</span>
                            <span>Rp<span id="total-price">142.500</span></span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Biaya Pengiriman</span>
                            <span>Rp<span id="shipping-cost">0</span></span>
                        </div>
                        <hr />
                        <div class="d-flex justify-content-between fw-bold fs-5">
                            <span>Subtotal</span>
                            <span>Rp<span id="subtotal">142.500</span></span>
                        </div>
                        <button id="payButton" class="btn-primary btn-block mt-3" disabled>Bayar Sekarang</button>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <!-- Modal Pilih Alamat -->
    <div class="modal fade" id="modalPilihAlamat" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Pilih Alamat Pengiriman</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div id="daftar-alamat" class="d-flex flex-column gap-2">
                        <!-- Address list will be populated by JS -->
                    </div>
                    <div id="kosong" class="text-center py-5">
                        <img src="assets/images/emptyCartFeedback.png" alt="Alamat kosong" width="150">
                        <p class="mt-3 text-muted">Belum ada alamat tersimpan. Tambahkan dulu ya!</p>
                    </div>
                </div>
                <div class="modal-footer justify-content-between">
                    <button class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#modalTambahAlamat">
                        <i class="bi bi-plus-circle me-1"></i> Tambah Alamat
                    </button>
                    <button class="btn btn-secondary" id="btnGunakanAlamat" disabled>Gunakan Alamat Ini</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Tambah Alamat -->
    <div class="modal fade" id="modalTambahAlamat" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <form id="formTambahAlamat" class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Tambah Alamat Baru</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="text" class="form-control mb-2" name="nama" placeholder="Nama Penerima" required>
                    <input type="text" class="form-control mb-2" name="telepon" placeholder="Nomor Telepon" required>
                    <textarea class="form-control mb-2" name="alamat" placeholder="Alamat lengkap" rows="2" required></textarea>
                    <input type="text" class="form-control mb-2" name="kecamatan" placeholder="Kecamatan" required>
                    <input type="text" class="form-control mb-2" name="kabupaten" placeholder="Kabupaten/Kota" required>
                    <input type="text" class="form-control mb-2" name="provinsi" placeholder="Provinsi" required>
                    <input type="text" class="form-control mb-2" name="kodepos" placeholder="Kode Pos" required>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn-primary">Simpan</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script>
        let alamatList = [];
        
        // Save address from form
        document.getElementById("formTambahAlamat").addEventListener("submit", function (e) {
            e.preventDefault();
            const form = e.target;
            const data = {
                nama: form.nama.value,
                telepon: form.telepon.value,
                alamat: form.alamat.value,
                kecamatan: form.kecamatan.value,
                kabupaten: form.kabupaten.value,
                provinsi: form.provinsi.value,
                kodepos: form.kodepos.value,
            };
            alamatList.push(data);
            form.reset();
            
            // Close add modal, open select modal
            const modalTambah = bootstrap.Modal.getInstance(document.getElementById("modalTambahAlamat"));
            modalTambah.hide();
            const modalPilih = new bootstrap.Modal(document.getElementById("modalPilihAlamat"));
            modalPilih.show();
            renderAlamat();
        });

        // Render address list
        function renderAlamat() {
            const container = document.getElementById("daftar-alamat");
            const kosong = document.getElementById("kosong");
            container.innerHTML = "";
            
            if (alamatList.length === 0) {
                kosong.style.display = "block";
                return;
            }
            
            kosong.style.display = "none";
            alamatList.forEach((item, i) => {
                const addressHtml = `
                    <label class="border rounded p-3 d-flex align-items-start gap-2">
                        <input type="radio" name="alamatRadio" value="${i}" class="mt-1">
                        <div>
                            <strong>${item.nama}</strong> | <strong>${item.telepon}</strong><br>
                            ${item.alamat}, ${item.kecamatan}, ${item.kabupaten}, ${item.provinsi}, ${item.kodepos}
                        </div>
                    </label>
                `;
                container.innerHTML += addressHtml;
            });
        }

        // Use selected address
        document.getElementById("btnGunakanAlamat").addEventListener("click", function () {
            const selected = document.querySelector("input[name='alamatRadio']:checked");
            if (!selected) return alert("Pilih alamat dulu ya~");
            
            const data = alamatList[selected.value];
            const displayHtml = `
                <div class="d-flex justify-content-between">
                    <h6><strong>Alamat Pengiriman</strong></h6>
                    <a href="#" class="text-dark fw-bold" data-bs-toggle="modal" data-bs-target="#modalPilihAlamat">Ubah Alamat</a>
                </div>
                <p><strong>${data.nama}</strong> | <strong>${data.telepon}</strong><br>
                ${data.alamat}, ${data.kecamatan}, ${data.kabupaten}, ${data.provinsi}, ${data.kodepos}</p>
            `;
            document.querySelector(".checkout-section .border").innerHTML = displayHtml;
            
            const modal = bootstrap.Modal.getInstance(document.getElementById("modalPilihAlamat"));
            modal.hide();
            updatePayButtonState();
        });

        // Enable use button when address is selected
        document.addEventListener("change", function (e) {
            if (e.target.name === "alamatRadio") {
                const btnGunakan = document.getElementById("btnGunakanAlamat");
                btnGunakan.disabled = false;
                btnGunakan.classList.remove("btn-secondary");
                btnGunakan.classList.add("btn-primary");
            }
        });

        // Update pay button state
        function updatePayButtonState() {
            const payButton = document.getElementById("payButton");
            const alamatSection = document.querySelector(".checkout-section .border");
            const hasAlamat = alamatSection && alamatSection.querySelector("p");
            const selectedPayment = document.querySelector('input[name="payment"]:checked');
            const hasPayment = !!selectedPayment;
            
            if (hasAlamat && hasPayment) {
                payButton.disabled = false;
                payButton.classList.remove("btn-secondary");
                payButton.classList.add("btn-primary");
            } else {
                payButton.disabled = true;
                payButton.classList.remove("btn-primary");
                payButton.classList.add("btn-secondary");
            }
        }

        // Check when payment method is selected
        document.querySelectorAll('input[name="payment"]').forEach(radio => {
            radio.addEventListener("change", updatePayButtonState);
        });

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

            // Initialize
            updatePayButtonState();
        });
    </script>
</body>
</html>