<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<!--datatable css-->
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
<!--datatable responsive css-->
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<!--datatable js-->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	
	$('.wasteList').DataTable({
		"paging": true,
		"order": [1,'desc'],
		"info": false,
		"lengthChange": false, // 항목 수 변경 옵션을 숨김
		"pageLength": 10, // 기본 페이지 길이를 10으로 설정
		"ordering" : false,
		"language": {
			"zeroRecords": "폐기물 신청내역이 없습니다.",
			"search": "검색",
			"paginate": {
				"next": "다음",
				"previous": "이전"
			},
		}
	});
		
	$("#regist").on("click",function(){
		console.log("등록등록");
		location.href="/waste/create";
	});
});	
</script>
<style>
ul.pagination {
	justify-content: flex-start;
}
div.dataTables_wrapper div.dataTables_paginate ul.pagination {
margin: 2px 0;
white-space: nowrap;
justify-content: flex-start !important;
}
tbody{
border-color:#d3d3d3;
}
.card-header{
border-color:white;
}
.card{
	min-height: 700px;
}
#printBtn{
	width: 70px;
	height:25px;
	background-color: #a2a4a5;
	color:white;
	border: 1px solid #a2a4a5;
	border-radius:5px;
	cursor: pointer;
	
}
</style>
<div class="container-fluid">
<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="las la-recycle"></i><strong>    폐기물 신청 내역</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">서비스</a></li>
						<li class="breadcrumb-item active">폐기물 신청 내역</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="col-12">
	<div class="card shadow p-3 rounded">
		<div class="card-header" style="display: flex;">
			<p class="card-title" style="font-size: 25px;">
				<img alt="폐기물" src="/resources/images/waste3.png"
					style="width: 45px; border: 1px solid lightgray; border-radius: 50%; margin-right: 10px;">폐기물 신청 내역
			</p>
		</div>
		<div>
			<img alt="배출신고 처리절차" src="/resources/images/waste2.png" style="width:1573px; height:200px; border-radius:5px; border:1px solid white;" >
		</div>
		<div class="card-body table-responsive p-0" style="font-size: 16px; margin-top:10px;">
			<p style="margin-bottom: 10px; margin-top: 10px; font-size: 16px;">
				<i class="ri-feedback-fill"> 승인완료 후
					<span style="color: red;"> 폐기물 스티커</span>를 부착하여 신청하신 장소에 배출부탁드립니다.
				</i>
			</p>
			<table class="table table-hover text-nowrap wasteList" >
				<thead>
					<tr align="center" style="background-color:#e1ebfd">
						<th>순번</th>
						<th>신청접수번호</th>
						<th>신청인ID</th>
						<th>폐기물품목</th>
						<th>수량</th>
						<th>수수료</th>
						<th>배출예정일</th>
						<th>접수일시</th>
						<th>처리상태</th>
						<th>스티커발급</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="wasteVO" items="${wasteVOList}" varStatus="stat">
						
						<tr class="tblRow" align="center" data-waste-seq="${wasteVO.wasteSeq}"
							data-fee="${wasteVO.fee}">
							<td>${wasteVO.rnum}</td>
							<td>${wasteVO.wasteSeq}</td>
							<td>${wasteVO.memId}</td>
							<td>${wasteVO.commDetailVO.commDetCodeNm}</td>
							<td>${wasteVO.qty}</td>
							<td><fmt:formatNumber value="${wasteVO.fee}" groupingUsed="true" /></td>
							<td>${wasteVO.estDt}</td>
							<td>${wasteVO.regDt}</td>
							<td>
								<c:choose>
									<c:when test="${wasteVO.wasteStatus == '승인대기'}">
										<span class="badge bg-warning" style="width: 80px; font-size:15px;">${wasteVO.wasteStatus}</span>
									</c:when>
									<c:when test="${wasteVO.wasteStatus == '승인완료'}">
										<span class="badge bg-success" style="width: 80px; font-size:15px;">${wasteVO.wasteStatus}</span>
									</c:when>
									<c:when test="${wasteVO.wasteStatus == '승인거절'}">
										<span class="badge bg-danger" style="width: 80px; font-size:15px;">${wasteVO.wasteStatus}</span>
									</c:when>
<%-- 									<c:otherwise> --%>
<%-- 										<span class="badge bg-danger">${wasteVO.wasteStatus}</span> --%>
<%-- 									</c:otherwise> --%>
								</c:choose>
							</td>
							<td>
								<c:choose>
									<c:when test="${wasteVO.wasteStatus == '승인완료'}">
<!-- 										<button type="button" id="print" class="btn btn-outline-success btn-icon waves-effect waves-light sticker-btn"  -->
<!-- 											data-bs-toggle="modal" data-bs-target="#showModal"><i class="ri-check-double-line"></i></button> -->
										<button class="btn btn-info btn-icon waves-effect waves-light sticker-btn" id="printBtn" 
											onclick="wSticker()">Print</button>
									</c:when>
									<c:otherwise>
										
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="text-end">
			<button type="button" id="regist" class="btn btn-primary waves-effect waves-light" style="width:80px;">신청</button>
			</div>
		</div>
	</div>
</div>
<script>
$(".tblRow").on('click', function(){
	var wasteSeq = $(this).data('waste-seq');
	location.href = "/waste/detail?wasteSeq=" + wasteSeq;
})

function wSticker() {
	event.stopPropagation();  // 이벤트 전파 막기
	
	let tr = $(event.target).closest("tr");
	let wasteSeq = tr.data("waste-seq");
	let fee = tr.data("fee");

// 	console.log("wasteSeq: " + wasteSeq);
// 	console.log("fee: " + fee);

	// URL 생성
	let url = '/waste/sticker?wasteSeq=' + wasteSeq + '&fee=' + fee;

	// 팝업 창 열기
	let popupWindow = window.open(url, 'window_name', 'width=580, height=700, location=no, status=no, scrollbars=yes');
	if (popupWindow) {
		popupWindow.moveTo(660, 150); // 팝업 창 위치 조정
	}
}


</script>