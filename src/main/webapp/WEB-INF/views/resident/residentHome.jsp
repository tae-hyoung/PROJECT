<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>


<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>



<style>
/* ////달력 영역 스타일- 시작///// */
.fc-view-harness{
 	margin-top: -15px;
}

.fc-toolbar-title {
	font-size: 23px !important;
	margin-right: 90px !important;
}


/* FullCalendar의 높이를 고정 */
#calendar .fc-scroller {
    height: 100% !important; 
    overflow: hidden  !important; 
}


/* 각 날짜 셀의 높이를 조정 */
.fc-daygrid-day-frame {
    height: 60px; /* 원하는 높이로 조절 */
}

/* 날짜 셀의 내용이 영역 내에 맞도록 조정 */
.fc-daygrid-day-top {
    height: 28px; /* 날짜 숫자의 높이 조절 */
}

/* 이벤트 목록의 높이 조정 */
.fc-daygrid-day-events {
    max-height: calc(100% - 28px); /* 날짜 숫자가 차지하는 공간을 제외한 높이 */
	overflow: visible;
}

/* 5주까지만 표시하고 나머지 주는 숨기기 */
.fc-daygrid-week:nth-child(n+8) {
    display: none;
}

/* 전체 캘린더의 높이를 조정 */
.fc-daygrid-body {
    overflow: visible;
}
.fc .fc-daygrid-day-number {
 width: 36px;
 font-size: 15px;
}
.fc-scrollgrid  {
  cursor:pointer;
}

.fc-direction-ltr .fc-daygrid-event.fc-event-end, .fc-direction-rtl .fc-daygrid-event.fc-event-start {
    margin-right: 1px;
    margin-left: 1px;
}

.fc .fc-daygrid-day.fc-day-today {
	background-color: #f7eb4b2e;
}
.fc-direction-ltr .fc-daygrid-event.fc-event-start, .fc-direction-rtl .fc-daygrid-event.fc-event-end {
    margin-left: 1px;
    margin-right: 1px;
}
/* ////달력 영역 스타일- 끝///// */

.tblRow{
	height: 40px;
}

#alarmSpan{
	cursor:pointer;
}
</style>

<input type="hidden" id="memId" value="<sec:authentication property='principal.memberVO.memId'/>">
<input type="hidden" id="roomCode" value="<sec:authentication property='principal.memberVO.roomCode'/>">

