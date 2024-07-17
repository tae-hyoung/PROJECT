<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<style>
.alarmCloseBtn{
	font-size: 2em;
	display: flex;
	justify-content: flex-end;
	cursor: pointer;
}

.nav-link{
	position: relative;
	
}

.nav-item{
	overflow: visible;
}

.cntAlarm{
	position: absolute;
	top: -10px;
	z-index: 1000;
}

</style>

<div style="display: none" id="memIdForAlarm"><sec:authentication property="principal.memberVO.memId" /></div>


<header id="page-topbar">
	<div class="layout-width">
		<div class="navbar-header">
			<div class="d-flex">
				<div class="navbar-brand-box horizontal-logo">
					<a href="/" class="logo logo-dark"> 
						<span class="logo-sm"> 
							<img src="/resources/images/logo/logo6.png" alt="" height="22">
						</span> 
						<span class="logo-lg"> 
							<img src="/resources/images/logo/logo5.png" alt="" height="17">
						</span>
					</a> 
				</div>

			</div>

			<div class="d-flex align-items-center">

				<div class="dropdown d-md-none topbar-head-dropdown header-item">
					<button type="button"
						class="btn btn-icon btn-topbar material-shadow-none btn-ghost-secondary rounded-circle"
						id="page-header-search-dropdown" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">
						<i class="bx bx-search fs-22"></i>
					</button>
					<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0"
						aria-labelledby="page-header-search-dropdown">
						<form class="p-3">
							<div class="form-group m-0">
								<div class="input-group">
									<input type="text" class="form-control"
										placeholder="Search ..." aria-label="Recipient's username">
									<button class="btn btn-primary" type="submit">
										<i class="mdi mdi-magnify"></i>
									</button>
								</div>
							</div>
						</form>
					</div>
				</div>
				
				<div class="dropdown ms-1 topbar-head-dropdown header-item">
					<span class="btn btn-icon btn-topbar rounded-circle">
						<a href="/"><i class="ri-home-3-line" style="font-size: 25px;"></i></a>
					</span>
				</div>
				
				<div class="ms-1 header-item d-none d-sm-flex">
					<button type="button"
						class="btn btn-icon btn-topbar material-shadow-none btn-ghost-secondary rounded-circle" onclick="toggleFullScreen()">
						<i class='bx bx-fullscreen fs-20'></i>
					</button>
				</div>

				<div class="ms-1 header-item d-none d-sm-flex">
					<button type="button"
						class="btn btn-icon btn-topbar material-shadow-none btn-ghost-secondary rounded-circle light-dark-mode" onclick="toggleDarkMode()">
						<i class='bx bx-moon fs-20'></i>
					</button>
				</div>

				<div class="ms-1 header-item d-none d-sm-flex">
					<button type="button" class="btn btn-icon btn-topbar material-shadow-none btn-ghost-secondary rounded-circle" id="page-header-JJIM-dropdown" 
							data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false">
						<i class='ri-shopping-cart-line fs-20'></i>
					</button>
					<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0" aria-labelledby="page-header-JJIM-dropdown">
						<div class="dropdown-head bg-primary bg-pattern rounded-top">
							<div class="p-3">
								<div class="row align-items-center">
									<div class="col">
										<h6 class="m-0 fs-16 fw-semibold text-white">찜 목록</h6>
									</div>
								</div>
							</div>

						</div>
						<div class="px-2 pt-2">
							<div data-simplebar style="min-height: 200px;" class="pe-2">
								
								<div class="tab-content position-relative">
									<div class="tab-pane fade show active py-2 ps-2">
										<div data-simplebar style="" class="pe-2" id="tblJJIM">
										</div>
									</div>
								</div>
								
							</div>
						</div>
					</div>
				</div>

				<div class="dropdown topbar-head-dropdown ms-1 header-item" id="notificationDropdown">
					<button type="button" class="btn btn-icon btn-topbar material-shadow-none btn-ghost-secondary rounded-circle" id="page-header-notifications-dropdown" 
							data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-haspopup="true" aria-expanded="false">
						<i class='bx bx-bell fs-20'></i>
						<span class="position-absolute topbar-badge fs-10 translate-middle badge rounded-pill bg-danger cntAlarm cntAllAlarm"></span>
					</button>
					<div class="dropdown-menu dropdown-menu-lg dropdown-menu-end p-0" aria-labelledby="page-header-notifications-dropdown">
						<div class="dropdown-head bg-primary bg-pattern rounded-top">
							<div class="p-3">
								<div class="row align-items-center">
									<div class="col">
										<h6 class="m-0 fs-16 fw-semibold text-white">알림</h6>
									</div>
									<div class="col-auto dropdown-tabs">
										<span class="badge bg-light text-body fs-13"> new <span class="cntAllAlarm"></span> </span>
									</div>
								</div>
							</div>

							<div class="px-2 pt-2">
								<ul class="nav nav-tabs dropdown-tabs nav-tabs-custom" data-dropdown-tabs="true" id="notificationItemsTab" role="tablist">
									<li class="nav-item waves-effect waves-light">
										<a class="nav-link active" data-bs-toggle="tab" href="#all-tab" role="tab" aria-selected="true"> 
											전체<span class="position-absolute topbar-badge fs-10 translate-middle badge rounded-pill bg-danger cntAlarm cntAllAlarm"></span> 
										</a>
									</li>
									<li class="nav-item waves-effect waves-light">
										<a class="nav-link" data-bs-toggle="tab" href="#srvc-tab" role="tab" aria-selected="false"> 
											서비스<span class="position-absolute topbar-badge fs-10 translate-middle badge rounded-pill bg-danger cntAlarm cntSrvcAlarm"></span> 
										</a>
									</li>
									<li class="nav-item waves-effect waves-light">
										<a class="nav-link" data-bs-toggle="tab" href="#comm-tab" role="tab" aria-selected="false"> 
											커뮤니티<span class="position-absolute topbar-badge fs-10 translate-middle badge rounded-pill bg-danger cntAlarm cntCommAlarm"></span> 
										</a>
									</li>
									<li class="nav-item waves-effect waves-light">
										<a class="nav-link" data-bs-toggle="tab" href="#info-tab" role="tab" aria-selected="false"> 
											입주정보<span class="position-absolute topbar-badge fs-10 translate-middle badge rounded-pill bg-danger cntAlarm cntInfoAlarm"></span> 
										</a>
									</li>
								</ul>
							</div>

						</div>

						<div class="tab-content position-relative" id="notificationItemsTabContent">
							<div class="tab-pane fade show active py-2 ps-2" id="all-tab" role="tabpanel">
								<div data-simplebar style="" class="pe-2" id="allAlarm"></div>
							</div>

							<div class="tab-pane fade py-2 ps-2" id="srvc-tab" role="tabpanel" aria-labelledby="srvc-tab">
								<div data-simplebar style="" class="pe-2" id="srvcAlarm"></div>
							</div>

							<div class="tab-pane fade py-2 ps-2" id="comm-tab" role="tabpanel" aria-labelledby="comm-tab">
								<div data-simplebar style="" class="pe-2" id="commAlarm"></div>
							</div>

							<div class="tab-pane fade py-2 ps-2" id="info-tab" role="tabpanel" aria-labelledby="info-tab">
								<div data-simplebar style="" class="pe-2" id="infoAlarm"></div>
							</div>
							
						</div>
					</div>
				</div>

				<div class="dropdown ms-sm-3 header-item topbar-user">
					<button type="button" class="btn material-shadow-none"
						id="page-header-user-dropdown" data-bs-toggle="dropdown"
						aria-haspopup="true" aria-expanded="false">
						<span class="d-flex align-items-center"> 
                        	<c:if test="${mjSajin != null }">
                                <img id ="hdrPrfImg" class="rounded-circle header-profile-user" src="/upload/profile/${mjSajin}" alt="Header Avatar" >             	
                        	</c:if>
                        	<c:if test="${mjSajin == null }">
                        		<img class="rounded-circle header-profile-user" src="/upload/profile/<sec:authentication property="principal.memberVO.profImg"/>" alt="Header Avatar">                 	
                        	</c:if>						                            		 
							<span class="text-start ms-xl-2">
							<span class="d-none d-xl-inline-block ms-1 fw-medium user-name-text"><sec:authentication property="principal.memberVO.memNm"/></span> 
							<c:if test="${nickname != null }">
								<span id="hdrNickname" class="d-none d-xl-block ms-1 fs-12 user-name-sub-text">${nickname}</span>
							</c:if>
							<c:if test="${nickname == null }">
								<span class="d-none d-xl-block ms-1 fs-12 user-name-sub-text"><sec:authentication property="principal.memberVO.nickname"/></span>
							</c:if>
						</span>
						</span>
					</button>
					
					<div class="dropdown-menu dropdown-menu-end">
						<!-- item-->
