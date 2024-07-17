<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.nav-item .nav-link {
	color: initial; 
}

/* .nav-item .nav-link:hover { */
/*     color: black !important; */
/* } */

.nav-item.active .nav-link {
    background-color: white;
    border-radius: 5px;
    color: black !important;
    font-size: 15px;
}

.nav-item.active .nav-link:hover {
    color: black !important;
}

.menu-dropdown {
    padding: 0.5rem 1rem;
}

/* 하위 메뉴의 너비 설정 */
.nav-item.open .nav-item .nav-link {
    width: 185px; 
}

.menu-title{
	color: #f9c6c6;
	font-size: 12px;
}

</style>
<div class="app-menu navbar-menu">
	<!-- LOGO -->
	<div class="navbar-brand-box">
		<a href="/home/residentHome" class="logo logo-light">
			<span class="logo-sm"> 
				<img src="/resources/images/logo/logo6.png" alt="#"  height="30">
			</span> 
			<span class="logo-lg"> 
				<img src="/resources/images/logo/logooo.png" alt="#"  height="50">
			</span>
		</a>
		<button type="button" class="btn btn-sm p-0 fs-20 header-item float-end btn-vertical-sm-hover" id="vertical-hover">
			<i class="ri-record-circle-line"></i>
		</button>
	</div>

	<div id="scrollbar">
		<div class="container-fluid">
			<div id="residentSide">
				<ul class="navbar-nav" id="navbar-nav">
	
					<li class="menu-title">
						<i class="ri-more-fill"></i> 
						<span>커뮤니티</span>
					</li>
					
					<li class="nav-item ${currentURI.contains('board_notice') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/board/list?boardCat=board_notice" role="button"> 
							<i class="las la-otter"></i> 
							<span>공지사항</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/board') && !currentURI.contains('board_notice') ? 'open' : ''}">
						<a class="nav-link menu-link" href="#sidebarBoards" data-bs-toggle="collapse" role="button"
							aria-expanded="${currentURI.startsWith('/board') && !currentURI.contains('board_notice')}" aria-controls="sidebarBoards"> 
							<i class="bx bx-edit"></i> 
							<span>게시판</span>
						</a>
						<div class="collapse menu-dropdown ${currentURI.startsWith('/board') && !currentURI.contains('board_notice') ? 'show' : ''}" id="sidebarBoards">
							<ul class="nav nav-sm flex-column">
								<li class="nav-item ${currentURI.contains('board_free') ? 'active' : ''}">
									<a href="/board/list?boardCat=board_free" class="nav-link">자유게시판</a>
								</li>
								<li class="nav-item ${currentURI.equals('/board/tradeList') || currentURI.contains('board_trade') ? 'active' : ''}">
									<a href="/board/tradeList" class="nav-link">중고거래</a>
								</li>
							</ul>
						</div>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/complain') ? 'open' : ''}">
						<a class="nav-link menu-link" href="#sidebarComplains" data-bs-toggle="collapse" role="button"
							aria-expanded="${currentURI.startsWith('/complain')}" aria-controls="sidebarComplains"> 
							<i class="bx bx-message-rounded-edit"></i> 
							<span>민원</span>
						</a>
						<div class="collapse menu-dropdown ${currentURI.startsWith('/complain') ? 'show' : ''}" id="sidebarComplains">
							<ul class="nav nav-sm flex-column">
								<li class="nav-item ${currentURI.equals('/complain/create') ? 'active' : ''}">
									<a href="/complain/create" class="nav-link">민원 신청</a>
								</li>
								<li class="nav-item ${currentURI.equals('/complain/list') ? 'active' : ''}">
									<a href="/complain/list" class="nav-link">나의 민원</a>
								</li>
							</ul>
						</div>
					</li>
	
					<li class="menu-title">
						<i class="ri-more-fill"></i> 
						<span>서비스</span>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/charge/resident/payment') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/charge/resident/payment" role="button"> 
							<i class="las la-file-invoice-dollar"></i> 
							<span>공과금 조회 및 납부</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/public') ? 'open' : ''}">
						<a class="nav-link menu-link" href="#sidebarFacilitys" data-bs-toggle="collapse" role="button"
							aria-expanded="${currentURI.startsWith('/public')}" aria-controls="sidebarFacilitys"> 
							<i class="las la-dove"></i> 
							<span>공동시설물 예약</span>
						</a>
						<div class="collapse menu-dropdown ${currentURI.startsWith('/public') ? 'show' : ''}" id="sidebarFacilitys">
							<ul class="nav nav-sm flex-column">
								<li class="nav-item ${currentURI.startsWith('/public/book') ? 'active' : ''}">
									<a href="/public/book/list" class="nav-link">도서관</a>
								</li>
								<li class="nav-item ${currentURI.startsWith('/public/tennis') ? 'active' : ''}">
									<a href="/public/tennis/reservation?facCode=facility01" class="nav-link">테니스</a>
								</li>
								<li class="nav-item ${currentURI.startsWith('/public/golf') ? 'active' : ''}">
									<a href="/public/golf/reservation?facCode=facility02" class="nav-link">스크린 골프</a>
								</li>
								<li class="nav-item ${currentURI.startsWith('/public/studyRoom') ? 'active' : ''}">
									<a href="/public/studyRoom/reservation?facCode=facility03" class="nav-link">독서실</a>
								</li>
							</ul>
						</div>
					</li>
					
					<li class="nav-item  ${currentURI.startsWith('/visitcar/list') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/visitcar/list" role="button"> 
							<i class="las la-car"></i> 
							<span>방문차량 등록</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/maintenance') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/maintenance/list" role="button"> 
							<i class="las la-wrench"></i> 
							<span>하자보수 신청</span>
						</a>
					</li>
						
					<li class="nav-item ${currentURI.startsWith('/waste') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/waste/wasteList" role="button"> 
							<i class=" las la-recycle"></i> 
							<span>폐기물 신청</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/delivery/resDeliveryList') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/delivery/resDeliveryList" role="button"> 
							<i class=" las la-truck"></i> 
							<span>택배 신청</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/calendar/calendarPage') ? 'active' : ''}">
						<a class="nav-link menu-link" href="http:/calendar/calendarPage" role="button"> 
							<i class=" las la-calendar-alt"></i> 
							<span>일정 관리</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/vote') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/vote/list" role="button"> 
							<i class=" las la-vote-yea"></i> 
							<span>투표</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/survey') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/survey/list" role="button"> 
							<i class="ri-survey-line"></i> 
							<span>설문조사</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/contract/list') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/contract/list" role="button"> 
							<i class="las la-file-contract"></i> 
							<span>의무공개 계약서</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/CCTV') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/CCTV" role="button"> 
							<i class="las la-video"></i> 
							<span>CCTV 조회</span>
						</a>
					</li>
	
					<li class="nav-item ${currentURI.startsWith('/moveout/insert') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/moveout/insert" role="button"> 
							<i class="las la-user-minus"></i> 
							<span>퇴거신고</span>
						</a>
					</li>
	
					
				</ul>
			</div>
		</div>
		<!-- Sidebar -->
	</div>
	<div class="sidebar-background"></div>
</div>


<!-- Vertical Overlay-->
<div class="vertical-overlay"></div>

<script>
// 메뉴 드롭다운 하나만 열리도록 처리
$(".menu-link").on('click', function(){
	$(".menu-link").attr('aria-expanded', false);
	$(".menu-dropdown").removeClass("show");
	$(this).attr('aria-expanded', true);
})

//현재 URI 가져오기
const currentURI = window.location.pathname;

// 각 메뉴 항목에 대해 active 클래스 추가
document.addEventListener('DOMContentLoaded', function() {
	const navLinks = document.querySelectorAll('.nav-link');
	navLinks.forEach(link => {
		const href = link.getAttribute('href');
		if (href && currentURI.startsWith(href)) { 
			link.parentElement.classList.add('active');
			link.closest('.collapse').classList.add('show'); // 부모 collapse도 활성화
			link.closest('.nav-item').classList.add('open'); // 부모 nav-item도 활성화
		}
	});
});
</script>