<%@page import="java.util.ArrayList"%>
<%@page import="Models.Admin"%>
<%@page import="Models.Staff"%>
<%@page import="Models.UserRoles"%>
<div class="main-content">
  <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
    <div class="breadcrumb-title pe-3">Manajemen Admin & Staff</div>
    <div class="ps-3">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-0 p-0">
          <li class="breadcrumb-item"><a href="javascript:;"><i class="bx bx-home-alt"></i></a></li>
          <li class="breadcrumb-item active" aria-current="page">Admin & Staff</li>
        </ol>
      </nav>
    </div>
    <div class="ms-auto">
      <div class="btn-group">
        <button type="button" class="btn btn-primary">Settings</button>
      </div>
    </div>
  </div>
  <h6 class="mb-0 text-uppercase">Daftar Admin dan Staff</h6>
  <hr>

  <div class="card mt-4">
    <div class="card-body">
      <div class="row g-3 mb-4 align-items-center">
        <div class="col-auto">
          <div class="position-relative">
            <input class="form-control px-5" type="search" placeholder="Cari Admin/Staff..." id="searchInput">
            <span class="material-icons-outlined position-absolute ms-3 translate-middle-y start-0 top-50 fs-5">search</span>
          </div>
        </div>
        <div class="col-auto flex-grow-1 overflow-auto">
          <div class="btn-group position-static">
            <div class="btn-group position-static">
              <button type="button" class="btn btn-filter dropdown-toggle px-4" data-bs-toggle="dropdown" aria-expanded="false">
                Filter by Role
              </button>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="?page=manageuser&filter=admin">Admin</a></li>
                <li><a class="dropdown-item" href="?page=manageuser&filter=staff">Staff</a></li>
                <li><a class="dropdown-item" href="?page=manageuser">Semua</a></li>
              </ul>
            </div>
            <div class="btn-group position-static">
              <button type="button" class="btn btn-filter dropdown-toggle px-4" data-bs-toggle="dropdown" aria-expanded="false">
                Status
              </button>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="javascript:;">Aktif</a></li>
                <li><a class="dropdown-item" href="javascript:;">Tidak Aktif</a></li>
              </ul>
            </div>
          </div>
        </div>
        <div class="col-auto">
          <div class="d-flex align-items-center gap-2 justify-content-lg-end">
            <button class="btn btn-filter px-4"><i class="bi bi-box-arrow-right me-2"></i>Export</button>
            <a href="UserManagement?action=add&type=admin" class="btn btn-primary px-4"><i class="bi bi-plus-lg me-2"></i>Tambah Admin</a>
            <a href="UserManagement?action=add&type=staff" class="btn btn-success px-4"><i class="bi bi-plus-lg me-2"></i>Tambah Staff</a>
          </div>
        </div>
      </div>

      <!-- Admin Section -->
      <div class="mb-4">
        <h6 class="text-uppercase mb-3">Daftar Admin</h6>
        <div class="table-responsive white-space-nowrap">
          <table class="table align-middle" style="width:100%">
            <thead class="table-light">
              <tr>
                <th><input class="form-check-input" type="checkbox"></th>
                <th>User ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Full Name</th>
                <th>Gender</th>
                <th>Role</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
              <%
                ArrayList<Admin> adminList = (ArrayList<Admin>) request.getAttribute("adminList");
                boolean hasAdminData = false;
                if (adminList != null && !adminList.isEmpty()) {
                  hasAdminData = true;
                  for (Admin admin : adminList) {
              %>
              <tr>
                <td><input class="form-check-input" type="checkbox"></td>
                <td><%= admin.getUserId() %></td>
                <td><%= admin.getUsername() %></td>
                <td><%= admin.getEmail() %></td>
                <td><%= admin.getFullName() != null ? admin.getFullName() : "-" %></td>
                <td><%= admin.getGender() != null ? admin.getGender() : "-" %></td>
                <td><span class="badge bg-danger"><%= admin.getRoleName() %></span></td>
                <td>
                  <div class="dropdown">
                    <button class="btn btn-sm btn-filter dropdown-toggle dropdown-toggle-nocaret"
                            type="button" data-bs-toggle="dropdown" aria-expanded="false">
                      <i class="bi bi-three-dots"></i>
                    </button>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="UserManagement?action=edit&userId=<%= admin.getUserId() %>&userType=admin"><i class="bi bi-pencil-square me-2"></i>Edit</a></li>
                      <li><a class="dropdown-item" href="UserManagement?action=delete&userId=<%= admin.getUserId() %>&userType=admin" onclick="return confirm('Apakah Anda yakin ingin menghapus admin ini?');"><i class="bi bi-trash me-2"></i>Hapus</a></li>
                    </ul>
                  </div>
                </td>
              </tr>
              <%
                  }
                }
                if (!hasAdminData) {
              %>
              <tr>
                <td colspan="8" class="text-center">Belum ada data admin.</td>
              </tr>
              <%
                }
              %>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Staff Section -->
      <div class="mb-4">
        <h6 class="text-uppercase mb-3">Daftar Staff</h6>
        <div class="table-responsive white-space-nowrap">
          <table class="table align-middle" style="width:100%">
            <thead class="table-light">
              <tr>
                <th><input class="form-check-input" type="checkbox"></th>
                <th>Staff ID</th>
                <th>Nama Staff</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Position</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
              <%
                ArrayList<Staff> staffList = (ArrayList<Staff>) request.getAttribute("staffList");
                boolean hasStaffData = false;
                if (staffList != null && !staffList.isEmpty()) {
                  hasStaffData = true;
                  for (Staff staff : staffList) {
              %>
              <tr>
                <td><input class="form-check-input" type="checkbox"></td>
                <td><%= staff.getStaffId() %></td>
                <td><%= staff.getStaffName() %></td>
                <td><%= staff.getEmail() %></td>
                <td><%= staff.getPhone() != null ? staff.getPhone() : "-" %></td>
                <td><span class="badge bg-info"><%= staff.getPosition() != null ? staff.getPosition() : "STAFF" %></span></td>
                <td>
                  <div class="dropdown">
                    <button class="btn btn-sm btn-filter dropdown-toggle dropdown-toggle-nocaret"
                            type="button" data-bs-toggle="dropdown" aria-expanded="false">
                      <i class="bi bi-three-dots"></i>
                    </button>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="UserManagement?action=edit&userId=<%= staff.getStaffId() %>&userType=staff"><i class="bi bi-pencil-square me-2"></i>Edit</a></li>
                      <li><a class="dropdown-item" href="UserManagement?action=delete&userId=<%= staff.getStaffId() %>&userType=staff" onclick="return confirm('Apakah Anda yakin ingin menghapus staff ini?');"><i class="bi bi-trash me-2"></i>Hapus</a></li>
                      <li><a class="dropdown-item" href="UserManagement?action=performance&userId=<%= staff.getStaffId() %>&userType=staff"><i class="bi bi-graph-up me-2"></i>Lihat Performa</a></li>
                    </ul>
                  </div>
                </td>
              </tr>
              <%
                  }
                }
                if (!hasStaffData) {
              %>
              <tr>
                <td colspan="7" class="text-center">Belum ada data staff.</td>
              </tr>
              <%
                }
              %>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Combined Data Section (Optional) -->
      <%
        ArrayList<ArrayList<Object>> combinedData = (ArrayList<ArrayList<Object>>) request.getAttribute("ListAllAdminStaff");
        if (combinedData != null && !combinedData.isEmpty()) {
      %>
      <div class="mb-4">
        <h6 class="text-uppercase mb-3">Data Gabungan Admin & Staff</h6>
        <div class="table-responsive white-space-nowrap">
          <table class="table align-middle" style="width:100%">
            <thead class="table-light">
              <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Full Name</th>
                <th>Gender</th>
                <th>Role</th>
                <th>Birth Date</th>
              </tr>
            </thead>
            <tbody>
              <%
                for (ArrayList<Object> row : combinedData) {
              %>
              <tr>
                <td><%= row.get(0) %></td>
                <td><%= row.get(1) %></td>
                <td><%= row.get(2) %></td>
                <td><%= row.get(3) != null ? row.get(3) : "-" %></td>
                <td><%= row.get(4) != null ? row.get(4) : "-" %></td>
                <td>
                  <span class="badge <%= ((Integer)row.get(5)) == UserRoles.ADMIN ? "bg-danger" : "bg-info" %>">
                    <%= row.get(6) %>
                  </span>
                </td>
                <td><%= row.get(7) != null ? row.get(7) : "-" %></td>
              </tr>
              <%
                }
              %>
            </tbody>
          </table>
        </div>
      </div>
      <%
        }
      %>

    </div>
  </div>
</div>

<script>
// Search functionality
document.getElementById('searchInput').addEventListener('keyup', function() {
    var input = this.value.toLowerCase();
    var tables = document.querySelectorAll('table tbody');
    
    tables.forEach(function(tbody) {
        var rows = tbody.querySelectorAll('tr');
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
