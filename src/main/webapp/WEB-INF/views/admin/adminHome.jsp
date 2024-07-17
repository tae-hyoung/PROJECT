<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>

<style>
.custom-progress {
    height: 23px;
    padding: 4px;
    border-radius: 30px;
}
.custom-progress .progress-bar::before {
	width: 5px;
    height: 8px;
}
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
    overflow: hidden !important;
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
/*     max-height: 300px; /* 조정한 날짜 셀의 높이에 따라 전체 높이 설정 */ */
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

.ml7012em{
	margin-left: 70px;
	font-size: 1.2em;
}


.topTotal{
	 min-height: 50px;
	 display: flex;
	 justify-content: center;
	 font-size: 1.2em;
	 font-weight: bolder;
	 color: white;
}

</style>

<script type="/resources/js/jquery.min.js"></script>
<input type="hidden" id="memId" value="<sec:authentication property='principal.memberVO.memId'/>">
<script>
$(document).ready(function() {
	
  // 1:1 민원 카운트
  $.ajax({
        url: "/complain/admin/homeCnt",
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
   			let notYetList = [];
   			let endList = [];
   			
	   		 for (var i = 0; i < result.length; i++) {
	             if(result[i].reply === null) {
	                 notYetList.push(result[i]);
	             } else {
	                 endList.push(result[i]);
	             }
	         }
	   		 $("#comNotYetCnt").html(notYetList.length);
	   		 $("#comEndCnt").html(endList.length);
        }
   });
   
  // 택배 카운트
  $.ajax({
        url: "/delivery/admin/homeCnt",
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
   			let notYetList = [];
   			let endList = [];
   			
	   		 for (var i = 0; i < result.length; i++) {
	             if(result[i].pckStatus  == 'N') {
	                 notYetList.push(result[i]);
	             } else {
	                 endList.push(result[i]);
	             }
	         }
	   		 $("#deliNotYetCnt").html(notYetList.length);
       		 $("#deliEndCnt").html(endList.length);
        }
   });
   
  // 폐기물 카운트
  $.ajax({
        url: "/waste/admin/homeCnt",
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
   			let notYetList = [];
   			let endList = [];
   			
	   		 for (var i = 0; i < result.length; i++) {
	             if(result[i].wasteStatus  == '승인대기') {
	                 notYetList.push(result[i]);
	             } else {
	                 endList.push(result[i]);
	             }
	         }
	   		 $("#wastNotYetCnt").html(notYetList.length);
       		 $("#wastEndCnt").html(endList.length);
        }
   });
  
   
  // 투표 카운트
  $.ajax({
        url: "/vote/admin/homeCnt",
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
   			let notYetList = [];
   			let endList = [];
   			
	   		 for (var i = 0; i < result.length; i++) {
	   	     	 if(result[i].endYn  == 'N') {
	                 notYetList.push(result[i]);
	             } else {
	                 endList.push(result[i]);
	             }
	         }
//              console.log("notYetList : " , notYetList.length);
//              console.log("endList : " , endList.length);
             
	   		 $("#voteNotYetCnt").html(notYetList.length);
       		 $("#voteEndCnt").html(endList.length);
        }
   });
  
  // 설문조사 카운트
  $.ajax({
        url: "/survey/admin/homeCnt",
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
   			let notYetList = [];
   			let endList = [];
   			
	   		 for (var i = 0; i < result.length; i++) {
	   	     	 if(result[i].endYn  == 'N') {
	                 notYetList.push(result[i]);
	             } else {
	                 endList.push(result[i]);
	             }
	         }
//              console.log("notYetList : " , notYetList.length);
//              console.log("endList : " , endList.length);
             
	   		 $("#surNotYetCnt").html(notYetList.length);
       		 $("#surEndCnt").html(endList.length);
        }
   });
   
  // 하자보수 카운트
  $.ajax({
        url: "/maintenance/admin/homeCnt",
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
   			let notYetList = [];
   			let endList = [];
   			
	   		 for (var i = 0; i < result.length; i++) {
	   		   if(result[i].mtStatus  == '접수완료') {
	                 notYetList.push(result[i]);
	             } else {
	                 endList.push(result[i]);
	             }
	         }
//              console.log("notYetList : " , notYetList.length);
//              console.log("endList : " , endList.length);
             
	   		 $("#mainNotYetCnt").html(notYetList.length);
       		 $("#mainEndCnt").html(endList.length);
        }
   });
	
  // 차량 카운트
  $.ajax({
        url: "/car/admin/homeCnt",
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
   			let notYetList = [];
   			let endList = [];
   			
	   		 for (var i = 0; i < result.length; i++) {
	   		   if(result[i].status  == '승인완료' || result[i].status  == '반려') {
	   				endList.push(result[i]);
	             } else {
	            	 notYetList.push(result[i]);
	             }
	         }
//              console.log("notYetList : " , notYetList.length);
//              console.log("endList : " , endList.length);
             
	   		 $("#carNotYetCnt").html(notYetList.length);
       		 $("#carEndCnt").html(endList.length);
        }
   });
  
  
    /* 걍 추가해봄... 수정 하셔도 됨 (명진)*/
  	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	let keyword = ""; //이건 없으면 안됨.
 	
	$.ajax({
 		url: "/admin/count",
 		type: 'GET',
 		data: {
 			"keyword": keyword
 		},
 		dataType: "json",
 		contentType: "application/json;charset=utf-8",
 		beforeSend: function (xhr) {
 			xhr.setRequestHeader(csrfHeader, csrfToken);
 		},
 		success: function (data) {
 			$.each(data, function (index, cnt) {
 				totalItem = data.cnt;
 				$('#waitCnt').text(data.cnt);
 			});
 		}, error: function () {
//  			console.log("다시 짜라.")
 		}
 	});
	
	$.ajax({
 		url: "/admin/memberCount",
 		type: 'GET',
 		data: {
 			"keyword": keyword
 		},
 		dataType: "json",
 		contentType: "application/json;charset=utf-8",
 		beforeSend: function (xhr) {
 			xhr.setRequestHeader(csrfHeader, csrfToken);
 		},
 		success: function (data) {
 			$.each(data, function (index, cnt) {
 				totalItem = data.cnt;
 				$('#memberCnt').text(data.cnt);
 			});
 		}, error: function () {
//  			console.log("다시 짜라.")
 		}
 	});
	

	
  
});
</script>




