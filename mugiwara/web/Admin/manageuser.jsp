<%@page import="java.sql.ResultSet"%>
<div class="main-content">
  <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
    <div class="breadcrumb-title pe-3">Manajemen Pengguna</div>
    <div class="ps-3">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb mb-0 p-0">
          <li class="breadcrumb-item"><a href="javascript:;"><i class="bx bx-home-alt"></i></a></li>
          <li class="breadcrumb-item active" aria-current="page">Beranda</li>
        </ol>
      </nav>
    </div>
    <div class="ms-auto">
      <div class="btn-group">
        <button type="button" class="btn btn-primary">Settings</button>
      </div>
    </div>
  </div>
  <h6 class="mb-0 text-uppercase">Daftar Semua Pengguna Website</h6>
  <hr>

  <div class="card mt-4">
    <div class="card-body">
      <div class="row g-3 mb-4 align-items-center">
        <div class="col-auto">
          <div class="position-relative">
            <input class="form-control px-5" type="search" placeholder="Cari Pengguna...">
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
                <li><a class="dropdown-item" href="javascript:;">Admin</a></li>
                <li><a class="dropdown-item" href="javascript:;">User</a></li>
                <li><a class="dropdown-item" href="javascript:;">Guest</a></li>
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
            <a href="adduser.jsp" class="btn btn-primary px-4"><i class="bi bi-plus-lg me-2"></i>Tambah Data</a>
          </div>
        </div>
      </div>
      <div class="product-table">
        <div class="table-responsive white-space-nowrap">
          <table id="userTable" class="table align-middle" style="width:100%">
            <thead class="table-light">
              <tr>
                <th>
                  <input class="form-check-input" type="checkbox">
                </th>
                <th>Username</th>
                <th>Email</th>
                <th>Nama Lengkap</th>
                <th>Gender</th>
                <th>Role</th>
                <th>Aksi</th>
              </tr>
            </thead>
            <tbody>
              <%
                ResultSet rs = (ResultSet) request.getAttribute("ListAllUser");
                boolean hasData = false;
                if (rs != null) {
                  try {
                    while (rs.next()) {
                      hasData = true;
              %>
              <tr>
                <td>
                  <input class="form-check-input" type="checkbox">
                </td>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("full_name") %></td>
                <td><%= rs.getString("gender") %></td>
                <td><%= rs.getString("role") %></td>
                <td>
                  <div class="dropdown">
                    <button class="btn btn-sm btn-filter dropdown-toggle dropdown-toggle-nocaret"
                            type="button" data-bs-toggle="dropdown" aria-expanded="false">
                      <i class="bi bi-three-dots"></i>
                    </button>
                    <ul class="dropdown-menu">
                      <li><a class="dropdown-item" href="edituser.jsp?id=<%= rs.getInt("user_id") %>"><i class="bi bi-pencil-square me-2"></i>Edit</a></li>
                      <li><a class="dropdown-item" href="UserController?action=delete&id=<%= rs.getInt("user_id") %>" onclick="return confirm('Apakah Anda yakin ingin menghapus pengguna ini?');"><i class="bi bi-trash me-2"></i>Hapus</a></li>
                    </ul>
                  </div>
                </td>
              </tr>
              <%
                    } // end while
                  } catch (Exception e) {
                    out.println("<tr><td colspan='7' class='text-danger text-center'>Error menampilkan data: " + e.getMessage() + "</td></tr>");
                    e.printStackTrace(); // Sebaiknya log error ke server juga
                  } finally {
                    if (rs != null) {
                      try { rs.close(); } catch (Exception e) { e.printStackTrace(); } // Pastikan ResultSet ditutup
                    }
                  }
                } // end if (rs != null)
                if (!hasData) {
              %>
              <tr>
                <td colspan="7" class="text-center">Belum ada data pengguna.</td>
              </tr>
              <%
                }
              %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
