<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8" />
    <title>비밀번호 변경</title>
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
                    <div class="text-center">
                        <div>
                            <a href="/" class="d-inline-block auth-logo">
                                <img src="/resources/images/logo/logo3.png" alt="로고" width="417px" height="91px">
                            </a>
                        </div>
                    </div>
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
                                    <label for="memPw" class="form-label">변경 할 비밀번호</label>
                                    <div class="position-relative auth-pass-inputgroup">
                                        <input type="password" class="form-control" id="memPw" name="memPw" placeholder="비밀번호(영문, 숫자, 특수문자 1개포함 8 ~ 20자 )">
                                        <button class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon material-shadow-none" type="button" id="lookPw">
                                            <i class="ri-eye-fill align-middle"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="memPwChk" class="form-label">비밀번호 확인</label>
                                    <div class="position-relative auth-pass-inputgroup">
                                        <input type="password" class="form-control" id="memPwChk" name="memPwChk" placeholder="비밀번호 확인">
                                        <button class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon material-shadow-none" type="button" id="lookPwChk">
                                            <i class="ri-eye-fill align-middle"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <button type="button" class="btn btn-primary w-100" id="passwordChange">비밀번호 변경</button>
                                </div>
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
const memId = sessionStorage.getItem("dormantMemId");


/* 가려진 비밀번호 확인하기 */
function lookPwBtn(btn, password){
    $(btn).on('click', function(){
        const inputPassword = $(password);
        const button = $(btn);
        if(inputPassword.attr("type") === 'password'){
            inputPassword.attr('type', 'text');
            button.html('<i class="ri-eye-off-fill align-middle"></i>');
        }else{
            inputPassword.attr('type', 'password');
            button.html('<i class="ri-eye-fill align-middle"></i>');
        }
    });
}
// 이벤트 리스너 등록
lookPwBtn('#lookPw', '#memPw');
lookPwBtn('#lookPwChk', '#memPwChk');

$("#passwordChange").click(function(){

	console.log("아이디 값 -> ", memId);
    
    let memPw = $('#memPw').val();
    let memPwChk = $('#memPwChk').val();

    const pattern = /^(?=.*\d)(?=.*[a-z])(?=.*[!@#$%^&*]).{8,20}$/; // 비밀번호 입력 관련...
    console.log("값 : ", memPw);
    console.log("길이 : ", memPw.length)
    if(memPw.length === 0){
        Swal.fire({
            title: '',
            text: '비밀번호를 입력하세요.',
            icon: 'warning'
        });
        return;
    }

    if(memPw.length < 8 || memPw.length > 20){
        Swal.fire("변경 실패!", "비밀번호는 8자이상 20자 이하로 설정 하세요", "error");
        return;
    }

    if(!pattern.test(memPw)){
        Swal.fire("변경 실패!", "영문, 숫자, 특수문자(!@#$%^&*) 는 반드시 1개이상 포함해야 합니다.", "error");
        return;
    }

    if(memPw !== memPwChk){
        Swal.fire("변경 실패!", "비밀번호 일치 여부를 확인하세요.", "error");
        return;
    }

    $.ajax({
        url:"/pwChange.do",
        type: 'POST',
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify({
            "memId": memId,
            "memPw": memPw
        }),
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader(csrfHeader, csrfToken);
        },
        success: function(){
            console.log(memId);
            console.log(memPw);
            Swal.fire({
                icon: "success",
                title: "비밀번호 변경 성공",
                text: "비밀번호가 변경되었습니다!"
            }).then((result) => {
                if(result.isConfirmed){
                	 window.location.href="/login";
                }
            });
        },error: function(error){
            console.log(error);
        }
    })
});

</script>
</html>