<div class="row" style="margin-left: 0px;">
	<div class="col-8">
		<!-- 관리비 시작 -->
		<div class="card" style="height: 380px;  font-size: 16px;">
		    <div class="card-header" style="padding-bottom: 3px;">
	            <div class="col-11">
	                <h3>관리비</h3>
	            </div>
	        </div>
	        
	        <div class="row">
		        <div class="col-7" style="margin-left: -60px; margin-top: 20px;">
					<div id="percent" style="display: none;">${percent}</div>
					<canvas id="chargeDoughnut" width="710" height="260"></canvas>
					<div id="percentDisp1" style="font-size: 1.8em; display: flex; justify-content: center; margin-left: 110px; margin-top: -90px;"></div>
					<div id="percentDisp2" style="font-size: 1.8em; display: flex; justify-content: center; margin-left: 110px;"></div>
		        </div>
		        <div class="col-5" style="margin-left: 40px;">
					<div style="background-color: white; width: 380px; margin-top: 14px;">
						<div style="border-bottom: 1px solid black">
							<p style="display:flex; justify-content: flex-end;">
								<span style="color: #299cdb; margin-top: 15px; font-size: 20px;">${fn:substring(ym, 0, 4)}년 ${fn:substring(ym, 5, 7)}월분</span>&nbsp;&nbsp;
								<span style="font-size: 2em; font-weight: 600;">납부하실 금액은</span>
							</p>
							<p style="display:flex; justify-content: flex-end; color: #e93813; font-size: 3.5em; font-weight: 600;">
								<span><fmt:formatNumber value="${chargeItemVO.totalCharge}" pattern="#,###" /></span>원
							</p>
							<p style="display:flex; justify-content: flex-end; margin-bottom: 13px;">
								<span style="font-size: 20px;">${fn:substring(ym, 0, 4)}년 ${fn:substring(ym, 5, 7)+1}월 16일까지</span>
							</p>
						</div>
						<div style="display:flex; justify-content: flex-end; margin-left: 40px">
							<p style="font-size: 1.3em; font-weight: 600;">납기내
								<span style="color: #3577f1; font-size: 1.4em; font-weight: 600;"><fmt:formatNumber value="${chargeItemVO.totalCharge}" pattern="#,###" />원</span>
							</p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<p style="font-size: 1.3em; font-weight: 600;">납기후
								<span style="color: #e93813; font-size: 1.4em; font-weight: 600;"><fmt:formatNumber value="${chargeItemVO.totalCharge * 1.02}" pattern="#,###" />원</span>
							</p>
						</div>
					</div>
				</div>
	        </div>
	        
		</div>
		<!-- 관리비 끝 -->
		
		<div style="display: flex; justify-content: center;">		
			<!-- 공지사항 -->
			<div class="card" style="width: 530px; height: 313px;font-size: 16px;">
			    <div class="card-header" style="padding-bottom: 3px;">
			        <div class="row">
			            <div class="col-11">
			                <h3>공지사항</h3>
			            </div>
			            <div class="col-1">
			                <h3><a href="/board/list?boardCat=board_notice" style="font: 2em; text-decoration-line: none;">+</a></h3>
			            </div>
			        </div>
			    </div>
			    <div class="card-body">
			        <table class="table table-striped table-nowrap align-middle mb-0" style="width: 100%; margin-top: -9px; line-height:2px"  >
			            <thead>
			                <tr>
			                    <th style="text-align: center;">제목</th>
			                    <th style="text-align: center;">등록일</th>
			                    <th style="text-align: center;">조회수</th>
			                </tr>
			            </thead>
			            <tbody>
			                <c:forEach var="boardVO" items="${boardVOList}" varStatus="stat">
			                    <tr class="tblRow boardRow">
			                        <td style="display: none">${boardVO.brdSeq}</td>
			                        <c:if test="${fn:length(boardVO.title) > 21}">
				                        <td style="text-align: left;">${fn:substring(boardVO.title, 0, 21)} ...</td>
			                        </c:if>
			                        <c:if test="${fn:length(boardVO.title) <= 21}">
				                        <td style="text-align: left;">${boardVO.title}</td>
			                        </c:if>
			                        <td style="text-align: center;">${fn:substring(boardVO.regDt, 0, 10)}</td>
			                        <td style="text-align: center;">${boardVO.viewCnt}</td>
			                    </tr>
			                </c:forEach>
			            </tbody>
			        </table>
			    </div>
			</div>
			<!-- 공지사항 -->
			
			<div style="width: 20px;"></div>
			
			<!--의무공개계약서 -->
			<div class="card" style="width: 540px;height: 313px;font-size: 16px;">
			    <div class="card-header" style="padding-bottom: 3px;">
			        <div class="row">
			            <div class="col-11">
			                <h3>의무공개계약서</h3>
			            </div>
			            <div class="col-1">
			                <h3><a href="/contract/list" style="font: 2em; text-decoration-line: none;">+</a></h3>
			            </div>
			        </div>
			    </div>
			    <div class="card-body">
			        <table class="table table-striped table-nowrap align-middle mb-0" style="width: 100%; margin-top: -9px; line-height:2px"  >
			            <thead>
			                <tr>
			                    <th style="text-align: center;">구분</th>
			                    <th style="text-align: center;">제목</th>
			                    <th style="text-align: center;">등록일</th>
			                </tr>
			            </thead>
			            <tbody>
			                <c:forEach var="contractVO" items="${contractVOList}" varStatus="stat">
			                    <tr class="tblRow contractRow">
			                        <td class="center">${contractVO.ctCt}</td>
			                        <c:if test="${fn:length(contractVO.ctTitle) > 20}">
				                        <td style="text-align: left;">${fn:substring(contractVO.ctTitle, 0, 20)} ...</td>
			                        </c:if>
			                        <c:if test="${fn:length(contractVO.ctTitle) <= 20}">
				                        <td style="text-align: left;">${contractVO.ctTitle}</td>
			                        </c:if>
			                        <td style="text-align: center;">${fn:substring(contractVO.ctRegDt, 0, 10)}</td>
			                    </tr>
			                </c:forEach>
			            </tbody>
			        </table>
			    </div>
			</div>
			<!--의무공개계약서 -->
		</div>
		
		<!-- 아파트 전경 -->
		<div class="card" style="font-size: 16px;">
		    <div class="card-header" style="padding-bottom: 3px;">
	            <div class="col-11">
	                <h3>아파트 전경</h3>
	            </div>
	        </div>
	        <div class="card-body">
	            <!-- Swiper -->
	            <div class="swiper responsive-swiper rounded gallery-light pb-4 swiper-initialized swiper-horizontal swiper-backface-hidden">
	                <div class="swiper-wrapper" id="swiper-wrapper-db558986b65b3fce" aria-live="polite">
	                    <div class="swiper-slide swiper-slide-active" role="group" aria-label="1 / 6" data-swiper-slide-index="0" style="margin-right: 50px;">
	                        <div class="gallery-box card">
	                            <div class="gallery-container">
                                    <img alt="" src="/resources/images/아파트전경1.jpg" style="height: 250px; border-radius: 30px;">
                                    <span class="gallery-overlay">
                                        <span class="overlay-caption">1</span>
                                    </span>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="swiper-slide swiper-slide-next" role="group" aria-label="2 / 6" data-swiper-slide-index="1" style="margin-right: 50px;">
	                        <div class="gallery-box card">
	                            <div class="gallery-container">
                                    <img alt="" src="/resources/images/아파트전경2.jpg" style="height: 250px; border-radius: 30px;">
                                    <span class="gallery-overlay">
                                        <span class="overlay-caption">2</span>
                                    </span>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="swiper-slide" role="group" aria-label="3 / 6" data-swiper-slide-index="2" style="margin-right: 50px;">
	                        <div class="gallery-box card mb-0">
	                            <div class="gallery-container">
                                    <img alt="" src="/resources/images/아파트전경3.jpg" style="height: 250px; border-radius: 30px;">
                                    <span class="gallery-overlay">
                                        <span class="overlay-caption">3</span>
                                    </span>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="swiper-slide" role="group" aria-label="4 / 6" data-swiper-slide-index="3" style="margin-right: 50px;">
	                        <div class="gallery-box card">
	                            <div class="gallery-container">
                                    <img alt="" src="/resources/images/아파트전경4.jpg" style="height: 250px; border-radius: 30px;">
                                    <span class="gallery-overlay">
                                        <span class="overlay-caption">4</span>
                                    </span>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="swiper-slide" role="group" aria-label="5 / 6" data-swiper-slide-index="4" style="margin-right: 50px;">
	                        <div class="gallery-box card">
	                            <div class="gallery-container">
                                    <img alt="" src="/resources/images/아파트전경5.jpg" style="height: 250px; border-radius: 30px;">
                                    <span class="gallery-overlay">
                                        <span class="overlay-caption">5</span>
                                    </span>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="swiper-slide" role="group" aria-label="5 / 6" data-swiper-slide-index="5" style="margin-right: 50px;">
	                        <div class="gallery-box card">
	                            <div class="gallery-container">
                                    <img alt="" src="/resources/images/아파트전경6.jpg" style="height: 250px; border-radius: 30px;">
                                    <span class="gallery-overlay">
                                        <span class="overlay-caption">6</span>
                                    </span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="swiper-pagination swiper-pagination-dark swiper-pagination-clickable swiper-pagination-bullets swiper-pagination-horizontal">
	                	<span class="swiper-pagination-bullet swiper-pagination-bullet-active" tabindex="0" role="button" aria-label="Go to slide 1" aria-current="true"></span>
	                	<span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 2"></span>
	                	<span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 3"></span>
	                	<span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 4"></span>
	                	<span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 5"></span>
	                	<span class="swiper-pagination-bullet" tabindex="0" role="button" aria-label="Go to slide 6"></span>
	                </div>
	            	<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span>
	            </div>
	        </div>
		</div>
		<!-- 아파트 전경 -->
	</div>

	<div class="col-4">
		<!--프로필 -->
		<div class="card" style="height: 280px; font-size: 16px; ">
			<div class="card-body p-4">
				<div style="display: flex;">
					<div class="profile-user position-relative d-inline-block mx-auto mb-4 col-md-5" style="margin-top: -10px;">
						<c:if test="${mjSajin != null }">
		                    <img src="/upload/profile/${mjSajin}" style="width: 180px; height: 180px;"
		                     class="rounded-circle avatar-xl img-thumbnail user-profile-image material-shadow"
		                     alt="user-profile-image">             	
		               	</c:if>
		             	<c:if test="${mjSajin == null }">
		             		 <img src="/upload/profile/<sec:authentication property="principal.memberVO.profImg"/>" style="width: 180px; height: 180px;"
		                     class="rounded-circle avatar-xl img-thumbnail user-profile-image material-shadow"
		                     alt="user-profile-image">                  	
		             	</c:if>	    
					</div>
					<div class="col-md-7">
						<p style="margin-bottom:15px; margin-top:12px; font-size:25px; text-align:center;"><span id="apt"></span> <span id="room"></span></p>
