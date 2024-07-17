<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>  
<style>
.header .nav li a::before {
  bottom: 15px;
}

</style>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
<header class="header" style="margin-top: 10px;">
	<div class="header-inner">
		<div class="container row col-lg-12">
			<div class="col-lg-3"></div>
			<div class="inner col-lg-6">
				<div class="row">
					<div class="col-lg-3 col-md-3 col-12" style="margin-left: -140px; margin-right: 100px;">
						<!-- Start Logo -->
						<div class="logo">
							<a href="/"><img style="margin-top: -6px;" src="/resources/images/logo/logo3.png" alt="#"></a>
						</div>
						<!-- End Logo -->
						<!-- Mobile Nav -->
						<div class="mobile-nav"></div>
						<!-- End Mobile Nav -->
					</div>
					<div class="col-lg-9 col-md-9 col-12">
						<!-- Main Menu -->
						<div class="main-menu">
							<nav class="navigation">
								<ul class="nav menu">
									<li class="menu-item" id="introduceHeader"><a href="/site/introduce" style="font-size: 16px; margin-left: 130px;">서비스 소개 </a></li>
									<li class="menu-item" id="danjiHeader"><a href="/site/danji" style="font-size: 16px;">단지소개</a></li>
									<li class="menu-item" id="noticeHeader"><a href="/site/notice?boardCat=board_site" style="font-size: 16px;">공지사항 </a></li>
									<li class="menu-item" id="bidHeader"><a href="/site/bidList" style="font-size: 16px;">입찰공고</a></li>
										<li class="menu-item " id="pageHeader__">
											<a href="#" style="font-size: 16px;">바로가기<i class="icofont-rounded-right"></i></a>
											<ul class="dropdown">
												<li><a href="/">사이트 홈</a></li>
												<li><a href="/home/adminHome">관리자 대시보드</a></li>
												<li><a href="/home/residentHome">입주민 대시보드</a></li>
											</ul>
										</li>
								</ul>
							</nav>
						</div>
						<!--/ End Main Menu -->
					</div>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="main-menu">
					<nav class="navigation">
						<ul class="nav-menu">
							<li class="menu-item" style="margin-top: 10px; margin-left: 200px;">
								<sec:authorize access="isAnonymous()">																
								 	<a href="/login" class="btn btn-primary" style="color: white;">로그인</a>
						             <button class="btn btn-warning dropdown-toggle" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
							                회원가입
							         </button>
						              <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
									    <li><a class="dropdown-item" href="/signup">입주민</a></li>
									    <li><hr class="dropdown-divider"></li>
									    <li><a class="dropdown-item" href="/adminSignup">관리자</a></li>
									  </ul>
								</sec:authorize>
								<sec:authorize access="isAuthenticated()">
									<form action="/logout" method="post" id="logout">
										<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
										<button type="button" class="btn btn-warning" style="color: white;" id = logout>로그아웃</button>
									</form>
								</sec:authorize>
<!-- 								<a href="#"> -->
<!-- 									${memId}님 환영합니다. -->
<!-- 									<img id="profImg" src="/resources/images/prof01.png" class="rounded-circle" style="width: 50px;"> -->
<!-- 								</a> -->
<!-- 								<ul class="dropdown"> -->
<!-- 									<li><a href="#" class="btn">정보수정</a></li> -->
<!-- 									<li><a href="#" class="btn">로그아웃</a></li> -->
<!-- 								</ul> -->
							</li>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<!--/ End Header Inner -->
</header>
<!-- SweetAlert  -->
<link href="/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
<script src="/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script>
$(function(){
	let url = window.location.href;
	let page;
	if(url.split('/').length > 4){
		page = url.split('/')[4];
		
		if(page.startsWith('introduce')){
			$("#introduceHeader").addClass('active');
			$("#introduce").addClass('active');
		}
		else if(page.startsWith('danji')){
			$("#danjiHeader").addClass('active');
			$("#danji").addClass('active');
		}
		else if(page.startsWith('notice')){
			$("#noticeHeader").addClass('active');
			$("#notice").addClass('active');
		}
		else if(page.startsWith('bid')){
			$("#bidHeader").addClass('active');
			$("#bid").addClass('active');
		}
	}
	else{
		$("#pageHeader").addClass('active');
	}
	
});

$('#logout').on("click", function(){
	Swal.fire({
		title: "로그아웃 하시겠습니까?",
		icon: 'warning',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: '예',
		cancelButtonText: '아니오'
	}).then((result) => {
		if(result.isConfirmed){
			$('#logout').submit();		
		}
	})
});
</script>