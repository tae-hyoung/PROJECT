<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<style>
ul.pagination {
	justify-content: flex-start;
}
div.dataTables_wrapper div.dataTables_paginate ul.pagination {
margin: 2px 0;
white-space: nowrap;
justify-content: flex-start !important; /* 중요도를 높여서 적용합니다 */
}
tbody{
border-color:#d3d3d3;
}
.card-header {
	border-color: white;
}
.card{
	min-height: 700px;
}
</style>
<script type="text/javascript">
$(function(){
	$('.maintenanceList').DataTable({
		"paging": true,
		"order": [1,'desc'],
		"info": false,
		"lengthChange": false, // 항목 수 변경 옵션을 숨김
		"pageLength": 10, // 기본 페이지 길이를 10으로 설정
		"ordering" : false,
		"language": {
			"zeroRecords": "하자보수 신청 내역이 없습니다.",
			"search": "검색",
			"paginate": {
				"next": "다음",
				"previous": "이전"
			},
		}
	});
	
	
	$("#regist").on("click",function(){
		console.log("등록등록");
		location.href="/maintenance/create";
	});
	
});	

</script>
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="las la-wrench"></i><strong>    하자보수 신청 내역</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">서비스</a></li>
						<li class="breadcrumb-item active">하자보수 신청 내역</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="col-12">
	<div class="card hadow p-3 rounded">
		<div class="card-header" style="display: flex;">
			<p class="card-title" style="font-size: 25px;">
				<img alt="하자보수" src="/resources/images/maintenance.png"
					style="width: 40px; margin-right: 10px;">하자보수 신청 내역
			</p>
		</div>
	<div>
		<img alt="하자보수 처리절차" src="/resources/images/mt04.png" style="width:1574px; height:165px; border-radius:5px; border:1px solid white;" >
	</div>
	<div class="card-body table-responsive p-0" style="font-size: 16px; margin-top:10px;">
		<p style="margin-bottom: 10px; margin-top: 10px; font-size: 16px;">
			<i class="ri-feedback-fill"> 하자보수 A/S 처리절차는 
				<span style="color: red;"> 접수완료 → 처리중(업체지정 → 방문일정예약 → 보수공사시작) → 처리완료(보수공사완료) </span> 순으로 진행됩니다.
			</i>
		</p>
		<table class="table table-hover text-nowrap maintenanceList">
			<thead>
				<tr class="tblRow" align="center" data-waste-seq="${maintenanceVO.mtSeq}" style="background-color:#e1ebfd">
					<th width="5%">순번</th>
					<th width="10%">신청접수번호</th>
					<th width="15%">신청인ID</th>
					<th width="15%">공종</th>
					<th width="15%">상세위치</th>
					<th width="15%">접수일시</th>
					<th width="15%">처리상태</th>
<!-- 					<th>처리일자</th> -->
					<th width="10%">비고</th>
			</thead>
			<tbody>
				<c:forEach var="maintenanceVO" items="${mtList}" varStatus="stat">
					<tr class="tblRow" align="center" data-mt-seq="${maintenanceVO.mtSeq}">
						<td>${maintenanceVO.rnum}</td>
						<td>${maintenanceVO.mtSeq}</td>
						<td>${maintenanceVO.memId}</td>
						<td>${maintenanceVO.mtConst}</td>
						<td>${maintenanceVO.mtLocation}</td>
						<td>${maintenanceVO.regDt}</td>
						<td>
							<c:choose>
								<c:when test="${maintenanceVO.mtStatus == '처리중'}">
									<span class="badge bg-warning" style="width: 80px; font-size:15px;">${maintenanceVO.mtStatus}</span>
								</c:when>
								<c:when test="${maintenanceVO.mtStatus == '접수완료'}">
									<span class="badge bg-secondary" style="width: 80px; font-size:15px;">${maintenanceVO.mtStatus}</span>
								</c:when>
								<c:when test="${maintenanceVO.mtStatus == '처리완료'}">
									<span class="badge bg-success" style="width: 80px; font-size:15px;">${maintenanceVO.mtStatus}</span>
								</c:when>
							</c:choose>
						</td>
						<td>${maintenanceVO.mtNote}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
		<div class="text-end">
			<button type="button" id="regist" class="btn btn-primary waves-effect waves-light" style="width:80px; ">신청</button>
		</div>
		</div>
</div>
<script>
	$(".tblRow").on('click', function(){
		var mtSeq = $(this).data('mt-seq');
		location.href = "/maintenance/detail?mtSeq=" + mtSeq;
	})
</script>