<!-- 						<br> -->
						<p style="font-size:20px; text-align:center; margin-bottom:25px;">
							<b><sec:authentication property='principal.memberVO.memNm'/>님</b> 환영합니다.
						</p>
<!-- 						<br>  -->
						<p style="float: left; margin-right: 25px; margin-left:60px;"><i class="mdi mdi-bell-ring-outline" style="font-size: 20px;"></i>&nbsp; <span id="alarmSpan"><span class="cntAllAlarm" id="alarmCount" style="color: blue; border-bottom: 1px solid blue;"></span>개</span></p>
						<p>&nbsp;<i class="mdi mdi-email-outline" style="font-size: 20px;"></i>&nbsp;<a href="/resident/msg"><span id="msgCount" style="color: blue; border-bottom: 1px solid blue;"></span>개</a></p>
					</div>
				</div>
			</div>
<script>


	if($('.cntAllAlarm').eq(0).text())	$('#alarmCount').text($('.cntAllAlarm').eq(0).text());
	else								$('#alarmCount').text('0');

	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	
	/*입주 호실*/
	let memId = $('#memId').val();
	
	function roomFormat(roomCode){
        const parts = roomCode.split('_');

        const danNum = parts[1]+'동';
        const danRoom = parts[2]+'호';

        return danNum + ' ' + danRoom;
    }
	
	$.ajax({
		url: "/resident/getProfile",
		type: "GET",
		data: {
			"memId": memId
		},
		dataType: "json",
		beforeSend: function(xhr){
			xhr.setRequestHeader(csrfHeader, csrfToken);
		},
		success: function(data){
			$.each(data, function(index, memberVO) {
			let roomCode = roomFormat(memberVO.roomCode);                
			$('#apt').text(memberVO.danjiName)
			$('#room').text(roomCode);
			});
		},

		error: function(error){
// 			console.error("에러난다 쌤? -> ", error);
		}
	})
	
	/* 받은 쪽지 수   */
	let sender = "";
	$.ajax({
		url: "/receiveNotReadCount",
		type: "GET",
		beforeSend: function(xhr){
			xhr.setRequestHeader(csrfHeader, csrfToken);
		},
		success: function(data){
			$.each(data, function(index, cnt){
				$('#msgCount').text(data.cnt);
			});
		}, error: function(){
// 			console.log("으악 실패!")
		}
	})
	
