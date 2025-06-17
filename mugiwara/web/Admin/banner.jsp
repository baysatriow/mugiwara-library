<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.*"%>
<%@page import="DAO.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%
    // Get data from request attributes
    ArrayList<BannerSlide> banners = (ArrayList<BannerSlide>) request.getAttribute("banners");
    ArrayList<BannerSlide> activeBanners = (ArrayList<BannerSlide>) request.getAttribute("activeBanners");
    Integer totalBanners = (Integer) request.getAttribute("totalBanners");
    Integer totalActiveBanners = (Integer) request.getAttribute("totalActiveBanners");
    Integer totalInactiveBanners = (Integer) request.getAttribute("totalInactiveBanners");
    String currentFilter = (String) request.getAttribute("currentFilter");
    
    // Pagination variables
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer totalItems = (Integer) request.getAttribute("totalItems");
    
    // Initialize if null
    if (banners == null) banners = new ArrayList<>();
    if (activeBanners == null) activeBanners = new ArrayList<>();
    if (totalBanners == null) totalBanners = 0;
    if (totalActiveBanners == null) totalActiveBanners = 0;
    if (totalInactiveBanners == null) totalInactiveBanners = 0;
    if (currentPage == null) currentPage = 1;
    if (totalPages == null) totalPages = 1;
    if (totalItems == null) totalItems = banners.size();
    if (currentFilter == null) currentFilter = "";
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm");
%>

