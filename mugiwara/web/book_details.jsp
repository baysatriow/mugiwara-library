<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Book Detail - Mugiwara Library</title>
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

    <!-- Breadcrumb -->
    <div class="breadcrumb-container">
        <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='currentColor'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
            <ol class="breadcrumb d-flex">
                <li class="breadcrumb-item"><a href="."><strong>Home</strong></a></li>
                <li class="breadcrumb-item active" aria-current="page">Laut Bercerita</li>
            </ol>
        </nav>
    </div>

    <!-- Detail Buku -->
    <section class="container my-4">
        <div class="book-detail-container">
            <div class="d-flex flex-column align-items-center">
                <img src="assets/images/Laut Bercerita.jpg" alt="Cover Laut Bercerita" class="book-detail-image" />
                <button class="btn-primary mt-3 d-flex align-items-center justify-content-center gap-2">
                    <strong>Tambah ke Keranjang</strong> 
                    <i class="bi bi-cart fs-6"></i>
                </button>
            </div>
            <!-- Detail Buku -->
            <div class="col-md">
                <!-- Judul + Harga -->
                <div class="book-detail-header">
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <div>
                            <h3 class="fw-bold mb-1">Laut Bercerita</h3>
                            <div class="fw-bold text-danger small">by Leila S. Chudori</div>
                        </div>
                        <div class="book-detail-price">
                            <div class="h5 fw-bold">Rp142.500</div>
                        </div>
                    </div>
                </div>
                
                <div class="book-detail-section-title">Detail Buku</div>
                <div class="book-meta-grid">
                    <div class="book-meta-item">
                        <div class="book-meta-label">Penerbit</div>
                        <div class="book-meta-value">Kepustakaan Populer Gramedia</div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Tanggal Terbit</div>
                        <div class="book-meta-value">3 Agustus 2022</div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">ISBN</div>
                        <div class="book-meta-value">9786024818722</div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Halaman</div>
                        <div class="book-meta-value">400</div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Bahasa</div>
                        <div class="book-meta-value">Indonesia</div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Panjang</div>
                        <div class="book-meta-value">20 cm</div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Lebar</div>
                        <div class="book-meta-value">13.5 cm</div>
                    </div>
                    <div class="book-meta-item">
                        <div class="book-meta-label">Berat</div>
                        <div class="book-meta-value">460 gram</div>
                    </div>
                </div>
            
                <!-- Sinopsis -->
                <div class="book-detail-section-title">Deskripsi Buku</div>   
                
                <p id="sinopsis" class="book-synopsis synopsis-collapsed">
                    Buku ini terdiri atas dua bagian. Bagian pertama mengambil sudut pandang seorang mahasiswa aktivis bernama Laut, menceritakan bagaimana Laut dan kawan-kawannya menyusun rencana, berpindah-pindah dalam pelarian, hingga tertangkap oleh pasukan rahasia. Sedangkan bagian kedua dikisahkan oleh Asmara, adik Laut. Bagian kedua mewakili perasaan keluarga korban penghilangan paksa, bagaimana pencarian mereka terhadap kerabat mereka yang tak pernah kembali.
                </p>
                <button id="toggleBtn" class="toggle-synopsis-btn">
                    <strong>Baca selengkapnya</strong>
                    <i id="toggleIcon" class="bi bi-chevron-down ms-1"></i>
                </button>
            </div>
        </div>
    </section>  

    <!-- Author's Books -->
    <section class="container my-5">
        <div class="section-header">
            <h4>Intip Karya Leila S. Chudori Lainnya...</h4>
            <p><a href="#">Lihat Semua</a></p>
        </div>
        
        <div id="authorBooks" class="carousel slide book-carousel-container author-books-carousel" data-bs-ride="carousel">
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <div class="book-list">
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Laut Bercerita</p>
                                <strong class="book-price">Rp142.500</strong>
                            </div>
                        </div>
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Pulang</p>
                                <strong class="book-price">Rp125.000</strong>
                            </div>
                        </div>
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">9 dari Nadira</p>
                                <strong class="book-price">Rp98.000</strong>
                            </div>
                        </div>
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Malam Terakhir</p>
                                <strong class="book-price">Rp89.000</strong>
                            </div>
                        </div>
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Kumpulan Cerpen</p>
                                <strong class="book-price">Rp75.000</strong>
                            </div>
                        </div>
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Anak-Anak Revolusi</p>
                                <strong class="book-price">Rp110.000</strong>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="carousel-item">
                    <div class="book-list">
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Senja dan Cinta yang Berdarah</p>
                                <strong class="book-price">Rp95.000</strong>
                            </div>
                        </div>
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Untuk Anakku Tersayang</p>
                                <strong class="book-price">Rp85.000</strong>
                            </div>
                        </div>
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Catatan Pinggir</p>
                                <strong class="book-price">Rp70.000</strong>
                            </div>
                        </div>
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Perempuan Berkalung Sorban</p>
                                <strong class="book-price">Rp92.000</strong>
                            </div>
                        </div>
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Rumah Kaca</p>
                                <strong class="book-price">Rp105.000</strong>
                            </div>
                        </div>
                        <div class="book-card">
                            <img src="assets/images/Laut Bercerita.jpg" class="book-cover" alt="Laut Bercerita">
                            <div class="book-body">
                                <h6 class="book-author">Leila S. Chudori</h6>
                                <p class="book-title">Jejak Langkah</p>
                                <strong class="book-price">Rp88.000</strong>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#authorBooks" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#authorBooks" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#authorBooks" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#authorBooks" data-bs-slide-to="1" aria-label="Slide 2"></button>
            </div>
        </div>
    </section>  

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 Isekai Byte - Mugiwara Library. All rights reserved.</p>
    </footer>

    <!-- Scripts -->
    <script>
        const sinopsis = document.getElementById("sinopsis");
        const toggleBtn = document.getElementById("toggleBtn");
        const toggleIcon = document.getElementById("toggleIcon");
        
        toggleBtn.addEventListener("click", () => {
            const isCollapsed = sinopsis.classList.contains("synopsis-collapsed");
            sinopsis.classList.toggle("synopsis-collapsed", !isCollapsed);
            sinopsis.classList.toggle("synopsis-expanded", isCollapsed);
            toggleBtn.querySelector("strong").textContent = isCollapsed ? "Sembunyikan" : "Baca selengkapnya";
            toggleIcon.className = isCollapsed ? "bi bi-chevron-up ms-1" : "bi bi-chevron-down ms-1";
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
        });
    </script>
</body>
</html>
