<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
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
		<a href="/admin/main" class="logo logo-light">
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
			<div id="adminSide">
				<ul class="navbar-nav" id="navbar-nav">
					<li class="menu-title">
						<i class="ri-more-fill"></i> 
						<span>입주민</span>
					</li>
					<li class="nav-item ${currentURI.equals('/admin/memberList') || currentURI.equals('/admin/waitMember') || currentURI.equals('/moveout/admin/list') || currentURI.equals('/car/admin/adCarList') || currentURI.equals('/visitcar/admin/adVisitCarList') ? 'open' : ''}">
						<a class="nav-link menu-link" href="#resident" data-bs-toggle="collapse" role="button"
							aria-expanded="${currentURI.equals('/admin/memberList') || currentURI.equals('/admin/waitMember') || currentURI.equals('/moveout/admin/list') || currentURI.equals('/car/admin/adCarList') || currentURI.equals('/visitcar/admin/adVisitCarList')}" aria-controls="resident"> 
							<i class=" las la-user-check"></i> 
							<span>입주민 관리</span>
						</a>
						<div class="collapse menu-dropdown ${currentURI.equals('/admin/memberList') || currentURI.equals('/admin/waitMember') || currentURI.equals('/moveout/admin/list') || currentURI.equals('/car/admin/adCarList') || currentURI.equals('/visitcar/admin/adVisitCarList') ? 'show' : ''}" id="resident">
							<ul class="nav nav-sm flex-column">
								<li class="nav-item ${currentURI.equals('/admin/memberList') ? 'active' : ''}">
									<a href="/admin/memberList" class="nav-link"> 입주민 목록 </a>
								</li>
								<li class="nav-item ${currentURI.equals('/admin/waitMember') ? 'active' : ''}">
									<a href="/admin/waitMember" class="nav-link"> 가입 신청 현황 </a>
								</li>
								<li class="nav-item ${currentURI.equals('/moveout/admin/list') ? 'active' : ''}">
									<a href="/moveout/admin/list" class="nav-link"> 퇴거 신청 현황 </a>
								</li>
								<li class="nav-item ${currentURI.equals('/car/admin/adCarList') ? 'active' : ''}">
									<a href="/car/admin/adCarList" class="nav-link"> 등록 차량 현황 </a>
								</li>
								<li class="nav-item ${currentURI.equals('/visitcar/admin/adVisitCarList') ? 'active' : ''}">
									<a href="/visitcar/admin/adVisitCarList" class="nav-link"> 방문 차량 현황 </a>
								</li>
<!-- 								<li class="nav-item"> -->
<!-- 									<a href="#" class="nav-link"> 검침 기록 </a> -->
<!-- 								</li> -->
							</ul>
						</div>
					</li>
					
					<li class="nav-item ${currentURI.equals('/charge/admin/insert') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/charge/admin/insert" role="button"> 
							<i class="mdi mdi-chart-bar"></i> 
							<span> 관리비 현황  </span>
						</a>
					</li>
	
					<li class="menu-title">
						<i class="ri-more-fill"></i> 
						<span>협력업체</span>
					</li>
					
					<li class="nav-item ${currentURI.equals('/ccpy/admin/list') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/ccpy/admin/list" role="button"> 
							<i class="las la-handshake"></i> 
							<span> 협력 업체 목록 </span>
						</a>
					</li>
	
					<li class="menu-title">
						<i class="ri-more-fill"></i> 
						<span>서비스</span>
					</li>
					
					<li class="nav-item ${currentURI.startsWith('/public/admin') ? 'open' : ''}">
						<a class="nav-link menu-link" href="#facilities" data-bs-toggle="collapse" role="button"
							aria-expanded="${currentURI.startsWith('/public/admin')}" aria-controls="facilities"> 
							<i class="las la-dove"></i> 
							<span>공동시설물</span>
						</a>
						<div class="collapse menu-dropdown ${currentURI.startsWith('/public/admin') ? 'show' : ''}" id="facilities">
							<ul class="nav nav-sm flex-column">
								<li class="nav-item ${currentURI.equals('/public/admin/bookList') ? 'active' : ''}">
									<a href="/public/admin/bookList" class="nav-link">도서관</a>
								</li>
								<li class="nav-item ${currentURI.equals('/public/admin/liveStatus') ? 'active' : ''}">
									<a href="/public/admin/liveStatus" class="nav-link">실시간 이용 현황</a>
								</li>
								<li class="nav-item ${currentURI.equals('/public/admin/allReList') ? 'active' : ''}">
									<a href="/public/admin/allReList" class="nav-link">전체 신청 목록</a>
								</li>
							</ul>
						</div>
					</li>
					
					<li class="nav-item ${currentURI.equals('/maintenance/admin/adList') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/maintenance/admin/adList" role="button"> 
							<i class="las la-wrench"></i> 
							<span> 하자보수 신청 현황 </span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.equals('/waste/admin/adWasteList') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/waste/admin/adWasteList" role="button"> 
							<i class="las la-recycle"></i> 
							<span> 폐기물 신청 현황 </span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.equals('/delivery/admin/delivery') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/delivery/admin/delivery" role="button"> 
							<i class="las la-truck"></i> 
							<span> 택배 신청 현황</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.equals('/calendar/admin/adminCalendarPage') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/calendar/admin/adminCalendarPage" role="button"> 
							<i class="las la-calendar-alt"></i> 
							<span> 단지 일정 관리 </span>
						</a>
					</li>

					<li class="nav-item ${currentURI.contains('/vote') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/vote/admin/list" role="button"> 
							<i class=" las la-vote-yea"></i> 
							<span>투표</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.contains('/survey') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/survey/admin/list" role="button"> 
							<i class="ri-survey-line"></i> 
							<span>설문조사</span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.equals('/contract/admin/list') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/contract/admin/list" role="button"> 
							<i class="las la-file-contract"></i> 
							<span> 의무공개 계약서 </span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.equals('/CCTV') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/CCTV/admin" role="button"> 
							<i class="las la-video"></i> 
							<span> CCTV </span>
						</a>
					</li>
	
	
					<li class="menu-title">
						<i class="ri-more-fill"></i> 
						<span>커뮤니티</span>
					</li>
					
					<li class="nav-item ${currentURI.equals('/board/admin/list') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/board/admin/list" role="button"> 
							<i class="bx bx-edit"></i> 
							<span> 게시판 관리 </span>
						</a>
					</li>
					
					<li class="nav-item ${currentURI.equals('/complain/admin/list') ? 'active' : ''}">
						<a class="nav-link menu-link" href="/complain/admin/list" role="button"> 
							<i class="bx bx-message-rounded-edit"></i> 
							<span> 민원 신청 현황 </span>
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
// 메뉴 드롭다운 하나만 열리도록
$(".menu-link").on('click', function(){
	$(".menu-link").attr('aria-expanded', false);
	$(".menu-dropdown").removeClass("show");
	$(this).attr('aria-expanded', true);
})
</script>