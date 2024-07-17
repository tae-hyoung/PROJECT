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
.card{
	min-height: 770px;
}
/* .card-header { */
/* 	border-color: white; */
/* } */
</style>
<script type="text/javascript">
$(function(){
	$('.ccpyList').DataTable({
		"paging": true,
		"order": [1,'desc'],
		"info": false,
		"lengthChange": false, // 항목 수 변경 옵션을 숨김
		"pageLength": 10, // 기본 페이지 길이를 10으로 설정
		"ordering" : false,
		"language": {
			"zeroRecords": "등록된 협력업체 내역이 없습니다.",
			"search": "검색",
			"paginate": {
				"next": "다음",
				"previous": "이전"
			},
		}
	});
});	
	
// 	//필터 변경 시 
// 	$('#filter').on('change', function () {
// 		var category = $(this).val();
// 		table.column(2).search(category).draw(); 
// 	});
	
</script>
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="las la-handshake"></i><strong>    협력업체 등록 내역</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item active">협력업체 목록</li>
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
				<img alt="협력업체" src="/resources/images/ccpy2.png"
					style="width: 40px; margin-right: 10px;"> 협력업체 목록
			</p>
		</div>
		<div class="card-body table-responsive p-0" style="font-size: 15px; margin-top:20px;">
			<table class="table table-hover text-nowrap ccpyList">
				<thead>
					<tr class="tblRow" align="center" data-waste-seq="${ccpyVO.ccpyCode}" style="background-color:#e1ebfd">
						<th width="5%">순번</th>
						<th width="10%">업체코드</th>
						<th width="10%">분류코드</th>
						<th width="15%">사업자등록번호</th>
						<th width="15%">업체명</th>
						<th width="15%">주소</th>
						<th width="15%">연락처</th>
						<th width="15%">계약기간</th>
				</thead>
				<tbody>
					<c:forEach var="ccpyVO" items="${ccpyList}" varStatus="stat">
						<tr class="tblRow" align="center" data-mt-seq="${ccpyVO.ccpyCode}">
							<td>${ccpyVO.rnum}</td>
							<td>${ccpyVO.ccpyCode}</td>
							<td>${ccpyVO.ccpyCat}</td>
							<td>${ccpyVO.bizRegNo}</td>
							<td>${ccpyVO.ccpyName}</td>
							<td>${ccpyVO.ccpyAddr}</td>
							<td>${ccpyVO.ccpyTelno}</td>
							<td style="text-align:left;">${ccpyVO.cntrDt} ~ ${ccpyVO.expDt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>