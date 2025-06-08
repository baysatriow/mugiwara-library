<%@page import="java.util.ArrayList"%>
<%@page import="Models.Customer"%>
<%@page import="Models.UserRoles"%>
<div class="main-content">
  <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
    <div class="breadcrumb-title pe-3">Manajemen Customer</div>
    <div class="ps-3">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-0 p-0">
          <li class="breadcrumb-item"><a href="javascript:;"><i class="bx bx-home-alt"></i></a></li>
          <li class="breadcrumb-item active" aria-current="page">Customer</li>
        </ol>
      </nav>
    </div>
    <div class="ms-auto">
      <div class="btn-group">
        <button type="button" class="btn btn-primary">Settings</button>
      </div>
    </div>
  </div>
  <h6 class="mb-0 text-uppercase">Daftar Customer</h6>
  <hr>

  <div class="card mt-4">
    <div class="card-body">
      <div class="row g-3 mb-4 align-items-center">
        <div class="col-auto">
          <div class="position-relative">
            <input class="form-control px-5" type="search" placeholder="Cari Customer..." id="searchCustomer">
            <span class="material-icons-outlined position-absolute ms-3 translate-middle-y start-0 top-50 fs-5">search</span>
          </div>
        </div>
        <div class="col-auto flex-grow-1 overflow-auto">
          <div class="btn-group position-static">
            <div class="btn-group position-static">
              <button type="button" class="btn btn-filter dropdown-toggle px-4" data-bs-toggle="dropdown" aria-expanded="false">
                Filter by Gender
              </button>
              <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="?page=managecustomer&filter=male">Laki-laki</a></li>
                <li><a class="dropdown-item" href="?page=managecustomer&filter=female">Perempuan</a></li>
                <li><a class="dropdown-item" href="?page=managecustomer">Semua</a></li>
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
            <a href="UserManagement?action=add&type=customer" class="btn btn-primary px-4"><i class="bi bi-plus-lg me-2"></i>Tambah Customer</a>
          </div>
        </div>
      </div>

      <!-- Customer Statistics -->
      <div class="row mb-4">
        <div class="col-md-3">
          <div class="card bg-primary text-white">
            <div class="card-body">
              <h5><%= request.getAttribute("totalCustomers") != null ? request.getAttribute("totalCustomers") : 0 %></h5>
              <p class="mb-0">Total Customer</p>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card bg-success text-white">
            <div class="card-body">
              <h5>0</h5>
              <p class="mb-0">Customer Aktif</p>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card bg-warning text-white">
            <div class="card-body">
              <h5>0</h5>
              <p class="mb-0">Customer Baru</p>
            </div>
          </div>
        </div>
        <div class="col-md-3">
          <div class="card bg-info text-white">
            <div class="card-body">
              <h5>0</h5>
              <p class="mb-0">Total Orders</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Customer Table -->
      <div class="product-table">
        <div class="table-responsive white-space-nowrap">
          <table id="customerTable" class="table align-middle" style="width:100%">
            <thead class="table-light">
              <tr>
                <th><input class="form-check-input" type="checkbox"></th>
                <th>Customer ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>Full Name</th>
                <th>Phone</th>
                <th>Gender</th>
                <th>Total Orders</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
              <%
                ArrayList<ArrayList<Object>> customerStats = (ArrayList<ArrayList<Object>>) request.getAttribute("ListAllCustomers");
                boolean hasCustomerData = false;
                if (customerStats != null && !customerStats.isEmpty()) {
                  hasCustomerData = true;
                  for (ArrayList<Object> customer : customerStats) {
              %>
              <tr>
                <td><input class="form-check-input" type="checkbox"></td>
                <td><%= customer.get(0) %></td>
                <td><%= customer.get(1) %></td>
                <td><%= customer.get(2) %></td>
                <td><%= customer.get(3) != null ? customer.get(3) : "-" %></td>
                <td><%= customer.get(4) != null ? customer.get(4) : "-" %></td>
                <td><%= customer.get(5) != null ? customer.get(5) : "-" %></td>
                <td>
                  <span class="badge bg-primary"><%= customer.get(6) %> orders</span>
                </td>
                <td>
                  <div class="dropdown">
                    <button class="btn btn-sm btn-filter dropdown-toggle dropdown-toggle-nocaret"
                            type="button" data-bs-toggle="dropdown" aria-expanded="false">
                      <i class="bi bi-three-dots"></i>
                    </button>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="UserManagement?action=edit&userId=<%= customer.get(0) %>&userType=customer"><i class="bi bi-pencil-square me-2"></i>Edit</a></li>
                      <li><a class="dropdown-item" href="UserManagement?action=delete&userId=<%= customer.get(0) %>&userType=customer" onclick="return confirm('Apakah Anda yakin ingin menghapus customer ini?');"><i class="bi bi-trash me-2"></i>Hapus</a></li>
                      <li><a class="dropdown-item" href="UserManagement?action=orders&userId=<%= customer.get(0) %>&userType=customer"><i class="bi bi-bag me-2"></i>Lihat Orders</a></li>
                      <li><a class="dropdown-item" href="UserManagement?action=cart&userId=<%= customer.get(0) %>&userType=customer"><i class="bi bi-cart me-2"></i>Lihat Cart</a></li>
                    </ul>
                  </div>
                </td>
              </tr>
              <%
                  }
                } else {
                  // Fallback to customerList if customerStats is not available
                  ArrayList<Customer> customerList = (ArrayList<Customer>) request.getAttribute("customerList");
                  if (customerList != null && !customerList.isEmpty()) {
                    hasCustomerData = true;
                    for (Customer customer : customerList) {
              %>
              <tr>
                <td><input class="form-check-input" type="checkbox"></td>
                <td><%= customer.getUserId() %></td>
                <td><%= customer.getUsername() %></td>
                <td><%= customer.getEmail() %></td>
                <td><%= customer.getFullName() != null ? customer.getFullName() : "-" %></td>
                <td><%= customer.getPhone() != null ? customer.getPhone() : "-" %></td>
                <td><%= customer.getGender() != null ? customer.getGender() : "-" %></td>
                <td><span class="badge bg-secondary">-</span></td>
                <td>
                  <div class="dropdown">
                    <button class="btn btn-sm btn-filter dropdown-toggle dropdown-toggle-nocaret"
                            type="button" data-bs-toggle="dropdown" aria-expanded="false">
                      <i class="bi bi-three-dots"></i>
                    </button>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="UserManagement?action=edit&userId=<%= customer.getUserId() %>&userType=customer"><i class="bi bi-pencil-square me-2"></i>Edit</a></li>
                      <li><a class="dropdown-item" href="UserManagement?action=delete&userId=<%= customer.getUserId() %>&userType=customer" onclick="return confirm('Apakah Anda yakin ingin menghapus customer ini?');"><i class="bi bi-trash me-2"></i>Hapus</a></li>
                      <li><a class="dropdown-item" href="UserManagement?action=orders&userId=<%= customer.getUserId() %>&userType=customer"><i class="bi bi-bag me-2"></i>Lihat Orders</a></li>
                    </ul>
                  </div>
                </td>
              </tr>
              <%
                    }
                  }
                }
                if (!hasCustomerData) {
              %>
              <tr>
                <td colspan="9" class="text-center">Belum ada data customer.</td>
              </tr>
              <%
                }
              %>
            </tbody>
          </table>
        </div>
      </div>

      <!-- Recent Customers -->
      <%
        ArrayList<Customer> recentCustomers = (ArrayList<Customer>) request.getAttribute("recentCustomers");
        if (recentCustomers != null && !recentCustomers.isEmpty()) {
      %>
      <div class="mt-4">
        <h6 class="text-uppercase mb-3">Customer Terbaru</h6>
        <div class="row">
          <%
            for (int i = 0; i < Math.min(recentCustomers.size(), 6); i++) {
              Customer customer = recentCustomers.get(i);
          %>
          <div class="col-md-4 mb-3">
            <div class="card">
              <div class="card-body">
                <h6 class="card-title"><%= customer.getUsername() %></h6>
                <p class="card-text">
                  <small class="text-muted"><%= customer.getEmail() %></small><br>
                  <small class="text-muted">Full Name: <%= customer.getFullName() != null ? customer.getFullName() : "-" %></small><br>
                  <small class="text-muted">Phone: <%= customer.getPhone() != null ? customer.getPhone() : "-" %></small>
                </p>
                <a href="UserManagement?action=edit&userId=<%= customer.getUserId() %>&userType=customer" class="btn btn-sm btn-primary">View Details</a>
              </div>
            </div>
          </div>
          <%
            }
          %>
        </div>
      </div>
      <%
        }
      %>

    </div>
  </div>
</div>

<script>
// Search functionality for customers
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

// Bulk actions
function selectAllCustomers() {
    var checkboxes = document.querySelectorAll('#customerTable input[type="checkbox"]');
    var masterCheckbox = document.querySelector('#customerTable thead input[type="checkbox"]');
    
    checkboxes.forEach(function(checkbox) {
        checkbox.checked = masterCheckbox.checked;
    });
}

// Add event listener to master checkbox
document.querySelector('#customerTable thead input[type="checkbox"]').addEventListener('change', selectAllCustomers);
</script>
