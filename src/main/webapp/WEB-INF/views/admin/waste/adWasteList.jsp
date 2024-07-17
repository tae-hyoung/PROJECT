<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
<!--datatable responsive css-->
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
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
.card-header{
border-color:white;
}
.statusTbl {
	border-radius: 10px;
	border: 0px solid #d3d3d3;
	border-collapse: separate;
	border-spacing: 0;
	overflow: hidden;
}

.statusTbl th,
.statusTbl td {
	border: 0px solid #d3d3d3;
}

.statusTbl thead th {
	background-color: #e1ebfd;
}
.statusTbl tbody td {
	background-color: #f8f8f8;
}
.adWasteList td {
	padding: 8px;
}
</style>
<script type="text/javascript">

	function formatPhoneNumber(phoneNumber) {
		return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
	}

$(function() {
	let csrfHeader = "${_csrf.headerName}";
	let csrfToken = "${_csrf.token}";

	$('.adWasteList').DataTable({
		"paging": true,
		"order": [1,'desc'],
		"info": false,
		"lengthChange": false, // 항목 수 변경 옵션을 숨김
		"pageLength": 10, // 기본 페이지 길이를 10으로 설정
		"ordering" : false,
		"language": {
			"zeroRecords": "폐기물 접수내역이 없습니다.",
			"search": "검색",
			"paginate": {
				"next": "다음",
				"previous": "이전"
			},
		}
	});

	$(document).on("click", ".editBtn", function() {
		let wasteSeq = $(this).closest("tr").data("waste-seq");

		let data = {
			"wasteSeq": wasteSeq
		}
		
		console.log(">>>>>>>>>>", data);
		$.ajax({
			url : "/waste/admin/modalDetail",
			method : "Post",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify(data),
			dataType: "json",
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeader,csrfToken);
			},
			success : function(wasteVO) {
// 				console.log(">>>>>>>>>>22", wasteVO);
				clearModalFields();

				$("#wasteSeq").val(wasteVO.wasteSeq);
				$("#memNm").val(wasteVO.memberVO.memNm);
				$("#dongCode").val(wasteVO.memberVO.dongCode);
				$("#roomCode").val(wasteVO.memberVO.roomCode);
				$("#memTelno").val(formatPhoneNumber(wasteVO.memberVO.memTelno));
				$("#commDetCodeNm").val(wasteVO.commDetailVO.commDetCodeNm);
				$("#qty").val(wasteVO.qty);
				$("#estDt").val(wasteVO.estDt);
				$("#statusComment").val(wasteVO.statusComment);
				$("#wasteStatus").val(wasteVO.wasteStatus);
				
				console.log("wasteVO.attachList : ", wasteVO.attachList);
				
				if (wasteVO.wasteStatus === "승인대기") {
					$("#wasteStatus").val("상태변경");
				} else {
					$("#wasteStatus").val(wasteVO.wasteStatus);
				}
				
				let str = "";
				
				if (wasteVO.attachList.length === 0) {
					str = "<p style='display: flex; align-items: center; margin:8px 8px 8px;'>등록된 첨부파일이 없습니다.</p>";
				} else {
					$.each(wasteVO.attachList, function(idx2, attachVO) {
						str += "<img class='attach-img' name='attach' style='width: 100px; height: 100px; margin:10px 10px 10px; border-radius: 5px;' alt='첨부파일' src='/upload" + attachVO.fileName + "'>";
					});
				}
				$("#divAttaches").html(str);
				
			},
			error : function( error) {
				console.error("Error:", error);
			} 
		});
		
		function clearModalFields() {
			$("#wasteSeq").val("");
			$("#memNm").val("");
			$("#dongCode").val("");
			$("#roomCode").val("");
			$("#memTelno").val("");
			$("#commDetCodeNm").val("");
			$("#qty").val("");
			$("#estDt").val("");
			$("#statusComment").val("");
			$("#wasteStatus").val("");
		}
	});

	$("#changeBtn").on("click", function() {
		let wasteSeq = $("#wasteSeq").val();
		let wasteStatus = $("#wasteStatus").val();
		let statusComment = $("#statusComment").val();

		if (wasteStatus=='상태변경') {
			alert("상태를 선택해주세요.");
			return;
		}
		
		

		let data = {
			wasteSeq : wasteSeq,
			wasteStatus : wasteStatus,
			statusComment : statusComment
		};

		$.ajax({
			url : "/waste/admin/modalUpdate",
			method : "POST",
			data : JSON.stringify(data),
			contentType : 'application/json; charset=utf-8',
			beforeSend : function(xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success : function(result) {
				if (result === "success") {
					 Swal.fire({
						position: "center",
						icon: "success",
						title: "처리상태가 업데이트되었습니다.",
						timer: 1500,
						showConfirmButton: false // 확인 버튼을 숨깁니다.
					}).then(() => {
						// Swal.fire의 타이머가 끝난 후 호출됩니다.
						location.replace(location.href);
// 					location.reload();
					});
					
				} else {
					alert("상태 업데이트에 실패했습니다.");
				}
			},
			error : function(error) {
				console.error("Error:", error);
			}
		});
	});
});
/*
//처리상태 count
$(document).ready(function() {
	
	$.ajax({
		url: '/waste/admin/statusCount', 
		type: 'GET',
		dataType: 'json', 
		success: function(data) {
			
			console.log('data:', data);
// 			var notYetCount = 0; 
// 			var REFUSECOUNT = 0; 
// 			var COMPLETEDCOUnt = 0;

			console.log("data.wasteStatus", data.wasteStatus);
			// 데이터를 처리상태에 따라 분류
				for (var i = 0; i < data.length; i++) {
					if (data[i].wasteStatus == '승인대기') {
						notYetCount = data[i].cnt;
					} else if (data[i].wasteStatus == '승인거절') {
						refuseCount = data[i].cnt;
					} else if (data[i].wasteStatus == '승인완료') {
						completedCount = data[i].cnt;
					}
				}
				var tableBody = $('#statusTableBody');
				var row = "<tr align=\"center\">" +
						"<td onclick=\"fn_filterList('all');\">" + (notYetCount + refuseCount + completedCount) + "</td>" +
						"<td onclick=\"fn_filterList('not');\">" + notYetCount + "</td>" +
						"<td onclick=\"fn_filterList('ref');\">" + refuseCount + "</td>" +
						"<td onclick=\"fn_filterList('com');\">" + completedCount + "</td>" +
						"</tr>";
				tableBody.append(row);
			},
			error: function(xhr, status, error) {
				console.error('Error:', error);
		}
	});
});


function fn_filterList(arg){
	if(arg == "not"){
		$("input[type=search]").val("승인대기");
	}else if(arg == "ref"){
		$("input[type=search]").val("승인거절");
	}else if(arg == "com"){
		$("input[type=search]").val("승인완료");
	}else{
		$("input[type=search]").val("");
	}
	$("input[type=search]").focus();
}
*/
</script>
<div class="container-fluid">
<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="las la-recycle"></i>    입주민 폐기물 접수 내역</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">서비스</a></li>
						<li class="breadcrumb-item active">입주민 폐기물 접수 내역</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="col-12">
	<div class="card hadow p-3 rounded">
		<div class="row"> 
			<div class="card-header col-9" style="display: flex;">
				<p class="card-title" style="font-size: 25px;">
					<img alt="하자보수" src="/resources/images/waste3.png" style="width: 50px; border: 1px solid lightgray; border-radius: 50%; margin-right: 10px;">입주민 폐기물 접수 내역
				</p>
			</div>
			<div>
				<img alt="배출신고 처리절차" src="/resources/images/waste2.png" style="width:1573px; height:200px; border-radius:5px; border:1px solid white; margin-bottom: 15px;" >
			</div>