<div class="main-content">
    <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
        <div class="breadcrumb-title pe-3">Banner Management</div>
        <div class="ps-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 p-0">
                    <li class="breadcrumb-item"><a href="../Admin?page=home"><i class="bx bx-home-alt"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Banner Slide</li>
                </ol>
            </nav>
        </div>
        <div class="ms-auto">
            <div class="btn-group">
                <button type="button" class="btn btn-custom-lainnya" data-bs-toggle="modal" data-bs-target="#addBannerModal">
                    <i class="bi bi-plus-circle me-2"></i>Tambah Banner
                </button>
            </div>
        </div>
    </div>

    <!-- Statistics Cards -->
    <div class="row g-3 mb-4">
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-grow-1">
                            <p class="text-secondary mb-1">Total Banner</p>
                            <h4 class="mb-0"><%= totalBanners %></h4>
                        </div>
                        <div class="widgets-icons bg-light-primary text-primary">
                            <i class="bi bi-image"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-grow-1">
                            <p class="text-secondary mb-1">Banner Aktif</p>
                            <h4 class="mb-0 text-success"><%= totalActiveBanners %></h4>
                        </div>
                        <div class="widgets-icons bg-light-success text-success">
                            <i class="bi bi-check-circle"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-grow-1">
                            <p class="text-secondary mb-1">Banner Non-Aktif</p>
                            <h4 class="mb-0 text-warning"><%= totalInactiveBanners %></h4>
                        </div>
                        <div class="widgets-icons bg-light-warning text-warning">
                            <i class="bi bi-x-circle"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-12 col-sm-6 col-lg-3">
            <div class="card">
                <div class="card-body">
                    <div class="d-flex align-items-center">
                        <div class="flex-grow-1">
                            <p class="text-secondary mb-1">Status System</p>
                            <h4 class="mb-0 text-info">Online</h4>
                        </div>
                        <div class="widgets-icons bg-light-info text-info">
                            <i class="bi bi-globe"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Filter and Search -->
    <div class="product-count d-flex align-items-center gap-3 gap-lg-4 mb-4 fw-medium flex-wrap font-text1">
        <a href="../Admin?page=banner" class="<%= currentFilter.isEmpty() ? "text-primary" : "" %>">
            <span class="me-1">Semua</span><span class="text-secondary">(<%= totalBanners %>)</span>
        </a>
        <a href="../Admin?page=banner&filter=active" class="<%= "active".equals(currentFilter) ? "text-primary" : "" %>">
            <span class="me-1">Aktif</span><span class="text-secondary">(<%= totalActiveBanners %>)</span>
        </a>
        <a href="../Admin?page=banner&filter=inactive" class="<%= "inactive".equals(currentFilter) ? "text-primary" : "" %>">
            <span class="me-1">Non-Aktif</span><span class="text-secondary">(<%= totalInactiveBanners %>)</span>
        </a>
    </div>

    <div class="row g-3 mb-4">
        <div class="col-auto">
            <div class="position-relative">
                <input class="form-control px-5" type="search" placeholder="Cari banner..." id="searchBanner">
                <span class="material-icons-outlined position-absolute ms-3 translate-middle-y start-0 top-50 fs-5">search</span>
            </div>
        </div>
        <div class="col-auto flex-grow-1 overflow-auto">
            <div class="btn-group position-static">
                <button type="button" class="btn btn-filter dropdown-toggle px-4" data-bs-toggle="dropdown">
                    <i class="bi bi-funnel me-2"></i>Filter Status
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="../Admin?page=banner">
                        <i class="bi bi-list me-2"></i>Semua Banner
                    </a></li>
                    <li><a class="dropdown-item" href="../Admin?page=banner&filter=active">
                        <i class="bi bi-check-circle me-2"></i>Banner Aktif
                    </a></li>
                    <li><a class="dropdown-item" href="../Admin?page=banner&filter=inactive">
                        <i class="bi bi-x-circle me-2"></i>Banner Non-Aktif
                    </a></li>
                </ul>
            </div>
        </div>
        <div class="col-auto">
            <div class="d-flex align-items-center gap-2 justify-content-lg-end">
                <button class="btn btn-filter px-4" onclick="refreshBanners()">
                    <i class="bi bi-arrow-clockwise me-2"></i>Refresh
                </button>
            </div>
        </div>
    </div>

    <!-- Banner Table -->
    <div class="card">
        <div class="card-body">
            <div class="product-table">
                <div class="table-responsive white-space-nowrap">
                    <table class="table align-middle table-hover" id="bannerTable">
                        <thead class="table-light">
                            <tr>
                                <th><input class="form-check-input" type="checkbox" id="selectAll"></th>
                                <th>Order</th>
                                <th>Preview</th>
                                <th>Banner Info</th>
                                <th>Link URL</th>
                                <th>Status</th>
                                <th>Schedule</th>
                                <th>Created</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (banners.isEmpty()) { %>
                            <tr>
                                <td colspan="9" class="text-center py-5">
                                    <div class="text-muted">
                                        <i class="bi bi-image fs-1 d-block mb-3 opacity-50"></i>
                                        <h5 class="mb-2">Belum ada banner</h5>
                                        <p class="mb-3">Mulai dengan menambahkan banner slide pertama Anda</p>
                                        <button class="btn btn-custom-lainnya" data-bs-toggle="modal" data-bs-target="#addBannerModal">
                                            <i class="bi bi-plus-circle me-2"></i>Tambah Banner Pertama
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <% } else { %>
                                <% for (BannerSlide banner : banners) { %>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox" value="<%= banner.getBannerID() %>"></td>
                                    <td>
                                        <span class="badge bg-secondary fs-6">#<%= banner.getOrder() %></span>
                                    </td>
                                    <td>
                                        <% if (banner.getImagePath() != null && !banner.getImagePath().isEmpty()) { %>
                                            <img src="../<%= banner.getImagePath() %>" alt="Banner" class="rounded shadow-sm" 
                                                 style="width: 80px; height: 50px; object-fit: cover; cursor: pointer;"
                                                 onclick="previewImage('../<%= banner.getImagePath() %>', '<%= banner.getTitle() %>')"
                                                 onerror="this.src='assets/images/default-banner.jpg'">
                                        <% } else { %>
                                            <div class="bg-light rounded d-flex align-items-center justify-content-center shadow-sm" 
                                                 style="width: 80px; height: 50px;">
                                                <i class="bi bi-image text-muted fs-4"></i>
                                            </div>
                                        <% } %>
                                    </td>
                                    <td>
                                        <div>
                                            <div class="fw-bold text-primary"><%= banner.getTitle() != null ? banner.getTitle() : "Untitled" %></div>
                                            <% if (banner.getDescription() != null && !banner.getDescription().isEmpty()) { %>
                                                <small class="text-muted">
                                                    <%= banner.getDescription().length() > 60 ? 
                                                        banner.getDescription().substring(0, 60) + "..." : 
                                                        banner.getDescription() %>
                                                </small>
                                            <% } else { %>
                                                <small class="text-muted fst-italic">No description</small>
                                            <% } %>
                                        </div>
                                    </td>
                                    <td>
                                        <% if (banner.getLinkUrl() != null && !banner.getLinkUrl().isEmpty()) { %>
                                            <a href="<%= banner.getLinkUrl() %>" target="_blank" class="text-decoration-none">
                                                <i class="bi bi-link-45deg me-1"></i>
                                                <span class="text-primary">View Link</span>
                                            </a>
                                        <% } else { %>
                                            <span class="text-muted">-</span>
                                        <% } %>
                                    </td>
                                    <td>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" 
                                                   <%= banner.isIsActive() ? "checked" : "" %>
                                                   onchange="toggleStatus(<%= banner.getBannerID() %>)"
                                                   title="<%= banner.isIsActive() ? "Klik untuk menonaktifkan" : "Klik untuk mengaktifkan" %>">
                                            <label class="form-check-label">
                                                <span class="badge bg-<%= banner.isIsActive() ? "success" : "secondary" %>">
                                                    <%= banner.isIsActive() ? "Aktif" : "Non-Aktif" %>
                                                </span>
                                            </label>
                                        </div>
                                    </td>
                                    <td>
                                        <% if (banner.getStartDate() != null || banner.getEndDate() != null) { %>
                                            <small class="text-muted">
                                                <% if (banner.getStartDate() != null) { %>
                                                    <i class="bi bi-calendar-event me-1"></i>
                                                    <%= banner.getStartDate().format(DateTimeFormatter.ofPattern("dd/MM/yy")) %>
                                                <% } %>
                                                <% if (banner.getEndDate() != null) { %>
                                                    <br><i class="bi bi-calendar-x me-1"></i>
                                                    <%= banner.getEndDate().format(DateTimeFormatter.ofPattern("dd/MM/yy")) %>
                                                <% } %>
                                            </small>
                                        <% } else { %>
                                            <small class="text-muted">
                                                <i class="bi bi-infinity me-1"></i>Permanent
                                            </small>
                                        <% } %>
                                    </td>
                                    <td>
                                        <small class="text-muted">
                                            <% if (banner.getCreateAt() != null) { %>
                                                <i class="bi bi-clock me-1"></i>
                                                <%= banner.getCreateAt().toLocalDateTime().format(DateTimeFormatter.ofPattern("dd MMM yy")) %>
                                            <% } else { %>
                                                -
                                            <% } %>
                                        </small>
                                    </td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-outline-secondary dropdown-toggle dropdown-toggle-nocaret"
                                                     type="button" data-bs-toggle="dropdown">
                                                <i class="bi bi-three-dots"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="javascript:;" 
                                                               onclick="viewBannerDetail(<%= banner.getBannerID() %>)">
                                                    <i class="bi bi-eye me-2"></i>Lihat Detail
                                                </a></li>
                                                <li><a class="dropdown-item" href="javascript:;" 
                                                               onclick="editBanner(<%= banner.getBannerID() %>)">
                                                    <i class="bi bi-pencil me-2"></i>Edit
                                                </a></li>
                                                <li><a class="dropdown-item" href="javascript:;" 
                                                               onclick="changeOrder(<%= banner.getBannerID() %>, <%= banner.getOrder() %>)">
                                                    <i class="bi bi-arrow-up-down me-2"></i>Ubah Urutan
                                                </a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-danger" href="javascript:;" 
                                                               onclick="deleteBanner(<%= banner.getBannerID() %>, '<%= banner.getTitle() != null ? banner.getTitle().replace("'", "\\'") : "Untitled" %>')">
                                                    <i class="bi bi-trash me-2"></i>Hapus
                                                </a></li>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                                <% } %>
                            <% } %>
                        </tbody>
                    </table>
                </div>
                
                <!-- Pagination -->
                <% if (totalPages > 1) { %>
                <div class="d-flex justify-content-between align-items-center mt-4">
                    <div class="text-muted">
                        Menampilkan <%= ((currentPage - 1) * 10) + 1 %> - <%= Math.min(currentPage * 10, totalItems) %> dari <%= totalItems %> banner
                    </div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination pagination-sm mb-0">
                            <% if (currentPage > 1) { %>
                            <li class="page-item">
                                <a class="page-link" href="../Admin?page=banner&pageNum=<%= currentPage - 1 %><%= !currentFilter.isEmpty() ? "&filter=" + currentFilter : "" %>">
                                    <i class="bi bi-chevron-left"></i>
                                </a>
                            </li>
                            <% } %>
                            
                            <% 
                            int startPage = Math.max(1, currentPage - 2);
                            int endPage = Math.min(totalPages, currentPage + 2);
                            
                            for (int i = startPage; i <= endPage; i++) { 
                            %>
                            <li class="page-item <%= i == currentPage ? "active" : "" %>">
                                <a class="page-link" href="../Admin?page=banner&pageNum=<%= i %><%= !currentFilter.isEmpty() ? "&filter=" + currentFilter : "" %>">
                                    <%= i %>
                                </a>
                            </li>
                            <% } %>
                            
                            <% if (currentPage < totalPages) { %>
                            <li class="page-item">
                                <a class="page-link" href="../Admin?page=banner&pageNum=<%= currentPage + 1 %><%= !currentFilter.isEmpty() ? "&filter=" + currentFilter : "" %>">
                                    <i class="bi bi-chevron-right"></i>
                                </a>
                            </li>
                            <% } %>
                        </ul>
                    </nav>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- Add Banner Modal -->
<div class="modal fade" id="addBannerModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-plus-circle me-2"></i>Tambah Banner Baru
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../BannerManagement" enctype="multipart/form-data" id="addBannerForm">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Title *</label>
                            <input type="text" class="form-control" name="title" required 
                                   placeholder="Masukkan judul banner">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Link URL <small class="text-muted">(Opsional)</small></label>
                            <input type="url" class="form-control" name="linkUrl" 
                                   placeholder="https://example.com">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" rows="3" 
                                      placeholder="Deskripsi banner (opsional)"></textarea>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Upload Image *</label>
                            <input type="file" class="form-control" name="imageFile" accept="image/*" 
                                   onchange="previewSelectedImage(this, 'addPreview')">
                            <div class="form-text">
                                <i class="bi bi-info-circle me-1"></i>
                                Format yang didukung: JPG, PNG, GIF, WebP. Maksimal 10MB.
                            </div>
                            <div class="mt-2">
                                <img id="addPreview" src="#" alt="Preview" style="max-width: 200px; max-height: 100px; display: none;" class="rounded border">
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-text text-muted mb-2">
                                <i class="bi bi-info-circle me-1"></i>
                                Atau masukkan path gambar manual:
                            </div>
                            <input type="text" class="form-control" name="imagePath" 
                                   placeholder="uploads/banners/banner1.jpg">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Start Date <small class="text-muted">(Opsional)</small></label>
                            <input type="datetime-local" class="form-control" name="startDate">
                            <div class="form-text">Tanggal mulai tampil</div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">End Date <small class="text-muted">(Opsional)</small></label>
                            <input type="datetime-local" class="form-control" name="endDate">
                            <div class="form-text">Tanggal berakhir tampil</div>
                        </div>
                        <div class="col-12">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="isActive" id="isActive" checked>
                                <label class="form-check-label" for="isActive">
                                    <strong>Aktifkan banner</strong>
                                    <small class="text-muted d-block">Banner akan langsung ditampilkan di website</small>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-custom-lainnya">
                        <i class="bi bi-check-circle me-2"></i>Simpan Banner
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- View Banner Detail Modal -->
<div class="modal fade" id="viewBannerModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-eye me-2"></i>Detail Banner
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="viewBannerLoading" class="text-center py-4">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-2">Memuat data banner...</p>
                </div>
                <div id="viewBannerContent" style="display: none;">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Banner ID</label>
                            <p class="form-control-plaintext" id="viewBannerID">-</p>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Status</label>
                            <p class="form-control-plaintext" id="viewStatus">-</p>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Title</label>
                            <p class="form-control-plaintext" id="viewTitle">-</p>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Description</label>
                            <p class="form-control-plaintext" id="viewDescription">-</p>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Link URL</label>
                            <p class="form-control-plaintext" id="viewLinkUrl">-</p>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-bold">Banner Image</label>
                            <div class="mt-2">
                                <img id="viewImage" src="#" alt="Banner Image" style="max-width: 100%; max-height: 300px; display: none;" class="rounded border">
                                <p id="viewNoImage" class="text-muted fst-italic">No image available</p>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Start Date</label>
                            <p class="form-control-plaintext" id="viewStartDate">-</p>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">End Date</label>
                            <p class="form-control-plaintext" id="viewEndDate">-</p>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Order</label>
                            <p class="form-control-plaintext" id="viewOrder">-</p>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Created At</label>
                            <p class="form-control-plaintext" id="viewCreateAt">-</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                <button type="button" class="btn btn-primary" onclick="editBannerFromView()" id="editFromViewBtn" style="display: none;">
                    <i class="bi bi-pencil me-2"></i>Edit Banner
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Edit Banner Modal -->
<div class="modal fade" id="editBannerModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-pencil me-2"></i>Edit Banner
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="editBannerLoading" class="text-center py-4">
                    <div class="spinner-border text-primary" role="status">
                        <span class="visually-hidden">Loading...</span>
                    </div>
                    <p class="mt-2">Memuat data banner...</p>
                </div>
                <form method="POST" action="../BannerManagement" enctype="multipart/form-data" id="editBannerForm" style="display: none;">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="bannerId" id="editBannerId">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Title *</label>
                            <input type="text" class="form-control" name="title" id="editTitle" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Link URL <small class="text-muted">(Opsional)</small></label>
                            <input type="url" class="form-control" name="linkUrl" id="editLinkUrl">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" name="description" id="editDescription" rows="3"></textarea>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Upload New Image</label>
                            <input type="file" class="form-control" name="imageFile" accept="image/*"
                                   onchange="previewSelectedImage(this, 'editPreview')">
                            <div class="form-text">Biarkan kosong jika tidak ingin mengubah gambar</div>
                            <div class="mt-2">
                                <img id="editPreview" src="#" alt="Preview" style="max-width: 200px; max-height: 100px; display: none;" class="rounded border">
                                <img id="editCurrentImage" src="#" alt="Current Image" style="max-width: 200px; max-height: 100px; display: none;" class="rounded border">
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Image Path Manual</label>
                            <input type="text" class="form-control" name="imagePath" id="editImagePath">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Start Date</label>
                            <input type="datetime-local" class="form-control" name="startDate" id="editStartDate">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">End Date</label>
                            <input type="datetime-local" class="form-control" name="endDate" id="editEndDate">
                        </div>
                        <div class="col-12">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="isActive" id="editIsActive">
                                <label class="form-check-label" for="editIsActive">
                                    Aktifkan banner
                                </label>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                <button type="submit" form="editBannerForm" class="btn btn-custom-lainnya" id="updateBannerBtn" style="display: none;">
                    <i class="bi bi-check-circle me-2"></i>Update Banner
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Change Order Modal -->
<div class="modal fade" id="changeOrderModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-arrow-up-down me-2"></i>Ubah Urutan Banner
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../BannerManagement">
                <input type="hidden" name="action" value="updateOrder">
                <input type="hidden" name="bannerId" id="orderBannerId">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Urutan Baru</label>
                        <input type="number" class="form-control" name="newOrder" id="newOrder" min="1" required>
                        <div class="form-text">
                            <i class="bi bi-info-circle me-1"></i>
                            Masukkan nomor urutan baru (1 = paling atas)
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-custom-lainnya">
                        <i class="bi bi-check-circle me-2"></i>Ubah Urutan
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-exclamation-triangle text-warning me-2"></i>Konfirmasi Hapus
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Apakah Anda yakin ingin menghapus banner "<strong id="deleteBannerName"></strong>"?</p>
                <div class="alert alert-warning">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    <strong>Peringatan:</strong> Tindakan ini tidak dapat dibatalkan dan file gambar akan ikut terhapus.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">
                    <i class="bi bi-trash me-2"></i>Ya, Hapus
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Image Preview Modal -->
<div class="modal fade" id="imagePreviewModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="previewTitle">Preview Banner</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <img id="previewImage" src="/placeholder.svg" alt="Banner Preview" class="img-fluid rounded">
            </div>
        </div>
    </div>
</div>

<script>
// Global variables
let currentBannerData = null;

// Toggle banner status
function toggleStatus(bannerId) {
    if (confirm('Apakah Anda yakin ingin mengubah status banner ini?')) {
        window.location.href = '../BannerManagement?action=toggleStatus&bannerId=' + bannerId;
    }
}

// View banner details in modal - Fixed with AJAX
function viewBannerDetail(bannerId) {
    // Show loading
    document.getElementById('viewBannerLoading').style.display = 'block';
    document.getElementById('viewBannerContent').style.display = 'none';
    document.getElementById('editFromViewBtn').style.display = 'none';
    
    // Show modal
    const viewModal = new bootstrap.Modal(document.getElementById('viewBannerModal'));
    viewModal.show();
    
    // Fetch data via AJAX
    fetch('../BannerManagement?action=getBanner&bannerId=' + bannerId)
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                showNotification('error', 'Error: ' + data.error);
                viewModal.hide();
                return;
            }
            
            // Store current data
            currentBannerData = data;
            
            // Hide loading and show content
            document.getElementById('viewBannerLoading').style.display = 'none';
            document.getElementById('viewBannerContent').style.display = 'block';
            document.getElementById('editFromViewBtn').style.display = 'inline-block';
            
            // Populate view modal
            document.getElementById('viewBannerID').textContent = data.bannerID || '-';
            document.getElementById('viewTitle').textContent = data.title || '-';
            document.getElementById('viewDescription').textContent = data.description || '-';
            document.getElementById('viewLinkUrl').innerHTML = data.linkUrl ? 
                `<a href="${data.linkUrl}" target="_blank">${data.linkUrl}</a>` : '-';
            document.getElementById('viewStatus').innerHTML = data.isActive ? 
                '<span class="badge bg-success">Aktif</span>' : '<span class="badge bg-secondary">Non-Aktif</span>';
            document.getElementById('viewOrder').textContent = data.order || '-';
            document.getElementById('viewStartDate').textContent = formatDisplayDate(data.startDate) || 'Not set';
            document.getElementById('viewEndDate').textContent = formatDisplayDate(data.endDate) || 'Not set';
            document.getElementById('viewCreateAt').textContent = formatDisplayDate(data.createAt) || '-';
            
            // Handle image
            const viewImage = document.getElementById('viewImage');
            const viewNoImage = document.getElementById('viewNoImage');
            if (data.imagePath) {
                viewImage.src = '../' + data.imagePath;
                viewImage.style.display = 'block';
                viewNoImage.style.display = 'none';
                viewImage.onerror = function() {
                    this.style.display = 'none';
                    viewNoImage.style.display = 'block';
                };
            } else {
                viewImage.style.display = 'none';
                viewNoImage.style.display = 'block';
            }
        })
        .catch(error => {
            console.error('Error fetching banner:', error);
            showNotification('error', 'Terjadi kesalahan saat mengambil data banner: ' + error.message);
            viewModal.hide();
        });
}

