<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!doctype html>
<html lang="en" data-bs-theme="light">

<head>
  <base href="${pageContext.request.contextPath}/Admin/">
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Mugiwara Library - Admin Dashboard</title>
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
  <link href="sass/semi-dark.css" rel="stylesheet">
  <link href="sass/bordered-theme.css" rel="stylesheet">
  <link href="sass/responsive.css" rel="stylesheet">

  <style>
    /* Ensuring the icons and text are white */
    .nav-link i {
        color: white !important;
    }
    .nav-link {
        color: white !important;
    }
  </style>
</head>

<body>

  <!--start header-->
  <jsp:include page="Components/header.jsp" flush="false"></jsp:include>
  <!--end top header-->

  <!--start mini sidebar-->
  <jsp:include page="Components/sidebar.jsp" flush="false"></jsp:include>
  <!--end mini sidebar-->
  
  <!--start main wrapper-->
  <main class="main-wrapper">
  <%
    String content = (String) request.getAttribute("content");
    if ("home".equals(content)){
        %>  
        <jsp:include page="home.jsp" flush="false"></jsp:include>
        <%
    } else if ("statistik".equals(content)){
        %>
        <jsp:include page="statistik.jsp" flush="false"></jsp:include>
        <%
    } else if ("barang".equals(content)){
        %>
        <jsp:include page="barang.jsp" flush="false"></jsp:include>
        <%
    } else if ("manageuser".equals(content)){
        %>
        <jsp:include page="manageuser.jsp" flush="false"></jsp:include>
        <%
    } else if ("setting".equals(content)){
        %>
        <jsp:include page="setting.jsp" flush="false"></jsp:include>
        <%
    } else {
        %>
        <jsp:include page="error-404.jsp" flush="false"></jsp:include>
        <%
    }
    
    %>  
  </main>
  <!--end main wrapper-->

  <!--start primary menu offcanvas-->
  <jsp:include page="Components/mainsidebar.jsp" flush="false"></jsp:include>
  <!--end primary menu offcanvas-->


  <!--start user details offcanvas-->
  <jsp:include page="Components/profile.jsp" flush="false"></jsp:include>
  <!--end user details offcanvas-->


  <!--start switcher-->
  <button class="btn btn-primary position-fixed bottom-0 end-0 m-3 d-flex align-items-center gap-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#staticBackdrop">
    <i class="material-icons-outlined">tune</i>Customize
  </button>
  
  <div class="offcanvas offcanvas-end" data-bs-scroll="true" tabindex="-1" id="staticBackdrop">
    <div class="offcanvas-header border-bottom h-70 justify-content-between">
      <div class="">
        <h5 class="mb-0">Theme Customizer</h5>
        <p class="mb-0">Customize your theme</p>
      </div>
      <a href="javascript:;" class="primaery-menu-close" data-bs-dismiss="offcanvas">
        <i class="material-icons-outlined">close</i>
      </a>
    </div>
    <div class="offcanvas-body">
      <div>
        <p>Theme variation</p>

        <div class="row g-3">
          <div class="col-12 col-xl-6">
            <input type="radio" class="btn-check" name="theme-options" id="LightTheme" checked>
            <label class="btn btn-outline-secondary d-flex flex-column gap-1 align-items-center justify-content-center p-4" for="LightTheme">
              <span class="material-icons-outlined">light_mode</span>
              <span>Light</span>
            </label>
          </div>
          <div class="col-12 col-xl-6">
            <input type="radio" class="btn-check" name="theme-options" id="DarkTheme">
            <label class="btn btn-outline-secondary d-flex flex-column gap-1 align-items-center justify-content-center p-4" for="DarkTheme">
              <span class="material-icons-outlined">dark_mode</span>
              <span>Dark</span>
            </label>
          </div>
          <div class="col-12 col-xl-6">
            <input type="radio" class="btn-check" name="theme-options" id="SemiDarkTheme">
            <label class="btn btn-outline-secondary d-flex flex-column gap-1 align-items-center justify-content-center p-4" for="SemiDarkTheme">
              <span class="material-icons-outlined">contrast</span>
              <span>Semi Dark</span>
            </label>
          </div>
          <div class="col-12 col-xl-6">
            <input type="radio" class="btn-check" name="theme-options" id="BoderedTheme">
            <label class="btn btn-outline-secondary d-flex flex-column gap-1 align-items-center justify-content-center p-4" for="BoderedTheme">
              <span class="material-icons-outlined">border_style</span>
              <span>Bordered</span>
            </label>
          </div>
        </div><!--end row-->

      </div>
    </div>
  </div>
  <!--start switcher-->


  <!--bootstrap js-->
  <script src="assets/js/bootstrap.bundle.min.js"></script>

  <!--plugins-->
  <script src="assets/js/jquery.min.js"></script>
  <!--plugins-->
  <script src="assets/plugins/perfect-scrollbar/js/perfect-scrollbar.js"></script>
  <script src="assets/plugins/metismenu/metisMenu.min.js"></script>
  <script src="assets/plugins/apexchart/apexcharts.min.js"></script>
  <%
    String validChart = (String) request.getAttribute("content");
    if ("home".equals(validChart)){
        %>  
        <script src="assets/js/index.js"></script>
        <%
    } else if ("statistik".equals(validChart)){
        %>
          <script src="assets/js/index2.js"></script>
        <%
    }
  %>  
  <script src="assets/plugins/peity/jquery.peity.min.js"></script>
  <script src="assets/plugins/datatable/js/jquery.dataTables.min.js"></script>
	<script src="assets/plugins/datatable/js/dataTables.bootstrap5.min.js"></script>
  <script>
    $(".data-attributes span").peity("donut")
  </script>
  <script src="assets/js/main.js"></script>
  <script>
		$(document).ready(function() {
			$('#userTable').DataTable();
		  } );
	</script>
	<!-- <script>
		$(document).ready(function() {
			var table = $('#example2').DataTable( {
				lengthChange: false,
				buttons: [ 'copy', 'excel', 'pdf', 'print']
			} );
		 
			table.buttons().container()
				.appendTo( '#example2_wrapper .col-md-6:eq(0)' );
		} );
	</script> -->
  <script>
    document.addEventListener('DOMContentLoaded', function() {
        <% 
        String notificationMsg = (String) session.getAttribute("notificationMsg");
        String notificationType = (String) session.getAttribute("notificationType");

        if (notificationMsg != null && notificationType != null) {
        %>
            Lobibox.notify('<%= notificationType %>', { // Tipe notifikasi: 'success', 'error', 'info', 'warning'
                pauseDelayOnHover: true,
                continueDelayOnInactiveTab: false,
                position: 'top right',
                icon: '<%= "success".equals(notificationType) ? "bi bi-check2-circle" : ("error".equals(notificationType) ? "bi bi-x-octagon" : "bi bi-info-circle") %>', // Sesuaikan ikon
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
</body>

</html>