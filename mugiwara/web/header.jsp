<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../session.jsp" %>

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

<script>
document.addEventListener('DOMContentLoaded', function () {
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

    // Category selection functionality
    const categoryItems = document.querySelectorAll('.dropdown-item[href*="category"]');
    const categoryText = document.getElementById('categoryText');
    const categoryButton = document.getElementById('dropdownMenuButton');
    
    categoryItems.forEach(item => {
        item.addEventListener('click', function(e) {
            const selectedCategory = this.textContent.trim();
            categoryText.textContent = selectedCategory;
            categoryButton.classList.add('selected');
        });
    });
});
</script>