// Edit banner from view modal
function editBannerFromView() {
    if (currentBannerData) {
        // Hide view modal
        const viewModal = bootstrap.Modal.getInstance(document.getElementById('viewBannerModal'));
        viewModal.hide();
        
        // Show edit modal with data
        showEditModal(currentBannerData);
    }
}

// Edit banner - Fixed with AJAX
function editBanner(bannerId) {
    // Show loading
    document.getElementById('editBannerLoading').style.display = 'block';
    document.getElementById('editBannerForm').style.display = 'none';
    document.getElementById('updateBannerBtn').style.display = 'none';
    
    // Show modal
    const editModal = new bootstrap.Modal(document.getElementById('editBannerModal'));
    editModal.show();
    
    // Fetch data via AJAX
    fetch('../BannerManagement?action=getBanner&bannerId=' + bannerId)
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                showNotification('error', 'Error: ' + data.error);
                editModal.hide();
                return;
            }
            
            // Hide loading and show form
            document.getElementById('editBannerLoading').style.display = 'none';
            document.getElementById('editBannerForm').style.display = 'block';
            document.getElementById('updateBannerBtn').style.display = 'inline-block';
            
            // Populate edit modal
            populateEditModal(data);
        })
        .catch(error => {
            console.error('Error fetching banner for edit:', error);
            showNotification('error', 'Terjadi kesalahan saat mengambil data banner: ' + error.message);
            editModal.hide();
        });
}

