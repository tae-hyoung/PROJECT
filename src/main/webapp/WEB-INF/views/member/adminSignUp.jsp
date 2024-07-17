<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg"
	data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">

<head>
	<meta charset="utf-8" />
	<title>관리자 회원가입</title>
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
    <style>
        .form-control {
            margin-bottom: 0;
        }
        .input-group {
            margin-bottom: 15px;
        }
        body {
            background-color: #B3B1B1;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
            font-family: Arial, sans-serif;
        }
    </style>
</head>
<body>
    <div style="width:100%; overflow-x: auto; display: flex; align-items: center;" class="auth-page-content" class="row">
		<div class="container">
			<!-- end row -->
			<div class="row justify-content-center">
				<div class="col-md-8 col-lg-6 col-xl-6">
					<div class="card mt-4 card-bg-fill">
						<a href="/" class="d-inline-block auth-logo">
               	          <img src="/resources/images/logo/logo3.png" alt="로고" width="417px" height="91px">
                        </a>
                        <div class="card-body">
                            <div class="card-body p-4">
                                <div class="text-center mt-2">
                                    <h5 class="text-primary">관리자 회원가입</h5>
                                    <br/>
                                </div>
                                <div class="p-2 mt-4">
                                    <div class="card mt-n5">
                                        <div class="card-body p-4">
                                            <div class="text-center">
                                                <div class="profile-user position-relative d-inline-block mx-auto  mb-4">
                                                    <img src="/resources/images/profile/basic.png" class="rounded-circle avatar-xl img-thumbnail user-profile-image material-shadow" alt="user-profile-image" id="adminImg">
                                                    <div class="avatar-xs p-0 rounded-circle profile-photo-edit">
                                                        <input id="profImg-Admin" name="profImg-Admin" type="file" class="profile-img-file-input">
                                                        <label for="profImg-Admin" class="profile-photo-edit avatar-xs">
                                                            <span class="avatar-title rounded-circle bg-light text-body material-shadow">
                                                                <i class="ri-camera-fill"></i>
                                                            </span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <h5 class="fs-16 mb-1">프로필사진</h5>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="adminId" class="form-label">아이디 <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="adminId" placeholder="아이디를 입력하세요" maxlength=20 required>
                                        <!-- 아이디 중복 발생 알림창 -->
                                        <div id="adminIdValid"></div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="adminSelect" class="form-label">관리 단지<span class="text-danger">*</span>
                                        </label> 
                                        <select id="adminSelect" class="form-select">
                                            <option value="" selected>관리 단지 선택</option>
                                            <c:forEach var="danji" items="${danjiList}" varStatus="stat">
                                            <option value="${danji.danjiCode }">${danji.danjiName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" for="password-input">비밀번호</label> <span
                                            class="text-danger">*</span>
                                        <div class="position-relative auth-pass-inputgroup">
                                            <input type="password" class="form-control pe-5 password-input"
                                                placeholder="비밀번호" id="adminPw" name="adminPw" required>
                                            <button
                                                class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon material-shadow-none"
                                                type="button" id="lookAdminPw">
                                                <i class="ri-eye-fill align-middle"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label" for="password-input">비밀번호 확인</label>
                                        <span class="text-danger">*</span>
                                        <div class="position-relative auth-pass-inputgroup">
                                            <input type="password" class="form-control pe-5 password-input"
                                                placeholder="비밀번호 확인" id="adminPwChk" aria-describedby="passwordInput"
                                                pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required
                                                aria-autocomplete="list">
                                            <button
                                                class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon material-shadow-none"
                                                type="button" id="lookAdminPwChk">
                                                <i class="ri-eye-fill align-middle"></i>
                                            </button>
                                        </div>
                                        <div id="equalAdminPw"></div>
                                    </div>
                                    <div class="mb-3">
                                        <label for="username" class="form-label">관리업체 명 <span
                                                class="text-danger">*</span></label> <input type="text" class="form-control"
                                            id="adminNm" name="adminNm" placeholder="관리업체 명" required>
                                    </div>
                                    <div class="mb-3">
                                        <label for="JoiningdatInput" class="form-label">연락처 <span
                                                class="text-danger">*</span></label> <input type="text" class="form-control"
                                            id="adminTelno" name="adminTelno" placeholder="연락처" maxlength="15" required>
                                    </div>
                                    <div class="input-group mb-6">
                                        <label for="JoiningdatInput" class="form-label">전자주소(이메일)
                                            <span class="text-danger">*</span>
                                        </label>
                                        <div class="input-group mb-6">
                                            <input type="text" class="form-control mb-3" id="adminEmail" name="adminEmail"
                                                placeholder="아이디" aria-label="Email" required>
                                            <span class="input-group-text mb-3">@</span> <input type="text"
                                                class="form-control mb-3" id="adminDomain" name="adminDomain" value="" placeholder="도메인 선택"
                                                readonly /> <select class="form-select mb-3" name="selectAdminDomain"
                                                id="selectAdminDomain" data-choice="active">
                                                <option value="" selected>선택하세요</option>
                                                <option value="naver.com">naver.com</option>
                                                <option value="hanmail.net">hanmail.net</option>
                                                <option value="gmail.com">gmail.com</option>
                                                <option value="direct">직접입력</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <input type="button" class="btn btn-primary w-100" value="가입신청" id="submitAdmin">
                                    </div>
                                </div>
                            </div>
                        </div>     
                        <!-- end card-body -->
                    </div>
                </div>
            </div>
        </div>
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

<!-- SweetAlert  -->
<link href="/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
<script src="/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
//ajax beforesend
const csrfHeader = "${_csrf.headerName}";
const csrfToken = "${_csrf.token}";


let activeTabId = $('.tab-pane.active').attr('id');

//관리자 사진
let imgInputAdmin = $("#profImg-Admin").val();

// 협력업체 사진
let imgInputPartner = $("#profImg-Partner").val();

// 유효성 검사 
let validNum; 

// 이미지파일
let img = "";



/* 사진 미리보기 함수 */
function upImg(imgInput, imgPrev){
    $(imgInput).on("change", handleImgFileSelect);
    //사진파일 필터링 함수
    function handleImgFileSelect(e){
        let files = e.target.files;
        let filesArr = Array.prototype.slice.call(files);

        // 허용되는 사진파일 확장자
        let reg = /(.?)\/(jpg|jpeg|png|bmp)$/;

        filesArr.forEach(function(f){
            filesArr.forEach(function (f) {
                if (!f.type.match(reg)) {
                    Swal.fire("등록 실패!", "지원하지 않는 파일 형식입니다.<br>(.jpg, .jpeg, .png, .bmp 사용가능) ", "error")
                    return;
                }

                memImg = f;

                let reader = new FileReader();
                reader.onload = function (e) {
                    $(imgPrev).attr("src", e.target.result);
                }
                reader.readAsDataURL(f);
            });
        })
    }
}

/* 아이디 유효성 검사 */
function idCheck(idInput, checkValid){
    $(idInput).on('input', function(){
        let idValid = $(idInput).val().trim();
        idValid = idValid.replace(/[^a-zA-Z0-9]/g, '');  
        $(idInput).val(idValid);
        
        if(idValid.length < 4){
            $(checkValid).html('아이디는 4글자 이상 입력해주세요');
            $(checkValid).css('color','red')
            return;
        
        }
        $.ajax({
            url: "/idcheck.do",
            type: "POST",
            data: idValid,
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            beforeSend: function (xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(data){
                if(data.cnt > 0){
                    $(checkValid).html('이미 등록된 회원 ID입니다.');
                    $(checkValid).css('color','red')
                    validNum = 0;

                }else{
                    $(checkValid).html('사용 가능한 회원 ID입니다.');
                    $(checkValid).css('color','blue')

                    validNum = 1;
                }
            },error: function(error){
                console.log("안된다 쌤?", error);
            }
        });
    });  
}
/* 이미지 업로드 이벤트리스너 */
upImg("#profImg-Admin", "#adminImg");
upImg("#profImg-Partner", "#partnerImg"); 

/* 아이디 유효성검사 이벤트리스너 */
idCheck("#adminId", "#adminIdValid");
idCheck("#partnerId", "#partnerIdValid");  

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
lookPwBtn('#lookAdminPw', '#adminPw');
lookPwBtn('#lookAdminPwChk', '#adminPwChk');
lookPwBtn('#lookPartnerPw', '#partnerPw');
lookPwBtn('#lookPartnerPwChk', '#partnerPwChk');
/* 가려진 비밀번호 부분 end */


// $('#lookAdminPw').on('click', lookPw('#adminPw', '#lookAdminPw'));

/* 비밀번호 일치 확인 */
function pwEqual(password, check, equal){
    let pw = $(password).val();
    let chk = $(check).val();

    if(chk.length > 0 && pw === chk){
        $(equal).html('비밀번호가 일치합니다.')
        $(equal).css('color', 'blue');
    }else{
        $(equal).html("비밀번호가 일치하지 않습니다.")
        $(equal).css('color', 'red');
    }

    if(pw.length === 0 || chk.length == 0){
        $(equal).css('display', 'none');
    }else{
        $(equal).css('display', 'block');
    }
}

// 비밀번호 일치 이벤트 리스너(관리자)
$('#adminPw').focusout('input', function(){
   pwEqual("#adminPw", "#adminPwChk", "#equalAdminPw");
});

$('#adminPwChk').focusout('input', function(){
   pwEqual("#adminPw", "#adminPwChk", "#equalAdminPw");
});

// 비밀번호 일치 이벤트 리스너(협력업체)
$('#partnerPw').focusout('input', function(){
   pwEqual("#partnerPw", "#partnerPwChk", "#equalPartnerPw");
});

$('#partnerPwChk').focusout('input', function(){
    pwEqual("#partnerPw", "#partnerPwChk", "#equalPartnerPw");
});
/*비밀번호 일치 확인 end*/

function rgxId(event){
    const input = event.target;
    const value = input.value;

    if(value !== undefined){
        const filteredValue = value.replace(/[^a-zA-Z0-9]/g, '');
        input.value = filteredValue; 
    }
}
// 이메일 계정 관련 이벤트 리스너
$('#adminEmail').on('input', rgxId);
$('#partnerEmail').on('input', rgxId);

function rgxTelno(tel){
    const input = tel.target;
    const value = input.value;

    if(value !== undefined){
        const filteredValue = value.replace(/[^0-9]/g, '');
        input.value = filteredValue;
    }
}

$('#partnerNo').on('input', function(){
    let value = $(this).val().replace(/[^0-9-]/g, '');
    let numbers = value.replace(/-/g, '');
    let formattedValue = '';

    if (numbers.length > 0) {
        formattedValue += numbers.substring(0, 3);
    }
    if (numbers.length > 3) {
        formattedValue += '-' + numbers.substring(3, 5);
    }
    if (numbers.length > 5) {
        formattedValue += '-' + numbers.substring(5, 10);
    }
    $(this).val(formattedValue);
});
//전화번호 이벤트 리스너
$("#adminTelno").on('input', rgxTelno);
$("#partnerTelno").on('input', rgxTelno);

function selDomain(domain, domainInput){
    $(domain).change(function(){
        $(domain + " option:selected").each(function(){
            if($(this).val() == 'direct'){
                $(domainInput).val('');
                $(domainInput).attr("readonly", false);
                $(domainInput).attr("placeholder", "직접 입력");
            }else{
                $(domainInput).val($(this).val());
                $(domainInput).attr("readonly", true);
                $(domainInput).attr("placeholder", "도메인 선택");
            }
        })
    })
}

selDomain("#selectAdminDomain", "#adminDomain");
selDomain("#selectPartnerDomain", "#partnerDomain");

// 우편번호 
function partnerExecPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("partnerExtraAddress").value = extraAddr;
            
            } else {
                document.getElementById("partnerExtraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('partnerPostcode').value = data.zonecode;
            document.getElementById("partnerAddress").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("partnerDetailAddress").focus();
        }
    }).open();
}

