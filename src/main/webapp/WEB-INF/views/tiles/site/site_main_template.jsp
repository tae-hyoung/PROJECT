<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<script src="/resources/sbadmin/vendor/jquery/jquery.min.js"></script>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SweetHome</title>

		<!-- Bootstrap CSS -->
		<link rel="stylesheet" href="/resources/site/css/bootstrap.min.css">
		<!-- Nice Select CSS -->
		<link rel="stylesheet" href="/resources/site/css/nice-select.css">
		<!-- Font Awesome CSS -->
		<link rel="stylesheet" href="/resources/site/css/font-awesome.min.css">
		<!-- icofont CSS -->
		<link rel="stylesheet" href="/resources/site/css/icofont.css">
		<!-- Slicknav -->
		<link rel="stylesheet" href="/resources/site/css/slicknav.min.css">
		<!-- Owl Carousel CSS -->
		<link rel="stylesheet" href="/resources/site/css/owl-carousel.css">
		<!-- Datepicker CSS -->
		<link rel="stylesheet" href="/resources/site/css/datepicker.css">
		<!-- Animate CSS -->
		<link rel="stylesheet" href="/resources/site/css/animate.min.css">
		<!-- Magnific Popup CSS -->
		<link rel="stylesheet" href="/resources/site/css/magnific-popup.css">
		
		<!-- Medipro CSS -->
		<link rel="stylesheet" href="/resources/site/css/normalize.css">
		<link rel="stylesheet" href="/resources/site/css/style.css">
		<link rel="stylesheet" href="/resources/site/css/responsive.css">

    <!-- Custom fonts for this template-->
    <link href="/resources/sbadmin/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="/resources/sbadmin/css/sb-admin-2.min.css" rel="stylesheet">
    
    <!-- sweet alert -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">


        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar ///// header.jsp 시작 /////// -->
                <tiles:insertAttribute name="header" />
                <!-- End of Topbar /////header.jsp 끝///// -->
	
		        <!-- site /// site.jsp 시작 ///// -->
		        <tiles:insertAttribute name="banner" />
		        <!-- End of site  /// site.jsp 끝 /////-->
        
                <!-- Begin Page Content -->
                <div class="container-fluid">
					<tiles:insertAttribute name="body" />
                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer /// footer.jsp 시작 ///// -->
            <tiles:insertAttribute name="footer" />
            <!-- End of Footer /// footer.jsp 끝 /////-->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">로그아웃 버튼을 클릭하면 로그아웃 됩니다.</div>
                <div class="modal-footer">
                	<form action="/logout" method="post">
	                    <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>                    
	                    <button type="submit" class="btn btn-primary">로그아웃</button>
	                    <sec:csrfInput />
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="/resources/sbadmin/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="/resources/sbadmin/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="/resources/sbadmin/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
<!--     <script src="/resources/sbadmin/vendor/chart.js/Chart.min.js"></script> -->

    <!-- Page level custom scripts -->
<!--     <script src="/resources/sbadmin/js/demo/chart-area-demo.js"></script> -->
<!--     <script src="/resources/sbadmin/js/demo/chart-pie-demo.js"></script> -->
	
		<!-- scripts -->
		<!-- jquery Min JS -->
		<script src="/resources/site/js/jquery.min.js"></script>
		<!-- jquery Migrate JS -->
		<script src="/resources/site/js/jquery-migrate-3.0.0.js"></script>
		<!-- jquery Ui JS -->
		<script src="/resources/site/js/jquery-ui.min.js"></script>
		<!-- Easing JS -->
		<script src="/resources/site/js/easing.js"></script>
		<!-- Color JS -->
		<script src="/resources/site/js/colors.js"></script>
		<!-- Popper JS -->
		<script src="/resources/site/js/popper.min.js"></script>
		<!-- Bootstrap Datepicker JS -->
		<script src="/resources/site/js/bootstrap-datepicker.js"></script>
		<!-- Jquery Nav JS -->
		<script src="/resources/site/js/jquery.nav.js"></script>
		<!-- Slicknav JS -->
		<script src="/resources/site/js/slicknav.min.js"></script>
		<!-- ScrollUp JS -->
		<script src="/resources/site/js/jquery.scrollUp.min.js"></script>
		<!-- Niceselect JS -->
		<script src="/resources/site/js/niceselect.js"></script>
		<!-- Tilt Jquery JS -->
		<script src="/resources/site/js/tilt.jquery.min.js"></script>
		<!-- Owl Carousel JS -->
		<script src="/resources/site/js/owl-carousel.js"></script>
		<!-- counterup JS -->
		<script src="/resources/site/js/jquery.counterup.min.js"></script>
		<!-- Steller JS -->
		<script src="/resources/site/js/steller.js"></script>
		<!-- Wow JS -->
		<script src="/resources/site/js/wow.min.js"></script>
		<!-- Magnific Popup JS -->
		<script src="/resources/site/js/jquery.magnific-popup.min.js"></script>
		<!-- Counter Up CDN JS -->
		<script
			src="http://cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
		<!-- Bootstrap JS -->
		<script src="/resources/site/js/bootstrap.min.js"></script>
		<!-- Main JS -->
		<script src="/resources/site/js/main.js"></script>

</body>

</html>