<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<title>하자보수 신청 페이지</title>
<style>
.card{
	min-height: 800px;
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script>
$(document).ready(function() {
	/**
	* 전화번호 하이픈(-) 정규식으로 바꿔주기
	*/
	function formatPhoneNumber(phoneNumber) {
		return phoneNumber.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
	}
	
	/**
	* 하자보수 접수번호 자동생성
	*/
	getMtSeq();
	

	/**
	* 취소하시겠습니까? 확인시 :리스트로 이동 , 취소시 : 이전페이지로 return
	*/
	$("#cancel").on("click", function() {
		Swal.fire({
			title: '신청을 취소하시겠습니까?',
			icon: 'warning',
			showCancelButton: true,
			confirmButtonText: '예',
			cancelButtonText: '아니오'
		}).then((result) => {
			if (result.isConfirmed) {
				Swal.fire({
					title: '신청이 취소되었습니다.',
					icon: 'error',
					showConfirmButton: false,
					timer: 1200,
					showCloseButton: false
				}).then(() => {
					location.href = "/maintenance/list";
				});
			}
		});
	});


	/**
	* 첨부파일 클릭하여 이미지 선택 시 이미지 미리보기! 
	*/
	function handleImg(e) {
		let files = e.target.files;
		let fileArr = Array.prototype.slice.call(files);

		fileArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
// 				alert("이미지 확장자만 가능합니다.");
				Swal.fire({
					title: '이미지 확장자만 가능합니다.',
					icon: 'warning',
					confirmButtonClass: 'btn btn-primary w-xs mt-2',
					buttonsStyling: false,
					showCloseButton: true
				});
				return;
			}
			let reader = new FileReader();
			$("#img").html("");

			reader.onload = function(e) {
				let img_html = "<img src=\"" + e.target.result + "\" style='width:150px; height:150px' />";
				$("#img").append(img_html);
			}
			reader.readAsDataURL(f);
		});
	}

	/**
	* 이미지 변경 시 변경된 이미지로 미리보기해준다.
	*/
	$("#uploadFiles").on("change", handleImg);

		
	/**
	* 페이지 로드 시 mtSeq 값을 가져와서 입력 필드에 설정
	*/
	function getMtSeq() {
		$.ajax({
			url: "/maintenance/getMtSeq",
			type: "post",
			dataType: "text",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			success: function(result) {
				console.log("result : ", result);
				$("input[name='mtSeq']").val(result);
			},
				error: function(xhr, status, error) {
				console.error("error : ", error);
			}
		});
	}
	
	/**
	* 자동입력 버튼 클릭 시 신청자 정보 자동입력
	*/
	$("#autoBtn").on("click", function() {

		$.ajax({
			url:"/maintenance/getMemberInfo",
			contentType:"application/json;charset=utf-8",
			data:{memId : 'memId'},
			type:"get",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			success : function(result) {
				console.log("result : ", result);
				
				$("#memNm").val(result.memberVO.memNm);
				$("#danjiName").val(result.danjiVO.danjiName);
				$("#addr").val(result.danjiVO.addr);
				$("#dongCode").val(result.memberVO.dongCode);
				$("#roomCode").val(result.memberVO.roomCode);
				$("#memTelno").val(formatPhoneNumber(result.memberVO.memTelno));
			}
			
		});
	});
	
	// 오른쪽 자동입력버튼
	$('#autoBtn2').on('click', function(){
		$('#mtConst').val('타일공사');
		$('#mtLocation').val('거실 발코니');
		$('#mtDetail').val('거실 발코니 타일이 깨졌어요. 하자보수가 필요합니다.');
		});
	
	
	//등록등록
	$("#apply").on("click",function(){

		let mtConst = $("#mtConst").val();
		let mtLocation = $("#mtLocation").val();
		let mtDetail = $("#mtDetail").val();
		
		let formData = new FormData();
		
		formData.append("mtConst", mtConst);
		formData.append("mtLocation", mtLocation);
		formData.append("mtDetail", mtDetail);
		
		let fileObj = $("#uploadFiles");
		
		let files = fileObj[0].files;
		console.log("files.length : ", files.length);
		
		for (let i = 0; i < files.length; i++) {
			formData.append("uploadFiles", files[i]);
		};

		Swal.fire({
			title: '신청하시겠습니까?',
			icon: 'question',
			showCancelButton: true,
			confirmButtonText: '예',
			cancelButtonText: '아니오'
		}).then((result) => {
			if (result.isConfirmed) {
				
				const csrfHeaderName = "${_csrf.headerName}";
				const csrfToken = "${_csrf.token}";
				
				$.ajax({
					url: "/maintenance/createAjax",
					processData: false,
					contentType: false,
					data: formData,
					type: "post",
					dataType: "text",
					beforeSend: function (xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfToken);
					},
					success: function (result) {
						Swal.fire({
							position: "center",
							icon: "success",
							title: "신청이 완료 되었습니다.",
							timer: 1500,
							showConfirmButton: false
						}).then(() => {
							console.log("result>>>", result);
							location.href = "/maintenance/list";
						});
					},
					error: function (error) {
						console.error("error : ", error);
					}
				});
			}
		});
		return false;
	});
});
</script>
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="las la-wrench"></i><strong> 하자보수 신청</strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="/maintenance/list">하자보수
								신청 내역</a></li>
						<li class="breadcrumb-item active">하자보수 신청</li>
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
				<p class="card-title mb-0 flex-grow-1" style="font-size: 25px;">
					<img alt="하자보수" src="/resources/images/maintenance.png"
						style="width: 35px; margin-right: 10px;">신청인 정보
				</p>
			</div>
			<div class="card-body" style="font-size: 16px;">
				<p style="margin-bottom: 10px; margin-top: 10px;">
					<i class="ri-feedback-fill"> 하자보수 A/S 처리절차는 <span
						style="color: red;"> 접수완료 → 방문일정예약 → 보수공사진행 </span> 순으로 진행됩니다.
					</i>
				</p>
				<br>
				<div class="live-preview">
					<form id="frm" name="frm" action="/maintenance/updatePost"
						method="post" enctype="multipart/form-data"
						style="font-size: 15px;">
						<div class="mb-3">
							<label for="mtSeq" class="form-label">신청접수번호</label> 
							<input type="button" class="btn btn-light waves-effect end" id="autoBtn" value="자동입력"  style="float: right; margin-bottom:10px;"/>
							<input type="text" class="form-control" id="mtSeq" name="mtSeq"
								value="${maintenanceVO.mtSeq}" readonly>
						</div>
						<div class="mb-3">
							<label for="memNm" class="form-label">성명</label> 
							<input type="text" class="form-control" id="memNm"
								value="${maintenanceVO.memberVO.memNm}" readonly required="required"/>
						</div>
						<div class="mb-3">
							<label for="danjiName" class="form-label">단지명</label> 
							<input type="text" class="form-control" id="danjiName"
								value="${maintenanceVO.danjiVO.danjiName}" readonly required="required"/>
						</div>
						<div class="mb-3">
							<label for="addr" class="form-label">주소</label> 
							<input type="text" class="form-control" id="addr"
								value="${maintenanceVO.danjiVO.addr}" readonly required="required"/>
						</div>
						<div class="row">
							<div class="col-md-6 mb-3">
								<label for="dongCode" class="form-label">동</label> 
								<input type="text" id="dongCode" class="form-control"
									value="${maintenanceVO.memberVO.dongCode}" readonly required="required"/>
							</div>
							<div class="col-md-6 mb-3">
								<label for="roomCode" class="form-label">호</label> 
								<input type="text" id="roomCode" class="form-control"
									value="${maintenanceVO.memberVO.roomCode}" readonly required="required"/>
							</div>
						</div>
						<div class="mb-3">
							<label for="memTelno" class="form-label">전화번호</label> <input
								type="text" class="form-control" id="memTelno"
								value="${maintenanceVO.memberVO.memTelno}" readonly required="required"/>
						</div>
					</form>
				</div>
				<!-- 				<div class="d-none code-view"> -->
				<!-- 					<pre class="language-markup" style="height: 375px;"></pre> -->
				<!-- 				</div> -->
			</div>
		</div>
	</div>

	<div class="col-6">
		<div class="card shadow p-3 rounded">
			<div class="card-header align-items-center d-flex">
				<p class="card-title mb-0 flex-grow-1" style="font-size: 25px;">
					<img alt="하자보수" src="/resources/images/maintenance.png"
						style="width: 35px; margin-right: 10px;">하자보수 신청
				</p>
			</div>
			<form action="" style="font-size: 16px;">
				<div class="mb-3">
					<label for="mtConst" class="form-label" style="margin-top: 20px;">하자보수 공종</label>
					<input type="button" class="btn btn-light waves-effect end" id="autoBtn2" value="자동입력"  style="float: right; margin-top:10px;"/>
					<input type="text" class="form-control" id="mtConst" placeholder="하자보수 공종" required>
				</div>
				<div class="mb-3">
					<label for="mtLocation" class="form-label" style="margin-top: 10px;">상세 위치</label>
					<input type="text" class="form-control" id="mtLocation" placeholder="상세 위치" required>
				</div>
				<div class="mb-3">
					<label for="mtDetail" class="form-label" style="margin-top: 10px;">상세 내용</label>
					<textarea class="form-control" id="mtDetail" rows="3" placeholder="상세 내용" required></textarea>
				</div>
				<div>
					<label for="attach" class="form-label" style="margin-top: 10px;">첨부파일</label>
					<input class="form-control" type="file" id="uploadFiles" name="uploadFiles" multiple>
				</div>
				
				<div style="border:3px dashed #ced4da; border-radius: 3px; margin-top:20px; min-height:170px;">
					<p id="img" style="padding: 10px;"></p>
				</div>
				<div class="form-actions text-end" style="margin-top:15px;">
					<button type="submit" class="btn btn-primary waves-effect waves-light" id="apply" style="width:80px; margin-right:5px;">신청</button> 
					<button type="button" class="btn btn-secondary waves-effect waves-light" id="cancel" style="width:80px;">취소</button>
				</div>
				<sec:csrfInput />
			</form>
		</div>
	</div>
</div>