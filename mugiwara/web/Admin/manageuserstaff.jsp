<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.*"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    ArrayList<Users> adminList = (ArrayList<Users>) request.getAttribute("adminList");
    ArrayList<Users> staffList = (ArrayList<Users>) request.getAttribute("staffList");
    if (adminList == null) adminList = new ArrayList<>();
    if (staffList == null) staffList = new ArrayList<>();
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
    
    // Pagination variables
    int currentPage = (Integer) request.getAttribute("currentPage");
    int totalPages = (Integer) request.getAttribute("totalPages");
    int totalItems = (Integer) request.getAttribute("totalItems");
%>

<div class="main-content">
    <!--breadcrumb-->
    <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
        <div class="breadcrumb-title pe-3">Manajemen Admin & Staff</div>
        <div class="ps-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 p-0">
                    <li class="breadcrumb-item"><a href="../Admin?page=home"><i class="bx bx-home-alt"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Admin & Staff</li>
                </ol>
            </nav>
        </div>
        <div class="ms-auto">
            <div class="btn-group">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addAdminModal">
                    <i class="bi bi-person-plus me-2"></i>Tambah Admin
                </button>
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addStaffModal">
                    <i class="bi bi-person-plus me-2"></i>Tambah Staff
                </button>
            </div>
        </div>
    </div>
    <!--end breadcrumb-->

    <div class="product-count d-flex align-items-center gap-3 gap-lg-4 mb-4 fw-medium flex-wrap font-text1">
        <a href="../Admin?page=manageuserstaff"><span class="me-1">Total</span><span class="text-secondary">(<%= totalItems %>)</span></a>
        <a href="javascript:;"><span class="me-1">Admin</span><span class="text-secondary">(${totalAdmins})</span></a>
        <a href="javascript:;"><span class="me-1">Staff</span><span class="text-secondary">(${totalStaff})</span></a>
    </div>

    <div class="row g-3">
        <div class="col-auto">
            <div class="position-relative">
                <input class="form-control px-5" type="search" placeholder="Cari admin/staff..." id="searchInput">
                <span class="material-icons-outlined position-absolute ms-3 translate-middle-y start-0 top-50 fs-5">search</span>
            </div>
        </div>
        <div class="col-auto flex-grow-1 overflow-auto">
            <div class="btn-group position-static">
                <div class="btn-group position-static">
                    <button type="button" class="btn btn-filter dropdown-toggle px-4" data-bs-toggle="dropdown">
                        Filter Role
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="../Admin?page=manageuserstaff">Semua</a></li>
                        <li><a class="dropdown-item" href="../Admin?page=manageuserstaff&filter=admin">Admin</a></li>
                        <li><a class="dropdown-item" href="../Admin?page=manageuserstaff&filter=staff">Staff</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="col-auto">
            <div class="d-flex align-items-center gap-2 justify-content-lg-end">
                <button class="btn btn-filter px-4">
                    <i class="bi bi-box-arrow-right me-2"></i>Export
                </button>
            </div>
        </div>
    </div><!--end row-->

    <!-- Admin Section -->
    <div class="card mt-4">
        <div class="card-header">
            <h6 class="mb-0 text-uppercase">Daftar Admin</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive white-space-nowrap">
                <table class="table align-middle" id="adminTable">
                    <thead class="table-light">
                        <tr>
                            <th><input class="form-check-input" type="checkbox"></th>
                            <th>User ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Full Name</th>
                            <th>Gender</th>
                            <th>Birth Date</th>
                            <th>Role</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (adminList.isEmpty()) { %>
                        <tr>
                            <td colspan="9" class="text-center py-4">
                                <div class="text-muted">
                                    <i class="bi bi-person-badge fs-1 d-block mb-2"></i>
                                    Belum ada data admin
                                </div>
                            </td>
                        </tr>
                        <% } else { %>
                            <% for (Users admin : adminList) { %>
                            <tr>
                                <td><input class="form-check-input" type="checkbox" value="<%= admin.getUserId() %>"></td>
                                <td><%= admin.getUserId() %></td>
                                <td><%= admin.getUsername() %></td>
                                <td><%= admin.getEmail() %></td>
                                <td><%= admin.getFullName() != null ? admin.getFullName() : "-" %></td>
                                <td><%= admin.getGender() != null ? admin.getGender() : "-" %></td>
                                <td><%= admin.getBirthDate() != null ? sdf.format(admin.getBirthDate()) : "-" %></td>
                                <td><span class="badge bg-danger">ADMIN</span></td>
                                <td>
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-filter dropdown-toggle dropdown-toggle-nocaret"
                                                type="button" data-bs-toggle="dropdown">
                                            <i class="bi bi-three-dots"></i>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="javascript:;" 
                                                   onclick="viewUser(<%= admin.getUserId() %>, 'admin')">
                                                <i class="bi bi-eye me-2"></i>Lihat Detail
                                            </a></li>
                                            <li><a class="dropdown-item" href="javascript:;" 
                                                   onclick="editUser(<%= admin.getUserId() %>, 'admin')">
                                                <i class="bi bi-pencil me-2"></i>Edit
                                            </a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item text-danger" href="javascript:;" 
                                                   onclick="deleteUser(<%= admin.getUserId() %>, '<%= admin.getUsername() %>', 'admin')">
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
        </div>
    </div>

    <!-- Staff Section -->
    <div class="card mt-4">
        <div class="card-header">
            <h6 class="mb-0 text-uppercase">Daftar Staff</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive white-space-nowrap">
                <table class="table align-middle" id="staffTable">
                    <thead class="table-light">
                        <tr>
                            <th><input class="form-check-input" type="checkbox"></th>
                            <th>User ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Full Name</th>
                            <th>Gender</th>
                            <th>Birth Date</th>
                            <th>Role</th>
                            <th>Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (staffList.isEmpty()) { %>
                        <tr>
                            <td colspan="9" class="text-center py-4">
                                <div class="text-muted">
                                    <i class="bi bi-people fs-1 d-block mb-2"></i>
                                    Belum ada data staff
                                </div>
                            </td>
                        </tr>
                        <% } else { %>
                            <% for (Users staff : staffList) { %>
                            <tr>
                                <td><input class="form-check-input" type="checkbox" value="<%= staff.getUserId() %>"></td>
                                <td><%= staff.getUserId() %></td>
                                <td><%= staff.getUsername() %></td>
                                <td><%= staff.getEmail() %></td>
                                <td><%= staff.getFullName() != null ? staff.getFullName() : "-" %></td>
                                <td><%= staff.getGender() != null ? staff.getGender() : "-" %></td>
                                <td><%= staff.getBirthDate() != null ? sdf.format(staff.getBirthDate()) : "-" %></td>
                                <td><span class="badge bg-info">STAFF</span></td>
                                <td>
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-filter dropdown-toggle dropdown-toggle-nocaret"
                                                type="button" data-bs-toggle="dropdown">
                                            <i class="bi bi-three-dots"></i>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="javascript:;" 
                                                   onclick="viewUser(<%= staff.getUserId() %>, 'staff')">
                                                <i class="bi bi-eye me-2"></i>Lihat Detail
                                            </a></li>
                                            <li><a class="dropdown-item" href="javascript:;" 
                                                   onclick="editUser(<%= staff.getUserId() %>, 'staff')">
                                                <i class="bi bi-pencil me-2"></i>Edit
                                            </a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item text-danger" href="javascript:;" 
                                                   onclick="deleteUser(<%= staff.getUserId() %>, '<%= staff.getUsername() %>', 'staff')">
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
                            <a class="page-link" href="../Admin?page=manageuserstaff&pageNum=<%= currentPage - 1 %><%= request.getParameter("filter") != null ? "&filter=" + request.getParameter("filter") : "" %>">
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
                            <a class="page-link" href="../Admin?page=manageuserstaff&pageNum=<%= i %><%= request.getParameter("filter") != null ? "&filter=" + request.getParameter("filter") : "" %>">
                                <%= i %>
                            </a>
                        </li>
                        <% } %>
                        
                        <% if (currentPage < totalPages) { %>
                        <li class="page-item">
                            <a class="page-link" href="../Admin?page=manageuserstaff&pageNum=<%= currentPage + 1 %><%= request.getParameter("filter") != null ? "&filter=" + request.getParameter("filter") : "" %>">
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

<!-- Add Admin Modal -->
<div class="modal fade" id="addAdminModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Admin Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../RegisterServletA" id="addAdminForm">
                <input type="hidden" name="source" value="admin">
                <input type="hidden" name="roleId" value="1">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Username *</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email *</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Password *</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Konfirmasi Password *</label>
                            <input type="password" class="form-control" name="confirmPassword" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="fullName">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Gender</label>
                            <select class="form-select" name="gender">
                                <option value="">Pilih Gender</option>
                                <option value="Male">Laki-laki</option>
                                <option value="Female">Perempuan</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Tanggal Lahir</label>
                            <input type="date" class="form-control" name="birthDate">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-primary">Simpan Admin</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Add Staff Modal -->
<div class="modal fade" id="addStaffModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Staff Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../RegisterServletA" id="addStaffForm">
                <input type="hidden" name="source" value="admin">
                <input type="hidden" name="roleId" value="2">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Username *</label>
                            <input type="text" class="form-control" name="username" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email *</label>
                            <input type="email" class="form-control" name="email" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Password *</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Konfirmasi Password *</label>
                            <input type="password" class="form-control" name="confirmPassword" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="fullName">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Gender</label>
                            <select class="form-select" name="gender">
                                <option value="">Pilih Gender</option>
                                <option value="Male">Laki-laki</option>
                                <option value="Female">Perempuan</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Tanggal Lahir</label>
                            <input type="date" class="form-control" name="birthDate">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-success">Simpan Staff</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit User Modal -->
<div class="modal fade" id="editUserModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalTitle">Edit User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../UserManagement" id="editUserForm">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="userType" id="editUserType">
                <input type="hidden" name="userId" id="editUserId">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Username *</label>
                            <input type="text" class="form-control" name="username" id="editUsername" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email *</label>
                            <input type="email" class="form-control" name="email" id="editEmail" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Full Name</label>
                            <input type="text" class="form-control" name="fullName" id="editFullName">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Gender</label>
                            <select class="form-select" name="gender" id="editGender">
                                <option value="">Pilih Gender</option>
                                <option value="Male">Laki-laki</option>
                                <option value="Female">Perempuan</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Tanggal Lahir</label>
                            <input type="date" class="form-control" name="birthDate" id="editBirthDate">
                        </div>
                        <div class="col-12">
                            <label class="form-label">Password Baru (kosongkan jika tidak ingin mengubah)</label>
                            <input type="password" class="form-control" name="password">
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-primary">Update User</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- View User Modal -->
<div class="modal fade" id="viewUserModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Detail User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <table class="table table-borderless">
                            <tr><td><strong>User ID:</strong></td><td id="viewUserId"></td></tr>
                            <tr><td><strong>Username:</strong></td><td id="viewUsername"></td></tr>
                            <tr><td><strong>Email:</strong></td><td id="viewEmail"></td></tr>
                            <tr><td><strong>Full Name:</strong></td><td id="viewFullName"></td></tr>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <table class="table table-borderless">
                            <tr><td><strong>Gender:</strong></td><td id="viewGender"></td></tr>
                            <tr><td><strong>Birth Date:</strong></td><td id="viewBirthDate"></td></tr>
                            <tr><td><strong>Role:</strong></td><td id="viewRole"></td></tr>
                            <tr><td><strong>Status:</strong></td><td id="viewStatus"></td></tr>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
            </div>
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
                <p>Apakah Anda yakin ingin menghapus user "<span id="deleteUserName"></span>"?</p>
                <p class="text-muted">Tindakan ini tidak dapat dibatalkan.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                <a href="#" id="confirmDeleteBtn" class="btn btn-danger">Hapus</a>
            </div>
        </div>
    </div>
</div>

<script>
// JavaScript functions for user management
function viewUser(userId, userType) {
    fetch('../UserManagement?action=getUser&userId=' + userId + '&userType=' + userType)
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                alert('Error: ' + data.error);
                return;
            }
            
            // Populate view modal
            document.getElementById('viewUserId').textContent = data.userId || '-';
            document.getElementById('viewUsername').textContent = data.username || '-';
            document.getElementById('viewEmail').textContent = data.email || '-';
            document.getElementById('viewFullName').textContent = data.fullName || '-';
            document.getElementById('viewGender').textContent = data.gender || '-';
            document.getElementById('viewBirthDate').textContent = data.birthDate || '-';
            document.getElementById('viewRole').textContent = data.roleName || userType.toUpperCase();
            document.getElementById('viewStatus').textContent = 'Aktif';
            
            // Show modal
            new bootstrap.Modal(document.getElementById('viewUserModal')).show();
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Terjadi kesalahan saat mengambil data user');
        });
}

function editUser(userId, userType) {
    fetch('../UserManagement?action=getUser&userId=' + userId + '&userType=' + userType)
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                alert('Error: ' + data.error);
                return;
            }
            
            // Populate edit form
            document.getElementById('editUserId').value = data.userId;
            document.getElementById('editUserType').value = userType;
            document.getElementById('editUsername').value = data.username || '';
            document.getElementById('editEmail').value = data.email || '';
            document.getElementById('editFullName').value = data.fullName || '';
            document.getElementById('editGender').value = data.gender || '';
            document.getElementById('editBirthDate').value = data.birthDate || '';
            
            // Update modal title
            document.getElementById('editModalTitle').textContent = 'Edit ' + userType.charAt(0).toUpperCase() + userType.slice(1);
            
            // Show modal
            new bootstrap.Modal(document.getElementById('editUserModal')).show();
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Terjadi kesalahan saat mengambil data user');
        });
}

function deleteUser(userId, username, userType) {
    document.getElementById('deleteUserName').textContent = username;
    document.getElementById('confirmDeleteBtn').href = '../UserManagement?action=delete&userId=' + userId + '&userType=' + userType;
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
}

// Search functionality
document.getElementById('searchInput').addEventListener('keyup', function() {
    var input = this.value.toLowerCase();
    var tables = document.querySelectorAll('#adminTable, #staffTable');
    
    tables.forEach(function(table) {
        var rows = table.querySelectorAll('tbody tr');
        rows.forEach(function(row) {
            var text = row.textContent.toLowerCase();
            if (text.includes(input)) {
                row.style.display = '';
            } else {
                row.style.display = 'none';
            }
        });
    });
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
