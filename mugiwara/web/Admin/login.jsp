<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en" data-bs-theme="light">

<head>
  <base href="${pageContext.request.contextPath}/Admin/">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login Dashboard - Mugiwara Library</title>
  <!--favicon-->
	<link rel="icon" href="assets/images/favicon-32x32.png" type="image/png">

  <!--plugins-->
  <link href="assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="assets/plugins/metismenu/metisMenu.min.css">
  <link rel="stylesheet" type="text/css" href="assets/plugins/metismenu/mm-vertical.css">
  <link rel="stylesheet" href="assets/plugins/notifications/css/lobibox.min.css">
  <!--bootstrap css-->
  <link href="assets/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css?family=Material+Icons+Outlined" rel="stylesheet">
  <!--main css-->
  <link href="assets/css/bootstrap-extended.css" rel="stylesheet">
  <link href="sass/main.css" rel="stylesheet">
  <link href="sass/dark-theme.css" rel="stylesheet">
  <link href="sass/responsive.css" rel="stylesheet">

  <style>
    /* Custom styles */
    .form-control {
        border-color: #AD2831;
    }
    .form-control:focus {
        border-color: #AD2831;
        box-shadow: 0 0 0 0.2rem rgba(173, 40, 49, 0.25);
    }
    .btn-custom {
        background-color: #AD2831;
        border-color: #AD2831;
        color: white;
    }
    .btn-custom:hover {
        background-color: #9e2127;
        border-color: #9e2127;
    }
    .btn-custom:disabled {
        background-color: #6c757d;
        border-color: #6c757d;
    }
    .loading-spinner {
        display: none;
    }
