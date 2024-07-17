<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
<!--datatable responsive css-->
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- <script type="text/javascript" src="/resources/js/jquery.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script> -->
<!-- datatable js -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.0/js/bootstrap.bundle.min.js"></script>
<style>
ul.pagination {
	justify-content: flex-start;
}

div.dataTables_wrapper div.dataTables_paginate ul.pagination {
	margin: 2px 0;
	white-space: nowrap;
	justify-content: flex-start !important;
}

#tbody {
	border-color: #d3d3d3;
}

.card-header {
	border-color: white;
}

.label {
	margin-top: 10px;
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
.statusTbl tr {
	cursor: pointer;
}
.adMaintenanceList td {
	padding: 5px;
	text-align: center;
	vertical-align: middle;
}
.adMaintenanceList td {
	width: 11%;
}
.adMaintenanceList td:nth-child(1) {
	width: 5%;
}
#mtDetail, #statusContent{
	resize: none;
}
.card{
	min-height: 750px;
}
</style>
<script>

	//전역변수
	let csrfHeader = "${_csrf.headerName}";
	let csrfToken = "${_csrf.token}";
	let maintenanceVO;
	
	//이미지 경로
	let imgSrc = {
		"청년도배": { img1: "/resources/images/청년도배1.png", img2: "/resources/images/청년도배2.png" },
		"베스트마루": { img1: "/resources/images/베스트마루1.png", img2: "/resources/images/베스트마루2.png" },
		"드림타일": { img1: "/resources/images/드림타일1.png", img2: "/resources/images/드림타일2.png" },
		"한성창호": { img1: "/resources/images/한성창호1.png", img2: "/resources/images/한성창호2.png" },
		"더나은가구": { img1: "/resources/images/더나은가구1.png", img2: "/resources/images/더나은가구2.png" },
		"바르다탄성": { img1: "/resources/images/바르다탄성1.png", img2: "/resources/images/바르다탄성2.png" },
		"성원전기": { img1: "/resources/images/성원전기1.png", img2: "/resources/images/성원전기2.png" },
		"청년누수케어": { img1: "/resources/images/청년누수케어1.png", img2: "/resources/images/청년누수케어2.png" },
		"크린코킹": { img1: "/resources/images/크린코킹1.png", img2: "/resources/images/크린코킹2.png" },
		"현대엘리베이터": { img1: "/resources/images/현대엘리베이터1.png", img2: "/resources/images/현대엘리베이터2.png" },
		"정한조경": { img1: "/resources/images/정한조경1.png", img2: "/resources/images/정한조경2.png" },
		"하나바스디자인": { img1: "/resources/images/하나바스디자인1.png", img2: "/resources/images/하나바스디자인2.png" },
		"제이원홈네트워크": { img1: "/resources/images/제이원홈네트워크1.png", img2: "/resources/images/제이원홈네트워크2.png" },
		"구로배관설비": { img1: "/resources/images/구로배관설비1.png", img2: "/resources/images/구로배관설비2.png" },
	};

	$(document).ready(function() {
		$('.adMaintenanceList').DataTable({
			"paging": true,
			"order": [1, 'desc'],
			"info": false,
			"lengthChange": false, // 항목 수 변경 옵션을 숨김
			"pageLength": 10, // 기본 페이지 길이를 10으로 설정
			"ordering": false,
			"language": {
				"zeroRecords": "하자보수 접수 내역이 없습니다.",
				"search": "검색",
				"paginate": {
					"next": "다음",
					"previous": "이전"
				},
			}
		});
	});

	// 모달상세1
	$(document).on("click", ".editBtn1", function () {
		let mtSeq = $(this).closest("tr").data("mt-seq");
		let memId = $(this).closest("tr").data("mem-id");

		let data = {
			"mtSeq": mtSeq,
			"memId": memId
		}

		$.ajax({
			url: "/maintenance/admin/modalDetail",
			contentType: 'application/json;charset=utf-8',
			data: JSON.stringify(data),
			type: "post",
			dataType: "json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function (maintenanceData) {
				maintenanceVO = maintenanceData;
				$("#mtSeq").val(maintenanceVO.mtSeq);
				$("#memId2").val(maintenanceVO.memId);
				$("#memNm").val(maintenanceVO.memberVO.memNm);
				$("#dongCode").val(maintenanceVO.memberVO.dongCode);
				$("#roomCode").val(maintenanceVO.memberVO.roomCode);
				$("#memTelno").val(formatPhoneNumber(maintenanceVO.memberVO.memTelno));
				$("#mtConst").val(maintenanceVO.mtConst);
				$("#mtLocation").val(maintenanceVO.mtLocation);
				$("#mtDetail").val(maintenanceVO.mtDetail);
				$("#mtStatus").val(maintenanceVO.mtStatus);
				$("#statusContent").val(maintenanceVO.statusContent);

			//첨부파일 처리하기
			//maintenanceVO.attachList : List<AttachVO> attachList
			let str = "";

			if (maintenanceVO.attachList.length === 0) {
				str = "<p style='display: flex; align-items: center; margin:8px 8px 8px;'>등록된 첨부파일이 없습니다.</p>";
			} else {
				$.each(maintenanceVO.attachList, function (idx2, attachVO) {
				console.log("attachVO.fileName>>>", attachVO.fileName);
				str += "<img class='attach-img' name='attach' style='width: 100px; height: 100px; margin:10px 10px 10px; border-radius: 5px;' alt='첨부파일' src='/upload" + attachVO.fileName + "'>";
				});
			}
				$("#divAttaches").html(str);
			},
				error: function (error) {
				console.error("Error:", error);
			}
		});
	});

	// 모달상세2
	$(document).on("click", ".editBtn2", function () {
		//이미지 초기화
		$("#img1").attr("src", "");
		$("#img2").attr("src", "");
		
		let mtSeq = $(this).closest("tr").data("mt-seq");
		let data = {
			"mtSeq": mtSeq
		}

		$.ajax({
			url: "/maintenance/admin/modalDetail",
			contentType: 'application/json;charset=utf-8',
			data: JSON.stringify(data),
			type: "post",
			dataType: "json",
			beforeSend: function (xhr) {
			   xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function (maintenanceData) {
				maintenanceVO = maintenanceData;

//             alert(maintenanceVO.mtSeq);

			$("#mtConst2").val(maintenanceVO.mtConst);
			$("#mtSeq1").val(maintenanceVO.mtSeq);

			//협력업체 정보 넣기
			let matchedCcpy = null;
			for (let i = 0; i < maintenanceVO.ccpyList.length; i++) {
				if (maintenanceVO.ccpyList[i].ccpyCode === maintenanceVO.ccpyCode) {
					matchedCcpy = maintenanceVO.ccpyList[i];
					break;
				}
			}

			//모달2 셀렉트박스에 옵션추가
			$('#ccpyCode').empty();
			$('#ccpyCode').append($('<option>',
				{
					value: '',
					text: '업체를 선택하세요'
				}));

			console.log("maintenanceVO.ccpyList>>>>>>", maintenanceVO.ccpyList);
			$.each(maintenanceVO.ccpyList, function (index, item) {
				$('#ccpyCode').append($('<option>', {
					value: item.ccpyCode,
					text: item.ccpyName
				}));
			});

			if (matchedCcpy) {
				$('option[value="' + matchedCcpy.ccpyCode +'"]').eq(0).attr("selected", "selected");

//                alert(matchedCcpy.bizRegNo);

				$("#bizRegNo").val(matchedCcpy.bizRegNo);
				$("#ccpyTelno").val(matchedCcpy.ccpyTelno);
				$("#ccpyAddr").val(matchedCcpy.ccpyAddr);
				$("#ccpyAddrDetail").val(matchedCcpy.ccpyAddrDetail);

				if (matchedCcpy.ccpyName in imgSrc) {
					$("#img1").attr("src", imgSrc[matchedCcpy.ccpyName].img1).css("visibility", "visible");
					$("#img2").attr("src", imgSrc[matchedCcpy.ccpyName].img2).css("visibility", "visible");
				}
			}

				// 셀렉트 박스 선택 자동입력해주깅
				$(document).on("change", "#ccpyCode", function () {
					let selectedCcpyCode = $(this).val();
					
					let selectedCcpyVO = maintenanceVO.ccpyList.find(function (ccpyVO) {
					return ccpyVO.ccpyCode === selectedCcpyCode;
				});
//                console.log("selectedCcpyVO>>>>>>>", selectedCcpyVO);

				if (selectedCcpyVO) {
					$("#ccpyName").val(selectedCcpyVO.ccpyName);
					$("#bizRegNo").val(selectedCcpyVO.bizRegNo);
					$("#ccpyTelno").val(selectedCcpyVO.ccpyTelno);
					$("#ccpyAddr").val(selectedCcpyVO.ccpyAddr);
					$("#ccpyAddrDetail").val(selectedCcpyVO.ccpyAddrDetail);

//                   console.log("selectedCcpyVO.ccpyName>>>>", selectedCcpyVO.ccpyName);
				} else {
				   $("#bizRegNo, #ccpyTelno, #ccpyAddr, #ccpyAddrDetail").val("");
				   $("#img1, #img2").attr("src", "");
				}

				let selectdCcpyNm = selectedCcpyVO.ccpyName;

				if (selectedCcpyVO.ccpyName in imgSrc) {
					$("#img1").attr("src", imgSrc[selectedCcpyVO.ccpyName].img1).css("visibility", "visible");
					$("#img2").attr("src", imgSrc[selectedCcpyVO.ccpyName].img2).css("visibility", "visible");
				}else{
					$("#img1, #img2").attr("src", "");
				}
			});
		},
			error: function (error) {
				console.error("Error:", error);
			}
		});
	});

	function formatPhoneNumber(phoneNumber) {
		return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
	}

	//모달수정1
	$(document).on("click", "#changeBtn1", function () {
		console.log("changeBtn1이야");

		let mtSeq = $("#mtSeq").val();
		let mtStatus = $("#mtStatus").val();
		let statusContent = $("#statusContent").val();

		let data = {
			"mtSeq": mtSeq,
			"mtStatus": mtStatus,
			"statusContent": statusContent,
		}
// 		alert("왼쪽모달수정 data>>>>", data);
		
		$.ajax({
			url: "/maintenance/admin/modalUpdate",
			contentType: 'application/json; charset=utf-8',
			data: JSON.stringify(data),
			type: "POST",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function (result) {
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
					});
				} else {
					alert("상태 업데이트에 실패했습니다.");
				}
				},
				error: function (error) {
					console.error("Error:", error);
				}
			});
		});

	//모달수정2
	$(document).on("click", "#changeBtn2", function () {
//       console.log("changeBtn2이야");

		let mtSeq = $("#mtSeq1").val();
		let ccpyCode = $("#ccpyCode").val();

		let data = {
			"mtSeq": mtSeq,
			"ccpyCode": ccpyCode
		}

		$.ajax({
			url: "/maintenance/admin/modalUpdate2",
			contentType: 'application/json; charset=utf-8',
			data: JSON.stringify(data),
			type: "POST",
			beforeSend: function (xhr) {
			   xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function (result) {
			
				$.each(data, function (index, item) {
					$('#ccpyCode').append($('<option>', {
						value: item.ccpyCode,
						text: item.ccpyName
					}));
				});

				if (result === "success") {
					Swal.fire({
						position: "center",
						icon: "success",
						title: "협력업체 지정이 완료되었습니다.",
						timer: 1500,
						showConfirmButton: false 
					}).then(() => {
						location.replace(location.href);
					});
				} else {
					alert("협력업체 지정이 완료되지 않았습니다.");
				}
			},
			error: function (error) {
			console.error("Error:", error);
			}
		});
	});
	
	
	//처리상태 count
	$(document).ready(function() {
		
		$.ajax({
			url: '/maintenance/admin/statusCount', 
			type: 'GET',
			dataType: 'json', 
			success: function(data) {
				
				console.log('data:', data);
				var result = data; 
				var allCount = 0; 
				var notYetCount = 0; 
				var processingCount = 0; 
				var completedCount = 0;

				// 데이터를 처리상태에 따라 분류
					for (var i = 0; i < data.length; i++) {
						if (data[i].mtStatus == '접수완료') {
							notYetCount = data[i].cnt;
						} else if (data[i].mtStatus == '처리중') {
							processingCount = data[i].cnt;
						} else if (data[i].mtStatus == '처리완료') {
							completedCount = data[i].cnt;
						}
					}
					var allCount = notYetCount + processingCount + completedCount;
// 					alert("allCount>>>>" + allCount);
				
					var tbody = $('#statusTableBody');
					var row = "<tr align=\"center\">" +
							"<td onclick=\"fn_filterList('all'); \">" + allCount + "</td>" +
							"<td onclick=\"fn_filterList('not'); \">" + notYetCount + "</td></a>" +
							"<td onclick=\"fn_filterList('pro'); \">" + processingCount + "</td></a>" +
							"<td onclick=\"fn_filterList('com'); \">" + completedCount + "</td></a>" +
							"</tr>";
					tbody.append(row);
				},
				error: function(xhr, status, error) {
					console.error('Error:', error);
			}
		});
	});
	

	function fn_filterList(arg){
		if(arg == "not"){
			$("input[type=search]").val("처리대기");
		}else if(arg == "pro"){
			$("input[type=search]").val("처리중");
		}else if(arg == "com"){
			$("input[type=search]").val("처리완료");
		}else{
			$("input[type=search]").val("");
		}
		$("input[type=search]").focus();
	}
	
	

	//수정버튼클릭 시
	$(document).on("click", "#edit", function(){
		$("#changeBtn2").css("display", "block");
		$("#cancel").css("display", "block");
		$("#edit").css("display", "none");
		$("#ccpyCode").prop("disabled", false);
		$("#bizRegNo").prop("disabled", false);
		$("#ccpyTelno").prop("disabled", false);
		$("#ccpyAddr").prop("disabled", false);
		$("#ccpyAddrDetail").prop("disabled", false);
	});
   
	//취소버튼클릭 시
	$(document).on("click", "#cancel", function(){
		$("#changeBtn2").css("display", "none");
		$("#cancel").css("display", "none");
		$("#edit").css("display", "block");
		$("#ccpyCode").prop("disabled", true);
	});


	
</script>
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="las la-wrench"></i><strong> 입주자 하자보수 신청 내역</strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">서비스</a></li>
						<li class="breadcrumb-item active">입주민 하자보수 신청 내역</li>
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
					<img alt="하자보수" src="/resources/images/maintenance.png" style="width: 40px; margin-right: 10px;">입주민 하자보수 신청 내역
				</p>
			</div>
			<div class="col-3">
				<table class="table table-hover text-nowrap statusTbl" style="width:100%; font-size: 15px;">
					<thead>
						<tr class="tblRow" align="center" style="background-color: #e1ebfd">
							<th>전&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;체</th>
							<th>처리대기</th>
							<th>처&nbsp;&nbsp;리&nbsp;&nbsp;중</th>
							<th>처리완료</th>
						</tr>    
					</thead>
					<tbody id="statusTableBody">
					</tbody>
				</table>				
			</div>
		</div>
		<div class="card-body table-responsive p-0"
			style="font-size: 16px; margin-top: 10px;">
			<table class="table table-hover text-nowrap adMaintenanceList">
				<thead>
					<tr class="tblRow" align="center"
						data-waste-seq="${maintenanceVO.mtSeq}"
						data-mem-id="${maintenanceVO.memId}"
						style="background-color: #e1ebfd">
						<th>순번</th>
						<th>신청접수번호</th>
						<th>신청인ID</th>
						<th>공종</th>
						<th>신청위치</th>
						<th>접수일시</th>
						<th>처리일자</th>
						<th>처리상태</th>
						<th>업체지정 / 상태변경</th>
				</thead>
				<tbody id="tb">
					<c:forEach var="maintenanceVO" items="${adMtList}" varStatus="stat">
						<tr class="tblRow" align="center"
							data-mt-seq="${maintenanceVO.mtSeq}"
							data-mem-id="${maintenanceVO.memId}">
							<td>${maintenanceVO.rnum}</td>
							<td>${maintenanceVO.mtSeq}</td>
							<td>${maintenanceVO.memId}</td>
							<td>${maintenanceVO.mtConst}</td>
							<td>${maintenanceVO.mtLocation}</td>
							<td>${maintenanceVO.regDt}</td>
							<td>
								<c:choose>
									<c:when test="${maintenanceVO.prcsDt == null}">
										<p> - </p>
									</c:when>
									<c:when test="${maintenanceVO.prcsDt != null}">
										${maintenanceVO.prcsDt}
									</c:when>
								</c:choose>
							</td>
							<td><c:choose>
									<c:when test="${maintenanceVO.mtStatus == '처리중'}">
										<span class="badge bg-warning" style="width: 80px; font-size:15px;">${maintenanceVO.mtStatus}</span>
									</c:when>
									<c:when test="${maintenanceVO.mtStatus == '접수완료'}">
										<span class="badge bg-secondary" style="width: 80px; font-size:15px;">처리대기</span>
									</c:when>
									<c:when test="${maintenanceVO.mtStatus == '처리완료'}">
										<span class="badge bg-success" style="width: 80px; font-size:15px;">${maintenanceVO.mtStatus}</span>
									</c:when>
									<c:otherwise>
										<span class="badge border border-danger text-danger">${maintenanceVO.mtStatus}</span>
									</c:otherwise>
								</c:choose></td>
							<td>
								<button type="button"
									class="btn btn-outline-danger btn-icon waves-effect waves-light material-shadow-none editBtn2"
									data-bs-toggle="modal" data-bs-target="#showModal2" style="margin-right:5px;">
									<i class="ri-check-double-line"></i>
								</button>
								<button type="button"
									class="btn btn-outline-success btn-icon waves-effect waves-light material-shadow-none editBtn1"
									data-bs-toggle="modal" data-bs-target="#showModal"
									style="margin-right: 5px;">
									<i class="ri-brush-2-fill"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<!-- 모달모달 1-->
	<div class="modal fade modal-lg" id="showModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-light p-3">
					<h5 class="modal-title" id="exampleModalLabel">
						<i class="las la-wrench"></i> 하자보수 접수 상세
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close" id="close-modal"></button>
				</div>
				<form class="tablelist-form" autocomplete="off">
					<div class="modal-body" style="font-size: 16px;">
						<div style="margin-bottom: 15px;">
							<i class="ri-feedback-fill"></i> 처리상태 변경 시 <span
								style="color: red;">승인 답변</span>을 입력하시기 바랍니다.
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="mb-3">
									<label for="mtSeq" class="form-label">신청접수번호</label> <input
										type="text" id="mtSeq" class="form-control" disabled />
								</div>
<!-- 								<div> -->
<%-- 									<input type="text" id="memId2" class="form-control" value="${maintenanceVO.memId}" disabled /> --%>
<!-- 								</div> -->
								<div class="mb-3">
									<label for="memNm" class="form-label">성명</label> 
									<input type="text" id="memNm" class="form-control" disabled />
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
								<div class="mb-3">
									<label for="attach" class="file-label">첨부파일</label>
									<div id="divAttaches"
										style="border: 1px solid #ced4da; border-radius: 3px; margin-top: 5px;">
<!-- 										<img class="attach-img"> -->
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="row">
									<div class="col-md-5 mb-3">
										<label for="mtConst" class="form-label">하자보수공종</label> <input
											type="text" id="mtConst" class="form-control" disabled />
									</div>
									<div class="col-md-7 mb-3">
										<label for="mtLocation" class="form-label">상세위치</label> <input
											type="text" id="mtLocation" class="form-control" disabled />
									</div>
								</div>
								<div class="mb-3">
									<label for="mtDetail" class="form-label">상세내용</label> <textarea
										type="text" id="mtDetail" class="form-control" rows="2" disabled></textarea>
								</div>
								<div>
									<label for="mtStatus" class="form-label">처리상태변경</label> <select
										class="form-select mb-3" name="mtStatus" id="mtStatus">
<!-- 										<option value="접수완료">접수완료</option> -->
										<option value="처리중">처리중</option>
										<option value="처리완료">처리완료</option>
									</select>
								</div>
								<div class="mb-3" style="margin-top: 16px;">
									<label for="statusContent" class="form-label">승인답변</label> <textarea
										id="statusContent" class="form-control" rows="2"
										placeholder="답변을 입력해 주세요." ></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<div class="hstack gap-2 justify-content-end">
							<button type="button" class="btn btn-success" id="changeBtn1">변경</button>
							<button type="button" class="btn btn-light"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- 모달모달 2-->
	<div class="modal fade modal-lg" id="showModal2" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header bg-light p-3">
					<h5 class="modal-title" id="exampleModalLabel">
						<i class="las la-handshake"></i> 협력업체 지정
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close" id="close-modal"></button>
				</div>
				<form class="tablelist-form" autocomplete="off">
					<div class="modal-body" style="font-size: 15px;">
						<div class="row">
							<div class="col-md-6">
								<div class="mb-3">
									<label for="mtSeq" class="form-label">신청접수번호</label> <input
										type="text" id="mtSeq1" class="form-control" disabled />
								</div>
								<div class="mb-3">
									<label for="mtConst" class="form-label">하자보수공종</label> <input
										type="text" id="mtConst2" class="form-control" disabled />
								</div>
								<div class="row">
									<div class="mb-3">
										<img id="img1" src=""
											style="width: 366px; height: 230px; margin-bottom: 5px;" onError="this.style.visibility='hidden'">
									</div>
									<div class="mb-3">
										<img id="img2" src="" style="width: 366px; height: 230px;" onError="this.style.visibility='hidden'">
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<%-- <p>우아아${maintenanceVO.ccpyCode}</p> --%>
								<input type="hidden" value="${maintenanceVO.ccpyCode}" />
								<div class="form-group mb-3">
									<label for="ccpyCode">업체선택</label> <select id="ccpyCode"
										class="form-select mb-3" disabled>
										<c:forEach items="${maintenanceVO.ccpyList}" var="ccpyVO">
											<option value="${ccpyVO.ccpyCode}">${ccpyVO.ccpyName}</option>
										</c:forEach>
									</select>
								</div>
								<div class="mb-3">
									<label for="bizRegNo">사업자등록번호</label> <input type="text"
										id="bizRegNo" class="form-control" disabled />
								</div>
								<div class="mb-3">
									<label for="ccpyTelno">전화번호</label> <input type="text"
										id="ccpyTelno" class="form-control" disabled />
									<div class="mb-3">
										<label for="ccpyAddr" style="margin-top:10px;">사업장 주소</label> <input type="text"
											id="ccpyAddr" class="form-control" disabled />
									</div>
									<div class="mb-3">
										<label for="ccpyAddrDetail">상세주소</label> <input type="text"
											id="ccpyAddrDetail" class="form-control" disabled />
									</div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<div class="hstack gap-2 justify-content-end">
								<button type="button" class="btn btn-success" id="edit">수정</button>
								<button type="button" class="btn btn-success" id="changeBtn2"
									style="display: none;">확인</button>
								<button type="button" class="btn btn-light" id="cancel"
									style="display: none;">취소</button>
								<button type="button" class="btn btn-light"
									data-bs-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>	
				</form>
			</div>
		</div>
	</div>
</div>