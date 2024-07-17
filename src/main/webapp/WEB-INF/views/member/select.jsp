<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- App favicon -->
<!-- jsvectormap css -->
<link href="/resources/assets/libs/jsvectormap/css/jsvectormap.min.css"
	rel="stylesheet" type="text/css" />

<!--Swiper slider css-->
<link href="/resources/assets/libs/swiper/swiper-bundle.min.css"
	rel="stylesheet" type="text/css" />

<!-- Layout config Js -->
<script src="/resources/assets/js/layout.js"></script>
<!-- Bootstrap Css -->
<link href="/resources/assets/css/bootstrap.min.css" rel="stylesheet"
	type="text/css" />
<!-- Icons Css -->
<link href="/resources/assets/css/icons.min.css" rel="stylesheet"
	type="text/css" />
<!-- App Css-->
<link href="/resources/assets/css/app.min.css" rel="stylesheet"
	type="text/css" />
<!-- custom Css-->
<link href="/resources/assets/css/custom.min.css" rel="stylesheet"
	type="text/css" />

<style>
#memberBtn {
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.75rem; /* h3 크기와 비슷한 폰트 크기 */
	text-align: center;
}

#adminBtn {
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 1.75rem; /* h3 크기와 비슷한 폰트 크기 */
	text-align: center;
}

#content {
	display: flex;
	justify-content: space-around;
	gap: 50px; /* 카드 사이의 간격을 20px로 설정 */
}
</style>
<title>선택</title>
</head>
<body>
	<div
		style="width: 100vw; height: 100vh; display: flex; align-items: center;"
		class="auth-page-content">
		<div class="container" id="content"
			style="display: flex; justify-content: space-around;">
			<div class="card" style="width: 36rem; height: 36rem;">
				<!-- <img src="/resources/images/admin.png" class="card-img-top"> -->
				<a href="/signup" class="btn btn-primary w-100 h-100" id="memberBtn">입주민 회원가입 신청</a>
			</div>
			<div class="card" style="width: 36rem; height: 36rem;">
				<!-- <img src="/resources/images/admin.png" class="card-img-top"> -->
				<a href="/adminSignUp" class="btn btn-warning w-100 h-100" id="adminBtn">관리자/협력업체 회원가입 신청</a>
			</div>
		</div>
	</div>
</body>
</html>