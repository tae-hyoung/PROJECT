<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>하자보수 신청 상세페이지</title>
<style>
.file-label {
	display: block;
	margin-top: 4px;
}
#steparrow-gen-info-tab.active, #steparrow-gen-info-tab:focus, #steparrow-gen-info-tab:hover {
	background-color: #405189; 
	color: #fff;
}

#steparrow-description-info-tab.active, #steparrow-description-info-tab:focus, #steparrow-description-info-tab:hover {
	background-color: #405189; 
	color: #fff;
}
textarea{
	resize: none;
}
.card{
	min-height: 950px;
}
h4 {
	margin-top:20px;
}
label, input.value{
	font-size: 16px;
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
let backupAttaches;
function formatPhoneNumber(phoneNumber) {
	return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
}

$(document).ready(function() {
	
	var mtConst = $("input[name='mtConst']").val();
	var mtLocation = $("input[name='mtLocation']").val();
	var mtDetail = $("input[name='mtDetail']").val();
	var mtSeq = "${maintenanceVO.mtSeq}";
	
	$("#memTelno").val(formatPhoneNumber($("#memTelno").val()));	


	$("#list").on("click", function() {
		location.href = "/maintenance/list";
	});
	
// 	$("#memTelno").val(formatPhoneNumber(maintenanceVO.memberVO.memTelno));
	
	//수정버튼
	$("#edit").on("click", function(){
		console.log("수정수정");
		
		$("#p1").css("display", "none");
		$("#p2").css("display", "block");
		$("#pp1").css("display", "none");
		$("#pp2").css("display", "block");
		$("#mtConst").prop("disabled", false);
		$("#mtDetail").prop("disabled", false);
		$("#mtLocation").prop("disabled", false);
		$("#attach").prop("disabled", false);
		$("#frm2").attr("action", "/maintenance/updatePost")
		
		$("#mtSeq").val(mtSeq);
		
	});
	
	//취소버튼
	$("#cancel").on("click", function() {
		$("#p1").css("display", "block");
		$("#p2").css("display", "none");
		$("#pp1").css("display", "block");
		$("#pp2").css("display", "none");
		$("#mtConst").prop("disabled", true);
		$("#mtDetail").prop("disabled", true);
		$("#mtLocation").prop("disabled", true);
		$("#attach").prop("disabled", true);
		
		//입력란 초기화
		$("input[name='mtConst']").val(mtConst);
		$("textarea[name='mtDetail']").val(mtConst);
		$("input[name='mtLocation']").val(mtConst);
		
		//백업된 이미지들 되돌리기
		$("#divAttaches").html(backupAttaches);
	});
	
	//이미지 미리보기
	$(".attach").on("change",handleImg);
	
	function handleImg(e) {
		let files = e.target.files;
		let fileArr = Array.prototype.slice.call(files);

		fileArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("이미지 확장자만 가능합니다.");
				return;
			}
			let reader = new FileReader();
			$("#divAttaches").html("");
			
			reader.onload = function(e) {
				let str = "<img class='attach-img' name='attach' style='width: 150px; height: 150px; margin:10px 10px 10px; border-radius: 5px;' alt='첨부파일' src='"+e.target.result+"'>"; 
				$("#divAttaches").append(str);
			}
			reader.readAsDataURL(f);
		});
	}

	//확인버튼 클릭 시
	$("#confirm").on("click", function(){
		Swal.fire({
			title: "수정 하시겠습니까?",
			icon: "question",
			showCancelButton: true,
			confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
			cancelButtonClass: 'btn btn-danger w-xs mt-2',
			confirmButtonText: "예",
			cancelButtonText: "아니오",
			buttonsStyling: false,
			showCloseButton: true
		}).then(function (result) {
			if (result.value) {
				let formData = new FormData();
			
				let mtConst = $("#mtConst").val();
				formData.append("mtConst",mtConst);
				
				let mtLocation = $("#mtLocation").val();
				formData.append("mtLocation",mtLocation);
				
				let mtDetail = $("#mtDetail").val();
				formData.append("mtDetail",mtDetail);
			
				//기본키 데이터*******
				formData.append("mtSeq",mtSeq);
				
				//첨부파일 처리
				let uploadFiles = $('input[name="uploadFiles"]')[0];
				let files = uploadFiles.files;
				let fileArr = Array.prototype.slice.call(files);
				fileArr.forEach(function(f) {
					if (!f.type.match("image.*")) {
						alert("이미지 확장자만 가능합니다.");
						return;
					}
					
					formData.append("uploadFiles",f);
				});
			
				$.ajax({
					url:"/maintenance/updateAjax",
					processData: false,
					contentType : false,
					data : formData,
					type : "post",
					dataType : "json",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success : function(result) {
						console.log("result : ",result);
	
						if (result != null) {
							Swal.fire({
								position: "center",
								icon: "success",
								title: "수정이 완료 되었습니다.",
								timer: 1500,
								showConfirmButton: false // 확인 버튼을 숨깁니다.
							}).then(() => {
								// Swal.fire의 타이머가 끝난 후 호출됩니다.
								console.log("result>>>", result);
								location.href = "/maintenance/detail?mtSeq="+ result.mtSeq;
							});
						}
						$("#p1").css("display","block");
						$("#p2").css("display","none");
						$(".formdata").attr("readonly", true);
					}
				});
			} else {
				Swal.fire({
					title: '수정이 취소되었습니다.',
					icon: 'error',
					showConfirmButton: false,
					timer: 1500,
					showCloseButton: false
				});
			}
		});
	});
	
	
	//삭제버튼 클릭 시 
	$("#delete").on("click", function(){
		Swal.fire({
			title: "삭제 하시겠습니까?\n삭제 시 복구가 불가합니다.",
			icon: "question",
			showCancelButton: true,
			confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
			cancelButtonClass: 'btn btn-danger w-xs mt-2',
			confirmButtonText: "예",
			cancelButtonText: "아니오",
			buttonsStyling: false,
			showCloseButton: true
		}).then(function (result) {
			if (result.value) {
				let mtSeq = $("input[name='mtSeq']").val();
				
				let data = {
					"mtSeq" : mtSeq
				};
				console.log("data : ", data);

				$.ajax({
					url: "/maintenance/deleteAjax",
					contentType: "application/json;charset=utf-8",
					data: JSON.stringify(data),
					type: "post",
					dataType: "text",
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					success: function(result) {
						console.log("result: ", result);
						
						if (result != null) {
							Swal.fire({
								position: "center",
								icon: "success",
								title: "삭제가 완료 되었습니다.",
								timer: 1500,
								showConfirmButton: false
							}).then(() => {
								location.href = "/maintenance/list";
							});
						} else {
							 Swal.fire({
								title: '삭제가 취소되었습니다.',
								icon: 'error',
								showConfirmButton: false,
								timer: 1500,
								showCloseButton: false
							});
						}
					}
				});
			} else {
				Swal.fire({
					title: '삭제가 취소되었습니다.',
					icon: 'error',
					showConfirmButton: false,
					timer: 1500,
					showCloseButton: false
				});
			}
		});
	});
});
</script>
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="las la-wrench"></i><strong> 하자보수 신청 상세</strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">하자보수
								신청</a></li>
						<li class="breadcrumb-item active">하자보수 신청 상세</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-6">
	 <!-- style="height: 785px;" -->
		<div class="card shadow p-3 rounded">
			<div class="card-header align-items-center d-flex">
				<p class="card-title mb-0 flex-grow-1" id="pp1" style="display: block; font-size: 25px;">
					<img alt="하자보수" src="/resources/images/maintenance.png"
						style="width: 35px; margin-right: 10px;">하자보수 신청 상세
				</p>
				<p class="card-title mb-0 flex-grow-1" id="pp2" style="display: none; font-size: 25px;">
					<img alt="하자보수" src="/resources/images/maintenance.png"
						style="width: 35px; margin-right: 10px;">하자보수 신청 수정
				</p>
			</div>
			<div class="card-body" style="font-size: 16px;">
				<p style="margin-bottom: 10px; margin-top: 10px;">
					<i class="ri-feedback-fill"> 하자보수 A/S 처리절차는 
						<span style="color: red;"> 접수완료 → 업체지정 → 방문일정예약 → 보수공사시작 </span> 순으로 진행됩니다.
					</i>
				</p>
				<br>
				<div class="live-preview">
					<form id="frm1" name="frm" action="/maintenance/updatePost"
						method="post" enctype="multipart/form-data" style="font-size: 16px;">
						<div class="mb-3">
							<label for="mtSeq" class="form-label">신청접수번호</label> 
							<input type="text" class="form-control" id="mtSeq" name="mtSeq"
								value="${maintenanceVO.mtSeq}" readonly disabled>
						</div>
						<div class="mb-3">
							<label for="memNm" class="form-label">성명</label> 
							<input type="text" class="form-control" id="memNm"
								value="${maintenanceVO.memberVO.memNm}" readonly disabled />
						</div>
						<div class="mb-3">
							<label for="danjiName" class="form-label">단지명</label> 
							<input type="text" class="form-control" id="danjiName"
								value="${maintenanceVO.danjiVO.danjiName}" readonly disabled/>
						</div>
						<div class="mb-3">
							<label for="addr" class="form-label">주소</label> 
							<input type="text" class="form-control" id="addr"
								value="${maintenanceVO.danjiVO.addr}" readonly disabled/>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="dongCode" class="form-label">동</label> 
								<input type="text" id="dongCode" class="form-control"
									value="${maintenanceVO.memberVO.dongCode}" readonly disabled/>
							</div>
							<div class="col-md-6 mb-3">
								<label for="roomCode" class="form-label">호</label> 
								<input type="text" id="roomCode" class="form-control"
									value="${maintenanceVO.memberVO.roomCode}" readonly disabled/>
							</div>
						</div>
						<div class="mb-3">
							<label for="memTelno" class="form-label">전화번호</label> 
							<input type="text" class="form-control" id="memTelno"
								value="${maintenanceVO.memberVO.memTelno}" readonly disabled/>
						</div>
						<div class="mb-3">
							<label for="regDt" class="form-label" >접수일시</label> 
							<input type="text" class="form-control" id="regDt"
								value="${maintenanceVO.regDt}" readonly disabled> 
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="col-6">
		<div class="card shadow p-3 rounded">
			<div class="card-header align-items-center d-flex">
				<p class="card-title mb-0 flex-grow-1" style="font-size: 25px;">
					<img alt="하자보수" src="/resources/images/maintenance.png"
						style="width: 35px; margin-right: 10px;">하자보수 접수 내용
				</p>
			</div>
			<div class="step-arrow-nav">
				<ul class="nav nav-pills custom-nav nav-justified" role="tablist">
					<li class="nav-item" role="presentation">
						<button class="nav-link done active" id="steparrow-gen-info-tab"
							data-bs-toggle="pill" data-bs-target="#steparrow-gen-info"
							type="button" role="tab" aria-controls="steparrow-gen-info"
							aria-selected="true" >접수내용</button>
					</li>
					<li class="nav-item" role="presentation">
						<button class="nav-link"
							 id="steparrow-description-info-tab" data-bs-toggle="pill"
							data-bs-target="#steparrow-description-info" type="button"
							role="tab" aria-controls="steparrow-description-info"
							aria-selected="flase">하자보수 업체 정보</button>
					</li>
				</ul>
			</div>
			<div class="card-body">
				<div class="tab-content">
					<div class="tab-pane fade show active" id="steparrow-gen-info" role="tabpanel"
						aria-labelledby="steparrow-gen-info-tab">
						<div class="live-preview">
							<form id="frm2" name="frm" action="/maintenance/updatePost"
						method="post" enctype="multipart/form-data">
								<div class="row">
									<div class="col-md-6 mb-3" style="margin-top:15px;">
										<label for="mtConst" class="form-label">하자보수공종</label> 
										<input type="text" class="form-control" id="mtConst" name="mtConst"
											value="${maintenanceVO.mtConst}" disabled>
									</div>
									<div class="col-md-6 mb-3" style="margin-top:15px;">
										<label for="mtLocation" class="form-label">상세위치</label> 
										<input type="text" class="form-control" id="mtLocation" name="mtLocation"
											value="${maintenanceVO.mtLocation}" disabled >
									</div>
								</div>	
								<div class="mb-3">
									<label for="mtDetail" class="form-label">상세내용</label>
									<textarea class="form-control" id="mtDetail" name="mtDetail" rows="2" disabled>${maintenanceVO.mtDetail}</textarea>

								</div>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="mtStatus" class="form-label">처리상태</label> 
										<input type="text" class="form-control" id="mtStatus"
											value="${maintenanceVO.mtStatus}" readonly disabled>
									</div>
									<div class="col-md-6 mb-3">
										<label for="prcsDt" class="form-label">처리일자</label> 
										<input type="text" class="form-control" id="prcsDt" value="${maintenanceVO.prcsDt}" readonly disabled>
									</div>
								</div>	
								<div class="mb-3">
									<label for="statusContent" class="form-label">승인답변</label>
									<textarea class="form-control" id="statusContent" name="statusContent" rows="2" placeholder="관리자가 등록한 답변이 없습니다." disabled>${maintenanceVO.statusContent}</textarea>

								</div>
								<div>
									<label class="file-label" for="attach">첨부파일</label> 
									<div id="divAttaches" style="border:1px solid #ced4da; border-radius: 3px; margin-top: 5px;" >
										<c:forEach var="attachVO" items="${maintenanceVO.attachList}" varStatus="stat">
