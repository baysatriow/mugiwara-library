<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Mugiwara Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />
    <link rel="shortcut icon" type="x-icon" href="assets/images/Logo Store.png">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/css/iziToast.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body class="auth-container">

    <div class="auth-card">
        <a href="home"><img src="assets/images/Logo Store.png" alt="Mugiwara Library Logo" class="auth-logo"></a>
        <h2 class="auth-title">Selamat Datang</h2>
        <p class="auth-subtitle">Masuk ke akun Anda untuk melanjutkan</p>

        <form action="Login" method="post" id="loginForm">
            <div class="mb-4">
                <label for="email" class="form-label">Email</label>
                <div class="position-relative">
                    <input type="email" class="form-control" id="email" name="email" required 
                           placeholder="email@contoh.com" value="${param.email}">
                    <i class="bi bi-envelope position-absolute" style="right: 15px; top: 50%; transform: translateY(-50%); color: #ae2831;"></i>
                </div>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <div class="position-relative">
                    <input type="password" class="form-control" id="password" name="password" 
                           required placeholder="Masukkan Password">
                    <button type="button" class="btn btn-outline-secondary position-absolute end-0 top-0 h-100" 
                            id="togglePassword">
                        <i class="bi bi-eye" id="eyeIcon"></i>
                    </button>
                </div>
            </div>
            
            <div class="auth-options">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" name="rememberMe" id="rememberMe">
                    <label class="form-check-label" for="rememberMe">
                        Ingat Saya
                    </label>
                </div>
                <a href="forgot-password.jsp" class="auth-link">Lupa Password?</a>
            </div>

            <button type="submit" class="btn btn-primary w-100 mt-4" id="loginBtn">
                <span class="spinner-border spinner-border-sm d-none" role="status" aria-hidden="true"></span>
                <i class="bi bi-box-arrow-in-right me-2"></i>Masuk
            </button>
        </form>

        <div class="auth-footer">
            Belum punya akun? <a href="register.jsp" class="auth-link">Daftar disini</a>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/izitoast@1.4.0/dist/js/iziToast.min.js"></script>

    <script>
        document.getElementById('togglePassword').addEventListener('click', function() {
            const passwordField = document.getElementById('password');
            const eyeIcon = document.getElementById('eyeIcon');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeIcon.classList.remove('bi-eye');
                eyeIcon.classList.add('bi-eye-slash');
            } else {
                passwordField.type = 'password';
                eyeIcon.classList.remove('bi-eye-slash');
                eyeIcon.classList.add('bi-eye');
            }
        });

        // Form submission with loading state
        document.getElementById('loginForm').addEventListener('submit', function() {
            const submitBtn = document.getElementById('loginBtn');
            const spinner = submitBtn.querySelector('.spinner-border');
            
            submitBtn.disabled = true;
            spinner.classList.remove('d-none');
            submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Memproses...';
        });

        // Load remembered email from cookie
        window.addEventListener('load', function() {
            const cookies = document.cookie.split(';');
            for (let cookie of cookies) {
                const [name, value] = cookie.trim().split('=');
                if (name === 'remembered_email') {
                    document.getElementById('email').value = decodeURIComponent(value);
                    document.getElementById('rememberMe').checked = true;
                    break;
                }
            }
        });

        // Show toast notifications
        <% if (request.getAttribute("toastType") != null) { %>
            iziToast.<%= request.getAttribute("toastType") %>({
                title: '<%= request.getAttribute("toastTitle") %>',
                message: '<%= request.getAttribute("toastMessage") %>',
                position: 'topRight',
                timeout: 5000
            });
        <% } %>

        // Show success message from URL parameter
        const urlParams = new URLSearchParams(window.location.search);
        const message = urlParams.get('message');
        
        if (message === 'logout_success') {
            iziToast.success({
                title: 'Logout Berhasil',
                message: 'Anda telah berhasil logout.',
                position: 'topRight',
                timeout: 3000
            });
        } else if (message === 'registration_success') {
            iziToast.success({
                title: 'Registrasi Berhasil',
                message: 'Akun berhasil dibuat! Silakan login.',
                position: 'topRight',
                timeout: 5000
            });
        } else if (message === 'not_logged_in') {
            iziToast.warning({
                title: 'Perhatian!',
                message: 'Anda belum login! Silakan login terlebih dahulu.',
                position: 'topRight',
                timeout: 5000
            });
        }
    </script>
</body>
</html>