</script>
		<div class="card-footer d-flex justify-content-center align-items-center" style="position: absolute; bottom: 0; width: 100%;">
			<a href="/resident/profile" class="btn btn-primary waves-effect waves-light" style="width: 180px; margin-right:40px; font-size:15px;">마이페이지</a>
			<form action="/logout" method="post" id = "logoutFormPage">
				<button type="button" class="btn btn-primary waves-effect waves-light" id="logoutButton" style="width: 180px; font-size:15px;">로그아웃</button>
				<sec:csrfInput/>
			</form>
			<script>
	        $('#logoutButton').click(function(){
	        	console.log("로그아웃 버튼 눌렀땅");
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
	                 // 폼을 제출합니다.
	                 $('#logoutFormPage').submit();
	              }
	           });
	        });
	  
			</script>	
		</div>
		</div>
		<!--프로필 -->
		<!--주차 가능 -->
		<div class="card" style="height: 300px; font-size: 16px;">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs nav-justified " role="tablist">
				<li class="nav-item waves-effect waves-light" role="presentation">
					<a class="nav-link active" data-bs-toggle="tab" href="#parkinglot" role="tab" aria-selected="false" tabindex="-1"> 주차장 현황 </a>
				</li>
				<li class="nav-item waves-effect waves-light" role="presentation">
					<a class="nav-link" data-bs-toggle="tab" href="#carLists" role="tab" aria-selected="true"> 보유 차량 현황 </a>
				</li>
				<li class="nav-item waves-effect waves-light" role="presentation">
					<a class="nav-link" data-bs-toggle="tab" href="#carInsert" role="tab" aria-selected="true"> 보유 차량 등록 </a>
				</li>
			</ul>
			<div class="card-body">
				<!-- Tab panes -->
				<div class="tab-content text-muted">
					<!-- 진행중 탭 -->
					<div class="tab-pane active show" id="parkinglot" role="tabpanel" style="margin-top: 19px">
						<canvas id="pieChart1" class="chartjs-chart" data-colors="[&quot;--vz-success&quot;, &quot;--vz-light&quot;]" style="display: block; box-sizing: border-box; height: 200px; width: 200px;"></canvas>
					</div>
					
					<div class="tab-pane" id="carLists" role="tabpanel" style="height: 230px; overflow-y: auto;">
						<table id="carTbl" class="display table table-bordered dt-responsive" style="width: 100%; font-size: 14px;">
				        	<thead>
				            <tr>
				                <th style="text-align: center;">차량번호</th>
				                <th style="text-align: center;">차량 종류</th>
				                <th style="text-align: center;">등록일</th>
				                <th style="text-align: center;">상태</th>
				                <th style="text-align: center;">삭제</th>
				            </tr>
				       		</thead>
				       		<tbody id="carList">
				       		
				        	</tbody>
				    	</table>
					</div>
					
					<div class="tab-pane" id="carInsert" role="tabpanel">
						<div class="card-body" style="font-size: 15px;">
							<div class="live-preview">
								<form id="frm" name="frm" action="" method="post" style="font-size: 15px;">
									<div class="mb-3">
										<label for="carNo" class="form-label">차량 번호</label> 
										<input type="button" class="btn btn-secondary waves-effect waves-light end" id="btnSubmit" value="신청" style="float: right; margin-bottom:10px;">
										<input type="text" class="form-control" id="carNo" name="carNo" value="" pattern="\d{3}[가-힣]\d{4}" title="형식: 숫자 4자리 + 한글 1자리 + 숫자 4자리" required>
			
									</div>
									<div class="mb-3">
										<label for="carModel" class="form-label">차량 종류</label> 
										<input type="text" class="form-control" id="carModel" value="" required="required">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<!--  -->
			</div>
		</div>
		<!--주차 가능 -->
		
		<!-- 달력 -->
		<div class="card" style="height: 502px;font-size: 16px;">
			<div class="card-body p-4" id='calendar' style="margin-left: -12px; margin-right: -12px;">
			</div>
		</div>
		<!-- 달력 -->
	</div>

	