<!-- 			<div class="col-3"> -->
<!-- 				<table class="table table-hover text-nowrap statusTbl" style="width:100%;"> -->
<!-- 					<thead> -->
<!-- 						<tr class="tblRow" align="center" style="background-color: #e1ebfd"> -->
<!-- 							<th>전&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;체</th> -->
<!-- 							<th>승인대기</th> -->
<!-- 							<th>승인거절</th> -->
<!-- 							<th>승인완료</th> -->
<!-- 						</tr>     -->
<!-- 					</thead> -->
<!-- 					<tbody id="statusTableBody"> -->
<!-- 					</tbody> -->
<!-- 				</table>				 -->
<!-- 			</div> -->
		</div>
		<div class="card-body table-responsive p-0" style="font-size: 15px;">
			<table
				class="table table-hover align-middle table-nowrap mb-0 adWasteList">
				<thead>
					<tr align="center" style="background-color:#e1ebfd">
						<th scope="col">순번</th>
						<th scope="col">신청접수번호</th>
						<th scope="col">신청인ID</th>
						<th scope="col">폐기물품목</th>
						<th scope="col">수량</th>
						<th scope="col">배출예정일</th>
						<th scope="col">접수일시</th>
						<th scope="col">처리상태</th>
						<th scope="col">상태변경</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="wasteVO" items="${adWasteVOList}" varStatus="stat">
						<tr class="tblRow" align="center" 
							data-waste-seq="${wasteVO.wasteSeq}"
							data-mem-id="${wasteVO.memId}"
							data-mem-nm="${wasteVO.memberVO.memNm}"
							data-dong-code="${wasteVO.memberVO.dongCode}"
							data-room-code="${wasteVO.memberVO.roomCode}"
							data-mem-telno="${wasteVO.memberVO.memTelno}"
							data-est-dt="${wasteVO.estDt}"
							data-comm-det-code-nm="${wasteVO.commDetailVO.commDetCodeNm}"
							data-qty="${wasteVO.qty}"
							data-status-comment="${wasteVO.statusComment}">
							<td>${wasteVO.rnum}</td>
							<td>${wasteVO.wasteSeq}</td>
							<td>${wasteVO.memId}</td>
							<td>${wasteVO.commDetailVO.commDetCodeNm}</td>
							<td>${wasteVO.qty}</td>
							<td>${wasteVO.estDt}</td>
							<td>${wasteVO.regDt}</td>
							<td><c:choose>
									<c:when test="${wasteVO.wasteStatus == '승인대기'}">
										<span class="badge bg-warning" style="width: 80px; font-size:15px;">${wasteVO.wasteStatus}</span>
									</c:when>
									<c:when test="${wasteVO.wasteStatus == '승인완료'}">
										<span class="badge bg-success" style="width: 80px; font-size:15px;">${wasteVO.wasteStatus}</span>
									</c:when>
									<c:when test="${wasteVO.wasteStatus == '승인거절'}">
										<span class="badge bg-danger" style="width: 80px; font-size:15px;">${wasteVO.wasteStatus}</span>
									</c:when>
								</c:choose></td>
							<td>
								<button type="button" class="btn btn-outline-success btn-icon waves-effect waves-light material-shadow-none editBtn"
										data-bs-toggle="modal" data-bs-target="#showModal" style="margin-left: 5px;" >
								<i class="ri-brush-2-fill"></i></button>
							</td>
						</tr>

					</c:forEach>

				</tbody>
			</table>
		</div>
	</div>
	<!-- 모달모달 -->
	<div class="modal fade modal-lg" id="showModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-light p-3">
					<h5 class="modal-title" id="exampleModalLabel"><i class="las la-recycle"></i>   폐기물 접수 상세</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" id="close-modal"></button>
				</div>
				<form class="tablelist-form" autocomplete="off">
					<div class="modal-body" style="font-size: 15px;">
						<div class="row">
							<div class="col-md-6">
								<div class="mb-3">
									<label for="wasteSeq" class="form-label">신청접수번호</label> <input
										type="text" id="wasteSeq" class="form-control" disabled />
								</div>
								<div class="mb-3">
									<label for="memNm" class="form-label">성명</label> <input
										type="text" id="memNm" class="form-control" disabled />
								</div>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="dongCode" class="form-label">동</label> <input
											type="text" id="dongCode" class="form-control" disabled />
									</div>
									<div class="col-md-6 mb-3">
										<label for="roomCode" class="form-label">호</label> <input
											type="text" id="roomCode" class="form-control" disabled />
									</div>
								</div>
								<div class="mb-3">
									<label for="memTelno" class="form-label">전화번호</label> <input
										type="text" id="memTelno" class="form-control" disabled />
								</div>
							</div>
							<div class="col-md-6">
								<div class="mb-3">
									<label for="commDetCodeNm" class="form-label">폐기물품목</label> <input
										type="text" id="commDetCodeNm" class="form-control" disabled />
								</div>
								<div class="mb-3">
									<label for="qty" class="form-label">수량</label> <input
										type="text" id="qty" class="form-control" disabled />
								</div>
								<div class="mb-3">
									<label for="estDt" class="form-label">배출예정일</label> <input
										type="text" id="estDt" class="form-control" disabled />
								</div>
								<div>
									<label for="wasteStatus" class="form-label">처리상태변경</label> 
									<select class="form-select mb-3" name="wasteStatus" id="wasteStatus" >
										<option selected="selected">상태변경</option>
										<option value="승인완료">승인완료</option>
										<option value="승인거절">승인거절</option>
									</select>
								</div>
							</div>
							<div class="col-md-12">
								<div class="mb-3">
									<label for="statusComment" class="form-label">승인답변</label> 
									<input type="text" id="statusComment" class="form-control"
										style="width: 100%;" />
								</div>
								<label for="divAttaches" class="form-label">첨부파일</label> 
								<div id="divAttaches" style="border: 1px solid #ced4da; border-radius: 3px; margin-top: 5px;">
									<img class="attach-img">
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="hstack gap-2 justify-content-end">
							<button type="button" class="btn btn-success" id="changeBtn">변경</button>
							<button type="button" class="btn btn-light"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>