<!-- 						<h6 class="dropdown-header">Welcome Anna!</h6> -->
							<sec:authorize access="hasRole('ROLE_ADMIN')">
							    <a class="dropdown-item" href="/admin/profile">
							        <i class="mdi mdi-account-circle text-muted fs-16 align-middle me-1"></i>
							        <span class="align-middle">마이 페이지</span>
							    </a>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_USER')">
							    <a class="dropdown-item" href="/resident/profile">
							        <i class="mdi mdi-account-circle text-muted fs-16 align-middle me-1"></i>
							        <span class="align-middle">마이 페이지</span>
							    </a>
							</sec:authorize> 
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<a class="dropdown-item" href="/admin/msg">
									<i class="mdi mdi-message-text-outline text-muted fs-16 align-middle me-1"></i>
									<span class="align-middle">쪽지</span>
								</a>
							</sec:authorize>
							<sec:authorize access="hasRole('ROLE_USER')">
								<a class="dropdown-item" href="/resident/msg">
									<i class="mdi mdi-message-text-outline text-muted fs-16 align-middle me-1"></i>
									<span class="align-middle">쪽지</span>
								</a>
							</sec:authorize>  
<!-- 							<a class="dropdown-item" href="index.html?#apps-tasks-kanban.html"><i -->
<!-- 							class="mdi mdi-calendar-check-outline text-muted fs-16 align-middle me-1"></i> -->
<!-- 							<span class="align-middle">Taskboard</span></a> <a -->
<!-- 							class="dropdown-item" href="index.html?#pages-faqs.html"><i -->
<!-- 							class="mdi mdi-lifebuoy text-muted fs-16 align-middle me-1"></i> -->
<!-- 							<span class="align-middle">Help</span></a> -->
						<div class="dropdown-divider"></div>
						<form action="/logout" method="post" id = "logoutForm">
							 <button type="button" class="dropdown-item" id="logout">
							 	<i class="mdi mdi-logout text-muted fs-16 align-middle me-1"></i> 
								<span class="align-middle" data-key="t-logout">로그아웃</span>
							 </button>
							 <sec:csrfInput/>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>