</div>


<div class="row" style="margin-left: -7px;">




</div>



<script>

let status = [];
let total = [];
let able;

// 주차 통계
$.ajax({
    url: "/car/admin/statistics",
    type: 'post',
    dataType: "json",
    beforeSend: function(xhr) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    },
    success: function(result) {
//         console.log("통계1 : ", result[0].status);
//         console.log("통계1 : ", result[0].total);
        
//         console.log("통계2 : ", result[1].status);
//         console.log("통계2 : ", result[1].total);

        for (let i = 0; i < result.length; i++) {
            status.push(result[i].status);
            total.push(result[i].total);
        }
//         console.log("통계 상태: ", status);
//         console.log("통계 상태: ", total);
        
        able = total[1] - total[0];
//         console.log("통계 상태: ", able);

        updateChart([total[0], able]);
    }
});

function updateChart( dataValues) {
    const pieExample1 = document.querySelector('#pieChart1').getContext('2d');

    // Create gradient for the chart
    const gradient1 = pieExample1.createLinearGradient(0, 0, 0, 400);
    // Start color gray, end color lightgray
    gradient1.addColorStop(0, '#c471f5');
    gradient1.addColorStop(1, '#ebedee');

    const gradient2 = pieExample1.createLinearGradient(0, 0, 0, 400);
    // Start color #2af598, end color #009efd
    gradient2.addColorStop(0, '#2af598');
    gradient2.addColorStop(1, '#009efd');

    const pieExampleChart1 = new Chart(pieExample1, {
        type: 'pie',
        data: {
            labels: ['승인완료', '잔여석'],
            datasets: [{
                data: dataValues,
                backgroundColor: [gradient2, gradient1],
                borderColor: [gradient2, gradient1],
                borderWidth: 1,
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true,
                    position: 'right'
                },
                datalabels: {
                    color: 'white',
                    font: {
                        size: 20,
                        weight: 'bold'
                    },
                    formatter: (value) => {
                        return value;
                    }
                }
            }
        },
        plugins: [ChartDataLabels]
    });
}