/*AJAX 전송하기 전 유효성 검사하기*/
function submitBtn(submit, idInput, codeInput, pwInput, pwEqualInput, nameInput, telInput, emailInput, domainInput, imgInput, url){
    $(submit).click(function(){
        let id = $(idInput).val().trim();
        let code = $(codeInput).val().trim();
        let pw = $(pwInput).val().trim();
        let eqp = $(pwEqualInput).val().trim();
        let name = $(nameInput).val().trim();
        let tel = $(telInput).val().trim();
        let email = $(emailInput).val().trim();
        let domain = $(domainInput).val().trim();

        const pattern = /^(?=.*\d)(?=.*[a-z])(?=.*[!@#$%^&*]).{8,}$/; // 비밀번호 입력 관련...

        if(id.length < 4 || id.length > 20){
            Swal.fire("가입 실패!", "아이디는 4 ~ 20자 사이로 설정해야 합니다.", "error");
            return;
        }

        if(!validNum){
            Swal.fire("가입 실패!", "이미 등록된 회원 ID입니다.", "error");
            return;
        }

        if(code === ''){
            Swal.fire("가입 실패!", "관리하는 단지를 선택하세요.", "error");
            return;
        }

        if(pw.length < 8 || pw.length > 20){
            Swal.fire("가입 실패!", "설정 할 비밀번호를 입력하세요(8 ~ 20자)", "error");
            return;
        }

        if(!pattern.test(pw)){
            Swal.fire("가입 실패!", "영문, 숫자, 특수문자(!@#$%^&*) 는 반드시 1개이상 포함해야 합니다.", "error");
            return;
        }

        if(pw != eqp){
            Swal.fire("가입 실패!", "비밀번호 일치 여부를 확인하세요.", "error");
            return;
        }

        if(name === ''){
            Swal.fire("가입 실패!", "업체명을 입력하세요.", "error");
            return;
        }

        if(tel === ''){
            Swal.fire("가입 실패!", "연락처를 입력하세요", "error");
            return;
        }

        if(email === '' || domain === ''){
            Swal.fire("가입 실패!", "전자주소(E-mail)를 입력하세요", "error");
            return;
        }

        let profileImg = $(imgInput)[0].files[0]; // 파일 객체
        let profileImgExt = ""; // 이미지 확장자
        let formData = new FormData();

        if(profileImg){
            img = id + 'Photo.'+profileImg.name.split('.').pop();
            formData.append('file', profileImg);
        }else{
            img = "";
        }

        console.log(img);

        let memberVO = {
            memId: id,
            roomCode: code,
            memPw: pw,
            memNm: name,
            nickname: name,
            memTelno: tel,
            memEmail: email + '@' + domain,
            profImg : img
        };

        formData.append('memberVO', new Blob([JSON.stringify(memberVO)], {type: "application/json;charset=utf-8"}));

        Swal.fire({
            tltle: "",
            text: "회원가입을 신청하시겠습니까?",
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '확인',
            cancelButtonText: '취소',
            icon: "question"
        }).then((result)=> {
            if(result.isConfirmed){
                $.ajax({
                    url: url,
                    data: formData,
                    type: 'POST',
                    processData: false,
                    contentType: false,
                    beforeSend: function(xhr){
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },success: function(data){
                        
                        window.location.href = "/login"
                    },error: function(){
                        alert("뜻대로 되지 않네요...ㅠㅠ")
                    }
                })
            }
        });
    })
}

//관리자에서 회원가입 신청
submitBtn("#submitAdmin", "#adminId", "#adminSelect", "#adminPw", "#adminPwChk", "#adminNm" ,"#adminTelno", "#adminEmail", "#adminDomain", "#profImg-Admin", "/signUpAdmin.do");

//협력업체 회원가입 신청
submitBtn("#submitPartner", "#partnerId", "#partnerSelect", "#partnerPw", "#partnerPwChk", "#partnerNm", "#partnerTelno", "#partnerEmail", "#partnerDomain", "#profImg-Partner", "/signUpPartner.do");
</script>
</html>