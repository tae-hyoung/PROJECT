<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!doctype html>
<html lang="en" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg"
    data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">

<head>
    <meta charset="utf-8" />
    <title>SWEET HOME 로그인</title>
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
    
    <!-- SweetAlert  -->
    <link href="/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
    
    <script src="/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
    
    <script src="/resources/js/jquery.min.js"></script>
    
    <style>
       .link-container {
           display: flex;
           justify-content: space-between;
           /* 좌, 중간, 우에 균등하게 배치 */
           width: 100%;
           margin: 0 auto;
           /* 가운데 정렬 */
       }

       .link-container a {
           flex: 1;
           text-align: center;
           /* 텍스트를 가운데 정렬 */
       }
    </style>

</head>

<body> 
    <div class="auth-one-bg-position auth-one-bg" id="loginImg">
        <div class="shape">
            <svg xmlns="http://www.w3.org/2000/svg" version="1.1" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 1440 120">
                <path d="M 0,36 C 144,53.6 432,123.2 720,124 C 1008,124.8 1296,56.8 1440,40L1440 140L0 140z"></path>
            </svg>
        </div>
       
    </div>
    <div style="width:100vw; height: 100vh; display: flex; align-items: center;"  class="auth-page-content">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">           
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6 col-xl-5">
                    <div class="card mt-4 card-bg-fill">
                        <div class="card-body p-4">
                        	<div class="text-center mb-4">
		                        <div>
		                            <a href="/" class="d-inline-block auth-logo">
		                                <img src="/resources/images/logo/logo3.png" alt="로고" style="width:80%; margin-top: 10px">
		                            </a>
		                        </div>
                    		</div>
                            <div class="text-center">
                                <h5 class="text-primary" style="font-size: 20pt;">방문을 환영합니다!</h5>
                                <p class="text-muted" style="font-size: 14pt;">SweeetHome 로그인</p>
                            </div>
                            <div class="p-2 mt-4">
                                <form action="/login" method="post" id="loginForm">
                                    <div class="mb-3">
                                        <div class="float-end">
                                            <a href="/idFind" class="text-muted">ID 찾기</a>
                                        </div>
                                        <label for="username" class="form-label">ID</label>
                                        <input type="text" class="form-control" id="memId" name="username" placeholder="ID" required>
                                    </div>

                                    <div class="mb-3">
                                        <div class="float-end">
                                            <a href="/pwFind" class="text-muted">비밀번호 찾기</a>
                                        </div>
                                        <label class="form-label" for="password-input">Password</label>
                                        <div class="position-relative auth-pass-inputgroup mb-3">
                                            <input type="password" class="form-control pe-5 password-input" placeholder="Password" id="memPw" name="password" required onkeyup="onkeyupMemberPw(event)">
                                        </div>
                                    </div>
                                    <!-- <div class="form-check">
                                        <input class="form-check-input" type="checkbox" value="" id="auth-remember-check">
                                        <label class="form-check-label" for="auth-remember-check">Remember me</label>
                                    </div> -->
                                    <div class="mt-4">
                                        <button class="btn btn-primary w-100" type="button" id="submitBtn" >로그인</button>
                                    </div>
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				                    <div class="mt-4 text-center">
				                        <p class="mb-0">아직 회원이 아니신가요? <a href="/select" class="fw-semibold text-primary text-decoration-underline"> 회원가입 </a> </p>
				                    </div>
                                </form>
                            </div>
                        </div>
                        <!-- end card body -->
                    </div>
                    <!-- end card -->


                </div>
            </div>
            <!-- end row -->
        </div>
        <!-- end container -->
    </div>
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

    <!-- Dashboard init -->
    <script src="/resources/assets/js/pages/dashboard-ecommerce.init.js"></script>
</body>
<script>
    const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    let userId = $('#memId');
    let userPw = $('#memPw');

    $('#submitBtn').on('click', function () {
        if(userId.val().length === 0){
            Swal.fire({
                icon: "warning",
                title: "",
                text: "ID를 입력하세요",
            });
            return;
        }

        if(userPw.val().length === 0){
            Swal.fire({
                icon: "warning",
                title: "",
                text: "비밀번호를 입력하세요",
            });
            return;
        }
        
        $.ajax({
            url: "/logInMember",
            type: 'POST',
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(
                { 
                    "memId": userId.val(),
                    "memPw": userPw.val()
                }
            ),  
            beforeSend:
                function (xhr) {
                    xhr.setRequestHeader(csrfHeader, csrfToken);
                },
            success: function (response) {
                console.log(response.status);
                if (response.status === 'success') {
                    $('#loginForm').submit();
                }
                else if(response.status === 'dormant'){
                    event.preventDefault();
                    Swal.fire({
                        icon: "warning",
                        title: "휴면 상태",
                        text: "비밀번호 변경 후 이용해주세요."
                    }).then((result) => {
                        if(result.isConfirmed){  
                            sessionStorage.setItem('dormantMemId', userId.val());// 입력했던 아이디 값 보내버리기
                        	window.location.href="/pwChange";
                        }
                    })
                }else if(response.status === 'wait'){
                	event.preventDefault();
                	Swal.fire({
	               		  title: "승인 대기중",
	               		  html: "관리자 승인후 이용 가능합니다(휴일 제외 1 ~ 2일 소요)<br>문의사항 : SWEET HOME",
	               		  icon: "warning"
               			});
                    return;
                }else if(response.status === 'reject'){
                	event.preventDefault();
                	Swal.fire({
                		icon: "error",
                        title: "승인이 거부된 계정입니다.",
                        text: "문의사항 SWEET HOME"
                	})
                	return;
                }     
                else {
                    event.preventDefault();
                    Swal.fire({
                        icon: "error",
                        title: "로그인 실패!",
                        text:  "문의사항 : SWEET HOME",
                    });
                    return;    
                }
            },
            error: function (error) {
                Swal.fire({
                    icon: "error",
                    title: "이거 뜨면 안되는데요?",
                    text: "문의사항 정명진",
                });    
            }
        });
    });
    
    function onkeyupMemberPw(event){
    	if(event.key == 'Enter') 
        $('#submitBtn').click();
    }
    
</script>

</html>