// Show edit modal with data
function showEditModal(data) {
    // Show modal
    const editModal = new bootstrap.Modal(document.getElementById('editBannerModal'));
    
    // Hide loading and show form
    document.getElementById('editBannerLoading').style.display = 'none';
    document.getElementById('editBannerForm').style.display = 'block';
    document.getElementById('updateBannerBtn').style.display = 'inline-block';
    
    // Populate edit modal
    populateEditModal(data);
    
    editModal.show();
}

// Populate edit modal with data - Fixed date handling
function populateEditModal(data) {
    document.getElementById('editBannerId').value = data.bannerID || '';
    document.getElementById('editTitle').value = data.title || '';
    document.getElementById('editDescription').value = data.description || '';
    document.getElementById('editImagePath').value = data.imagePath || '';
    document.getElementById('editLinkUrl').value = data.linkUrl || '';
    document.getElementById('editIsActive').checked = data.isActive || false;
    
    // Show current image if exists
    const currentImageElement = document.getElementById('editCurrentImage');
    const previewElement = document.getElementById('editPreview');
    
    if (data.imagePath) {
        currentImageElement.src = '../' + data.imagePath;
        currentImageElement.style.display = 'block';
        currentImageElement.onerror = function() {
            this.style.display = 'none';
        };
    } else {
        currentImageElement.style.display = 'none';
    }
    
    // Hide preview initially
    previewElement.style.display = 'none';
    
    // Handle dates - use the date values directly from server
    document.getElementById('editStartDate').value = data.startDate || '';
    document.getElementById('editEndDate').value = data.endDate || '';
}

