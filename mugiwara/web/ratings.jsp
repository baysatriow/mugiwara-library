<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Apa Kata Customer - Mugiwara Library</title>
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
                <li class="breadcrumb-item active" aria-current="page">Apa Kata Customer</li>
            </ol>
        </nav>
    </div>

    <!-- Reviews Content -->
    <main>
        <div class="reviews-container">
            <h4>Apa Kata Customer</h4>
            <div class="review-list">
                <div class="review-item">
                    <p class="date">30 Februari 2025</p>
                    <p class="name">Sakamoto Taro</p>
                    <div class="stars">★★★★★</div>
                    <p class="comment">
                        <em>"Buku-buku nya sangat wow sekali, proses checkout juga sangat mudah, desain webnya juga mudah dimengerti dan koleksi bukunya sangat lengkap. Pengiriman juga cepat dan packaging rapi!"</em>
                    </p>
                </div>
                
                <div class="review-item">
                    <p class="date">28 Februari 2025</p>
                    <p class="name">Yuki Tanaka</p>
                    <div class="stars">★★★★★</div>
                    <p class="comment">
                        <em>"Pelayanan customer service sangat responsif dan membantu. Harga buku-buku di sini juga sangat kompetitif. Pasti akan belanja lagi di sini!"</em>
                    </p>
                </div>
                
                <div class="review-item">
                    <p class="date">25 Februari 2025</p>
                    <p class="name">Hiroshi Sato</p>
                    <div class="stars">★★★★☆</div>
                    <p class="comment">
                        <em>"Website yang user-friendly dengan koleksi buku yang sangat lengkap. Proses pembelian mudah dan aman. Hanya saja pengiriman agak lama karena cuaca buruk."</em>
                    </p>
                </div>
                
                <div class="review-item">
                    <p class="date">22 Februari 2025</p>
                    <p class="name">Akiko Yamamoto</p>
                    <div class="stars">★★★★★</div>
                    <p class="comment">
                        <em>"Kualitas buku sangat bagus, tidak ada yang rusak atau cacat. Packaging juga sangat aman. Terima kasih Mugiwara Library!"</em>
                    </p>
                </div>
                
                <div class="review-item">
                    <p class="date">20 Februari 2025</p>
                    <p class="name">Kenji Nakamura</p>
                    <div class="stars">★★★★★</div>
                    <p class="comment">
                        <em>"Sangat puas dengan pelayanan dan kualitas buku. Rekomendasi buku dari website ini juga sangat akurat sesuai dengan preferensi saya."</em>
                    </p>
                </div>
                
                <div class="review-item">
                    <p class="date">18 Februari 2025</p>
                    <p class="name">Mei Suzuki</p>
                    <div class="stars">★★★★☆</div>
                    <p class="comment">
                        <em>"Koleksi buku sangat lengkap dan update. Website mudah digunakan. Hanya perlu ditingkatkan lagi untuk variasi metode pembayaran."</em>
                    </p>
                </div>
                
                <div class="review-item">
                    <p class="date">15 Februari 2025</p>
                    <p class="name">Takeshi Yamada</p>
                    <div class="stars">★★★★★</div>
                    <p class="comment">
                        <em>"Pengalaman berbelanja yang sangat menyenangkan. Dari browsing hingga checkout semuanya lancar. Buku sampai dengan kondisi sempurna!"</em>
                    </p>
                </div>
                
                <div class="review-item">
                    <p class="date">12 Februari 2025</p>
                    <p class="name">Rina Watanabe</p>
                    <div class="stars">★★★★★</div>
                    <p class="comment">
                        <em>"Mugiwara Library adalah toko buku online terbaik yang pernah saya coba. Pelayanan excellent, harga terjangkau, dan kualitas terjamin!"</em>
                    </p>
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
