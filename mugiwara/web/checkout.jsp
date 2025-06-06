<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

    <div class="cart-container">
        <h4>Checkout</h4>
        
        <div class="checkout-layout">
            <div class="checkout-left">
                <!-- Address Section -->
                <div class="checkout-section">
                    <div class="border rounded p-4">
                        <h6 class="mb-3"><strong>Alamat Pengiriman</strong></h6>
                        <button id="address-button" class="btn-primary d-flex align-items-center" data-bs-toggle="modal" data-bs-target="#modalPilihAlamat">
                            Pilih alamat pengiriman
                        </button>
                    </div>
                </div>
                
                <!-- Payment Method Section -->
                <div class="checkout-section">
                    <div class="border rounded p-4 payment-section">
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
                
                <!-- Order Section -->
                <div class="checkout-section">
                    <div class="order-box shadow-box">
                        <h5 class="order-heading"><strong>Pesanan</strong></h5>
                        <hr />
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
                    </div>
                </div>
            </div>
            
            <div class="checkout-right">
                <div class="summary-box shadow-box">
                    <h6 class="mb-3"><strong>Ringkasan Barang</strong></h6>
                    <div class="d-flex justify-content-between">
                        <span>Total Harga (<span id="item-count">1 Barang</span>)</span>
                        <span>Rp<span id="total-price">142.500</span></span>
                    </div>
                    <div class="d-flex justify-content-between text-danger mb-2">
                        <span>Total Biaya Pengiriman</span>
                        <span>Rp0</span>
                    </div>
                    <hr />
                    <div class="d-flex justify-content-between fw-bold">
                        <span>Subtotal</span>
                        <span>Rp<span id="subtotal">142.500</span></span>
                    </div>
                    <button id="payButton" class="btn-secondary btn-block mt-3" disabled>Bayar</button>
                </div>
            </div>            
        </div>
    </div>

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
                    <button class="btn-close" data-bs-dismiss="modal"></button>
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
                    <button class="btn-secondary" id="btnGunakanAlamat" disabled>Gunakan</button>
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
                    <button class="btn-close" data-bs-dismiss="modal"></button>
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