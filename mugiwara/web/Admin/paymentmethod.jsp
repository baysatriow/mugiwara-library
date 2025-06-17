<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Models.*"%>
<%@page import="DAO.*"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%
    // Get data from request attributes
    ArrayList<QrisPayment> qrisList = (ArrayList<QrisPayment>) request.getAttribute("qrisList");
    ArrayList<BankTransfer> bankList = (ArrayList<BankTransfer>) request.getAttribute("bankList");
    Integer totalPaymentMethods = (Integer) request.getAttribute("totalPaymentMethods");
    Integer totalQris = (Integer) request.getAttribute("totalQris");
    Integer totalBank = (Integer) request.getAttribute("totalBank");
    
    // Initialize if null
    if (qrisList == null) qrisList = new ArrayList<>();
    if (bankList == null) bankList = new ArrayList<>();
    if (totalPaymentMethods == null) totalPaymentMethods = 0;
    if (totalQris == null) totalQris = 0;
    if (totalBank == null) totalBank = 0;
    
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy HH:mm");
%>

<div class="main-content">
    <div class="page-breadcrumb d-none d-sm-flex align-items-center mb-3">
        <div class="breadcrumb-title pe-3">Pengaturan Payment</div>
        <div class="ps-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0 p-0">
                    <li class="breadcrumb-item"><a href="../Admin?page=home"><i class="bx bx-home-alt"></i></a></li>
                    <li class="breadcrumb-item active" aria-current="page">Metode Pembayaran</li>
                </ol>
            </nav>
        </div>
        <div class="ms-auto">
            <div class="btn-group">
                <button type="button" class="btn btn-custom-lainnya dropdown-toggle" data-bs-toggle="dropdown">
                    <i class="bi bi-plus-circle me-2"></i>Tambah Metode
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#addQrisModal">
                        <i class="bi bi-qr-code me-2"></i>QRIS Payment
                    </a></li>
                    <li><a class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#addBankModal">
                        <i class="bi bi-bank me-2"></i>Bank Transfer
                    </a></li>
                </ul>
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
                            <p class="text-secondary mb-1">Total Metode</p>
                            <h4 class="mb-0"><%= totalPaymentMethods %></h4>
                        </div>
                        <div class="widgets-icons bg-light-primary text-primary">
                            <i class="bi bi-credit-card"></i>
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
                            <p class="text-secondary mb-1">QRIS Payment</p>
                            <h4 class="mb-0"><%= totalQris %></h4>
                        </div>
                        <div class="widgets-icons bg-light-success text-success">
                            <i class="bi bi-qr-code"></i>
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
                            <p class="text-secondary mb-1">Bank Transfer</p>
                            <h4 class="mb-0"><%= totalBank %></h4>
                        </div>
                        <div class="widgets-icons bg-light-info text-info">
                            <i class="bi bi-bank"></i>
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
                            <p class="text-secondary mb-1">Status</p>
                            <h4 class="mb-0 text-success">Aktif</h4>
                        </div>
                        <div class="widgets-icons bg-light-warning text-warning">
                            <i class="bi bi-check-circle"></i>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- QRIS Payment Methods -->
    <div class="card mb-4">
        <div class="card-header">
            <div class="d-flex align-items-center justify-content-between">
                <h5 class="card-title mb-0">
                    <i class="bi bi-qr-code me-2"></i>QRIS Payment Methods
                </h5>
                <span class="badge bg-primary"><%= qrisList.size() %> metode</span>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table align-middle table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Payment Code</th>
                            <th>QRIS Code</th>
                            <th>Status</th>
                            <th>Created Date</th>
                            <th>Image</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (qrisList.isEmpty()) { %>
                        <tr>
                            <td colspan="7" class="text-center py-4">
                                <div class="text-muted">
                                    <i class="bi bi-qr-code fs-1 d-block mb-2 opacity-50"></i>
                                    <p class="mb-0">Belum ada QRIS payment method</p>
                                    <small>Klik "Tambah Metode" untuk menambah QRIS baru</small>
                                </div>
                            </td>
                        </tr>
                        <% } else { %>
                            <% for (QrisPayment qris : qrisList) { %>
                            <tr>
                                <td><span class="badge bg-secondary">#<%= qris.getPaymentId() %></span></td>
                                <td>
                                    <strong><%= qris.getPaymentCode() %></strong>
                                </td>
                                <td>
                                    <code class="text-primary"><%= qris.getQrisCode() != null ? qris.getQrisCode().substring(0, Math.min(20, qris.getQrisCode().length())) + "..." : "-" %></code>
                                </td>
                                <td>
                                    <span class="badge bg-<%= "ACTIVE".equals(qris.getStatus()) ? "success" : "secondary" %>">
                                        <i class="bi bi-<%= "ACTIVE".equals(qris.getStatus()) ? "check-circle" : "x-circle" %> me-1"></i>
                                        <%= qris.getStatus() %>
                                    </span>
                                </td>
                                <td>
                                    <small class="text-muted">
                                        <i class="bi bi-calendar me-1"></i>
                                        <%= qris.getDateTime() != null ? qris.getDateTime().format(formatter) : "-" %>
                                    </small>
                                </td>
                                <td>
                                    <% if (qris.getImagePath() != null && !qris.getImagePath().isEmpty()) { %>
                                        <img src="<%= qris.getImagePath() %>" alt="QRIS" class="rounded" style="width: 40px; height: 40px; object-fit: cover;">
                                    <% } else { %>
                                        <div class="bg-light rounded d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                            <i class="bi bi-image text-muted"></i>
                                        </div>
                                    <% } %>
                                </td>
                                <td>
                                    <div class="dropdown">
                                        <button class="btn btn-sm btn-outline-secondary dropdown-toggle dropdown-toggle-nocaret"
                                                 type="button" data-bs-toggle="dropdown">
                                            <i class="bi bi-three-dots"></i>
                                        </button>
                                        <ul class="dropdown-menu">
                                            <li><a class="dropdown-item" href="javascript:;" 
                                                           onclick="viewQris(<%= qris.getPaymentId() %>)">
                                                <i class="bi bi-eye me-2"></i>Lihat Detail
                                            </a></li>
                                            <li><a class="dropdown-item" href="javascript:;" 
                                                           onclick="editQris(<%= qris.getPaymentId() %>)">
                                                <i class="bi bi-pencil me-2"></i>Edit
                                            </a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item text-danger" href="javascript:;" 
                                                           onclick="deletePayment(<%= qris.getPaymentId() %>, 'QRIS', '<%= qris.getPaymentCode() %>')">
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

    <!-- Bank Transfer Methods -->
    <div class="card">
        <div class="card-header">
            <div class="d-flex align-items-center justify-content-between">
                <h5 class="card-title mb-0">
                    <i class="bi bi-bank me-2"></i>Bank Transfer Methods
                </h5>
                <span class="badge bg-info"><%= bankList.size() %> metode</span>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table align-middle table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Payment Code</th>
                            <th>Bank Info</th>
                            <th>Account Details</th>
                            <th>Status</th>
                            <th>Created Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (bankList.isEmpty()) { %>
                        <tr>
                            <td colspan="7" class="text-center py-4">
                                <div class="text-muted">
                                    <i class="bi bi-bank fs-1 d-block mb-2 opacity-50"></i>
                                    <p class="mb-0">Belum ada bank transfer method</p>
                                    <small>Klik "Tambah Metode" untuk menambah bank baru</small>
                                </div>
                            </td>
                        </tr>
                        <% } else { %>
                            <% for (BankTransfer bank : bankList) { %>
                            <tr>
                                <td><span class="badge bg-secondary">#<%= bank.getPaymentId() %></span></td>
                                <td>
                                    <strong><%= bank.getPaymentCode() %></strong>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <% if (bank.getImagePath() != null && !bank.getImagePath().isEmpty()) { %>
                                            <img src="<%= bank.getImagePath() %>" alt="Bank" class="rounded me-2" style="width: 30px; height: 30px; object-fit: cover;">
                                        <% } else { %>
                                            <div class="bg-light rounded d-flex align-items-center justify-content-center me-2" style="width: 30px; height: 30px;">
                                                <i class="bi bi-bank text-muted"></i>
                                            </div>
                                        <% } %>
                                        <strong><%= bank.getBankName() %></strong>
                                    </div>
                                </td>
                                <td>
                                    <div>
                                        <div class="fw-bold"><%= bank.getAccountNumber() %></div>
                                        <small class="text-muted"><%= bank.getAccName() %></small>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge bg-<%= "ACTIVE".equals(bank.getStatus()) ? "success" : "secondary" %>">
                                        <i class="bi bi-<%= "ACTIVE".equals(bank.getStatus()) ? "check-circle" : "x-circle" %> me-1"></i>
                                        <%= bank.getStatus() %>
                                    </span>
                                </td>
                                <td>
                                    <small class="text-muted">
                                        <i class="bi bi-calendar me-1"></i>
                                        <%= bank.getDateTime() != null ? bank.getDateTime().format(formatter) : "-" %>
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
                                                           onclick="viewBank(<%= bank.getPaymentId() %>)">
                                                <i class="bi bi-eye me-2"></i>Lihat Detail
                                            </a></li>
                                            <li><a class="dropdown-item" href="javascript:;" 
                                                           onclick="editBank(<%= bank.getPaymentId() %>)">
                                                <i class="bi bi-pencil me-2"></i>Edit
                                            </a></li>
                                            <li><hr class="dropdown-divider"></li>
                                            <li><a class="dropdown-item text-danger" href="javascript:;" 
                                                           onclick="deletePayment(<%= bank.getPaymentId() %>, 'BANK', '<%= bank.getPaymentCode() %>')">
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
</div>

<!-- Add QRIS Modal -->
<div class="modal fade" id="addQrisModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-qr-code me-2"></i>Tambah QRIS Payment
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../PaymentManagement">
                <input type="hidden" name="action" value="addQris">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Payment Code *</label>
                        <input type="text" class="form-control" name="paymentCode" required 
                               placeholder="e.g., QRIS-001">
                        <div class="form-text">Kode unik untuk identifikasi QRIS</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">QRIS Code *</label>
                        <textarea class="form-control" name="qrisCode" rows="4" required 
                                  placeholder="Masukkan QRIS code lengkap"></textarea>
                        <div class="form-text">String QRIS yang akan di-scan customer</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Image Path</label>
                        <input type="text" class="form-control" name="imagePath" 
                               placeholder="assets/images/qris-logo.png">
                        <div class="form-text">Path ke logo/gambar QRIS (opsional)</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-custom-lainnya">
                        <i class="bi bi-plus-circle me-2"></i>Simpan QRIS
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Add Bank Modal -->
<div class="modal fade" id="addBankModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="bi bi-bank me-2"></i>Tambah Bank Transfer
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="POST" action="../PaymentManagement">
                <input type="hidden" name="action" value="addBank">
                <div class="modal-body">
                    <div class="mb-3">
                        <label class="form-label">Payment Code *</label>
                        <input type="text" class="form-control" name="paymentCode" required 
                               placeholder="e.g., BT-BCA-001">
                        <div class="form-text">Kode unik untuk identifikasi bank transfer</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Bank Name *</label>
                        <select class="form-select" name="bankName" required>
                            <option value="">Pilih Bank</option>
                            <option value="Bank BCA">Bank BCA</option>
                            <option value="Bank Mandiri">Bank Mandiri</option>
                            <option value="Bank BRI">Bank BRI</option>
                            <option value="Bank BNI">Bank BNI</option>
                            <option value="Bank CIMB Niaga">Bank CIMB Niaga</option>
                            <option value="Bank Danamon">Bank Danamon</option>
                            <option value="Bank Permata">Bank Permata</option>
                            <option value="Bank BTN">Bank BTN</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Account Number *</label>
                        <input type="text" class="form-control" name="accountNumber" required 
                               placeholder="e.g., 1234567890">
                        <div class="form-text">Nomor rekening bank</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Account Name *</label>
                        <input type="text" class="form-control" name="accName" required 
                               placeholder="e.g., Toko Buku Mugiwara">
                        <div class="form-text">Nama pemilik rekening</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Image Path</label>
                        <input type="text" class="form-control" name="imagePath" 
                               placeholder="assets/images/bank-logo.png">
                        <div class="form-text">Path ke logo bank (opsional)</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="submit" class="btn btn-custom-lainnya">
                        <i class="bi bi-plus-circle me-2"></i>Simpan Bank Transfer
                    </button>
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
                <h5 class="modal-title">
                    <i class="bi bi-exclamation-triangle text-warning me-2"></i>Konfirmasi Hapus
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>Apakah Anda yakin ingin menghapus metode pembayaran "<strong id="deletePaymentName"></strong>"?</p>
                <div class="alert alert-warning">
                    <i class="bi bi-exclamation-triangle me-2"></i>
                    <strong>Peringatan:</strong> Tindakan ini tidak dapat dibatalkan dan akan menghapus semua data terkait.
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

<script>
function deletePayment(paymentId, type, paymentName) {
    document.getElementById('deletePaymentName').textContent = paymentName;
    document.getElementById('confirmDeleteBtn').href = '../PaymentManagement?action=delete&paymentId=' + paymentId + '&type=' + type;
    new bootstrap.Modal(document.getElementById('deleteModal')).show();
}

function viewQris(paymentId) {
    fetch('../PaymentManagement?action=getPayment&paymentId=' + paymentId + '&type=QRIS')
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                alert('Error: ' + data.error);
                return;
            }
            
            let details = `=== QRIS Payment Details ===\n`;
            details += `Payment ID: ${data.paymentId}\n`;
            details += `Payment Code: ${data.paymentCode}\n`;
            details += `QRIS Code: ${data.qrisCode}\n`;
            details += `Status: ${data.status}\n`;
            details += `Payment Status: ${data.paymentStatus}\n`;
            details += `Created: ${data.dateTime}\n`;
            details += `Image Path: ${data.imagePath || 'Not set'}`;
            
            alert(details);
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Terjadi kesalahan saat mengambil data QRIS');
        });
}

function viewBank(paymentId) {
    fetch('../PaymentManagement?action=getPayment&paymentId=' + paymentId + '&type=BANK')
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                alert('Error: ' + data.error);
                return;
            }
            
            let details = `=== Bank Transfer Details ===\n`;
            details += `Payment ID: ${data.paymentId}\n`;
            details += `Payment Code: ${data.paymentCode}\n`;
            details += `Bank Name: ${data.bankName}\n`;
            details += `Account Number: ${data.accountNumber}\n`;
            details += `Account Name: ${data.accName}\n`;
            details += `Status: ${data.status}\n`;
            details += `Payment Status: ${data.paymentStatus}\n`;
            details += `Created: ${data.dateTime}\n`;
            details += `Image Path: ${data.imagePath || 'Not set'}`;
            
            alert(details);
        })
        .catch(error => {
            console.error('Error:', error);
            alert('Terjadi kesalahan saat mengambil data bank transfer');
        });
}

function editQris(paymentId) {
    alert('Edit QRIS functionality will be implemented in next update');
}

function editBank(paymentId) {
    alert('Edit Bank Transfer functionality will be implemented in next update');
}
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
