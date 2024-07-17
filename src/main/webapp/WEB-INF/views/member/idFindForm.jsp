<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <title>아이디 찾기</title>
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
</head>

<body>
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
		                                <img src="/resources/images/logo/logo3.png" alt="로고" style="width:100%;">
		                            </a>
		                        </div>
                    		</div>
                            <div class="p-2 mt-4">
                                <div class="mb-3">
                                    <label for="memNm" class="form-label">회원명 / 업체명</label>
                                    <input type="text" class="form-control" id="memNm" name="memNm" placeholder="회원명 / 업체명">
                                </div>
                                <div class="mb-3">
                                    <label for="memTelno" class="form-label">연락처</label>
                                    <input type="text" class="form-control" id="memTelno" name="memTelno" placeholder="연락처">
                                </div>
                                <div class="mt-4">
                                    <button type="button" class="btn btn-primary w-100" id="find">찾기</button>
                                </div>
                            </div>
                            <div class="mt-4 text-end">
                                <a href="/login" class="fw-semibold text-primary text-decoration-underline"> 로그인 </a> </p>
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
</body>
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
<script>
     const csrfHeader = "${_csrf.headerName}";
     const csrfToken = "${_csrf.token}";

     $('#memTelno').on('input', rgxTelno);

    function rgxTelno(tel){
        const input = tel.target;
        const value = input.value;

        if(value !== undefined){
            const filteredValue = value.replace(/[^0-9]/g, '');
            input.value = filteredValue;
        }
    }

    /* 아이디 찾기 */
    $('#find').click(function(){
        let memNm = $('#memNm').val();
        let memTelno = $('#memTelno').val();

        console.log(memNm.length);
        if(memNm.length === 0){
            Swal.fire({
                title: '',
                text: '회원명 / 업체명을 입력하세요.',
                icon: 'warning' 
            })
            return;
        }

        if(memTelno.length === 0){
            Swal.fire({
                title: '',
                text: '연락처를 입력하세요.',
                icon: 'warning' 
            })
            return;
        }

        $.ajax({
            type: 'POST',
            url: '/idFind.do',
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify({
                memNm: memNm,
                memTelno: memTelno
            }),
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(response){
                console.log(response.memId);
                if(response.memId){
                    const memId = response.memId;
                    Swal.fire({
                        title: '아이디 찾기 결과',
                        text: 'ID : ' + memId
                    });
                }else{
                    Swal.fire({
                        title: '아이디 찾기 결과',
                        text: '입력하신 정보와 일치하는 아이디가 존재하지 않습니다!',
                        icon: 'error',
                    })
                }
            },error: function(xhr, status, error){
                console.log("에러발생 : ", error);
            }
        })
    })

</script>
</html>