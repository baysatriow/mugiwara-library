<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.*"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
    ArrayList<Customer> customerList = (ArrayList<Customer>) request.getAttribute("customerList");
    if (customerList == null) customerList = new ArrayList<>();
    
    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
    
    // Pagination variables
    int currentPage = (Integer) request.getAttribute("currentPage");
    int totalPages = (Integer) request.getAttribute("totalPages");
    int totalItems = (Integer) request.getAttribute("totalItems");
%>

<div class="main-content">
    <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
        <div class="breadcrumb-title pe-3">Manajemen Customer</div>
        <div class="ps-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 p-0">
                    <li class="breadcrumb-item"><a href="../Admin?page=home"><i class="bx bx-home-alt"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Customer</li>
                </ol>
            </nav>
        </div>
        <div class="ms-auto">
            <div class="btn-group">
                <button type="button" class="btn btn-custom-lainnya" data-bs-toggle="modal" data-bs-target="#addCustomerModal">
                    <i class="bi bi-person-plus me-2"></i>Tambah Customer
                </button>
            </div>
        </div>
    </div>
    <div class="product-count d-flex align-items-center gap-3 gap-lg-4 mb-4 fw-medium flex-wrap font-text1">
        <a href="../Admin?page=managecustomer"><span class="me-1">Semua</span><span class="text-secondary">(<%= totalItems %>)</span></a>
        <a href="javascript:;"><span class="me-1">Aktif</span><span class="text-secondary">(${totalCustomers})</span></a>
        <a href="javascript:;"><span class="me-1">Baru Bulan Ini</span><span class="text-secondary">(0)</span></a>
    </div>

    <div class="row g-3">
        <div class="col-auto">
            <div class="position-relative">
                <input class="form-control px-5" type="search" placeholder="Cari customer..." id="searchCustomer">
                <span class="material-icons-outlined position-absolute ms-3 translate-middle-y start-0 top-50 fs-5">search</span>
            </div>
        </div>
        <div class="col-auto flex-grow-1 overflow-auto">
            <div class="btn-group position-static">
                <div class="btn-group position-static">
                    <button type="button" class="btn btn-filter dropdown-toggle px-4" data-bs-toggle="dropdown">
                        Filter Gender
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="../Admin?page=managecustomer">Semua</a></li>
                        <li><a class="dropdown-item" href="../Admin?page=managecustomer&filter=male">Laki-laki</a></li>
                        <li><a class="dropdown-item" href="../Admin?page=managecustomer&filter=female">Perempuan</a></li>
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
    </div><div class="card mt-4">
        <div class="card-body">
            <div class="product-table">
                <div class="table-responsive white-space-nowrap">
                    <table class="table align-middle" id="customerTable">
                        <thead class="table-light">
                            <tr>
                                <th><input class="form-check-input" type="checkbox" id="selectAll"></th>
                                <th>Customer ID</th>
                                <th>Username</th>
                                <th>Email</th>
                                <th>Full Name</th>
                                <th>Gender</th>
                                <th>Tanggal Lahir</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if (customerList.isEmpty()) { %>
                            <tr>
                                <td colspan="8" class="text-center py-4">
                                    <div class="text-muted">
                                        <i class="bi bi-people fs-1 d-block mb-2"></i>
                                        Belum ada data customer
                                    </div>
                                </td>
                            </tr>
                            <% } else { %>
                                <% for (Customer customer : customerList) { %>
                                <tr>
                                    <td><input class="form-check-input" type="checkbox" value="<%= customer.getUserId() %>"></td>
                                    <td><%= customer.getUserId() %></td>
                                    <td><%= customer.getUsername() %></td>
                                    <td><%= customer.getEmail() %></td>
                                    <td><%= customer.getFullName() != null ? customer.getFullName() : "-" %></td>
                                    <td><%= customer.getGender() != null ? customer.getGender() : "-" %></td>
                                    <td><%= customer.getBirthDate() != null ? sdf.format(customer.getBirthDate()) : "-" %></td>
                                    <td>
                                        <div class="dropdown">
                                            <button class="btn btn-sm btn-filter dropdown-toggle dropdown-toggle-nocaret"
                                                     type="button" data-bs-toggle="dropdown">
                                                <i class="bi bi-three-dots"></i>
                                            </button>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="javascript:;" 
                                                               onclick="viewCustomer(<%= customer.getUserId() %>)">
                                                    <i class="bi bi-eye me-2"></i>Lihat Detail
                                                </a></li>
                                                <li><a class="dropdown-item" href="javascript:;" 
                                                               onclick="editCustomer(<%= customer.getUserId() %>)">
                                                    <i class="bi bi-pencil me-2"></i>Edit
                                                </a></li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li><a class="dropdown-item text-danger" href="javascript:;" 
                                                               onclick="deleteCustomer(<%= customer.getUserId() %>, '<%= customer.getUsername() %>')">
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
                
                <% if (totalPages > 1) { %>
                <div class="d-flex justify-content-between align-items-center mt-3">
                    <div class="text-muted">
                        Menampilkan <%= ((currentPage - 1) * 10) + 1 %> - <%= Math.min(currentPage * 10, totalItems) %> dari <%= totalItems %> data
                    </div>
                    <nav aria-label="Page navigation">
                        <ul class="pagination pagination-sm mb-0">
                            <% if (currentPage > 1) { %>
                            <li class="page-item">
                                <a class="page-link" href="../Admin?page=managecustomer&pageNum=<%= currentPage - 1 %><%= request.getParameter("filter") != null ? "&filter=" + request.getParameter("filter") : "" %>">
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
                                <a class="page-link" href="../Admin?page=managecustomer&pageNum=<%= i %><%= request.getParameter("filter") != null ? "&filter=" + request.getParameter("filter") : "" %>">
                                    <%= i %>
                                </a>
                            </li>
                            <% } %>
                            
                            <% if (currentPage < totalPages) { %>
                            <li class="page-item">
                                <a class="page-link" href="../Admin?page=managecustomer&pageNum=<%= currentPage + 1 %><%= request.getParameter("filter") != null ? "&filter=" + request.getParameter("filter") : "" %>">
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

<div class="modal fade" id="addCustomerModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Tambah Customer Baru</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../RegisterServletA" id="addCustomerForm">
                <input type="hidden" name="source" value="admin">
                <input type="hidden" name="roleId" value="3">
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
                    <button type="submit" class="btn btn-custom-lainnya">Simpan Customer</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="editCustomerModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Edit Customer</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../UserManagement" id="editCustomerForm">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="userType" value="customer">
                <input type="hidden" name="userId" id="editCustomerId">
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
                    <button type="submit" class="btn btn-custom-lainnya">Update Customer</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="viewCustomerModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Detail Customer</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-6">
                        <table class="table table-borderless">
                            <tr><td><strong>Customer ID:</strong></td><td id="viewCustomerId"></td></tr>
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

<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Konfirmasi Hapus</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Apakah Anda yakin ingin menghapus customer "<span id="deleteCustomerName"></span>"?</p>
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
function viewCustomer(customerId) {
    fetch('../UserManagement?action=getUser&userId=' + customerId + '&userType=customer')
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                alert('Error: ' + data.error);
                return;
            }
            
            document.getElementById('viewCustomerId').textContent = data.userId || '-';
            document.getElementById('viewUsername').textContent = data.username || '-';
            document.getElementById('viewEmail').textContent = data.email || '-';
            document.getElementById('viewFullName').textContent = data.fullName || '-';
            document.getElementById('viewGender').textContent = data.gender || '-';
            document.getElementById('viewBirthDate').textContent = data.birthDate || '-';
            document.getElementById('viewRole').textContent = data.roleName || 'Customer';
            document.getElementById('viewStatus').textContent = 'Aktif';
            
            new bootstrap.Modal(document.getElementById('viewCustomerModal')).show();
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Terjadi kesalahan saat mengambil data customer');
        });
}

function editCustomer(customerId) {
    fetch('../UserManagement?action=getUser&userId=' + customerId + '&userType=customer')
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                alert('Error: ' + data.error);
                return;
            }
            
            document.getElementById('editCustomerId').value = data.userId;
            document.getElementById('editUsername').value = data.username || '';
            document.getElementById('editEmail').value = data.email || '';
            document.getElementById('editFullName').value = data.fullName || '';
            document.getElementById('editGender').value = data.gender || '';
            document.getElementById('editBirthDate').value = data.birthDate || '';
            
            new bootstrap.Modal(document.getElementById('editCustomerModal')).show();
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Terjadi kesalahan saat mengambil data customer');
        });
}

function deleteCustomer(customerId, customerName) {
    document.getElementById('deleteCustomerName').textContent = customerName;
    document.getElementById('confirmDeleteBtn').href = '../UserManagement?action=delete&userId=' + customerId + '&userType=customer';
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
}

document.getElementById('searchCustomer').addEventListener('keyup', function() {
    var input = this.value.toLowerCase();
    var table = document.getElementById('customerTable');
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

document.getElementById('selectAll').addEventListener('change', function() {
    const checkboxes = document.querySelectorAll('tbody input[type="checkbox"]');
    checkboxes.forEach(checkbox => {
        checkbox.checked = this.checked;
    });
});
</script>

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