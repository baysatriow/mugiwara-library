<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrasi - Mugiwara Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <!-- iziToast CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/css/iziToast.min.css">
    <!-- Font Awesome for icons (Changed to CSS for better compatibility) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" xintegrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="auth-container">

    <div class="auth-card">
        <a href="index.jsp"><img src="assets/images/Logo Store.png" alt="Mugiwara Library Logo" class="auth-logo"></a>
        <h2 class="auth-title">Buat Akun Baru</h2>
        <p class="auth-subtitle">Daftar untuk mulai berbelanja.</p>

        <form action="RegisterServlet" method="post" id="registerForm">
            <div class="mb-3">
                <label for="fullName" class="form-label">Nama Lengkap</label>
                <input type="text" class="form-control" id="fullName" name="fullName" 
                       placeholder="Masukkan Nama Lengkap Anda" required 
                       value="${param.fullName}" maxlength="100">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" 
                       placeholder="email@contoh.com" required 
                       value="${param.email}" maxlength="100">
                <div class="form-text">Email akan digunakan untuk login ke akun Anda.</div>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <div class="position-relative">
                    <input type="password" class="form-control" id="password" name="password" 
                           placeholder="Buat Password Anda" required minlength="8">
                    <button type="button" class="btn btn-outline-secondary position-absolute end-0 top-0 h-100" 
                            id="togglePassword" style="border-left: none;">
                        <i class="fa-solid fa-eye" id="eyeIcon"></i>
                    </button>
                </div>
                <div class="form-text">
                    Password harus minimal 8 karakter, mengandung huruf besar, huruf kecil, angka, dan karakter khusus.
                </div>
                <div class="password-strength mt-2">
                    <div class="progress" style="height: 5px;">
                        <div class="progress-bar" id="passwordStrength" role="progressbar" style="width: 0%"></div>
                    </div>
                    <small id="passwordStrengthText" class="text-muted"></small>
                </div>
            </div>
            <div class="mb-4">
                <label for="confirmPassword" class="form-label">Konfirmasi Password</label>
                <div class="position-relative">
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" 
                           placeholder="Konfirmasi Password Anda" required>
                    <button type="button" class="btn btn-outline-secondary position-absolute end-0 top-0 h-100" 
                            id="toggleConfirmPassword" style="border-left: none;">
                        <i class="fa-solid fa-eye" id="eyeIconConfirm"></i>
                    </button>
                </div>
                <div id="passwordMatch" class="form-text"></div>
            </div>
            
            <div class="mb-3">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="agreeTerms" required>
                    <label class="form-check-label" for="agreeTerms">
                        Saya setuju dengan <a href="terms.jsp" target="_blank" class="auth-link">Syarat dan Ketentuan</a> 
                        serta <a href="privacy.jsp" target="_blank" class="auth-link">Kebijakan Privasi</a>
                    </label>
                </div>
            </div>
            
            <button type="submit" class="btn btn-custom-lainnya w-100" id="registerBtn" disabled>
                <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                Daftar
            </button>
        </form>

        <div class="auth-footer">
            Sudah punya akun? <a href="login.jsp" class="auth-link">Masuk disini</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- iziToast JS -->
    <script src="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/js/iziToast.min.js"></script>

    <script>
    // Toggle password visibility
    document.getElementById('togglePassword').addEventListener('click', function() {
        togglePasswordVisibility('password', 'eyeIcon');
    });

    document.getElementById('toggleConfirmPassword').addEventListener('click', function() {
        togglePasswordVisibility('confirmPassword', 'eyeIconConfirm');
    });

    function togglePasswordVisibility(fieldId, iconId) {
        const passwordField = document.getElementById(fieldId);
        const eyeIcon = document.getElementById(iconId);

        if (passwordField.type === 'password') {
            passwordField.type = 'text';
            eyeIcon.classList.remove('fa-eye');
            eyeIcon.classList.add('fa-eye-slash');
        } else {
            passwordField.type = 'password';
            eyeIcon.classList.remove('fa-eye-slash');
            eyeIcon.classList.add('fa-eye');
        }
    }

    // Password strength checker
    document.getElementById('password').addEventListener('input', function() {
        const password = this.value;
        const strengthBar = document.getElementById('passwordStrength');
        const strengthText = document.getElementById('passwordStrengthText');

        let strength = 0;
        let feedback = [];

        if (password.length >= 8) strength += 20;
        else feedback.push('minimal 8 karakter');

        if (/[a-z]/.test(password)) strength += 20;
        else feedback.push('huruf kecil');

        if (/[A-Z]/.test(password)) strength += 20;
        else feedback.push('huruf besar');

        if (/[0-9]/.test(password)) strength += 20;
        else feedback.push('angka');

        if (/[^A-Za-z0-9]/.test(password)) strength += 20;
        else feedback.push('karakter khusus');

        strengthBar.style.width = strength + '%';

        if (strength < 40) {
            strengthBar.className = 'progress-bar bg-danger';
            strengthText.textContent = 'Lemah - Perlu: ' + feedback.join(', ');
            strengthText.className = 'text-danger';
        } else if (strength < 80) {
            strengthBar.className = 'progress-bar bg-warning';
            strengthText.textContent = 'Sedang - Perlu: ' + feedback.join(', ');
            strengthText.className = 'text-warning';
        } else {
            strengthBar.className = 'progress-bar bg-success';
            strengthText.textContent = 'Kuat';
            strengthText.className = 'text-success';
        }

        checkFormValidity();
    });

    // Password match checker
    document.getElementById('confirmPassword').addEventListener('input', function() {
        const password = document.getElementById('password').value;
        const confirmPassword = this.value;
        const matchDiv = document.getElementById('passwordMatch');

        if (confirmPassword === '') {
            matchDiv.textContent = '';
            matchDiv.className = 'form-text';
        } else if (password === confirmPassword) {
            matchDiv.textContent = '✓ Password cocok';
            matchDiv.className = 'form-text text-success';
        } else {
            matchDiv.textContent = '✗ Password tidak cocok';
            matchDiv.className = 'form-text text-danger';
        }

        checkFormValidity();
    });

    // Add event listeners for other input fields to re-check validity
    document.getElementById('fullName').addEventListener('input', checkFormValidity);
    document.getElementById('email').addEventListener('input', checkFormValidity);

    // Check form validity
    function checkFormValidity() {
        const fullName = document.getElementById('fullName').value;
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const agreeTerms = document.getElementById('agreeTerms').checked;
        const registerBtn = document.getElementById('registerBtn');

        const isPasswordStrong = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$/.test(password);
        const isPasswordMatch = password === confirmPassword && confirmPassword !== '';

        const isFullNameValid = fullName.trim() !== '';
        const isEmailValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email); // Basic email regex

        // All conditions must be true for the button to be enabled
        registerBtn.disabled = !(isFullNameValid && isEmailValid && isPasswordStrong && isPasswordMatch && agreeTerms);
    }

    // Terms checkbox listener
    document.getElementById('agreeTerms').addEventListener('change', checkFormValidity);

    // Call checkFormValidity on page load to set initial button state
    document.addEventListener('DOMContentLoaded', checkFormValidity);

    // Form submission with loading state
    document.getElementById('registerForm').addEventListener('submit', function() {
        const submitBtn = document.getElementById('registerBtn');
        const spinner = submitBtn.querySelector('.spinner-border');

        submitBtn.disabled = true;
        spinner.classList.remove('d-none');
        submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Memproses...';
    });

    // Show toast notifications
    <% if (request.getAttribute("toastType") != null) { %>
        iziToast.<%= request.getAttribute("toastType") %>({
            title: '<%= request.getAttribute("toastTitle") %>',
            message: '<%= request.getAttribute("toastMessage") %>',
            position: 'topRight',
            timeout: 5000
        });

        <% if (request.getAttribute("registrationSuccess") != null) { %>
            // Auto redirect to login after successful registration
            setTimeout(function() {
                window.location.href = 'login.jsp?message=registration_success&email=<%= request.getAttribute("registeredEmail") %>';
            }, 2000);
        <% } %>
    <% } %>
    </script>
</body>
</html>
