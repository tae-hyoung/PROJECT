<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<title>폐기물 배출 신청 페이지</title>
<link rel="shortcut icon" href="assets/images/favicon.ico">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script>
$(function() {
	function priceToString(fee) {
		return fee.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
	
	// 오늘날짜 이전은 선택 못하도록 막아두기
	var today = new Date().toISOString().split('T')[0];
	$('#estDt').attr('min', today);

	$("#cancel").on("click", function() {
		Swal.fire({
			title: '신청을 취소하시겠습니까?',
			icon: 'question',
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
					location.href = "/waste/wasteList";
				});
			}
		});
	});

	// 수량 옵션
	$('.minus').on('click', function(e) {
		e.preventDefault();
		var $count = $(this).siblings('.product-quantity');
		var now = parseInt($count.val());
		var min = 1;
		if (now > min) {
			$count.val(now - 1);
			updateFee();
		}
	});

	$('.plus').on('click', function(e) {
		e.preventDefault();
		var $count = $(this).siblings('.product-quantity');
		var now = parseInt($count.val());
		var max = 10;
		if (now < max) {
			$count.val(now + 1);
			updateFee();
		}
	});

	function handleImg(e) {
		let files = e.target.files;
		let fileArr = Array.prototype.slice.call(files);

		fileArr.forEach(function(f) {
			if (!f.type.match("image.*")) {
				alert("이미지 확장자만 가능합니다.");
				return;
			}
			let reader = new FileReader();
			$("#img").html("");
			
			reader.onload = function(e) {
			let img_html = "<img src=\"" + e.target.result + "\" style='width: 170px; height: 170px; margin:10px 10px 10px; border-radius: 5px;' />";
			
			$("#img").append(img_html);
			}
			reader.readAsDataURL(f);
		});
	}
	
	$("#frm").submit(function(e){
		e.preventDefault();
		
		let commDetCodeNm = $("select[name='commDetCodeNm']").val();
		let qty = $("input[name='qty']").val();
		let commDetCodeDscr = $("input[name='commDetCodeDscr']").val();
		let recycleYn = $("select[name='recycleYn']").val();
		let etc = $("textarea[name='etc']").val();
		let estDt = $("input[name='estDt']").val();
		
		let formData = new FormData();
		
		formData.append("commDetCodeNm",commDetCodeNm);
		formData.append("qty",qty);
		formData.append("commDetCodeDscr",commDetCodeDscr);
		formData.append("recycleYn",recycleYn);
		formData.append("etc",etc);
		formData.append("estDt",estDt);
		
		let fileObj = $("#uploadFiles");
		
		let files = fileObj[0].files;
		console.log("files.length : ", files.length);
		
		for(let i=0; i<files.length; i++){
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
				$.ajax({
					url:"/waste/createAjax",
					processData:false,
					contentType:false,
					data:formData,
					type:"post",
					dataType:"text",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
					},
					success:function(result){
						 Swal.fire({
								position: "center",
								icon: "success",
								title: "신청이 완료 되었습니다.",
								timer: 1500,
								showConfirmButton: false // 확인 버튼을 숨깁니다.
							}).then(() => {
								// Swal.fire의 타이머가 끝난 후 호출됩니다.
								console.log("result>>>", result);
								location.href = "/waste/wasteList";
							});
						},
						error:function(error){
							console.error("error : ", error);
						}
					});
				}
			});
			return false;
		});



	// 이미지 미리보기 시작
	$("#uploadFiles").on("change", handleImg);

	// 폐기물 품목 선택 시 수수료 자동 입력
	$('#commDetCodeNm').on('change', function() {
		updateFee();
	});

	// 수량 변경 시 수수료 재계산
	$('#qty').on('input', function() {
		updateFee();
	});

	// 수수료 업데이트 함수
	function updateFee() {
		var selectedOption = $('#commDetCodeNm').find('option:selected');
		var dscr = parseFloat(selectedOption.data('dscr'));
		var qty = parseInt($('#qty').val());
// 			var dscr = selectedOption.data('dscr');
// 			var qty = parseInt($('#qty').val());
// 		console.log('Selected Option:', selectedOption.text());
// 		console.log('Data Description (dscr):', dscr);
// 		console.log('Quantity (qty):', qty);
		if (!isNaN(dscr) && !isNaN(qty)) {
			var fee = dscr * qty;
			var totalFee = priceToString(fee);
			console.log('Total Fee:', totalFee);
			$('#commDetCodeDscr').val(totalFee);
		} 
	}
	
});
</script>
<style>
#frm {
	font-size: 16px;
}

