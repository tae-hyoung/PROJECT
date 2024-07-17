<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>  

<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
   src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
   
<link rel="stylesheet"
   href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
<!--datatable responsive css-->
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">
<!-- datatable js -->
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

table th{
	text-align: center;
	background-color: #e9ebec;
}

table th, td{
	height: 50px;
}

tbody tr:hover{
	background-color: lightgrey;
}

#mvoTbl {
    width: 100% !important;
}

#mvoTbl th, #mvoTbl td {
    white-space: nowrap; 
    font-size: 16px;
}
#mvoTbl th:nth-child(3), #mvoTbl td:nth-child(3) {
    width: 5%; 
}
#mvoTbl th:nth-child(4), #mvoTbl td:nth-child(4) {
    width: 5%; 
}
#mvoTbl th:nth-child(5), #mvoTbl td:nth-child(5) {
    width: 5%; 
}
#mvoTbl th:nth-child(6), #mvoTbl td:nth-child(6) {
    width: 15%; 
}
#mvoTbl th:nth-child(7), #mvoTbl td:nth-child(7) {
    width: 15%; 
}
#mvoTbl th:nth-child(8), #mvoTbl td:nth-child(8) {
    width: 15%; 
}
#mvoTbl th:nth-child(9), #mvoTbl td:nth-child(9) {
    width: 15%; 
}
#mvoTbl th:nth-child(10), #mvoTbl td:nth-child(10) {
    width: 10%; 
}
#mvoTbl th:nth-child(11), #mvoTbl td:nth-child(11) {
    width: 5%; 
}
#mvoTbl th:nth-child(12), #mvoTbl td:nth-child(12) {
    width: 10%; 
}
.minHeight{
	min-height: 600px;
}

.center{
	text-align: center;
}

.right{
	text-align: right;
}

.hidden{
	display: none;
}

.myBg{
	font-size: 16px;
	text-align: center;
	width: 100px;
}

#mvoTbl_wrapper .pagination{
	justify-content: flex-start;
}
</style>

<div class="container-fluid">
<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="ri-file-edit-line"></i><strong> 퇴거 신청 현황  </strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">입주민 관리</a></li>
						<li class="breadcrumb-item active">퇴거 신청 현황</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="col-12">
	<div class="card">
		<div class="card-title"></div>
		<!-- 정산금 입력 모달 시작 -->
		<div id="chargeModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		    <div class="modal-dialog modal-lg">
		        <div class="modal-content">
		        	<div class="modal-header">
		        		<h1>
			        		<span id="dongModal"></span>&nbsp;
			        		<span id="roomModal"></span>&nbsp;&nbsp;퇴거&nbsp;정산
		        		</h1>
		        	</div>
		        	<div class="modal-body">
						<input type="hidden" id="mvoSeqInModal" value="">
						<input type="hidden" id="roomCodeInModal" value="">
						<span style="color: red;">※ 개별 사용량에 따른 정산된 금액을 입력해주세요.</span>
						<br><br>
						<div>
							<label for="charge">정산 요금</label>
							<input type="number" class="form-control" id="charge" /><br>
						</div>
						
						<div style="display: flex; justify-content: flex-end;">
							<span class="btn btn-outline-warning" data-bs-toggle="modal" data-bs-target="#chargeModal">취소</span>
							<span class="btn btn-outline-info" id="chargeInput">저장</span>
						</div>
		        	</div>
				</div>
			</div>
		</div>
		<!-- 정산금 입력 모달 끝 -->
		<div class="card-body">
			<div>
				<table id="mvoTbl">
					<thead>
						<tr>
							<th class="hidden"></th>
							<th class="hidden"></th>
							<th>번호</th>
							<th>동</th>
							<th>호</th>
							<th>신청인</th>
							<th>연락처</th>
							<th>신청일</th>
							<th>퇴거예정일</th>
							<th>퇴거방식</th>
							<th>상태</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="moveoutVO" items="${moveoutVOList}" varStatus="stat">
							<tr>
								<td class="hidden">${moveoutVO.mvoSeq}</td>
								<td class="hidden">${moveoutVO.roomCode}</td>
								<td class="right"><fmt:formatNumber value="${fn:substring(moveoutVO.mvoSeq, 3, 6)}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td class="center">${fn:substring(moveoutVO.roomCode, 5, 8)}동&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td class="center">${fn:substring(moveoutVO.roomCode, 9, 12)}호&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>${moveoutVO.applicant}</td>
								<td>${moveoutVO.applicantTelno}</td>
								<td class="center">${moveoutVO.regDt}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td class="center">${moveoutVO.estDt}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								<td>${moveoutVO.method}</td>
								<c:if test="${moveoutVO.status eq '신청'}">
									<td class="center"><span class="badge myBg bg-secondary"">${moveoutVO.status}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</c:if>
								<c:if test="${moveoutVO.status eq '정산금 미납'}">
									<td class="center"><span class="badge myBg bg-warning">${moveoutVO.status}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</c:if>
								<c:if test="${moveoutVO.status eq '정산 완료'}">
									<td class="center"><span class="badge myBg bg-success">${moveoutVO.status}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</c:if>
								<c:if test="${moveoutVO.status eq '신청 취소'}">
									<td class="center"><span class="badge myBg" style="background-color: lightgray; color: black;">${moveoutVO.status}</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
								</c:if>
								<td class="center">
									<c:if test="${moveoutVO.status eq '신청'}">
										<button class="btn btn-outline-info chargeModal" data-bs-toggle="modal" data-bs-target="#chargeModal">정산금 부과</button>
									</c:if>
									<c:if test="${moveoutVO.status eq '정산금 미납'}">
										<button class="btn btn-outline-info" disabled>부과 완료</button>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script>