<!-- SweetAlert  -->
<link href="/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
<script src="/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>

<!-- removeNotificationModal -->
<div id="removeNotificationModal" class="modal fade zoomIn"
	tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close" id="NotificationModalbtn-close"></button>
			</div>
			<div class="modal-body">
				<div class="mt-2 text-center">
					<lord-icon src="https://cdn.lordicon.com/gsqxdxog.json"
						trigger="loop" colors="primary:#f7b84b,secondary:#f06548"
						style="width:100px;height:100px"></lord-icon>
					<div class="mt-4 pt-2 fs-15 mx-4 mx-sm-5">
						<h4>Are you sure ?</h4>
						<p class="text-muted mx-4 mb-0">Are you sure you want to
							remove this Notification ?</p>
					</div>
				</div>
				<div class="d-flex gap-2 justify-content-center mt-4 mb-2">
					<button type="button" class="btn w-sm btn-light"
						data-bs-dismiss="modal">Close</button>
					<button type="button" class="btn w-sm btn-danger"
						id="delete-notification">Yes, Delete It!</button>
				</div>
			</div>

		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<script>
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
			$('#logoutForm').submit();
		}
	})
})

function toggleFullScreen() {
  if (!document.fullscreenElement) {
    document.documentElement.requestFullscreen()
  } else {
    if (document.exitFullscreen) {
      document.exitFullscreen()
    }
  }
}