// Helper function to format date for display
function formatDisplayDate(dateString) {
    if (!dateString) return null;
    
    try {
        const date = new Date(dateString);
        if (isNaN(date.getTime())) return null;
        
        return date.toLocaleDateString('id-ID', {
            day: '2-digit',
            month: 'short',
            year: 'numeric',
            hour: '2-digit',
            minute: '2-digit'
        });
    } catch (e) {
        return dateString;
    }
}

// Change banner order
function changeOrder(bannerId, currentOrder) {
    document.getElementById('orderBannerId').value = bannerId;
    document.getElementById('newOrder').value = currentOrder;
    const orderModal = new bootstrap.Modal(document.getElementById('changeOrderModal'));
    orderModal.show();
}

// Delete banner
function deleteBanner(bannerId, bannerTitle) {
    document.getElementById('deleteBannerName').textContent = bannerTitle;
    document.getElementById('confirmDeleteBtn').href = '../BannerManagement?action=delete&bannerId=' + bannerId;
    const deleteModal = new bootstrap.Modal(document.getElementById('deleteModal'));
    deleteModal.show();
}

// Preview image
function previewImage(imagePath, title) {
    document.getElementById('previewImage').src = imagePath;
    document.getElementById('previewTitle').textContent = 'Preview: ' + title;
    const previewModal = new bootstrap.Modal(document.getElementById('imagePreviewModal'));
    previewModal.show();
}

