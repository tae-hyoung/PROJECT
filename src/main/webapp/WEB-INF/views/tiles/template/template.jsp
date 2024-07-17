
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<!doctype html>
<html lang="en" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">

<head>

    <meta charset="utf-8" />
    <title>SWEET_HOME</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta content="Premium Multipurpose Admin & Dashboard Template" name="description" />
    <meta content="Themesbrand" name="author" />
    <!-- App favicon -->
    <link rel="shortcut icon" href="/resources/assets/images/favicon.ico">

    <!-- jsvectormap css -->
    <link href="/resources/assets/libs/jsvectormap/css/jsvectormap.min.css" rel="stylesheet" type="text/css" />

    <!--Swiper slider css-->
    <link href="/resources/assets/libs/swiper/swiper-bundle.min.css" rel="stylesheet" type="text/css" />

    <!-- Layout config Js -->
    <script src="/resources/assets/js/layout.js"></script>
    <!-- Bootstrap Css -->
    <link href="/resources/assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="/resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="/resources/assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <!-- custom Css-->
    <link href="/resources/assets/css/custom.min.css" rel="stylesheet" type="text/css" />
    
    <script src="/resources/js/jquery.min.js"></script>

    <!-- sweet alert -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
	
</head>

<body>

    <!-- Begin page -->
    <div id="layout-wrapper">

        
                <tiles:insertAttribute name="header" />
        
                <tiles:insertAttribute name="sidebar" />


        <!-- ============================================================== -->
        <!-- Start right Content here -->
        <!-- ============================================================== -->
        <div class="main-content">

            <div class="page-content">
                <div class="container-fluid">

                    <div class="row">
<!--                     <div> -->
                <tiles:insertAttribute name="body" />

                    </div>

                </div>
                <!-- container-fluid -->
            </div>
            <!-- End Page-content -->

                <tiles:insertAttribute name="footer" />
        </div>
        <!-- end main content-->

    </div>
    <!-- END layout-wrapper -->



    <!--start back-to-top-->
    <button onclick="topFunction()" class="btn btn-danger btn-icon" id="back-to-top">
        <i class="ri-arrow-up-line"></i>
    </button>
    <!--end back-to-top-->

    <!--preloader-->
    <div id="preloader">
        <div id="status">
            <div class="spinner-border text-primary avatar-sm" role="status">
                <span class="visually-hidden">Loading...</span>
            </div>
        </div>
    </div>

    <!-- JAVASCRIPT -->
    <script src="/resources/assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/resources/assets/libs/simplebar/simplebar.min.js"></script>
    <script src="/resources/assets/libs/node-waves/waves.min.js"></script>
    <script src="/resources/assets/libs/feather-icons/feather.min.js"></script>
    <script src="/resources/assets/js/pages/plugins/lord-icon-2.1.0.js"></script>
    <script src="/resources/assets/js/plugins.js"></script>

    <!-- apexcharts -->
    <script src="/resources/assets/libs/apexcharts/apexcharts.min.js"></script>

    <!-- Vector map-->
    <script src="/resources/assets/libs/jsvectormap/js/jsvectormap.min.js"></script>
    <script src="/resources/assets/libs/jsvectormap/maps/world-merc.js"></script>

    <!--Swiper slider js-->
    <script src="/resources/assets/libs/swiper/swiper-bundle.min.js"></script>
	<script src="/resources/assets/js/pages/swiper.init.js"></script>

    <!-- Dashboard init -->
    <script src="/resources/assets/js/pages/dashboard-ecommerce.init.js"></script>

    <!-- App js -->
<!--     <script src="/resources/assets/js/app.js"></script> -->
</body>

</html>