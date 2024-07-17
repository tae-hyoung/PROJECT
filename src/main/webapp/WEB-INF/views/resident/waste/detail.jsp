<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<title>폐기물 배출 신청 상세페이지</title>
<style>
#frm {
	font-size: 15px;
}

.form-control {
/* 	margin-top: 5px; */
	margin-bottom: 5px;
}

input[type='date'] {
	border: 1px solid #ced4da;
	position: relative;
	width: 100%;
	padding: 5px;
	background: url('/resources/images/calendar.png') no-repeat right 10px
		center/25px auto;
	border-radius: 0.25rem;
	text-align: center;
	font-size: 100%;
}

input[type='date']::-webkit-calendar-picker-indicator {
	position: absolute;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	background: transparent;
	color: transparent;
	cursor: pointer;
}
label {
	margin-top:5px;
}
.file-label {
	display: block;
	margin-top: 4px;
}

#p1, #p2 {
	display: flex;
	justify-content: flex-end;
	margin-top: 10px;
	gap:5px;
}
input:focus {
	outline-color: aqua;
}
.card{
	min-height: 830px;
}
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
</head>
<body>
<script type="text/javascript">

//전역변수
let backupAttaches;

$(document).ready(function() {

	var commDetCode = $("select[name='commDetCode']").val();
	var wQty = $("input[name='qty']").val();
	var wRecycleYn = $("#recycleYn").val();
	var wEtc = $("textarea[name='etc']").val();
	var wEstDt = $("input[name='estDt']").val();
	
	
	//이미지 미리보기
	$(".attach").on("change", handleImg);
	
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
				let str = "<img class='attach-img' name='attach' style='width: 120px; height: 120px; margin:10px 10px 10px; border-radius: 5px;' alt='첨부파일' src='"+e.target.result+"'>"; 
				$("#divAttaches").append(str);
			}
			reader.readAsDataURL(f);
		});
	}

	$("#list").on("click", function() {
		location.href = "/waste/wasteList";
	});
	
	//확인버튼 클릭 시
	$("#confirm").on("click", function() {
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
			
			//재사용 가능여부
			let recycleYn = $("#recycleYn").val();
			formData.append("recycleYn", recycleYn);
			//기타사항
			let etc = $("input[name='etc']").val();
			formData.append("etc", etc);
			//배출일자
			let estDt = $("input[name='estDt']").val();
			formData.append("estDt", estDt);
	
			//첨부파일 처리
			let uploadFiles = $('input[name="uploadFiles"]')[0];
			let files = uploadFiles.files;
			let fileArr = Array.prototype.slice.call(files);
			fileArr.forEach(function(f) {
				if (!f.type.match("image.*")) {
					alert("이미지 확장자만 가능합니다.");
					return;
				}
				formData.append("uploadFiles", f);
			});
			
			let commDetCodeNm = $("#commDetCodeNm").val();
			formData.append("commDetCodeNm", commDetCodeNm);
			
			//기본키 데이터*******
			let wasteSeq = $("input[name='wasteSeq']").val();
			formData.append("wasteSeq", wasteSeq);
			
			let strCsrf = $("input[name='_csrf']").val();
			formData.append("_csrf", strCsrf);
			
				$.ajax({
					url: "/waste/updateAjax",
					processData: false,
					contentType: false,
					data: formData,
					type: "post",
					dataType: "json",
					beforeSend: function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					success: function(result) {
						console.log("result: ", result);
	
						if (result != null) {
							Swal.fire({
								position: "center",
								icon: "success",
								title: "수정이 완료 되었습니다.",
								timer: 1500,
								showConfirmButton: false
							}).then(() => {
								location.href = "/waste/detail?wasteSeq=" + result.wasteSeq;
							});
						}
						$("#p1").css("display", "block");
						$("#p2").css("display", "none");
						$(".formdata").attr("readonly", true);
						$('.minus, .plus').prop('disabled', true);
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
	
	$("#edit").on("click", function() {
		backupAttaches = $("#divAttaches").html();

		$("#p1").css("display", "none");
		$("#p2").css("display", "block");
		$("#pp1").css("display", "none");
		$("#pp2").css("display", "block");
		$("#feedback1").css("display", "none");
		$("#feedback2").css("display", "block");

		$("#etc").prop("disabled", false);
		$("#estDt").prop("disabled", false);
		$("#recycleYn").prop("disabled", false);
		$("#attach").prop("disabled", false);
		$("#frm").attr("action", "/waste/updatePost");
	});

	$("#cancel").on("click", function() {
		$("#p1").css("display", "block");
		$("#p2").css("display", "none");
		$("#pp1").css("display", "block");
		$("#pp2").css("display", "none");
		$("#feedback1").css("display", "block");
		$("#feedback2").css("display", "none");
		$(".form-select.mb-3").prop("disabled", true);
		$(".formdata").attr("readonly", true);
		$('.minus, .plus').prop('disabled', true);
		$("#recycleYn").prop("disabled", true);
		$("#etc").prop("disabled", true);
		$("#estDt").prop("disabled", true);
		$("#attach").prop("disabled", true);
		$("input[name='commDetCode']").val(commDetCode);
		$("input[name='qty']").val(wQty);
		$("input[name='recycleYn']").val(wRecycleYn);
		$("textarea[name='etc']").val(wEtc);
		$("input[name='estDt']").val(wEstDt);
		$("#divAttaches").html(backupAttaches);
	});

	$("#delete").on("click", function() {
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
				let wasteSeq = $("input[name='wasteSeq']").val();
	
				let data = {
					"wasteSeq": wasteSeq
				};
				console.log("data: " + data);
	
				$.ajax({
					url: "/waste/deleteAjax",
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
								location.href = "/waste/wasteList";
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
	<%-- <p>${wasteVO}</p> --%>
	<%-- <p>attach: ${wasteVO.attach}</p> --%>
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="las la-recycle"></i><strong> 폐기물 신청 상세</strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="/waste/wasteList">폐기물 신청 내역</a></li>
						<li class="breadcrumb-item active">폐기물 신청 상세</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>	
	<div class="col-12">
		<div class="card">
			<div class="card-header" style="display: flex;">
				<p id="pp1" class="card-title" style="font-size: 25px;">
					<img alt="폐기물" src="/resources/images/waste.png"
						style="width: 40px; margin-right: 10px;">폐기물 신청 상세
				</p>
				<p id="pp2" class="card-title"
					style="font-size: 25px; display: none;">
					<img alt="폐기물" src="/resources/images/waste.png"
						style="width: 40px; margin-right: 10px;">폐기물 신청 수정
				</p>
				<div class="card-tools" style="margin-left: auto;">
					<div class="input-group input-group-sm" style="width: 300px;">
					</div>
				</div>
			</div>
			
			<div>
				<form id="frm" name="frm" action="/waste/updatePost" method="post" enctype="multipart/form-data" style="font-size:15px;">
					<!-- 폼데이터 -->
					<div class="col-md-1"></div>
					<div class="col-md-6" id="feedback1" style="display: block; margin:10px 50px; font-size:16px;">
						<i class="ri-feedback-fill"></i> 차량진입이 가능한 곳까지
						<span style="color: red;">직접 배출</span>해주셔야 합니다.
					</div>
					<div class="col-md-6" id="feedback2" style="display: none; margin:10px 50px;">
						<i class="ri-feedback-fill"></i> 
						<span style="color: red;">재사용 가능여부, 배출장소, 배출일자, 첨부파일만</span> 수정 가능합니다.
					</div>
					<div style="display:flex; margin-left:30px;">
						<div class="col-md-5 card-body" style="float:left; margin-right: 50px;">
							<div>
								<label for="wasteSeq">신청접수번호</label> 
								<input type="text"class="form-control" name="wasteSeq" value="${wasteVO.wasteSeq}" disabled />
							</div>
							<div>
								<label for="memId">신청인ID</label> <input type="text"
									class="form-control" name="memId" value="${wasteVO.memId}"
									disabled />
							</div>
							<div>
								<label for="commDetCodeNm">폐기물 품목</label><br> 
								<select id="commDetCodeNm" name="commDetCode" class="form-select mb-3"
									aria-label="Default select example" disabled>
									<option value="${wasteVO.commDetailVO.commDetCode}" selected>${wasteVO.commDetailVO.commDetCodeNm}</option>
								</select>
							</div>
							<div>
								<label for="qty">수량</label><br>
								<div class="input-step">
									<button type="button" class="minus material-shadow minus">–</button>
									<input type="number" id="qty" name="qty" class="product-quantity"
										value="${wasteVO.qty}" min="1"/>
									<button type="button" class="plus material-shadow plus">+</button>
								</div>
							</div>
							<div>
								<label for="fee">수수료</label><br> 
								<input type="text" class="form-control" id="fee" name="fee" value="<fmt:formatNumber value="${wasteVO.fee}" groupingUsed="true"/>" disabled style="text-align: right"/>
							</div>
							<div>
								<label for="recycleYn">재사용 가능여부</label> 
								<select id="recycleYn" name="recycleYn" class="form-select mb-3"
									aria-label="Default select example" disabled>
									<c:choose>
										<c:when test="${wasteVO.recycleYn == 'y'}">
											<option value="y" selected>재사용가능</option>
											<option value="n">재사용불가</option>
										</c:when>
										<c:when test="${wasteVO.recycleYn == 'n'}">
											<option value="y">재사용가능</option>
											<option value="n" selected>재사용불가</option>
										</c:when>
										<c:otherwise>
											<option value="y">재사용가능</option>
											<option value="n">재사용불가</option>
										</c:otherwise>
									</c:choose>
								</select>
							</div>
							<div>
								<label for="etc">배출장소</label> 
								<input type="text" id="etc" name="etc" value="${wasteVO.etc}" class="form-control" disabled placeholder="배출장소" />
							</div>
							<div>
								<label for="estDt">배출일자</label> 
								<input type="date" id="estDt" name="estDt" value="${wasteVO.estDt}" class="form-control" disabled required placeholder="배출예정일" />
							</div>
						</div>
					<div class="col-md-5 card-body">
						<div>
							<label for="regDt">접수일자</label> 
							<input type="text" name="regDt" value="${wasteVO.regDt}" class="form-control" disabled placeholder="접수일시" />
						</div>
						<div>
							<label for="wasteStatus" style="margin-top:10px;">처리상태</label> 
							<input type="text" class="form-control" name="wasteStatus" value="${wasteVO.wasteStatus}" disabled />
						</div>
						<div>
							<label for="statusComment" style="margin-top:10px;">승인답변</label> 
							<c:choose>
								<c:when test="${wasteVO.statusComment != null}">
									<input type="text" class="form-control" name="statusComment"
									value="${wasteVO.statusComment}" disabled />
								</c:when>
								<c:when test="${wasteVO.statusComment == null}">
									<input type="text" class="form-control" name="statusComment"
									value="관리자가 등록한 답변이 없습니다." disabled />
								</c:when>
							</c:choose>
								
						</div>
						<div>
							<label class="file-label" for="attach" style="margin-top:10px;">첨부파일</label> 
							<div id="divAttaches" style="border:1px solid #ced4da; border-radius: 3px; margin-top: 5px;" >
								<c:forEach var="attachVO" items="${wasteVO.attachList}" varStatus="stat">
									<img class="attach-img" name="attach" style="width: 130px; height: 120px; margin:10px 10px 10px; border-radius: 5px;" alt="첨부파일"
										src="/upload${attachVO.fileName}">
								</c:forEach>
							</div>								
						</div>
						<div style="margin-top:20px;">
							<label for="attach" class="form-label">첨부파일</label>
							<input type="file" id="attach" name="uploadFiles"
								class="form-control attach" accept=".jpg, .jpeg, .png, .pdf" disabled="disabled" multiple />
						</div>
						<div class="text-end">
							<!-- ///// 일반모드 시작 ///// -->
							<p id="p1" style="margin-top: 30px;">
								<input type="button" class="btn btn-primary waves-effect waves-light" id="edit" value="수정" /> 
								<input type="button" class="btn btn-secondary waves-effect waves-light" id="delete" value="삭제" /> 
								<input type="button" class="btn btn-success waves-effect" id="list" value="목록" />
							</p>
							<!-- ///// 일반모드 끝  ///// -->
							<!-- ///// 수정모드 시작 ///// -->
							<p id="p2" style="display: none; margin-top: 30px;">
								<input type="button" class="btn btn-primary waves-effect waves-light" id="confirm" value="확인" /> 
								<input type="button" class="btn btn-secondary waves-effect waves-light" id="cancel" value="취소" />
							</p>
							<!-- ///// 수정모드 끝  ///// -->
						</div>
					</div>
					</div>
					</form>
				</div>
		</div>
	</div>
<script>
// 	function priceToString(fee) {
// 	    return fee.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
// 	}
	
// 	document.addEventListener('DOMContentLoaded', (event) => {
// 		const feeInput = document.getElementById('fee');
// 		const feeValue = parseFloat(feeInput.value);
// 		if (!isNaN(feeValue)) {
// 			feeInput.value = priceToString(feeValue);
// 		}
// 	});
</script>	
</body>
</html>