// Preview selected image file
function previewSelectedImage(input, previewId) {
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const preview = document.getElementById(previewId);
            preview.src = e.target.result;
            preview.style.display = 'block';
            
            // Hide current image if editing
            if (previewId === 'editPreview') {
                const currentImage = document.getElementById('editCurrentImage');
                if (currentImage) {
                    currentImage.style.display = 'none';
                }
            }
        }
        reader.readAsDataURL(input.files[0]);
    }
}

// Refresh banners
function refreshBanners() {
    window.location.reload();
}

// Show notification
function showNotification(type, message) {
    if (typeof Lobibox !== 'undefined') {
        Lobibox.notify(type, {
            pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
            position: 'top right',
            icon: type === 'success' ? 'bi bi-check2-circle' : 'bi bi-x-octagon',
            msg: message,
            sound: false
        });
    } else {
        // Fallback to alert if Lobibox is not available
        alert(message);
    }
}

// Search functionality
document.getElementById('searchBanner').addEventListener('keyup', function() {
    const input = this.value.toLowerCase();
    const table = document.getElementById('bannerTable');
    const rows = table.querySelectorAll('tbody tr');
    
    rows.forEach(function(row) {
        const text = row.textContent.toLowerCase();
        if (text.includes(input)) {
            row.style.display = '';
        } else {
            row.style.display = 'none';
        }
    });
});

