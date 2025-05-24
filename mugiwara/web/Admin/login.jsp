<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en" data-bs-theme="light">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login Dashboard - Mugiwara Library - </title>
  <!--favicon-->
	<link rel="icon" href="assets/images/favicon-32x32.png" type="image/png">

  <!--plugins-->
  <link href="assets/plugins/perfect-scrollbar/css/perfect-scrollbar.css" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="assets/plugins/metismenu/metisMenu.min.css">
  <link rel="stylesheet" type="text/css" href="assets/plugins/metismenu/mm-vertical.css">
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
                      <form class="row g-3">
                          <div class="col-12">
                              <label for="inputEmailAddress" class="form-label">Email</label>
                              <input type="email" class="form-control" id="inputEmailAddress" placeholder="baysatriow@contoh.com">
                          </div>
                          <div class="col-12">
                              <label for="inputChoosePassword" class="form-label">Password</label>
                              <div class="input-group" id="show_hide_password">
                                  <input type="password" class="form-control border-end-0" id="inputChoosePassword" value="12345678" placeholder="Masukkan Password"> 
                                  <a href="javascript:;" class="input-group-text bg-transparent"><i class="bi bi-eye-slash-fill"></i></a>
                              </div>
                          </div>
                          <div class="col-md-6">
                              <div class="form-check form-switch">
                                  <input class="form-check-input" type="checkbox" id="flexSwitchCheckChecked">
                                  <label class="form-check-label" for="flexSwitchCheckChecked">Ingat Saya</label>
                              </div>
                          </div>
                          <div class="col-md-6 text-end">
                              <a href="auth-basic-forgot-password.html">Lupa Password ?</a>
                          </div>
                          <div class="col-12">
                              <div class="d-grid">
                                  <button type="submit" class="btn btn-custom">Masuk</button>
                              </div>
                          </div>
                          <div class="col-12">
                              <div class="text-center">
                                  <p class="mb-0">Belum punya Akun? <a href="daftar.jsp">Hubungi Admin!</a></p>
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


    <!--plugins-->
    <script src="assets/js/jquery.min.js"></script>

    <script>
      $(document).ready(function () {
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
      });
    </script>
  
  </body>
</html>