</script>

<!-- 달력 -->	
<script>
$(document).ready(function() {
    // FullCalendar 초기화 옵션
    const calendarEl = document.querySelector('#calendar');
    const calendar = new FullCalendar.Calendar(calendarEl, {
        // 캘린더 옵션 설정
        headerToolbar: {
            left: 'prev today',
            center: 'title',
            right: 'next'
        },
        initialView: 'dayGridMonth',
        locale: 'ko',
        editable: true,
        height: '100%', // 전체 높이를 부모 요소에 맞춤
        contentHeight: 'auto', // 높이를 자동으로 조정
        aspectRatio: 1, // 캘린더의 가로 세로 비율 조정
        dayMaxEventRows: 1, // 날짜 셀 내 최대 이벤트 행 수
        eventLimit: false, // "더보기" 링크 비활성화
        eventSources: [
            {
                // adminCalendarList.jsp에서 데이터를 가져와서 캘린더에 표시
                events: function(info, successCallback, failureCallback) {
                    $.ajax({
                        url: "/calendar/calendarList5",
                        dataType: "json",
                        type: "get",
                        success: function(data) {
                            // 데이터 처리 후 successCallback 호출
                            let events = data.map(function(event) {
                                return {
                                    id: event.calSeq,
                                    title: event.calTitle,
                                    start: event.calStart,
                                    end: event.calEnd,
                                    allDay: event.isAllDay,
                                    extendedProps: {
                                        calSort: event.calSort
                                    }
                                };
                            });
                            successCallback(events);
                        },
                        error: function() {
                            failureCallback();
                        }
                    });
                }
            }
        ],
        eventDidMount: function(info) {
               if (info.event.extendedProps.calSort == 2) {// 개인일정 색상
                   	info.el.style.backgroundColor = '#cdecff';// 일정 바
                   	info.el.style.color = '#107db8'; // 글씨 
                   	$(info.el).find(".fc-event-title-container").css("color","#107db8");
               } else if (info.event.extendedProps.calSort == 0) { // 아파트 일정 색상
                   	info.el.style.backgroundColor = '#cff8c7'; // 일정 바
                   	info.el.style.color = '#1e8c27'; // 글씨 
                   	$(info.el).find(".fc-event-title-container").css('color','#1e8c27');
               } else if (info.event.extendedProps.calSort == 1) {// 예약 및 신청 일정 색상
            	    	info.el.style.backgroundColor = '#ffdcdc'; // 일정 바
                    	info.el.style.color = '#ee5231'; // 글씨 
                    	$(info.el).find(".fc-event-title-container").css("color","#ee5231");
               }
           }
    });

    // FullCalendar 렌더링
    calendar.render();
    
 // 5주까지만 표시하고 나머지 주는 숨기기
    const hideExtraWeeks = () => {
        const weeks = document.querySelectorAll('.fc-daygrid-week');
        weeks.forEach((week, index) => {
            if (index >= 6) {
                week.style.display = 'none';
            }
        });
    };

    calendar.on('datesSet', hideExtraWeeks);
    hideExtraWeeks(); // 초기 렌더링 시 호출

    // 달력 영역 클릭 시 URL로 이동
    $('.fc-scrollgrid ').on('click', function() {
        location.href = '/calendar/calendarPage';
    });
});
</script>
<!-- 달력 -->	

<!--------------------------------------------------------------------------------------------------------------------------------------------------------------->

<!-- 관리비 도넛차트용 스크립트 -->
<script>