// Select all functionality
document.getElementById('selectAll').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('tbody input[type="checkbox"]');
    checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
    });
});

// Form validation
document.getElementById('addBannerForm').addEventListener('submit', function(e) {
    const title = this.querySelector('input[name="title"]').value.trim();
    const imageFile = this.querySelector('input[name="imageFile"]').files[0];
    const imagePath = this.querySelector('input[name="imagePath"]').value.trim();
    
    if (!title) {
        e.preventDefault();
        showNotification('error', 'Title banner harus diisi!');
        return;
    }
    
    if (!imageFile && !imagePath) {
        e.preventDefault();
        showNotification('error', 'Silakan upload gambar atau masukkan path gambar!');
        return;
    }
});

document.getElementById('editBannerForm').addEventListener('submit', function(e) {
    const title = this.querySelector('input[name="title"]').value.trim();
    
    if (!title) {
        e.preventDefault();
        showNotification('error', 'Title banner harus diisi!');
        return;
    }
});

// Initialize page
document.addEventListener('DOMContentLoaded', function() {
    <% 
    String notificationMsg = (String) session.getAttribute("notificationMsg");
    String notificationType = (String) session.getAttribute("notificationType");

    if (notificationMsg != null && notificationType != null) {
    %>
        showNotification('<%= notificationType %>', '<%= notificationMsg.replace("\'", "\\\'") %>');
    <%
        session.removeAttribute("notificationMsg");
        session.removeAttribute("notificationType");
    }
    %>
});
</script>