let darkMode = false;
function toggleDarkMode(){
	if(!darkMode){
		$("*").css('background-color', 'black');
		darkMode = true;
	}else{
		$("*").css('background-color', 'white');
		darkMode = false;
	}
}

// 알람
function getAlarm(){
	$.ajax({
		url: "/alarm",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify($('#memIdForAlarm').text().trim()),
		type: "post",
		dataType: "json",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}",
					"${_csrf.token}");
		},
		success: function(result) {
// 			console.log("result : ", result);

			let allStr = '';
			let srvcStr = '';
			let commStr = '';
			let infoStr = '';
			for(let i=0; i<result.length; i++){
				allStr += '<div class="text-reset notification-item d-block dropdown-item" style="height: 100px;">';
				allStr += '<div class="d-flex row" data-alarmSeq="'+result[i].alarmSeq+'">';
				
				if(result[i].category == '민원')	{
					allStr += '민원에 답변이 등록되었습니다.<br>';
					allStr += '<span class="col-11"><a href="/complain/list">페이지로 이동</a></span>';
					
					commStr += '<div class="text-reset notification-item d-block dropdown-item" style="height: 100px;">';
					commStr += '<div class="d-flex row" data-alarmSeq="'+result[i].alarmSeq+'">';
					commStr += '민원에 답변이 등록되었습니다.<br>';
					commStr += '<span class="col-11"><a href="/complain/list">페이지로 이동</a></span>';
					commStr += '<span class="col-11">접수번호: '+result[i].globalCode+'</span>';
					commStr += '<span class="col-1 alarmCloseBtn"><i class="mdi mdi-close-circle-outline"></i></span>';
					commStr += '</div>';
					commStr += '</div>';
				}				
				else if(result[i].category == '차량')	{
					allStr += '차량 등록이 승인되었습니다.<br>';
					allStr += '<span class="col-11"><a href="/car/list">페이지로 이동</a></span>';
					
					infoStr += '<div class="text-reset notification-item d-block dropdown-item" style="height: 100px;">';
					infoStr += '<div class="d-flex row" data-alarmSeq="'+result[i].alarmSeq+'">';
					infoStr += '차량 등록이 승인되었습니다.<br>';
					infoStr += '<span class="col-11"><a href="/car/list">페이지로 이동</a></span>';
					infoStr += '<span class="col-11">접수번호: '+result[i].globalCode+'</span>';
					infoStr += '<span class="col-1 alarmCloseBtn"><i class="mdi mdi-close-circle-outline"></i></span>';
					infoStr += '</div>';
					infoStr += '</div>';
				}
				else if(result[i].category == '퇴거')	{
					allStr += '퇴거 관리비가 정산되었습니다.<br>	';
					allStr += '<span class="col-11"><a href="/moveout/insert">페이지로 이동</a></span>';
					
					infoStr += '<div class="text-reset notification-item d-block dropdown-item" style="height: 100px;">';
					infoStr += '<div class="d-flex row" data-alarmSeq="'+result[i].alarmSeq+'">';
					infoStr += '퇴거 관리비가 정산되었습니다.<br>';
					infoStr += '<span class="col-11"><a href="/moveout/insert">페이지로 이동</a></span>';
					infoStr += '<span class="col-11">접수번호: '+result[i].globalCode+'</span>';
					infoStr += '<span class="col-1 alarmCloseBtn"><i class="mdi mdi-close-circle-outline"></i></span>';
					infoStr += '</div>';
					infoStr += '</div>';
				}
				else if(result[i].category == '택배 수거'){
					allStr += '택배가 수거되었습니다.<br>';
					allStr += '<span class="col-11"><a href="/delivery/resDeliveryList">페이지로 이동</a></span>';
					
					srvcStr += '<div class="text-reset notification-item d-block dropdown-item" style="height: 100px;">';
					srvcStr += '<div class="d-flex row" data-alarmSeq="'+result[i].alarmSeq+'">';
					srvcStr += '택배가 수거되었습니다.<br>';
					srvcStr += '<span class="col-11"><a href="/delivery/resDeliveryList">페이지로 이동</a></span>';
					srvcStr += '<span class="col-11">접수번호: '+result[i].globalCode+'</span>';
					srvcStr += '<span class="col-1 alarmCloseBtn"><i class="mdi mdi-close-circle-outline"></i></span>';
					srvcStr += '</div>';
					srvcStr += '</div>';
				}
				else if(result[i].category == '택배 반려'){
					allStr += '택배가 반려되었습니다.<br>';
					allStr += '<span class="col-11"><a href="/delivery/resDeliveryList">페이지로 이동</a></span>';
					
					srvcStr += '<div class="text-reset notification-item d-block dropdown-item" style="height: 100px;">';
					srvcStr += '<div class="d-flex row" data-alarmSeq="'+result[i].alarmSeq+'">';
					srvcStr += '택배가 반려되었습니다.<br>';
					srvcStr += '<span class="col-11"><a href="/delivery/resDeliveryList">페이지로 이동</a></span>';
					srvcStr += '<span class="col-11">접수번호: '+result[i].globalCode+'</span>';
					srvcStr += '<span class="col-1 alarmCloseBtn"><i class="mdi mdi-close-circle-outline"></i></span>';
					srvcStr += '</div>';
					srvcStr += '</div>';
				}
				else if(result[i].category == '하자보수 상태 변경'){
					allStr += '하자보수 신청의 상태가 변경되었습니다.<br>';
					allStr += '<span class="col-11"><a href="/maintenance/detail?mtSeq='+result[i].globalCode+'">페이지로 이동</a></span>';
					
					srvcStr += '<div class="text-reset notification-item d-block dropdown-item" style="height: 100px;">';
					srvcStr += '<div class="d-flex row" data-alarmSeq="'+result[i].alarmSeq+'">';
					srvcStr += '하자보수 신청의 상태가 변경되었습니다.<br>';
					srvcStr += '<span class="col-11"><a href="/maintenance/detail?mtSeq='+result[i].globalCode+'">페이지로 이동</a></span>';
					srvcStr += '<span class="col-11">접수번호: '+result[i].globalCode+'</span>';
					srvcStr += '<span class="col-1 alarmCloseBtn"><i class="mdi mdi-close-circle-outline"></i></span>';
					srvcStr += '</div>';
					srvcStr += '</div>';
				}
				else if(result[i].category == '하자보수 업체 지정'){
					allStr += '하자보수 업체가 지정되었습니다.<br>';
					allStr += '<span class="col-11"><a href="/maintenance/detail?mtSeq='+result[i].globalCode+'">페이지로 이동</a></span>';
					
					srvcStr += '<div class="text-reset notification-item d-block dropdown-item" style="height: 100px;">';
					srvcStr += '<div class="d-flex row" data-alarmSeq="'+result[i].alarmSeq+'">';
					srvcStr += '하자보수 업체가 지정되었습니다.<br>';
					srvcStr += '<span class="col-11"><a href="/maintenance/detail?mtSeq='+result[i].globalCode+'">페이지로 이동</a></span>';
					srvcStr += '<span class="col-11">접수번호: '+result[i].globalCode+'</span>';
					srvcStr += '<span class="col-1 alarmCloseBtn"><i class="mdi mdi-close-circle-outline"></i></span>';
					srvcStr += '</div>';
					srvcStr += '</div>';
				}
				else if(result[i].category == '폐기물'){
					allStr += '폐기물 신청이 승인되었습니다.<br>';
					allStr += '<span class="col-11"><a href="/waste/detail?wasteSeq='+result[i].globalCode+'">페이지로 이동</a></span>';
					
					srvcStr += '<div class="text-reset notification-item d-block dropdown-item" style="height: 100px;">';
					srvcStr += '<div class="d-flex row" data-alarmSeq="'+result[i].alarmSeq+'">';
					srvcStr += '폐기물 신청이 승인되었습니다.<br>';
					srvcStr += '<span class="col-11"><a href="/waste/detail?wasteSeq='+result[i].globalCode+'">페이지로 이동</a></span>';
					srvcStr += '<span class="col-11">접수번호: '+result[i].globalCode+'</span>';
					srvcStr += '<span class="col-1 alarmCloseBtn"><i class="mdi mdi-close-circle-outline"></i></span>';
					srvcStr += '</div>';
					srvcStr += '</div>';
				}
				allStr += '<span class="col-11">접수번호: '+result[i].globalCode+'</span>';
				allStr += '<span class="col-1 alarmCloseBtn"><i class="mdi mdi-close-circle-outline"></i></span>';
				allStr += '</div>';
				allStr += '</div>';
			}
			
			let noAlarm = '';
			noAlarm += '<div class="text-reset notification-item d-block dropdown-item" style="height: 100px;">';
			noAlarm += '<div class="d-flex row" style="margin: 30px;">알람이 없습니다.';
			noAlarm += '</div>';
			noAlarm += '</div>';
			
			$('#allAlarm').html(allStr);
			$('.cntAllAlarm').text($('#allAlarm').children().length);
			if($('.cntAllAlarm').eq(0).text() == '0'){
				$(".cntAllAlarm").text('');
				$('#allAlarm').html(noAlarm);
			}
			
			$('#srvcAlarm').html(srvcStr);
			$('.cntSrvcAlarm').text($('#srvcAlarm').children().length);
			if($('.cntSrvcAlarm').text() == '0'){
				$(".cntSrvcAlarm").text('');
				$('#srvcAlarm').html(noAlarm);
			}
			
			$('#commAlarm').html(commStr);
			$('.cntCommAlarm').text($('#commAlarm').children().length);
			if($('.cntCommAlarm').text() == '0'){
				$(".cntCommAlarm").text('');
				$('#commAlarm').html(noAlarm);
			}
			
			$('#infoAlarm').html(infoStr);
			$('.cntInfoAlarm').text($('#infoAlarm').children().length);
			if($('.cntInfoAlarm').text() == '0'){
				$(".cntInfoAlarm").text('');
				$('#infoAlarm').html(noAlarm);
			}
			
		}
	});
}