const doughnut = document.querySelector('#chargeDoughnut');

new Chart(doughnut, {
	type: 'doughnut',
	data: {

		labels: getDoughnutLabel(),
		datasets:[{
			backgroundColor: getDoughnutColor(), 
			data: getDoughnutData()
		}]
	},

	options: {
		responsive: false,
		plugins:{
			legend: {
				display: false,
			},
			tooltip:{
				enabled: false
			}
		},
		rotation: -90,
		circumference: 180,
		borderWidth: 0,
	}
});

function getDoughnutLabel(){
	let data = [];
	for(let i=0; i<200; i++){
		data.push(i);
	}
	return data;
}
   
function getDoughnutData(){
	let data = [];
	for(let i=0; i<200; i++){
		data.push(1);
	}
	return data;
}

function getDoughnutColor(){
	let percent = Math.round($("#percent").text() / 2);
// 	console.log(percent);
	let backgroundColors = [];

	for(let i=0; i<30; i++){
		let red = i*7;
		let green = 150+i*3;
		let blue = i;
		
		percent--;
		if(percent == 0){
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+0+', '+0+', '+0+', 1)');
		}else{
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
		}
	}
	for(let i=0; i<20; i++){
		let red = 210+i*2;
		let green = 240+i*2;
		let blue = 30+i;
		
		percent--;
		if(percent == 0){
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+0+', '+0+', '+0+', 1)');
		}else{
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
		}
	}
	for(let i=0; i<20; i++){
		let red = 240;
		let green = 280-i*2;
		let blue = 50-i;
		
		percent--;
		if(percent == 0){
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+0+', '+0+', '+0+', 1)');
		}else{
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
		}
	}
	for(let i=0; i<30; i++){
		let red = 240;
		let green = 240-i*7;
		let blue = 20-i;
		
		percent--;
		if(percent == 0){
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+0+', '+0+', '+0+', 1)');
		}else{
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
		}
	}

	return backgroundColors;
}

function percentDisp(){
	let percent = $('#percent').text();
	let str1 = '평균 대비 ';
	let str2 = '';
	if(percent > 100){
		str1 += (Number(percent)-100) + '%';
		str2 += '<span style="color: red;">많이 </span> 사용했습니다.';
	}else{
		str1 += (100 - Number(percent)) + '%';
		str2 += '<span style="color: blue;">적게 </span> 사용했습니다.';
	}
	
	$('#percentDisp1').html(str1);
	$('#percentDisp2').html(str2);
}
percentDisp();
</script>


<script>
let interval;
let alarmDiv = $('#page-header-notifications-dropdown');
let alarmIcon = $('#page-header-notifications-dropdown').children().eq(0);
function move(){
	if(count / 7 < 10){
		alarmDiv.css('color', 'red');
// 		alarmDiv.css('background-color', 'black');
		alarmIcon.removeClass('fs-20');
		alarmIcon.addClass('fs-22');
	}else if(count / 7 < 20){
		alarmDiv.css('color', 'green');
// 		alarmDiv.css('background-color', 'white');
		alarmIcon.removeClass('fs-22');
		alarmIcon.addClass('fs-24');
	}else if(count / 7 < 30){
		alarmDiv.css('color', 'gold');
// 		alarmDiv.css('background-color', 'black');
		alarmIcon.removeClass('fs-24');
		alarmIcon.addClass('fs-22');
	}else{
		alarmDiv.css('color', 'skyblue');
// 		alarmDiv.css('background-color', 'white');
		alarmIcon.removeClass('fs-22');
		alarmIcon.addClass('fs-20');
	}
		
	if(count < 70){
		deg++;
	}else if(count < 210){
		deg--;
	}else if(count < 280){
		deg++;
	}else{
		deg = 0;
		alarmDiv.css('color', 'gray');
		clearInterval(interval);
		count = 0;
	}
	alarmDiv.css('transform', 'rotate('+deg+'deg)');
	
	count++;
}

let deg = 0;
let count = 0;
$('#alarmSpan').on('click', function(){
	clearInterval(interval);
	interval = setInterval(move, 1);
})
</script>

<script>
$(function(){
	$('.swiper-slide').css('width', '373px');
	$('.swiper-slide').css('margin-right', '25px');
})
</script>

<script type="text/javascript">
	