.col-md-4, .col-md-6 {
	margin-top: 15px;
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

.input-group {
	display: flex;
	align-items: center;
}

/* .input-group .form-control { */
/* 	flex: 1; */
/* } */

.input-group .btn {
	margin-left: 10px;
}
.form-control {
	margin-top: 5px;
	margin-bottom: 5px;
}
.file-label {
	display: block;
}

.form-actions {
	display: flex;
	justify-content: flex-end;
	margin-top: 10px;
	gap:5px;
}
.card{
	min-height: 700px;
}
</style>
</head>
<body>


<div style="display: none" id="memId"><sec:authentication property="principal.memberVO.memId" /></div>
<div style="display: none" id="memNm"><sec:authentication property="principal.memberVO.memNm" /></div>
<div style="display: none" id="nickname"><sec:authentication property="principal.memberVO.nickname" /></div>
<div style="display: none" id="memTelno"><sec:authentication property="principal.memberVO.memTelno" /></div>
<div style="display: none" id="memEmail"><sec:authentication property="principal.memberVO.memEmail" /></div>
<div style="display: none" id="roomCode"><sec:authentication property="principal.memberVO.roomCode" /></div>




<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="ri-file-edit-line"></i><strong> 폐기물 배출 신청</strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="/waste/wasteList">폐기물 신청 내역</a></li>
						<li class="breadcrumb-item active">폐기물 신청</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>
	<div class="col-12">
		<div class="card">
			<div class="card-header" style="display: flex;">
				<p class="card-title" style="font-size: 25px; align: center;">
					<img alt="폐기물" src="/resources/images/waste.png"
						style="width: 40px; margin-right: 10px;">폐기물 신청
				</p>
				<div class="card-tools" style="margin-left: auto;">
					<div class="input-group input-group-sm" style="width: 300px;"></div>
				</div>
			</div> 
			<div class="card-body table-responsive p-10" style="margin-left:30px;">
				<form id="frm" name="frm" action="/waste/createAjax" method="post" enctype="multipart/form-data">
					<h4 style="margin-top:20px;">
						<strong>배출 정보</strong>
						
					</h4>
					<i></i> <i class="ri-feedback-fill"></i> 
					<span style="color: red;">차량진입이 가능한 곳까지 직접 배출해주셔야 합니다.</span>
					<!-- Left Column -->
					<div class="row">
						<div class="col-md-5" style="margin-right: 30px; ">
<%-- 							<input type="hidden" name="wasteSeq" value="${wasteVO.wasteSeq}"> --%>
							<label for="commDetCodeNm" style="margin-top:30px;">폐기물 품목</label> 
							<select id="commDetCodeNm" name="commDetCodeNm" class="form-select mb-3" required>
								<option disabled selected>폐기물 품목 선택</option>
								<c:forEach var="commDetail" items="${commDetail}">
									<option value="${commDetail.commDetCode}"
										data-dscr="${commDetail.commDetCodeDscr}">${commDetail.commDetCodeNm}</option>
								</c:forEach>
							</select> 
							<label for="qty">배출 수량</label>
							<div class="input-step">
								<button type="button" class="minus material-shadow minus">–</button>
								<input type="number" id="qty" name="qty"
									class="product-quantity" value="1" readonly required/>
								<button type="button" class="plus material-shadow plus">+</button>
							</div><br>
							<label for="commDetCodeDscr" style="margin-top: 10px;">수수료</label>
							<div class="input-group">
								<input type="text" class="form-control" id="commDetCodeDscr" name="commDetCodeDscr" readonly> 
									<input type="button" class="btn btn-secondary waves-effect waves-light" id="payment"
									value="수수료결제"/>
							</div>

							<label for="recycleYn" style="margin-top: 10px;">재사용 가능여부</label> 
							<select id="recycleYn" name="recycleYn" class="form-select mb-3" aria-label="Default select example" required>
								<option value="disabled select">가능여부 선택</option>
								<option value="y">재사용가능</option>
								<option value="n">재사용불가</option>
							</select>
							<div>
								<div>
									<label for="etc" class="form-label">기타사항</label>
									<textarea class="form-control" id="etc" name="etc" rows="3" required></textarea>
								</div>

								<div  style="margin: 5px 0px 100px 0px;">
									<label for="estDt" style="margin-top:10px;">배출일자</label> 
									<input type="date" placeholder="날짜 선택" id="estDt" name="estDt" required>
								</div>
							</div>
						</div>
						<div class="col-md-1"></div>
						<!-- Right Column -->
						<div class="col-md-5">
<!-- 							<div> -->
<!-- 								<label class="file-label" for="attach">첨부파일</label> -->
<!-- 									<input type="file" id="uploadFiles" name="uploadFiles" multiple /> -->
<!-- 							</div> -->
							<div>
								<label for="attach" class="form-label">첨부파일</label>
								<input class="form-control" type="file" id="uploadFiles" name="uploadFiles" multiple>
							</div>
							
							<div style="border:2px dashed #ced4da; border-radius: 3px; margin-top:10px;">
								<p id="img" style="min-height: 180px;"></p>
							</div>
							<div class="form-actions" style="margin-top:20px;">
								<button type="submit" class="btn btn-primary waves-effect waves-light" id="apply">신청</button> 
								<button type="button" class="btn btn-secondary waves-effect waves-light" id="cancel">취소</button>
							</div>
						</div>
					</div>
					<sec:csrfInput />
				</form>
			</div>
		</div>
	</div>
<script>
$("#payment").on('click', async function(){
// 	alert("결제결제");
	
	let charge = $('#commDetCodeDscr').val().replace(',', '');
	
// 	console.log(charge);
	const response = await PortOne.requestPayment({
		// Store ID 설정
		storeId: "store-22c2becf-63f0-4f4d-98fb-6a665ab06ca7",
		// 채널 키 설정
		channelKey: "channel-key-23a08f82-f8a6-4029-86cd-befb632c7108",
		paymentId: crypto.randomUUID(),
		orderName: '폐기물 수수료 결제',
		totalAmount: Number(charge),
		currency: "CURRENCY_KRW",
		payMethod: "CARD",
		customer:{
			customerId: $('#memId').text(),
			fullName: $('#memNm').text(),
			phoneNumber: $('#memTelno').text(),
			email: $('#memEmail').text(),
		},
	});
});
</script>	
</body>
</html>