$('#mvoTbl').DataTable({
    "autoWidth": false,
    "searching": true,
    "paging": true,
    "ordering": true,
    "info": true,
    "lengthChange": false,
    "pageLength": 10,
    "order": [], 
    "language": {
        "zeroRecords": "퇴거를 신청한 입주민이 없습니다.",
        "search": "",
        "paginate": {
            "next": "다음",
            "previous": "이전"
        },
        "info": "TOTAL :  _TOTAL_ 건<br>PAGE : _PAGE_ 페이지/ _PAGES_ 페이지 "
    },
	"initComplete": function(settings, json) {
	    $('#mvoTbl_wrapper .row:eq(1)').addClass('minHeight'); // 원하는 클래스 추가
	    $('#mvoTbl_wrapper .pagination').css('justify-content', 'flex-start'); // 원하는 클래스 추가
	    
	}
});

$('.chargeModal').on('click', function(){
	let mvoSeq = $(this).parent().parent().children().eq(0).text();
	let roomCode = $(this).parent().parent().children().eq(1).text();
	
	$('#dongModal').text($(this).parent().parent().children().eq(3).text().trim());
	$('#roomModal').text($(this).parent().parent().children().eq(4).text().trim());
	$('#mvoSeqInModal').val(mvoSeq);
	$('#roomCodeInModal').val(roomCode);
	
})

$("#chargeInput").on('click', function(){
	

	  Swal.fire({
	        title: "신청을 승인하고 관리비를 부과하시겠습니까?",
  	        icon: "warning",
	        showCancelButton: true,
	        confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
	        cancelButtonClass: 'btn btn-danger w-xs mt-2',
	        confirmButtonText: "예",
	        cancelButtonText: "아니오",
	        buttonsStyling: false,
	        showCloseButton: true
	    }).then(function (result) {
	        if (result.value) {
	    		
	    		let data = {
	    				mvoSeq: $('#mvoSeqInModal').val(),
	    				roomCode: $('#roomCodeInModal').val(),
	    				charge: Number($('#charge').val())
	    		};
	    		
	    		$.ajax({
	    			url : "/moveout/OK",
	    			contentType : "application/json;charset=utf-8",
	    			data : JSON.stringify(data),
	    			type : "post",
	    			dataType : "json",
	    			beforeSend : function(xhr) {
	    				xhr.setRequestHeader("${_csrf.headerName}",
	    						"${_csrf.token}");
	    			},
	    			success : function(result) {
	    				console.log(result);
	    				location.reload();
	    			}
	    		})
	        } 
	    });
	
})

</script>