$(function(){
	
	getCarList();
	
	$('#btnSubmit').on("click",function(){
		var carNo = $("#carNo").val();
		var memId = $("#memId").val();
		var carModel = $("#carModel").val();
		
		// 정규 표현식 패턴
        var carNoPattern = /^\d{3}[가-힣]\d{4}$/;
        
        // 차량 번호 입력 여부 확인
        if (carNo.trim() === "") {
            Swal.fire({
                icon: 'error',
                title: '입력 오류',
                text: '차량 번호를 입력해주세요.',
            });
            return false;
        }

        // 차량 번호 형식 확인
        if (!carNoPattern.test(carNo)) {
            Swal.fire({
                icon: 'error',
                title: '유효성 검사 실패',
                text: '차량 번호는 숫자 3자리 + 한글 1자리 + 숫자 4자리 형식이어야 합니다.',
            });
            return false;
        }

        // 차량 모델 입력 여부 확인
        if (carModel.trim() === "") {
            Swal.fire({
                icon: 'error',
                title: '입력 오류',
                text: '차량 모델을 입력해주세요.',
            });
            return false;
        }
        
// 		console.log(carNo, memId, carModel);
		
		let data = {
				'carNo':carNo,
				'memId':memId,
				'carModel':carModel
		};
		
		$.ajax({
			url	:"/car/create",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
            success: function(result) {
//                 console.log("result : ", result);
                getCarList();
                Swal.fire({
                    icon: 'success',
                    title: '성공',
                    text: '차량이 성공적으로 등록되었습니다.',
                });
            },
            error: function(error) {
                Swal.fire({
                    icon: 'error',
                    title: '등록 실패',
                    text: '차량 등록에 실패했습니다. 다시 시도해주세요.',
                });
            }
		});
	});
	
	$(document).on('click', ".delete",  function(){
		let carNo = $(this).parent().parent().children().eq(0).text();
		
		if (confirm("차량을 삭제하시겠습니까?")) {
// 			let carNo = $("input[name='carNo']").val();

			let data = {
				"carNo" : carNo
			};
// 			console.log("data : " + data);

			$.ajax({
				url : "/car/deleteAjax",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(data),
				type : "post",
				dataType : "text",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(result) {
// 					console.log("result : ", result);

					if (result != null) {
						
						getCarList();
						
						Swal.fire({
								position: "center",
								icon: "success",
								title: "삭제가 완료 되었습니다.",
								timer: 1000,
								showConfirmButton: false // 확인 버튼을 숨깁니다.
							}).then(() => {
								// Swal.fire의 타이머가 끝난 후 호출됩니다.
// 								console.log("result>>>", result);
								
								
						});
					}
				}
			});
		}
	});
	
	
	
	
	
	
	
});

function getCarList(){
	let data = {
			'memId':$("#memId").val()
	};
	
	$.ajax({
		url: "/car/list",
		contentType: "application/json;charset=utf-8",
		data:JSON.stringify(data),
		type: "post",
		dataType: "json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success: function(result) {
// 			console.log("result : ", result);
			
			let str = "";
			for(let i=0; i<result.length; i++){

				str += "<tr>";
				str += "<td>"+result[i].carNo+"</td>";
				str += "<td>"+result[i].carModel+"</td>";
				str += "<td>"+result[i].regDt.substring(0, 10)+"</td>";
				str += "<td style='text-align: center;'>";
			    switch (result[i].status) {
			        case '승인대기':
			            str += "<span class='badge bg-warning'>" + result[i].status + "</span>";
			            break;
			        case '승인완료':
			            str += "<span class='badge bg-success'>" + result[i].status + "</span>";
			            break;
			        case '승인거절':
			            str += "<span class='badge bg-danger'>" + result[i].status + "</span>";
			            break;
			        default:
			            str += "<span class='badge bg-danger'>" + result[i].status + "</span>";
			    }
				str += "<td><input type='button' style='margin-left: 5px;' class='btn btn-danger btn-sm delete' value='삭제'></input></td>";
				str += "</tr>";
			}
// 			console.log("str : ", str);
			
// 			$(".clsPagingArea").html(result.pagingArea);
			$("#carList").html(str);
			
			$("#carNo").val("");
			$("#carModel").val("");
			
		}
	});
}



</script>