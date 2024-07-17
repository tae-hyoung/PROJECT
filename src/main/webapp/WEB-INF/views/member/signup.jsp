<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="en" data-layout="vertical" data-topbar="light" data-sidebar="dark" data-sidebar-size="lg"
	data-sidebar-image="none" data-preloader="disable" data-theme="default" data-theme-colors="default">

<head>
	<meta charset="utf-8" />
	<title>입주민 회원가입</title>
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
	
	<link href="/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />

</head>
<body>
	<div style="width:100%; overflow-x: auto; display: flex; align-items: center;" class="auth-page-content" class="row">
		<div class="container">
			<!-- end row -->
			<div class="row justify-content-center">
				<div class="col-md-8 col-lg-6 col-xl-6">
					<div class="card mt-4 card-bg-fill">
						<form id="upForm" enctype="multipart/form-data">
							<div class="card-body p-4">
								<button type="button" id="autoBtn" class="btn btn-primary" >AUTO</button>
								<div class="text-center mt-2">
									<h5 class="text-primary">입주민 회원가입</h5>
									<br />
								</div>
								<div class="p-2 mt-4">
									<div class="card mt-n5">
										<div class="card-body p-4">
											<div class="text-center">
												<div class="profile-user position-relative d-inline-block mx-auto  mb-4">
													<img src="/resources/images/profile/basic.png" id="memImg"
														class="rounded-circle avatar-xl img-thumbnail user-profile-image material-shadow"
														alt="user-profile-image">
													<div class="avatar-xs p-0 rounded-circle profile-photo-edit">
														<input id="profImg" type="file" class="profile-img-file-input"
															name="profImg" accept="image/*"> <label for="profImg"
															class="profile-photo-edit avatar-xs"> <span
																class="avatar-title rounded-circle bg-light text-body material-shadow">
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
										<label for="memId" class="form-label">아이디 <span class="text-danger">*</span></label>
										<input type="text" class="form-control" id="memId" name="memId"
											placeholder="아이디를 입력하세요" maxlength=20 required>
										<div id="dupId"></div>
									</div>
									<div class="mb-3">
										<label for="aptSelect" class="form-label">입주 아파트 <span class="text-danger">*</span>
										</label> 
										<select id="aptSelect" class="form-select">
											<option value="">입주 아파트 선택</option>
											<c:forEach var="danji" items="${danjiList}" varStatus="stat">
											<option value="${danji.danjiCode }">${danji.danjiName}</option>
											</c:forEach>
										</select>
									</div>
									<div class="input-group mb-6">
										<select class="form-select mb-3" id="aptNum" data-choice="active">
											<option value="" selected>선택하세요</option>
										</select> <span class="input-group-text mb-3">동</span> <input type="text"
											class="form-control mb-3" id="roomNum" placeholder="호실" required> <span
											class="input-group-text mb-3">호</span>
									</div>
									<div class="mb-3">
										<label class="form-label" for="password-input">비밀번호</label> <span
											class="text-danger">*</span>
										<div class="position-relative auth-pass-inputgroup">
											<input type="password" class="form-control pe-5 password-input"
												placeholder="비밀번호" id="memPw" name="memPw" required>
											<button
												class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon material-shadow-none"
												type="button" id="lookPw">
												<i class="ri-eye-fill align-middle"></i>
											</button>
										</div>
									</div>
									<div class="mb-3">
										<label class="form-label" for="password-input">비밀번호 확인</label>
										<span class="text-danger">*</span>
										<div class="position-relative auth-pass-inputgroup">
											<input type="password" class="form-control pe-5 password-input"
												placeholder="비밀번호 확인" id="memPwChk" aria-describedby="passwordInput"
												pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required
												aria-autocomplete="list">
											<button
												class="btn btn-link position-absolute end-0 top-0 text-decoration-none text-muted password-addon material-shadow-none"
												type="button" id="lookPwChk">
												<i class="ri-eye-fill align-middle"></i>
											</button>
										</div>
										<div id="chkPw"></div>
									</div>
									<div class="mb-3">
										<label for="username" class="form-label">입주민 명 <span
												class="text-danger">*</span></label> <input type="text" class="form-control"
											id="memNm" name="memNm" placeholder="입주민 명" required>
									</div>
									<div class="mb-3">
										<label for="JoiningdatInput" class="form-label">생년월일 <span
												class="text-danger">*</span></label> <input type="date" class="form-control"
											id="memBirth" name="memBirth" placeholder="생년월일(ex.19970910)">
									</div>
									<div class="mb-3">
										<label for="JoiningdatInput" class="form-label">성별 <span
												class="text-danger">*</span>
										</label> <select class="form-select" id="memSex" name="memSex">
											<option value="m">남</option>
											<option value="f">여</option>
										</select>
									</div>
									<div class="mb-3">
										<label for="JoiningdatInput" class="form-label">연락처 <span
												class="text-danger">*</span></label> <input type="text" class="form-control"
											id="memTelno" name="memTelno" placeholder="연락처" maxlength="15" required>
									</div>
									<div class="input-group mb-6">
										<label for="JoiningdatInput" class="form-label">전자주소(이메일)
											<span class="text-danger">*</span>
										</label>
										<div class="input-group mb-6">
											<input type="text" class="form-control mb-3" id="emailId" name="emailId"
												placeholder="아이디" aria-label="Email" required>
											<span class="input-group-text mb-3">@</span> <input type="text"
												class="form-control mb-3" id="dirEmail" name="dirEmail" value="선택하세요"
												readonly /> <select class="form-select mb-3" name="selectEmail"
												id="selectEmail" data-choice="active">
												<option value="" selected>선택하세요</option>
												<option value="naver.com">naver.com</option>
												<option value="hanmail.net">hanmail.net</option>
												<option value="gmail.com">gmail.com</option>
												<option value="direct">직접입력</option>
											</select>
										</div>
									</div>
									<div class="mb-3">
										<label for="JoiningdatInput" class="form-label">닉네임 <span
												class="text-danger">*</span></label> <input type="text" class="form-control"
											id="nickname" name="nickname" placeholder="닉네임" maxlength="10" required>
										<div id="nickFeedback"></div>
									</div>
									<div class="mb-3">
										<label for="JoiningdatInput" class="form-label">세대주 계정
											명</label> <input type="text" class="form-control" id="hshldrId" name="hshldrId"
											placeholder="동거인일 경우 입력해주세요.">
									</div>
									<div class="mb-3">
										<input type="button" class="btn btn-primary w-100" value="가입신청" id="btn_submit">
									</div>
								</div>
							</div>
						</form>
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

	<!-- SweetAlert  -->
    
    
    <script src="/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
    
    <script src="/resources/js/jquery.min.js"></script>

	<script>
		/* 프로필 사진 */
		let memImg="";
		let validId;
		let validNick;

		$(document).ready(function () {
			$("#profImg").on("change", handleImgFileSelect);
		});

		function handleImgFileSelect(e) {
			let files = e.target.files;
			let filesArr = Array.prototype.slice.call(files);

			let reg = /(.*?)\/(jpg|jpeg|png|bmp)$/;

			filesArr.forEach(function (f) {
				if (!f.type.match(reg)) {
					alert("이미지 파일만 가능합니다!");
					return;
				}

				memImg = f;

				let reader = new FileReader();
				reader.onload = function (e) {
					$("#memImg").attr("src", e.target.result);
				}
				reader.readAsDataURL(f);
			});
		}

		/* 아이디 필터링 */
		$('#memId').focusout('input',function () {
				let memId = $('#memId').val().trim();

				//아이디 입력 안했을 때
				if (memId.trim().length < 4) {
					$("#dupId").html('아이디 4글자 이상 입력해주세요.');
					$("#dupId").css('color', 'red'); // 색상 변경
					return; // 함수 종료
				}

				// 한글과 특수문자 제거
				memId = memId.replace(/[^a-zA-Z0-9]/g, '');;
				$('#memId').val(memId);

				$.ajax({
					url: "/idcheck.do",
					type: "POST",
					data: memId,
					dataType: "json",
					contentType: "application/json;charset=utf-8",
					beforeSend: function (xhr) {
						xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
					},
					success: function (data) {
						console.log(data.cnt)
						if (data.cnt > 0) {
							$("#dupId").html('중복되는 ID입니다.');
							$("#dupId").css('color', 'red');
							validId = 0;
						} else {
							$("#dupId").html('사용 가능한 ID입니다.')
							$("#dupId").css('color', 'blue');
							validId = 1;
						}

					},
					error: function () {
						alert("다시 짜라.");
					}
				});
			});

		function noKor(event) {
			const input = event.target;
			const value = input.value;

			// 값이 존재하는지 확인
			if (value !== undefined) {
				// 한글은 안됨!
				const filteredValue = value.replace(/[^a-zA-Z0-9]/g, '');
				input.value = filteredValue; // 필터링된 값으로 입력 필드 값을 변경.
			}
		}

		/* 숫자 빼고 입력 안되는 함수 */
		function onlyNum(event) {
			const input = event.target;
			const value = input.value;

			// 값이 존재하는지 확인
			if (value !== undefined) {
				// 정규식을 사용하여 숫자가 아닌 문자를 필터링.
				const filteredValue = value.replace(/[^0-9]/g, '');
				input.value = filteredValue; // 필터링된 값으로 입력 필드 값을 변경.
			}
		}

		function lookPw() {
			const memPw = $('#memPw');
			const lookPw = $('#lookPw');

			if (memPw.attr('type') === 'password') {
				memPw.attr('type', 'text');
				lookPw.html('<i class="ri-eye-off-fill align-middle"></i>'); // 텍스트가 표시될 때 아이콘 변경
			}

			else {
				memPw.attr('type', 'password');
				lookPw.html('<i class="ri-eye-fill align-middle"></i>'); // 텍스트가 숨겨질 때 아이콘 변경
			}

		}

		function lookPwChk() {
			const memPwChk = $('#memPwChk');
			const lookPwChk = $('#lookPwChk');

			if (memPwChk.attr('type') === 'password') {
				memPwChk.attr('type', 'text');
				lookPwChk.html('<i class="ri-eye-off-fill align-middle"></i>'); // 텍스트가 표시될 때 아이콘 변경
			}

			else {
				memPwChk.attr('type', 'password');
				lookPwChk.html('<i class="ri-eye-fill align-middle"></i>'); // 텍스트가 숨겨질 때 아이콘 변경
			}
		}
		/* 비밀번호 확인 */
		$('#memPwChk').focusout('input', function () {
			let memPw = $('#memPw').val();
			let memPwChk = $('#memPwChk').val();

			if (memPwChk.length > 0 && memPw === memPwChk) {
				$("#chkPw").html('비밀번호가 일치합니다.')
				$("#chkPw").css('color', 'blue');
			} else {
				$("#chkPw").html('비밀번호가 일치하지 않습니다.')
				$("#chkPw").css('color', 'red');
			}

			if (memPw.length == 0 || memPwChk.length == 0) {
				$("#chkPw").css('display', 'none');
			} else {
				$("#chkPw").css('display', 'block');
			}
		})

		/* 닉네임 체크 */
		$('#nickname').focusout('input',function () {
				let nickname = $('#nickname').val();

				// 공백 및 특수문자 제거
				nickname = nickname.replace(
					/[''""\s~`!@#$%^&*()_\-+={}[\]|\\:;<>,.?/]/g, '');
				$('#nickname').val(nickname);

				//닉네임 입력 안했을 때
				if (nickname.trim() === '') {
					$("#nickFeedback").html('닉네임을 입력해주세요.');
					$("#nickFeedback").css('color', 'red'); // 색상 변경
					return; // 함수 종료
				}
				$.ajax({
					url: "/nickcheck.do",
					type: "POST",
					data: nickname,
					dataType: "json",
					contentType: "application/json;charset=utf-8",
					beforeSend: function (xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
					success: function (data) {
						if (data.cnt > 0) {
							$("#nickFeedback").html('중복되는 닉네임 입니다.');
							$("#nickFeedback").css('color', 'red');
							validNick = 0;
						} else {
							$("#nickFeedback").html('사용 가능한 닉네임 입니다.')
							$("#nickFeedback").css('color', 'blue');
							validNick = 1;
						}

					},
					error: function () {
						alert("다시 짜라.");
					}
				});
			});

		$('#selectEmail').change(function () {
			$("#selectEmail option:selected").each(function () {
				if ($(this).val() == 'direct') {
					$("#dirEmail").val('');
					$("#dirEmail").attr("readonly", false);
				} else {
					$("#dirEmail").val($(this).text());
					$("#dirEmail").attr("readonly", true);
				}
			})
		})

		$('#btn_submit').click(function () {
			let memId = $('#memId').val();
			const pattern = /^(?=.*\d)(?=.*[a-z])(?=.*[!@#$%^&*]).{8,}$/;

			/*입력 검증*/
			if (memId.trim().length < 4
				|| memId.trim().length > 20) {
				Swal.fire("", "아이디는 4 ~ 20자 사이로 설정해야 합니다.", "warning");
				return;
			}

			if (!validId) {
				Swal.fire("", "ID 중복 여부를 확인해주세요!", "warning");
				return;
			}

			if ($('#aptSelect').val().trim() === '') {
				Swal.fire("", "입주중인 아파트를 선택하세요", "warning");
				return;
			}

			if ($('#aptNum').val().trim() === ''){
				Swal.fire("", "아파트 단지를 선택하세요.", "warning");
				return;
			}

			if ($('roomNum').val() === ''){
				Swal.fire("", "호실을 입력하세요.", "warning");
				return;
			}

			if ($('#memPw').val().trim().length < 8
				|| $('#memPw').val().trim() > 20) {
				Swal.fire("", "설정 할 비밀번호를 입력하세요( 8 ~ 20자)", "warning");
				return;
			}

			if (!pattern.test($('#memPw').val().trim())) {
				Swal.fire("", "영문, 숫자, 특수문자(!@#$%^&*) 는 반드시 1개이상 포함해야 합니다.", "warning");
				return;
			}

			if ($('#memPw').val().trim() != $('#memPwChk').val().trim()) {
				Swal.fire("", "비밀번호 일치 여부를 확인하세요.", "warning");
				return;
			}

			if ($('#memNm').val() === '') {
				Swal.fire("", "입주민 명을 입력하세요", "warning");
				return;
			}

			if ($('#memBirth').val() === '') {
				Swal.fire("", "생년월일을 입력하세요.", "warning");
				return;
			}

			if ($('#memTelno').val() === '') {
				Swal.fire("", "연락처를 입력하세요.", "warning");
				return;
			}

			if ($('#emailId').val() === ''
				|| $('#dirEmail').val() === '') {
				Swal.fire("", "전자주소를 입력하세요.", "warning");
				return;
			}

			if(domain === '선택하세요'){
				Swal.fire("", "이메일 도메인을 선택하세요!" , "warning");
			}

			if ($('#nickname').val() === '') {
				Swal.fire("", "설정 할 닉네임을 입력하세요." , "warning");
				return;
			}

			if (!validNick) {
				Swal.fire("", "닉네임 중복 여부를 확인해주세요!" , "warning");
				return;
			}

			let profileImg = $('#profImg')[0].files[0]; // 파일객체 가져오기
			let profImgExt = ''; // 확장자겠지?
			let formData = new FormData();

			if(profileImg){
				if(!profileImg.type.startsWith('image/')){
					Swal.fire("", "이미지 파일만 업로드 가능합니다!" , "warning");
					return;
				}
				
				memImg = memId + 'Photo.' + profileImg.name.split('.').pop();
				formData.append('file', profileImg);
			}else{
				memImg = "";
			}

			let memberVO = {
				memId: memId,
				roomCode: $('#aptSelect').val() + '_' + $('#aptNum').val() + '_' + $('#roomNum').val(),
				memPw: $('#memPw').val(),
				memNm: $('#memNm').val(),
				memBirth: $('#memBirth').val(),
				memSex: $('#memSex').val(),
				memTelno: $('#memTelno').val(),
				memEmail: $('#emailId').val() + '@' + $('#dirEmail').val(),
				nickname: $('#nickname').val(),
				hshldrId: $('#hshldrId').val(),
				profImg: memImg
			};

			formData.append('memberVO', new Blob([JSON.stringify(memberVO)], {type: "application/json;charset=utf-8"}));


			$.ajax({
				url: "/signUp.do",
				data: formData,
				type: "POST",
				processData: false,
				contentType: false,
				beforeSend: function (xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success: function (data) {	
					Swal.fire("회원가입 성공!", "관리자 승인 후 사용 로그인이 가능합니다", "success").then((result) => {
						if(result.isConfirmed){
							window.location.href = "/login"
						}
					});
				},
				error: function () {
					alert("에러 문의 -> 정명진.");
				}
			});
		});

		$('#autoBtn').click(function(){
			$('#memId').val('ddit404'); 
			//$('#aptSelect').val('D001');
			$('#memPw').val('ddit404!');
			$('#memPwChk').val('ddit404!');
			$('#memNm').val('유대덕')
			$('#nickname').val('스위트홈');
			$('#memTelno').val('01093840966');
			$('#emailId').val('audwls0910');
			$('#memBirth').val('1997-09-10');
			$('#dirEmail').val('naver.com');
			$('#selectEmail').val('naver.com');
		})


		// 아이디
		const memIdInput = document.getElementById('memId');
		if (memIdInput) { // memTelInput이 존재하는지 확인
			memIdInput.addEventListener('input', noKor);
		}

		// 전화번호
		const memTelInput = document.getElementById('memTelno');
		if (memTelInput) { // memTelInput이 존재하는지 확인
			memTelInput.addEventListener('input', onlyNum);
		}

		// 생년월일
		/*
		const memBirthInput = document.getElementById('memBirth');
		if (memBirthInput) {
			memBirthInput.addEventListener('input', onlyNum);
		}
		 */

		// 이메일
		const memEmailInput = document.getElementById('emailId');
		if (memEmailInput) {
			memEmailInput.addEventListener('input', noKor);
		}
		

		//세대주 계정
		const ldrIdInput = document.getElementById('hshldrId');
		if (ldrIdInput) { // memTelInput이 존재하는지 확인
			ldrIdInput.addEventListener('input', noKor);
		}

		$('#lookPw').on('click', lookPw);
		$('#lookPwChk').on('click', lookPwChk);
		
		let domain = $('#selectEmail').val();

		//aptSelect 아파트 호실 관련...
		$('#aptSelect')
			.on(
				'change',
				function () {
					let aptSelect = $(this).val();
					let aptNum = $('#aptNum');

					// 동 초기화
					aptNum.empty().append(
						'<option value="" selected>선택하세요</option>')
					if (aptSelect) {
						aptNum.prop('disabled', false);

						if (aptSelect === 'D001') {
							aptNum
								.append('<option value = "101">101</option>');
							aptNum
								.append('<option value = "102">102</option>');
							aptNum
								.append('<option value = "103">103</option>');
							aptNum
								.append('<option value = "104">104</option>');
							aptNum
								.append('<option value = "105">105</option>');
							aptNum
								.append('<option value = "106">106</option>');
							aptNum
								.append('<option value = "107">107</option>');
							aptNum
								.append('<option value = "108">109</option>');
							aptNum
								.append('<option value = "110">110</option>');
							aptNum
								.append('<option value = "111">111</option>');
							aptNum
								.append('<option value = "112">112</option>');
							aptNum
								.append('<option value = "113">113</option>');
							aptNum
								.append('<option value = "114">114</option>');
							aptNum
								.append('<option value = "115">115</option>');
							aptNum
								.append('<option value = "116">116</option>');
							aptNum
								.append('<option value = "117">117</option>');
							aptNum
								.append('<option value = "118">118</option>');
							aptNum
								.append('<option value = "119">119</option>');
						} else {
							aptNum.prop('disabled', true);
						}
					}
				})
	</script>
</body>

</html>