<%-- 											<p>왕와옹${attachVO.fileName}</p> --%>
											<img class="attach-img" name="attach" style="width: 150px; height: 150px; margin:10px 10px 10px; border-radius: 5px;" alt="   등록된 첨부파일이 없습니다."
												src="/upload${attachVO.fileName}">
										</c:forEach>
									</div>								
								</div>
								<div style="margin-top:15px;">
									<label for="attach" class="form-label">파일업로드</label>
									<input type="file" id="attach" name="uploadFiles"
										class="form-control attach" accept=".jpg, .jpeg, .png, .pdf" disabled multiple />
								</div>
							</form>
						</div>
						<div class="text-end">
							<!-- ///// 일반모드 시작 ///// -->
							<p id="p1" style="margin-top:20px;">
								<input type="button" class="btn btn-primary waves-effect waves-light" id="edit" value="수정" /> 
								<input type="button" class="btn btn-secondary waves-effect waves-light" id="delete" value="삭제" /> 
								<input type="button" class="btn btn-success waves-effect" id="list" value="목록" />
							</p>
							<!-- ///// 일반모드 끝  ///// -->
							<!-- ///// 수정모드 시작 ///// -->
							<p id="p2" style="display: none; margin-top:20px;">
								<input type="button" class="btn btn-secondary waves-effect waves-light" id="confirm" value="확인" /> 
								<input type="button" class="btn btn-success waves-effect" id="cancel" value="취소" />
							</p>
							<!-- ///// 수정모드 끝  ///// -->
						</div>
					</div>
					<!-- 협력업체 정보 출력 -->
					<div class="tab-pane fade" id="steparrow-description-info" role="tabpanel"
						aria-labelledby="steparrow-description-info-tab">
						<div class="tab-pane card-body" id="div1">
							<div class="live-preview">
								<form id="frm3" name="frm" action="/maintenance/updatePost"
							method="post" enctype="multipart/form-data">
									<c:choose>
										<c:when test="${empty maintenanceVO.ccpyCode}">
											<img alt="업체선정" src="/resources/images/mt02.jpg" style="width:680px;">
											<h4 style="text-align:center;">※  관리자가 업체지정 중에 있습니다.</h4>
										</c:when>
										<c:otherwise>
											<c:forEach var="ccpy" items="${maintenanceVO.ccpyList}">
												<c:if test="${ccpy.ccpyCode eq maintenanceVO.ccpyCode}">
	<%-- 											<p>우아아${maintenanceVO.ccpyList}</p> --%>
													<input type="hidden" value = "${maintenanceVO.ccpyCode}" />
													<div class="mb-3">
													<span class="badge border border-info text-info" style="font-size:18px;">
														<i style="font-size:18px;"></i>${ccpy.ccpyName}
													</span>
													</div>
													<div class="mb-3">
														<label for="mtConst" class="form-label">공종</label> 
														<input type="text" class="form-control" id="mtConst"
															value="${maintenanceVO.mtConst}" readonly>
													</div>
													<div class="mb-3">
														<label for="bizRegNo" class="form-label">사업자번호</label> 
														<input type="text" class="form-control" id="bizRegNo"
															value="${ccpy.bizRegNo}" readonly>
													</div>
													<div class="row">
														<div class="col-md-8 mb-3">
															<label for="ccpyAddr" class="form-label">주소</label> 
															<input type="text" class="form-control" id="ccpyAddr"
																value="${ccpy.ccpyAddr}" readonly>
														</div>
														<div class="col-md-4 mb-3">
															<label for="ccpyAddrDetail" class="form-label">상세주소</label> 
															<input type="text" class="form-control" id="ccpyAddrDetail"
																value="${ccpy.ccpyAddrDetail}" readonly>
														</div>
													</div>	
													<div class="mb-3">
														<label for="ccpyTelno" class="form-label">전화번호</label> 
														<input type="text" class="form-control" id="ccpyTelno"
															value="${ccpy.ccpyTelno}" readonly>
													</div>
													<div class="row">
														<div class="col-md-6 mb-3">
															<img alt="업체이미지" src="/resources/images/${ccpy.ccpyName}1.png" style="width:330px; height:200px; margin-top:15px;">
														</div>
														<div class="col-md-6 mb-3">
															<img alt="업체이미지" src="/resources/images/${ccpy.ccpyName}2.png" style="width:330px; height:200px; margin-top:15px;">
														</div>
													</div>
												</c:if>
											</c:forEach>
										</c:otherwise>
									</c:choose>	
								</form>	
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