<!-- 탭 시작 -->
<div class="card" style="height: 314px;font-size: 16px;margin-left: 27px;width: 1016px;">
	<div class="card-body">
		<!-- Nav tabs -->
		<ul class="nav nav-pills nav-justified mb-3" role="tablist"
			style="border: 1px solid #405189; border-radius: 6px;">
			<li class="nav-item waves-effect waves-light" role="presentation">
				<a class="nav-link active" data-bs-toggle="tab" href="#notYet"
				role="tab" aria-selected="false" tabindex="-1"> 미완료 </a>
			</li>
			<li class="nav-item waves-effect waves-light" role="presentation">
				<a class="nav-link" data-bs-toggle="tab" href="#endWork" role="tab"
				aria-selected="true"> 완료 </a>
			</li>
		</ul>
		<!-- Tab panes -->
		<div class="tab-content text-muted">
			<!-- 진행중 탭 -->
			<div class="tab-pane active show" id="notYet" role="tabpanel">
				<div class="row">
					<div class="col-md-6">
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/admin/waitMember"
								class="ms-3">회원 가입 신청 ( <span id="waitCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/car/admin/adCarList"
								class="ms-3">차량 등록 신청 ( <span id="carNotYetCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/vote/admin/list"
								class="ms-3">진행 중 투표 ( <span id="voteNotYetCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/survey/admin/list"
								class="ms-3">진행 중 설문 조사 ( <span id="surNotYetCnt"></span> )건</a>
						</div>
						<br>
					</div>
					<div class="col-md-6">
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/maintenance/admin/adList"
								class="ms-3">하자 보수 신청 ( <span id="mainNotYetCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/waste/admin/adWasteList"
								class="ms-3">폐기물 신청 ( <span id="wastNotYetCnt"></span> )건</a>
						</div>
						<br> 
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/complain/admin/list"
								class="ms-3">1:1 민원 신청 ( <span id="comNotYetCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href=/delivery/admin/delivery
								class="ms-3">택배 신청 ( <span id="deliNotYetCnt"></span> )건</a>
						</div>
						<br>
					</div>
				</div>
			</div>
			<!--  -->

			<!-- 완료 된 현황 -->
			<div class="tab-pane" id="endWork" role="tabpanel">
				<div class="row">
					<div class="col-md-6">
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/admin/memberList"
								class="ms-3">회원 가입 신청 ( <span id="memberCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/car/admin/adCarList"
								class="ms-3">차량 등록 신청 (<span id="carEndCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/vote/admin/list"
								class="ms-3">완료 된 투표 ( <span id="voteEndCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/survey/admin/list"
								class="ms-3">완료 된 설문 조사 ( <span id="surEndCnt"></span> )건</a>
						</div>
						<br>
					</div>
					<div class="col-md-6">
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/maintenance/admin/adList"
								class="ms-3">하자 보수 신청 (<span id="mainEndCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/waste/admin/adWasteList"
								class="ms-3">폐기물 신청 ( <span id="wastEndCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/complain/admin/list"
								class="ms-3">1:1 민원 신청 ( <span id="comEndCnt"></span> )건</a>
						</div>
						<br>
						<div class="d-flex  align-items-center mb-2 ml7012em">
							<i class="ri-checkbox-circle-fill text-success"></i> <a href="/delivery/admin/delivery"
								class="ms-3">택배 신청 (<span id="deliEndCnt"></span>)건</a>
						</div>
						<br>
					</div>
				</div>
			</div>
			<!--  -->
		</div>
	</div>
	<!-- end card-body -->
</div>
<!-- 탭 끝 -->


<!--프로필 -->
<div class="card col-4" style="height: 314px;font-size: 16px;margin-left: 17px;">
    <div class="card-body p-4">
        <div style="display: flex;">
            <div class="profile-user position-relative d-inline-block mx-auto mb-4 col-md-5">     
            	<c:if test="${mjSajin != null }">
                    <img src="/upload/profile/${mjSajin}" style="width: 180px; height: 180px; margin-top:5px;"
                     class="rounded-circle avatar-xl img-thumbnail user-profile-image material-shadow"
                     alt="user-profile-image">             	
               	</c:if>
             	<c:if test="${mjSajin == null }">
             		 <img src="/upload/profile/<sec:authentication property="principal.memberVO.profImg"/>" style="width: 180px; height: 180px; margin-top:5px;"
                     class="rounded-circle avatar-xl img-thumbnail user-profile-image material-shadow"
                     alt="user-profile-image">                  	
             	</c:if>	    
            </div>
            <div class="col-md-7" style="margin-top: 15px;">
                <p style="margin-bottom:15px; margin-top:12px; font-size:25px; text-align:center;"><span id="apt"></span></p>
                <p style="font-size:22px; text-align:center; margin-bottom:25px;"><b>관리자님</b> 환영합니다.</p>
                <p style="font-size:15px; text-align:center;"><i class="mdi mdi-login"></i>   로그인 유효 시간: <span id="loginTime" style="color: #2323d1;"></span></p>
<!--                 <p style="float: left; margin-right: 10px;">알림 __개</p> -->
<!--                 <p>쪽지 __개</p> -->
            </div>
        </div>
    </div>
    <div class="card-footer d-flex justify-content-center align-items-center" style="position: absolute; bottom: 0; width: 95%;">
        <button id = "profile" class="btn btn-primary waves-effect waves-light" style="width: 180px; margin-right:40px; font-size:15px;">마이페이지</button>
        <form action="/logout" method="post" id = "logoutForm">
           <button type ="button" id="logoutBtn" class="btn btn-primary waves-effect waves-light" style="width: 180px; font-size:15px;">로그아웃</button>
           <sec:csrfInput/>
        </form>
    </div>
</div>
<!--프로필 -->


<!--관리비 차트 -->
<div class="card" style="height: 510px; font-size: 16px;margin-left: 27px;width: 1016px;margin-top: -7px;">
	<div class="card-body row">
		<div style="font-size: 2em; display: flex; justify-content: center;">
			<button id="prev" style="border: none; background-color: inherit;"><i class="mdi mdi-chevron-double-left"></i></button>
			<span id="year">2024</span>년
			<button id="next" style="border: none; background-color: inherit;"><i class="mdi mdi-chevron-double-right"></i></button>
		</div>
		
		<div class="col-3">
			<div class="card topTotal" style="background-color: #1fab89;">
				<span style="display: flex; justify-content: center;">총액 &nbsp;&nbsp;<span id="total">0</span>원</span>
			</div>
		</div>
		<div class="col-3">
			<div class="card topTotal" style="background-color: #299cdb;">
				<span style="display: flex; justify-content: center;">납부액 <span id="payTotal">0</span>원</span>
			</div>
		</div>
		<div class="col-3">
			<div class="card topTotal" style="background-color: #f7b84b;">
				<span style="display: flex; justify-content: center;">미납료 &nbsp;&nbsp;<span id="nonPayTotal">0</span>원</span>
			</div>
		</div>
		<div class="col-3">
			<div class="card topTotal" style="background-color: #fe4880;">
				<span style="display: flex; justify-content: center;">연체료 &nbsp;&nbsp;<span id="lateTotal">0</span>원</span>
			</div>
		</div>
	</div>
	
	<div>
		<canvas id="yearChart" width="980px;" height="350px;"></canvas>
	</div>
</div>
<!--관리비? 차트 -->

<!-- 달력 -->
<div class="card col-4"
	style="height: 510px; font-size: 16px; margin-left: 17px; margin-top: -7px;">
	<div class="card-body p-4" id='calendar' style="margin-left: -12px; margin-right: -12px;"></div>
</div>
<!-- 달력 -->

<!-- 공지사항 -->
<div class="card" style="height: 314px; font-size: 15px; margin-left: 27px; width: 1016px; margin-top: -7px;">
    <div class="card-header" style="padding-bottom: 3px;">
        <div class="row">
            <div class="col-11">
                <h3>공지사항</h3>
            </div>
            <div class="col-1">
                <h3><a href="/board/admin/list" style="font: 2em; text-decoration-line: none;">+</a></h3>
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
                    <th style="text-align: center;">추천수</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="boardVO" items="${boardVOList}" varStatus="stat">
                    <tr class="tblRow boardRow">
                        <td style="display: none">${boardVO.brdSeq}</td>
                        <td style="text-align: left;">${boardVO.title}</td>
                        <td style="text-align: center;">${fn:substring(boardVO.content, 0, 20)}</td>
                        <td style="text-align: center;">${fn:substring(boardVO.regDt, 0, 10)}</td>
                        <td style="text-align: center;">${boardVO.viewCnt}</td>
                        <td style="text-align: center;">${boardVO.likeCnt}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<!-- 공지사항 -->


<!--주차 가능 -->
<div class="card col-4" style="height: 314px; font-size: 16px; margin-left: 17px; margin-top: -7px;">

		<div class="card-header">
			<h2 style="margin-bottom: -10px;">주차장 여유 자리 </h2>
		</div>
		<div class="card-body">
			<canvas id="pieChart1" class="chartjs-chart"
			    data-colors="[&quot;--vz-success&quot;, &quot;--vz-light&quot;]"
			    style="display: block; box-sizing: border-box; height: 200px; width: 200px;"></canvas>
		</div>
		
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
        console.log("통계1 : ", result[0].status);
        console.log("통계1 : ", result[0].total);
        
        console.log("통계2 : ", result[1].status);
        console.log("통계2 : ", result[1].total);

        for (let i = 0; i < result.length; i++) {
            status.push(result[i].status);
            total.push(result[i].total);
        }
        console.log("통계 상태: ", status);
        console.log("통계 상태: ", total);
        
        able = total[1] - total[0];
        console.log("통계 상태: ", able);

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
<!--주차 가능 -->



<script>

const yearChart = $('#yearChart');

$('#yearChart').on('click', function(){
	location.href="/charge/admin/insert";
});

$('#prev').on('click', function(){
	let year = Number($('#year').text());
	year--;
	$('#year').text(year);
	getYearAvg();
})

$('#next').on('click', function(){
	let year = Number($('#year').text());
	year++;
	$('#year').text(year);
	getYearAvg();
})

let totalCt = [];
let payCt = [];
let nonPayCt = [];
let lateCt = [];
function getYearAvg(){
	totalCt = [];
	payCt = [];
	nonPayCt = [];
	lateCt = [];
	
	let data = {
			year: $('#year').text(),
			danjiCode: 'D001'
	};

	$.ajax({
		url:"/charge/getYearAvg",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
// 			console.log(result);
			let total = 0;
			let payTotal = 0;
			let nonPayTotal = 0;
			let lateTotal = 0;
			for(let i=0; i<result.length; i++){
				total += result[i].payCt + result[i].nonPayCt + result[i].lateCt;
				payTotal += result[i].payCt;
				nonPayTotal += result[i].nonPayCt;
				lateTotal += result[i].lateCt;
				
				totalCt.push(result[i].payCt + result[i].nonPayCt + result[i].lateCt);
				payCt.push(result[i].payCt);
				nonPayCt.push(result[i].nonPayCt);
				lateCt.push(result[i].lateCt);
				
			}
			
			$('#total').text(total.toLocaleString('ko-KR'));
			$('#payTotal').text(payTotal.toLocaleString('ko-KR'));
			$('#nonPayTotal').text(nonPayTotal.toLocaleString('ko-KR'));
			$('#lateTotal').text(lateTotal.toLocaleString('ko-KR'));
			newYearChart(totalCt, payCt, nonPayCt, lateCt);
		}
	});
}

function newYearChart(totalCt, payCt, nonPayCt, lateCt){
	let chartStatus = Chart.getChart('yearChart');
	if (chartStatus === undefined) {
		new Chart(yearChart, {
		    type: 'bar',
		    data: {
		    	labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    	datasets: [{
		    		label: '월별 총액',
		    		backgroundColor: '#1fab89',
		    		data: totalCt,
		    	},{
		    		label: '월별 납부액',
		    		backgroundColor: '#299cdb',
		    		data: payCt,
		    	}, {
		    		label: '월별 미납액',
		    		backgroundColor: '#f7b84b',
		    		data: nonPayCt,
		    	}, {
		    		label: '월별 연체액',
		    		backgroundColor: '#fe4880',
		    		data: lateCt,
		    	}],
		    },
		    options: {
				responsive: false,

		    }
		});
	}else{
		chartStatus.data.labels = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
		chartStatus.data.datasets[0].data =  totalCt;
		chartStatus.data.datasets[1].data =  payCt;
		chartStatus.data.datasets[2].data =  nonPayCt;
		chartStatus.data.datasets[3].data =  lateCt;
		chartStatus.update();
	}
}
getYearAvg();
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
        aspectRatio: 1.35, // 캘린더의 가로 세로 비율 조정
        dayMaxEventRows: 1, // 날짜 셀 내 최대 이벤트 행 수
        eventLimit: false, // "더보기" 링크 비활성화
        eventSources: [
            {
                // adminCalendarList.jsp에서 데이터를 가져와서 캘린더에 표시
                events: function(info, successCallback, failureCallback) {
                    $.ajax({
                        url: "/calendar/admin/adminCalendarList",
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
            // 이벤트 스타일링
            info.el.style.backgroundColor = '#cff8c7';
            info.el.style.color = '#1e8c27';
            $(info.el).find(".fc-event-title-container").css('color','#1e8c27');
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
        location.href = '/calendar/admin/adminCalendarPage';
    });
});
</script>
<!-- 달력 -->



<script>
$('#logoutBtn').on("click", function(){
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
});

$('#profile').on("click", function(){
   location.href = "/admin/profile";
});


let memId = $('#memId').val();
$.ajax({
	url: "/admin/getProfile",
	type: "GET",
	data: {
		"memId": memId
	},
	dataType: "json",
	beforeSend : function(xhr) {
		xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	},
	success: function(data){
		$.each(data, function(index, memberVO) {
			$('#apt').text(memberVO.danjiName)
		});
	}
})
</script>

<script>
function chkLoginSession(){
	let endTime = new Date(${endTime});
	let now = new Date();
	let diff = endTime - now;
	let diffDay;
	let diffHour;
	let diffMin;
	let diffSec;
	
	if(diff <= 0){
		claerInterval(loginSession);
		$('#loginTime').html('<br>세션이 유요하지 않습니다. <br>다시 로그인해주세요.');
	}else{
		diffDay = Math.floor(diff / (1000*60*60*24));
		diff -= diffDay * (1000*60*60*24)
		
		diffHour = Math.floor(diff / (1000*60*60));
		diff -= diffHour * (1000*60*60)
		
		diffMin = Math.floor(diff / (1000*60));
		diff -= diffMin * (1000*60)
		
		diffSec = Math.floor(diff / (1000));
		
		let str = ''
		if(diffDay > 0){
			str += diffDay + '일';
		}
		if(diffHour > 0){
			str += diffHour + '시간';
		}
		if(diffMin > 0){
			str += diffMin + '분';
		}
		if(diffSec > 0){
			str += diffSec + '초';
		}
		
		console.log("loginSession: ", str);
		
		$('#loginTime').html(str);
	}
}

let loginSession = setInterval(chkLoginSession, 1000);
</script>