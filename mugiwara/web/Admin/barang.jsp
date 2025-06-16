<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.Locale"%>

<%
    ArrayList<Book> books = (ArrayList<Book>) request.getAttribute("books");
    ArrayList<Author> authors = (ArrayList<Author>) request.getAttribute("authors");
    ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
    ArrayList<Publisher> publishers = (ArrayList<Publisher>) request.getAttribute("publishers");
    
    if (books == null) books = new ArrayList<>();
    if (authors == null) authors = new ArrayList<>();
    if (categories == null) categories = new ArrayList<>();
    if (publishers == null) publishers = new ArrayList<>();
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(new Locale("id", "ID"));
    
    // Pagination variables
    int currentPage = (Integer) request.getAttribute("currentPage");
    int totalPages = (Integer) request.getAttribute("totalPages");
    int totalItems = (Integer) request.getAttribute("totalItems");
    String selectedCategoryName = (String) request.getAttribute("selectedCategoryName");
    if (selectedCategoryName == null) selectedCategoryName = "Kategori";
%>

<!--start main wrapper-->
<div class="main-content">
    <!--breadcrumb-->
    <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
        <div class="breadcrumb-title pe-3">eCommerce</div>
        <div class="ps-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 p-0">
                    <li class="breadcrumb-item"><a href="../Admin?page=home"><i class="bx bx-home-alt"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Manajemen Buku</li>
                </ol>
            </nav>
        </div>
        <div class="ms-auto">
            <div class="btn-group">
                <button type="button" class="btn btn-custom-lainnya" data-bs-toggle="modal" data-bs-target="#addAuthorModal">
                    <i class="bi bi-person-plus me-2"></i>Tambah Penulis
                </button>
                <button type="button" class="btn btn-custom-lainnya" data-bs-toggle="modal" data-bs-target="#addCategoryModal">
                    <i class="bi bi-tag me-2"></i>Tambah Kategori
                </button>
                <button type="button" class="btn btn-custom-lainnya" data-bs-toggle="modal" data-bs-target="#addPublisherModal">
                    <i class="bi bi-building me-2"></i>Tambah Penerbit
                </button>
            </div>
        </div>
    </div>
    <!--end breadcrumb-->

    <div class="product-count d-flex align-items-center gap-3 gap-lg-4 mb-4 fw-medium flex-wrap font-text1">
        <a href="../Admin?page=barang"><span class="me-1">Semua</span><span class="text-secondary">(<%= totalItems %>)</span></a>
        <a href="javascript:;"><span class="me-1">Stok Rendah</span><span class="text-secondary">(${lowStockBooks})</span></a>
        <a href="javascript:;"><span class="me-1">Habis</span><span class="text-secondary">(${outOfStockBooks})</span></a>
    </div>

    <div class="row g-3">
        <div class="col-auto">
            <div class="position-relative">
                <form method="GET" action="../Admin" class="d-flex">
                    <input type="hidden" name="page" value="barang">
                    <input type="hidden" name="action" value="search">
                    <input class="form-control px-5" type="search" name="keyword" 
                           placeholder="Cari buku, penulis, penerbit..." 
                           value="${searchKeyword}">
                    <button type="submit" class="btn btn-outline-secondary">
                        <span class="material-icons-outlined">search</span>
                    </button>
                </form>
            </div>
        </div>
        <div class="col-auto flex-grow-1 overflow-auto">
            <div class="btn-group position-static">
                <div class="btn-group position-static">
                    <button type="button" class="btn btn-filter dropdown-toggle px-4" data-bs-toggle="dropdown">
                        <%= selectedCategoryName %>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="../Admin?page=barang">Semua Kategori</a></li>
                        <% for (Category category : categories) { %>
                        <li><a class="dropdown-item" href="../Admin?page=barang&action=filter&categoryId=<%= category.getCategory_id() %>">
                            <%= category.getName() %>
                        </a></li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-auto">
            <div class="d-flex align-items-center gap-2 justify-content-lg-end">
                <a href="../BarangServlet?action=export" class="btn btn-filter px-4">
                    <i class="bi bi-box-arrow-right me-2"></i>Export Excel
                </a>
                <button class="btn btn-custom-lainnya px-4" data-bs-toggle="modal" data-bs-target="#addBookModal">
                    <i class="bi bi-plus-lg me-2"></i>Tambah Buku
                </button>
            </div>
        </div>
    </div><!--end row-->

    <div class="card mt-4">
        <div class="card-body">
            <div class="product-table">
                <div class="table-responsive white-space-nowrap">
                    <table class="table align-middle">
                        <thead class="table-light">
                            <tr>
                                <th><input class="form-check-input" type="checkbox" id="selectAll"></th>
                                <th>Buku</th>
                                <th>Harga</th>
                                <th>Kategori</th>
                                <th>Penulis</th>
                                <th>Penerbit</th>
                                <th>Stok</th>
                                <th>Tanggal</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (books.isEmpty()) { %>
                            <tr>
                                <td colspan="9" class="text-center py-4">
                                    <div class="text-muted">
                                        <i class="bi bi-book fs-1 d-block mb-2"></i>
                                        Belum ada data buku
                                    </div>
                                </td>
                            </tr>
                            <% } else { %>
                                <% for (Book book : books) { %>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox" value="<%= book.getBook_id() %>"></td>
                                    <td>
                                        <div class="d-flex align-items-center gap-3">
                                            <div class="product-box">
                                                <img src="../<%= book.getImagePath() != null ? book.getImagePath() : "assets/images/no-image.png" %>" 
                                                     width="70" class="rounded-3" alt="<%= book.getTitle() %>">
                                            </div>
                                            <div class="product-info">
                                                <a href="javascript:;" class="product-title"><%= book.getTitle() %></a>
                                                <p class="mb-0 product-category">ISBN: <%= book.getISBN() %></p>
                                            </div>
                                        </div>
                                    </td>
                                    <td><%= currencyFormat.format(book.getPrice()) %></td>
                                    <td><%= book.getCategory() != null ? book.getCategory().getName() : "-" %></td>
                                    <td><%= book.getAuthor() != null ? book.getAuthor().getName() : "-" %></td>
                                    <td><%= book.getPublisher() != null ? book.getPublisher().getName() : "-" %></td>
                                    <td>
                                        <span class="badge <%= book.getStock() > 10 ? "bg-success" : (book.getStock() > 0 ? "bg-warning" : "bg-danger") %>">
                                            <%= book.getStock() %>
                                        </span>
                                    </td>
                                    <td><%= book.getPublicationDate() != null ? sdf.format(book.getPublicationDate()) : "-" %></td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-filter dropdown-toggle dropdown-toggle-nocaret"
                                                    type="button" data-bs-toggle="dropdown">
                                                <i class="bi bi-three-dots"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="javascript:;" 
                                                       onclick="viewBook(<%= book.getBook_id() %>)">
                                                    <i class="bi bi-eye me-2"></i>Lihat Detail
                                                </a></li>
                                                <li><a class="dropdown-item" href="javascript:;" 
                                                       onclick="editBook(<%= book.getBook_id() %>)">
                                                    <i class="bi bi-pencil me-2"></i>Edit
                                                </a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-danger" href="javascript:;" 
                                                       onclick="deleteBook(<%= book.getBook_id() %>, '<%= book.getTitle() %>')">
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
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <div class="text-muted">
                        Menampilkan <%= ((currentPage - 1) * 10) + 1 %> - <%= Math.min(currentPage * 10, totalItems) %> dari <%= totalItems %> data
                    </div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination pagination-sm mb-0">
                            <% if (currentPage > 1) { %>
                            <li class="page-item">
                                <a class="page-link" href="../Admin?page=barang&pageNum=<%= currentPage - 1 %><%= request.getParameter("keyword") != null ? "&action=search&keyword=" + request.getParameter("keyword") : "" %><%= request.getParameter("categoryId") != null ? "&action=filter&categoryId=" + request.getParameter("categoryId") : "" %>">
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
                                <a class="page-link" href="../Admin?page=barang&pageNum=<%= i %><%= request.getParameter("keyword") != null ? "&action=search&keyword=" + request.getParameter("keyword") : "" %><%= request.getParameter("categoryId") != null ? "&action=filter&categoryId=" + request.getParameter("categoryId") : "" %>">
                                    <%= i %>
                                </a>
                            </li>
                            <% } %>
                            
                            <% if (currentPage < totalPages) { %>
                            <li class="page-item">
                                <a class="page-link" href="../Admin?page=barang&pageNum=<%= currentPage + 1 %><%= request.getParameter("keyword") != null ? "&action=search&keyword=" + request.getParameter("keyword") : "" %><%= request.getParameter("categoryId") != null ? "&action=filter&categoryId=" + request.getParameter("categoryId") : "" %>">
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
<!--end main wrapper-->

<!-- Add Book Modal -->
<div class="modal fade" id="addBookModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Buku Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../BarangServlet" id="addBookForm" enctype="multipart/form-data">
                <input type="hidden" name="action" value="add">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">ISBN *</label>
                            <input type="text" class="form-control" name="isbn" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Judul Buku *</label>
                            <input type="text" class="form-control" name="title" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Penulis *</label>
                            <select class="form-select" name="authorId" required>
                                <option value="">Pilih Penulis</option>
                                <% for (Author author : authors) { %>
                                <option value="<%= author.getAuthor_id() %>"><%= author.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Penerbit *</label>
                            <select class="form-select" name="publisherId" required>
                                <option value="">Pilih Penerbit</option>
                                <% for (Publisher publisher : publishers) { %>
                                <option value="<%= publisher.getPublisher_id() %>"><%= publisher.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Kategori *</label>
                            <select class="form-select" name="categoryId" required>
                                <option value="">Pilih Kategori</option>
                                <% for (Category category : categories) { %>
                                <option value="<%= category.getCategory_id() %>"><%= category.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Harga *</label>
                            <input type="number" class="form-control" name="price" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Stok *</label>
                            <input type="number" class="form-control" name="stock" min="0" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Tanggal Terbit</label>
                            <input type="date" class="form-control" name="publicationDate">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Lebar (cm)</label>
                            <input type="number" class="form-control" name="width" step="0.1" min="0">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Panjang (cm)</label>
                            <input type="number" class="form-control" name="length" step="0.1" min="0">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Berat (gram)</label>
                            <input type="number" class="form-control" name="weight" min="0">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Foto Buku</label>
                            <input type="file" class="form-control" name="bookImage" accept="image/*">
                            <small class="text-muted">Format: JPG, PNG, GIF. Max: 10MB</small>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Deskripsi</label>
                            <textarea class="form-control" name="description" rows="3"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-custom-lainnya">Simpan Buku</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Book Modal -->
<div class="modal fade" id="editBookModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Buku</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../BarangServlet" id="editBookForm" enctype="multipart/form-data">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="bookId" id="editBookId">
                <input type="hidden" name="currentImagePath" id="editCurrentImagePath">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">ISBN *</label>
                            <input type="text" class="form-control" name="isbn" id="editIsbn" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Judul Buku *</label>
                            <input type="text" class="form-control" name="title" id="editTitle" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Penulis *</label>
                            <select class="form-select" name="authorId" id="editAuthorId" required>
                                <option value="">Pilih Penulis</option>
                                <% for (Author author : authors) { %>
                                <option value="<%= author.getAuthor_id() %>"><%= author.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Penerbit *</label>
                            <select class="form-select" name="publisherId" id="editPublisherId" required>
                                <option value="">Pilih Penerbit</option>
                                <% for (Publisher publisher : publishers) { %>
                                <option value="<%= publisher.getPublisher_id() %>"><%= publisher.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Kategori *</label>
                            <select class="form-select" name="categoryId" id="editCategoryId" required>
                                <option value="">Pilih Kategori</option>
                                <% for (Category category : categories) { %>
                                <option value="<%= category.getCategory_id() %>"><%= category.getName() %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Harga *</label>
                            <input type="number" class="form-control" name="price" id="editPrice" min="0" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Stok *</label>
                            <input type="number" class="form-control" name="stock" id="editStock" min="0" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Tanggal Terbit</label>
                            <input type="date" class="form-control" name="publicationDate" id="editPublicationDate">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Lebar (cm)</label>
                            <input type="number" class="form-control" name="width" id="editWidth" step="0.1" min="0">
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Panjang (cm)</label>
                            <input type="number" class="form-control" name="length" id="editLength" step="0.1" min="0">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Berat (gram)</label>
                            <input type="number" class="form-control" name="weight" id="editWeight" min="0">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Foto Buku</label>
                            <input type="file" class="form-control" name="bookImage" accept="image/*">
                            <small class="text-muted">Kosongkan jika tidak ingin mengubah foto</small>
                            <div id="currentImagePreview" class="mt-2"></div>
                        </div>
                        <div class="col-12">
                            <label class="form-label">Deskripsi</label>
                            <textarea class="form-control" name="description" id="editDescription" rows="3"></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-custom-lainnya">Update Buku</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- View Book Detail Modal -->
<div class="modal fade" id="viewBookModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Detail Buku</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-4">
                        <img id="viewBookImage" src="/placeholder.svg" class="img-fluid rounded" alt="Book Cover">
                    </div>
                    <div class="col-md-8">
                        <table class="table table-borderless">
                            <tr><td><strong>ISBN:</strong></td><td id="viewIsbn"></td></tr>
                            <tr><td><strong>Judul:</strong></td><td id="viewTitle"></td></tr>
                            <tr><td><strong>Penulis:</strong></td><td id="viewAuthor"></td></tr>
                            <tr><td><strong>Penerbit:</strong></td><td id="viewPublisher"></td></tr>
                            <tr><td><strong>Kategori:</strong></td><td id="viewCategory"></td></tr>
                            <tr><td><strong>Harga:</strong></td><td id="viewPrice"></td></tr>
                            <tr><td><strong>Stok:</strong></td><td id="viewStock"></td></tr>
                            <tr><td><strong>Tanggal Terbit:</strong></td><td id="viewPublicationDate"></td></tr>
                            <tr><td><strong>Dimensi:</strong></td><td id="viewDimensions"></td></tr>
                            <tr><td><strong>Berat:</strong></td><td id="viewWeight"></td></tr>
                        </table>
                        <div class="mt-3">
                            <strong>Deskripsi:</strong>
                            <p id="viewDescription" class="mt-2"></p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
            </div>
        </div>
    </div>
</div>

<!-- Add Author Modal -->
<div class="modal fade" id="addAuthorModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Penulis</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../BarangServlet">
                <input type="hidden" name="action" value="addAuthor">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Nama Penulis *</label>
                        <input type="text" class="form-control" name="authorName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Deskripsi</label>
                        <textarea class="form-control" name="authorDescription" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-custom-lainnya">Simpan</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Kategori</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../BarangServlet">
                <input type="hidden" name="action" value="addCategory">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Nama Kategori *</label>
                        <input type="text" class="form-control" name="categoryName" required>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-custom-lainnya">Simpan</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Add Publisher Modal -->
<div class="modal fade" id="addPublisherModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Penerbit</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../BarangServlet">
                <input type="hidden" name="action" value="addPublisher">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Nama Penerbit *</label>
                        <input type="text" class="form-control" name="publisherName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Deskripsi</label>
                        <textarea class="form-control" name="publisherDescription" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-custom-lainnya">Simpan</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Konfirmasi Hapus</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Apakah Anda yakin ingin menghapus buku "<span id="deleteBookTitle"></span>"?</p>
                <p class="text-muted">Tindakan ini tidak dapat dibatalkan.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                <form method="POST" action="../BarangServlet" style="display: inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="bookId" id="deleteBookId">
                    <button type="submit" class="btn btn-danger">Hapus</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
// JavaScript functions for modal operations
function viewBook(bookId) {
    // Fetch book data and show in view modal
    fetch('../BarangServlet?action=getBook&bookId=' + bookId)
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                alert('Error: ' + data.error);
                return;
            }
            
            // Populate view modal
            document.getElementById('viewBookImage').src = '../' + data.imagePath || 'assets/images/no-image.png';
            document.getElementById('viewIsbn').textContent = data.isbn || '-';
            document.getElementById('viewTitle').textContent = data.title || '-';
            document.getElementById('viewAuthor').textContent = data.authorName || '-';
            document.getElementById('viewPublisher').textContent = data.publisherId || '-';
            document.getElementById('viewCategory').textContent = data.categoryName || '-';
            document.getElementById('viewPrice').textContent = 'Rp ' + (data.price || 0).toLocaleString('id-ID');
            document.getElementById('viewStock').textContent = data.stock || 0;
            document.getElementById('viewPublicationDate').textContent = data.publicationDate || '-';
            document.getElementById('viewDimensions').textContent = (data.width || 0) + ' x ' + (data.length || 0) + ' cm';
            document.getElementById('viewWeight').textContent = (data.weight || 0) + ' gram';
            document.getElementById('viewDescription').textContent = data.description || 'Tidak ada deskripsi';
            
            // Show modal
            new bootstrap.Modal(document.getElementById('viewBookModal')).show();
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Terjadi kesalahan saat mengambil data buku');
        });
}

function editBook(bookId) {
    // Fetch book data and populate edit modal
    fetch('../BarangServlet?action=getBook&bookId=' + bookId)
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                alert('Error: ' + data.error);
                return;
            }
            
            // Populate edit form
            document.getElementById('editBookId').value = data.bookId;
            document.getElementById('editIsbn').value = data.isbn || '';
            document.getElementById('editTitle').value = data.title || '';
            document.getElementById('editAuthorId').value = data.authorId || '';
            document.getElementById('editPublisherId').value = data.publisherId || '';
            document.getElementById('editCategoryId').value = data.categoryId || '';
            document.getElementById('editPrice').value = data.price || '';
            document.getElementById('editStock').value = data.stock || '';
            document.getElementById('editDescription').value = data.description || '';
            document.getElementById('editPublicationDate').value = data.publicationDate || '';
            document.getElementById('editWidth').value = data.width || '';
            document.getElementById('editLength').value = data.length || '';
            document.getElementById('editWeight').value = data.weight || '';
            document.getElementById('editCurrentImagePath').value = data.imagePath || '';
            
            // Show current image preview
            if (data.imagePath) {
                document.getElementById('currentImagePreview').innerHTML = 
                    '<img src="../' + data.imagePath + '" class="img-thumbnail" style="max-width: 100px;">';
            }
            
            // Show modal
            new bootstrap.Modal(document.getElementById('editBookModal')).show();
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Terjadi kesalahan saat mengambil data buku');
        });
}

function deleteBook(bookId, bookTitle) {
    document.getElementById('deleteBookId').value = bookId;
    document.getElementById('deleteBookTitle').textContent = bookTitle;
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
}

// Select all checkbox functionality
document.getElementById('selectAll').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('tbody input[type="checkbox"]');
    checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
    });
});

// File upload preview
document.querySelector('input[name="bookImage"]').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            // You can add image preview here if needed
        };
        reader.readAsDataURL(file);
    }
});
</script>

<!-- Notification Script -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    <% 
    String notificationMsg = (String) session.getAttribute("notificationMsg");
    String notificationType = (String) session.getAttribute("notificationType");

    if (notificationMsg != null && notificationType != null) {
    %>
        Lobibox.notify('<%= notificationType %>', {
            pauseDelayOnHover: true,
            continueDelayOnInactiveTab: false,
            position: 'top right',
            icon: '<%= "success".equals(notificationType) ? "bi bi-check2-circle" : ("error".equals(notificationType) ? "bi bi-x-octagon" : "bi bi-info-circle") %>',
            msg: '<%= notificationMsg.replace("\'", "\\\'") %>',
            sound: false
        });
    <%
        session.removeAttribute("notificationMsg");
        session.removeAttribute("notificationType");
    }
    %>
});
</script>