</style>
  </head>

  <body class="bg-login">

    <!--authentication-->
     <div class="container-fluid my-5">
        <div class="row">
           <div class="col-12 col-md-8 col-lg-6 col-xl-5 col-xxl-4 mx-auto">
            <div class="card rounded-4">
              <div class="card-body p-5 d-flex flex-column align-items-center justify-content-center">
                  <img src="assets/images/logo_store.png" class="mb-4" width="145" alt="">
                  <h4 class="fw-bold text-center">Masuk Dashboard Admin</h4>
                  <p class="mb-0 text-center">Silahkan Masukkan Data Akun Anda!</p>
                
                  <div class="form-body my-4">
                      <form class="row g-3" method="POST" action="../Logina" id="loginForm">
                          <div class="col-12">
                              <label for="inputEmailAddress" class="form-label">Email</label>
                              <input type="email" name="email" class="form-control" id="inputEmailAddress" 
                                     placeholder="admin@contoh.com" required maxlength="100"
                                     value="${param.email}">
                          </div>
                          <div class="col-12">
                              <label for="inputChoosePassword" class="form-label">Password</label>
                              <div class="input-group" id="show_hide_password">
                                  <input type="password" class="form-control border-end-0" id="inputChoosePassword" 
                                         name="password" placeholder="Masukkan Password" required maxlength="255"> 
                                  <a href="javascript:;" class="input-group-text bg-transparent">
                                      <i class="bi bi-eye-slash-fill"></i>
                                  </a>
                              </div>
                          </div>
                          <div class="col-md-6">
                              <div class="form-check form-switch">
                                  <input class="form-check-input" type="checkbox" id="flexSwitchCheckChecked" name="rememberMe">
                                  <label class="form-check-label" for="flexSwitchCheckChecked">Ingat Saya</label>
                              </div>
                          </div>
                          <div class="col-md-6 text-end">
                              <a href="forgot-password.jsp">Lupa Password ?</a>
                          </div>
                          <div class="col-12">
                              <div class="d-grid">
                                  <button type="submit" class="btn btn-custom" id="loginBtn">
                                      <span class="loading-spinner spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
                                      <span class="btn-text">Masuk</span>
                                  </button>
                              </div>
                          </div>
                          <div class="col-12">
                              <div class="text-center">
                                  <p class="mb-0">Belum punya Akun? <a href="contact-admin.jsp">Hubungi Admin!</a></p>
                              </div>
                          </div>
                      </form>
                  </div>
              </div>
            </div>
           </div>
        </div><!--end row-->
     </div>
      
    <!--authentication-->

  <!--bootstrap js-->
  <script src="assets/js/bootstrap.bundle.min.js"></script>

  <!--plugins-->
  <script src="assets/js/jquery.min.js"></script>
  <!--plugins-->
  <script src="assets/plugins/perfect-scrollbar/js/perfect-scrollbar.js"></script>
  <script src="assets/plugins/metismenu/metisMenu.min.js"></script>
  <!--notification js -->
	<script src="assets/plugins/notifications/js/lobibox.min.js"></script>
	<script src="assets/plugins/notifications/js/notifications.min.js"></script>
	<script src="assets/plugins/notifications/js/notification-custom-script.js"></script>
  <script src="assets/js/main.js"></script>

    <script>
      $(document).ready(function () {
        // Toggle password visibility
        $("#show_hide_password a").on('click', function (event) {
          event.preventDefault();
          if ($('#show_hide_password input').attr("type") == "text") {
            $('#show_hide_password input').attr('type', 'password');
            $('#show_hide_password i').addClass("bi-eye-slash-fill");
            $('#show_hide_password i').removeClass("bi-eye-fill");
          } else if ($('#show_hide_password input').attr("type") == "password") {
            $('#show_hide_password input').attr('type', 'text');
            $('#show_hide_password i').removeClass("bi-eye-slash-fill");
            $('#show_hide_password i').addClass("bi-eye-fill");
          }
        });

        // Form submission with loading state
        $('#loginForm').on('submit', function() {
            const submitBtn = $('#loginBtn');
            const spinner = submitBtn.find('.loading-spinner');
            const btnText = submitBtn.find('.btn-text');
            
            submitBtn.prop('disabled', true);
            spinner.show();
            btnText.text('Memproses...');
        });

        // Load remembered email from cookie
        const cookies = document.cookie.split(';');
        for (let cookie of cookies) {
            const [name, value] = cookie.trim().split('=');
            if (name === 'admin_remembered_email') {
                $('#inputEmailAddress').val(decodeURIComponent(value));
                $('#flexSwitchCheckChecked').prop('checked', true);
                break;
            }
        }

        // Show success message from URL parameter
        const urlParams = new URLSearchParams(window.location.search);
        const message = urlParams.get('message');
        
        if (message === 'logout_success') {
            Lobibox.notify('success', {
                pauseDelayOnHover: true,
                continueDelayOnInactiveTab: false,
                position: 'top right',
                icon: 'bi bi-check2-circle',
                msg: 'Anda telah berhasil logout dari dashboard admin.',
                sound: false
            });
        }
      });
    </script>

    <!-- Notification Script -->
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        <% 
        String notificationMsg = (String) request.getAttribute("notificationMsg");
        String notificationType = (String) request.getAttribute("notificationType");

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
            request.removeAttribute("notificationMsg");
            request.removeAttribute("notificationType");
        }
        %>
    });
    </script>

    <!-- Email validation script -->
    <script>
        // Real-time email validation
        $('#inputEmailAddress').on('blur', function() {
            const email = $(this).val();
            const emailRegex = /^[a-zA-Z0-9_+&*-]+(?:\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$/;
            
            if (email && !emailRegex.test(email)) {
                $(this).addClass('is-invalid');
                if (!$(this).next('.invalid-feedback').length) {
                    $(this).after('<div class="invalid-feedback">Format email tidak valid</div>');
                }
            } else {
                $(this).removeClass('is-invalid');
                $(this).next('.invalid-feedback').remove();
            }
        });

        // Remove validation on input
        $('#inputEmailAddress').on('input', function() {
            $(this).removeClass('is-invalid');
            $(this).next('.invalid-feedback').remove();
        });
    </script>
  </body>
</html>