getAlarm();

$(document).on('click', ".alarmCloseBtn", function(){
	let alarmDiv = $(this).parent()[0];
// 	console.log(alarmDiv);
	
	let data = {
			alarmSeq: alarmDiv.dataset.alarmseq
	}
	
// 	console.log(data);
	
	// 아작스로 알람 번호 보내서 읽음으로 처리하기
	$.ajax({
		url: "/alarm/read", 
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post", 
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
// 			console.log(result);
			getAlarm();
		}
	})
});

function getJJIMList(){
	$.ajax({
		url: "/board/getJJIMListById",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify($('#memIdForAlarm').text().trim()),
		type: "post",
		dataType: "json",
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result) {
			console.log("JJIMVOList: ", result);
			
			let str = '';
			for(let i=0; i<result.length; i++){

				str += '<div class="text-reset d-block dropdown-item" style="height: 80px;">';
				str += '<div class="d-flex row" data-boardSeq="'+result[i].brdSeq+'">';
				str += '<span class="col-1">'+ (i+1) +'. </span>';
				str += '<span class="col-8">'+result[i].title+'</span>';
				str += '<span class="col-11"><a href="/board/detail?boardCat=board_trade&brdNo='+result[i].brdSeq+'">게시글로 이동</a></span>';
				str += '</div>';
				str += '</div>';
				
			}
			$('#tblJJIM').html(str);
		}
	});
}
getJJIMList();
</script>