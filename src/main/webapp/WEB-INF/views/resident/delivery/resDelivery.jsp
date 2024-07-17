<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<!--datatable css-->
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
<!--datatable responsive css-->
<link rel="stylesheet"
	href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
<link rel="stylesheet"
	href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">

<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>


<!-- datatable js -->
<script
	src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script
	src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script
	src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script
	src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script
	src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script
	src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>

<style>
div.dataTables_wrapper div.dataTables_paginate ul.pagination {
	justify-content: left;
}

.form-control {
	width: 80%;
	font-size:15px;
}

img {
	width: 100%;
}

.card-title{
	font-weight:bold;
}

.text-white {
	color: rgb(133 133 137) !important;
}

.input-group {
    display: flex;
    align-items: center;
}
.input-group input {
	margin-top: -14px;
    flex: 1;
    max-width: 100%; /* 입력 박스의 최대 너비를 줄입니다. */
}
.input-group span {
    margin-left: 6px !important; /* 입력 박스와 단위 표시 사이의 간격을 조정합니다. */
}
.input-group .btn { /*결제 버튼 사이즈 조절*/
	margin-top: -14px;
	width: 75px;
  	height: 41px;
}

textarea:disabled {
    background: #ed1f1f38 !important;
}

#modalBackTm:disabled {
	 background: #ed1f1f38 !important;
}
</style>

<div style="display: none" id="memId"><sec:authentication property="principal.memberVO.memId" /></div>
<div style="display: none" id="memNm"><sec:authentication property="principal.memberVO.memNm" /></div>
<div style="display: none" id="nickname"><sec:authentication property="principal.memberVO.nickname" /></div>
<div style="display: none" id="memTelno"><sec:authentication property="principal.memberVO.memTelno" /></div>
<div style="display: none" id="memEmail"><sec:authentication property="principal.memberVO.memEmail" /></div>
<div style="display: none" id="roomCode"><sec:authentication property="principal.memberVO.roomCode" /></div>

<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="las la-truck"></i>&nbsp;<strong>택배 신청 내역</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">서비스</a></li>
						<li class="breadcrumb-item active">택배 신청 내역</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="col-12">
	<div class="card">
		<div class="card-header">
		
			<h3 class="card-title" style="font-size: 40px;"> <img alt="택배" src="/resources/images/택배원2.png" style="width: 47px; margin-right: 7px; margin-bottom: 3px;">택배 신청 내역</h3>
		</div>
		<div class="card-body" style="font-size: 16px;">
			<p>
				📢 <span class="text-danger"
					style="font-size: 17px; font-weight: bold;"> 신청 완료 -> (반려)
					-> 수거 완료</span> 순으로 진행됩니다. <br>※ 신청 완료 상태일 경우에만 철회가 가능합니다.
			</p>

			<table id="deliListTable"
				class="display table table-bordered dt-responsive"
				style="width: 100%; text-align: center;">
				<thead style="font-size: 16px; background-color: #69bde729;">
					<tr>
						<th>순 번</th>
						<th>신청 일련번호</th>
						<th>신청인ID</th>
						<th>운송 품목</th>
						<th>신청 일시</th>
						<th>수거 일시</th>
						<th>처리 여부</th>
					</tr>
				</thead>
				<tbody style="font-size: 16px;">
					<c:forEach var="deliveryVO" items="${deliveryVOList}"
						varStatus="stat">
						<tr class="tblRow" data-pck-seq="${deliveryVO.pckSeq}">
							<td>${deliveryVO.rnum}</td>
							<td>${deliveryVO.pckSeq}</td>
							<td>${deliveryVO.memId}</td>
							<td>${deliveryVO.commDetailVOList[0].commDetCodeNm}</td>
							<td>${deliveryVO.regDt}</td>
							<td><c:choose>
									<c:when test="${deliveryVO.pickUpDt == null}">
										<span> - </span>
									</c:when>
									<c:otherwise>
										<span>${deliveryVO.pickUpDt}</span>
									</c:otherwise>
								</c:choose></td>
							<td><c:choose>
									<c:when test="${deliveryVO.cancelYn == 'Y'}">
										<span class="badge border text-white bg-dark-subtle" style="font-size: 16px; font-weight: bold;">신청 철회</span>
									</c:when>
									<c:when test="${deliveryVO.backYn == 'Y'}">
										<span class="badge bg-danger" style="font-size: 16px; width: 90px;">반려</span>
									</c:when>
									<c:when test="${deliveryVO.pckStatus == 'N'}">
										<span class="badge bg-warning" style="font-size: 16px;">신청
											완료</span>
									</c:when>
									<c:when test="${deliveryVO.pckStatus == 'Y'}">
										<span class="badge bg-success" style="font-size: 16px;">수거
											완료</span>
									</c:when>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<button type="button" id="addBtn"
				class="btn btn-soft-success waves-effect waves-light material-shadow-none"
				style="float: right;">신청</button>

			<!-- 신청 modals//////////////////////////////////////////////////////// -->
			<div class="modal fade bd-example-modal-xl" id="modalAdd"
				tabindex="-1" aria-labelledby="exampleModalgridLabel"
				aria-modal="true">
				<div class="modal-dialog modal-xl">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title" id="modalAddTitle"
								style="font-size: 40px;">택배 신청</h1>
							<hr>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close" id="close2"></button>
						</div>
						<div class="modal-body" id="modalAddBody" style="font-size: 16px;">
							<form id="frm" action="/delivery/create2" method="post"
								enctype="multipart/form-data">
								<p>
									<span class="text-danger">*필수 기재 </span><br> <span
										class="text-danger">[유의] 상품 정보가 실제와 다를 시 수거 하지 않습니다.
										정확한 기재 부탁드립니다.</span>
										<button type="button" class="btn btn-ghost-info waves-effect material-shadow-none" id="auto">자동 완성</button>
								</p>
								<div class="row">
									<div class="col-md-4">
										<h2>보내는분</h2>
										<hr>
										<p>
											이름<span class="text-danger">*</span> <input type="text"
												class="form-control" id="modalSendName" name="sendName"
												required placeholder="이름">
										</p>
										<p>
											전화번호<span class="text-danger">*</span> <input type="tel"
												class="form-control phone" id="modalSendTel" name="sendTel"
												placeholder="휴대폰 번호" required />

										</p>
										<h2>받는 분</h2>
										<hr>
										<p>
											이름<span class="text-danger">*</span> <input type="text"
												class="form-control" id="modalReName" name="reName" required
												placeholder="이름">
										</p>
										<p>
											전화번호<span class="text-danger">*</span> <input type="tel"
												class="form-control phone" id="modalReTel" name="reTel"
												placeholder="휴대폰 번호" required />
										</p>
										<p>
											주소<span class="text-danger">*</span>
											<button type="button" id="btnPost">주소 검색</button>
											<input type="text" class="form-control" id="modalPost"
												name="rePost" required placeholder="우편번호" readonly>
										</p>
										<p>
											<input type="text" class="form-control" id="modalAddress"
												name="reAddress" required placeholder="주소">
										</p>
										<p>
											<input type="text" class="form-control" id="modalDeAddress"
												name="reDeAddress" required placeholder="상세주소">
										</p>
									</div>

									<div class="col-md-4">
										<h2>상품 정보</h2>
										<hr>
										<p>
											운송 품목(규격) <span class="text-danger">*</span> <select
												name="pckItem" id="modalPckItem1" class="form-select"
												required>
											</select>
										</p>

										<p>
											무게 <span class="text-danger">*</span>
											<div class="input-group">
											<!--onblur : - 사용자가 다른 곳을 클릭 했을 때 (focus out 시에) 이벤트  발생 -->
											<input type="text" class="form-control" id="modalWeigh1"
												name="weigh" required onblur="fWCheck(this)"
												placeholder="무게"><span>kg</span>
											</div>
										</p>

										<p>
											금액 
											<div class="input-group">
											<input type="text" class="form-control" id="modalPrice1"
												name="price" readonly placeholder="0">
												<span>원</span>
											</div>

										</p>
										<p>
											수량 <span class="text-danger">*</span> 
											<div class="input-group">
											<input type="text"
												class="form-control" id="modalPckQty1" name="pckQty"
												value="" required placeholder="수량">
												<span>개</span>
											</div>
										</p>
										<p>총액
										
										<div class="input-group">
											<input type="text" class="form-control" id="modalTotal1"
												name="total" readonly>
											<button type="button"
												class="btn btn-soft-secondary waves-effect waves-light material-shadow-none"
												id="payBtn">결제</button>
										</div>
										</p>
									</div>

									<div class="col-md-4">
										<h2>신청 정보</h2>
										<hr>
										<p>
											택배사 <span class="text-danger">*</span> <select
												name="ccpyCode" id="modalCcpyCode1" class="form-select"
												required>
											</select>
										</p>
										<p>
											희망일 <span class="text-danger">*</span> <input type="date"
												class="form-control" id="modalHopeDt" name="hopeDt" value=""
												required>

										</p>
										<p id="pImg"></p>
										<p>
											첨부파일 <span class="text-danger">*</span> <input type="file"
												class="form-control" id="uploadFile" name="uploadFile"
												value="" multiple required>
										</p>
									</div>
								</div>
								<div class="col-lg-12">
									<div class="hstack gap-2 justify-content-end">
										<button type="button"
											class="btn btn-soft-secondary waves-effect waves-light material-shadow-none"
											data-bs-dismiss="modal" id="submit">신청</button>
										<button type="button"
											class="btn btn-soft-danger waves-effect waves-light material-shadow-none"
											id="cancle">재작성</button>
										<button type="button"
											class="btn btn-soft-dark waves-effect waves-light material-shadow- "
											id="close3">닫기</button>
									</div>
								</div>
								<sec:csrfInput />
							</form>
						</div>
					</div>
				</div>
			</div>

			<!-- 상세 modals(신청완료)////////////////////////////////////////////////////////// -->
			<div class="modal fade bd-example-modal-xl" id="modalDetail"
				tabindex="-1" aria-labelledby="exampleModalgridLabel"
				aria-modal="true">
				<div class="modal-dialog modal-xl">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title" id="modalDetailTitle"
								style="font-size: 40px;">택배 상세</h1>
							<hr>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close" id="close"></button>
						</div>
						<div class="modal-body" id="modalDetailBody"
							style="font-size: 16px;">
							<p id="p1" style="display: none;">
								<span class="text-danger" style="font-size: 19px;">※
									택배사에서 수거 완료되어 상세 내역만 확인 가능합니다.</span>
							</p>
							<p id="p2" style="display: none;">
								<span class="text-danger" style="font-size: 19px;">※ 택배
									신청이 철회되어 상세 내역만 확인 가능합니다.</span>
							</p>
							<p id="p5" style="display: none;">
								<span class="text-danger" style="font-size: 19px;">*수정
									가능한 항목</span>
							</p>
							<p id="p9" style="display: none;">
								<span class="text-danger" style="font-size: 19px;">※ 반려
									처리 되었습니다. 사유 확인 후 재 신청 바랍니다.</span>
							</p>
							<p>
								택배 일련 번호<input type="text" class="form-control" id="modalPckSeq"
									name="pckSeq" disabled readonly>
							</p>
							<div class="row">
								<div class="col-md-4">
									<h2>보내는분</h2>
									<hr>
									<p>
										이름<span class="text-danger upSpan" style="display: none;">*</span>
										<input type="text" class="form-control form"
											id="modalSendName1" name="sendName" disabled readonly>
									</p>
									<p>
										전화번호<span class="text-danger upSpan" style="display: none;">*</span>
										<input type="tel" class="form-control phone form"
											id="modalSendTel1" name="sendTel" placeholder="휴대폰 번호"
											disabled readonly />
									</p>
									<h2>받는 분</h2>
									<hr>
									<p>
										이름<span class="text-danger upSpan" style="display: none;">*</span>
										<input type="text" class="form-control form" id="modalReName1"
											name="reName" disabled readonly>
									</p>
									<p>
										전화번호<span class="text-danger upSpan" style="display: none;">*</span>
										<input type="tel" class="form-control phone form"
											id="modalReTel1" name="reTel" placeholder="휴대폰 번호" disabled
											readonly />

									</p>
									<p>
										주소<span class="text-danger upSpan" style="display: none;">*</span>
										<button type="button" id="btnPost1" class="form-ad" disabled>주소
											검색</button>
										<input type="text" class="form-control" id="modalPost1"
											name="rePost" required placeholder="우편번호" disabled readonly>
									</p>
									<p>
										<input type="text" class="form-control form"
											id="modalAddress1" name="reAddress" required placeholder="주소"
											disabled readonly>
									</p>
									<p>
										<input type="text" class="form-control form"
											id="modalDeAddress1" name="reDeAddress" required
											placeholder="상세주소" disabled readonly>
									</p>
								</div>

								<div class="col-md-4">
									<h2>상품 정보</h2>
									<hr>
									<p>
										운송 품목(규격) <input type="text" class="form-control"
											id="modalPckItem" name="pckItem" disabled readonly>
									</p>
									<p>
										무게
										<input type="text" class="form-control" id="modalWeigh"
											name="weigh" disabled readonly>
									</p>
									<p>
										금액
										<input type="text" class="form-control" id="modalPrice"
											name="price" disabled readonly>
									</p>
									<p>
										수량
										<input type="text" class="form-control" id="modalPckQty"
											name="pckQty" value="" disabled readonly>
									</p>
									<p>
										총액
										<input type="text" class="form-control" id="modalPckTotal"
											name="pckTotal" value="" disabled readonly>
									</p>
									<p id="back" style="display: none;">
										반려 사유
										<textarea class="form-control form" id="modalBackComment"
											name="backComment" style="resize: none" disabled readonly></textarea>
									</p>
								</div>
								<div class="col-md-4">
									<h2>신청 정보</h2>
									<hr>
									<p>
										택배사<input type="text" class="form-control" id="modalCcpyCode"
											name="ccpyCode" value="" disabled readonly>
									</p>
									<p>
										희망일 <span class="text-danger upSpan" style="display: none;">*</span>
										<input type="text" class="form-control form" id="modalHopeDt1"
											name="hopeDt" value="" disabled readonly>
									</p>
									<p>
										신청일<input type="text" class="form-control" id="modalRegDt"
											name="regDt" value="" disabled readonly>
									</p>
									<p id="p3" style="display: none;">
										수거일<input type="text" class="form-control" id="modalPickUpDt"
											name="pickUpDt" value="" disabled readonly>
									</p>
									<p id="p4" style="display: none;">
										신청 철회일<input type="text" class="form-control"
											id="modalCancelTm" name="cancelTm" value="" disabled readonly>
									</p>
									<p id="p8" style="display: none;">
										반려일<input type="text" class="form-control" id="modalBackTm"
											name="backTm" value="" disabled readonly>
									</p>
									<p id="pImg2"></p>
									<p>
										첨부파일 <img id="modalAttach" alt="" src="">
									</p>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="hstack gap-2 justify-content-end">
									<!-- 일반모드  -->
									<p id="p6">
										<button type="button"
											class="btn btn-soft-success waves-effect waves-light material-shadow-none"
											id="edit">수정</button>
										<button type="button"
											class="btn btn-soft-danger waves-effect waves-light material-shadow-none"
											id="delUpdate">신청 취소</button>
										<button type="button"
											class="btn btn-soft-dark waves-effect waves-light material-shadow-none"
											data-bs-dismiss="modal" id="confirm">확인</button>
									</p>
									<!-- 수정모드  -->
									<p id="p7" style="display: none;">
										<button type="button"
											class="btn btn-soft-success waves-effect waves-light material-shadow-none"
											id="update">저장</button>
										<button type="button"
											class="btn btn-soft-danger waves-effect waves-light material-shadow-none"
											id="upCalcel">취소</button>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>

$(document).ready(function() {
    $('#deliListTable').DataTable({
        "paging": true,
        "ordering": true,
        "info": false,
        "lengthChange": false, // 항목 수 변경 옵션을 숨김
        "pageLength": 10, // 기본 페이지 길이를 10으로 설정
        "language": {
            "zeroRecords": "내역이 없습니다.",
            "search": "검색:",
            "paginate": {
                "next": "다음",
                "previous": "이전"
            },
        }
    });
});

//희망일 오늘 날짜 이전 선택 불가 
const today = new Date();
const year = today.getFullYear();
const month = ('0'+(today.getMonth()+1)).slice(-2);
const day = ('0'+today.getDate()).slice(-2);
const dateString = year + '-' + month+'-'+day;
console.log("dateString", dateString);
document.querySelector("#modalHopeDt").setAttribute("min",dateString);
document.querySelector("#modalHopeDt1").setAttribute("min",dateString);

// 이미지 미리보기 핸들러 함수
function handleImg(e){
	   let files = e.target.files;
	   let fileArr = Array.prototype.slice.call(files);
	   
	   fileArr.forEach(function(f){
	      if(!f.type.match("image.*")){
// 	         alert("이미지 확장자만 가능합니다.");
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
	      
	      $("#pImg").html("");
	      
	      reader.onload = function(e){
	         let img_html = "<img src=\"" + e.target.result + "\" style='width:50%;' />";
	         $("#pImg").append(img_html);
	      }
	      //f : 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화 함
	      reader.readAsDataURL(f);
	   });//end forEach
	}

$(function() {
	
	
	
	//다음 우편번호 검색(신청시)
	$("#btnPost").on("click",function(){
		new daum.Postcode({
			//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
			oncomplete:function(data){
				$("#modalPost").val(data.zonecode);
				$("#modalAddress").val(data.address);
				$("#modalDeAddress").val(data.buildingName);
				
			}
		}).open();
	});
	
	//다음 우편번호 검색(수정시)
	$("#btnPost1").on("click",function(){
		new daum.Postcode({
			//다음 창에서 검색이 완료되면 콜백함수에 의해 결과 데이터가 data 객체로 들어옴
			oncomplete:function(data){
				$("#modalPost1").val(data.zonecode);
				$("#modalAddress1").val(data.address);
				$("#modalDeAddress1").val(data.buildingName);
				
			}
		}).open();
	});
	
	
	//이미지 미리보기 시작.///////
	$("#uploadFile").on("change",handleImg);
	//이미지 미리보기 끝.///////
	
	// 상세 모달
	// 이벤트 위임을 사용하여 .tblRow 요소에 클릭 이벤트 할당
	$(document).on("click",".tblRow",function() {
		let pckSeq = $(this).data("pckSeq");
		console.log("pckSeq :", pckSeq);

		let data = {
			"pckSeq" : pckSeq
		};

		console.log("data : ", data);
		$.ajax({
			url : "/delivery/resDeliveryDetail",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data),
			type : "post",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			success : function(result) {
				console.log("result : ", result);
				
				if (result.cancelYn == 'Y') {// 신청 철회된 상태일때
					$("#delUpdate").hide();
					$("#edit").hide();
					$("#confirm").show();
					$("#p2").css("display", "block");
					$("#p4").css("display", "block");
					$("#modalDetail").modal("show");
				} else if (result.backYn == 'Y'){ // 반려된 상태일때
					$("#delUpdate").hide();
					$("#edit").hide();
					$("#confirm").show();
					$("#back").css("display", "block");
					$("#p8").css("display", "block");
					$("#p9").css("display", "block");
					$("#modalDetail").modal("show");
				} else if (result.pckStatus == 'N') { // 신청완료된 상태일때
					$("#edit").show();
					$("#delUpdate").show();
					$("#confirm").show();
					$("#modalDetail").modal("show");
				} else if (result.pckStatus == 'Y') {// 수거완료된 상태일때
					$("#delUpdate").hide();
					$("#edit").hide();
					$("#confirm").show();
					$("#p1").css("display", "block");
					$("#p3").css("display", "block");
					$("#modalDetail").modal("show");
				} 
				// 상세페이지- 금액, 총액  콤마 찍기
				let pPrice = result.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 원";
				let pTotal = result.pckTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + " 원";
				
				// 전화번화 하이픈 넣기
				let sTel = result.sendTel.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})(\d+)(\d{4})$/, "$1-$2-$3").replace("--", "-");
				console.log("sTel:", sTel);
				let rTel = result.reTel.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})(\d+)(\d{4})$/, "$1-$2-$3").replace("--", "-");
				console.log("sTel:", sTel);
				
				let kg = result.weigh + " kg"; 
				console.log("kgkgkgkgkg",kg);
				let qty = result.pckQty + " 개";
				
				$("#modalPckSeq").val(result.pckSeq);
				$("#modalPckItem").val(result.commDetailVOList[0].commDetCodeNm);
				$("#modalWeigh").val(kg);
				$("#modalPrice").val(pPrice);
				$("#modalPckQty").val(qty);
				$("#modalPckTotal").val(pTotal);
				$("#modalCcpyCode").val(result.commDetailVOList[1].ccpyName);
				$("#modalRegDt").val(result.regDt);
				$("#modalAttach").attr("src",'/upload'+result.attach);
				$("#modalCancelTm").val(result.cancelTm);
				$("#modalPickUpDt").val(result.pickUpDt);
	            $("#modalHopeDt1").val(result.hopeDt); 
	            $("#modalSendName1").val(result.sendName);
	            $("#modalSendTel1").val(sTel);
	            $("#modalReName1").val(result.reName);
	            $("#modalReTel1").val(rTel);
	            $("#modalPost1").val(result.rePost);
	            $("#modalAddress1").val(result.reAddress);
	            $("#modalDeAddress1").val(result.reDeAddress);
	            $("#modalBackComment").val(result.backComment);
	            $("#modalBackTm").val(result.backTm);
	            
	           
	            
	         // 수정 취소 클릭시
				$("#upCalcel").on("click",function(){
					 $("#p6").css("display","block");
					 $("#p7").css("display","none");
					 $("#p5").css("display","none");
		             $(".upSpan").css("display","none");
	                    
	                 //readonly 속성 추가
	                 $(".form").attr("readonly",true);
	                 $(".form-ad").attr("disabled",true);
	                 $(".form").attr("disabled",true);
	                 $("#modalPost1").attr("disabled",true);
	                 
	              // input 타입을 date로 변경
	                 $("#modalHopeDt1").attr("type", "text");
	                 
	                 $("#modalSendName1").val(result.sendName);
			         $("#modalSendTel1").val(result.sendTel);
			         $("#modalReName1").val(result.reName);
			         $("#modalReTel1").val(result.reTel);
			         $("#modalPost1").val(result.rePost);
			         $("#modalAddress1").val(result.reAddress);
			         $("#modalDeAddress1").val(result.reDeAddress);
			         $("#modalHopeDt1").val(result.hopeDt); 
			            
					
				});
	         
	         // 수정 x 클릭시
	         $("#close").on("click",function(){
	        	 $("#p6").css("display","block");
				 $("#p7").css("display","none");
				 $("#p5").css("display","none");
	             $(".upSpan").css("display","none");
                    
                 //readonly 속성 추가
                 $(".form").attr("readonly",true);
                 $(".form-ad").attr("disabled",true);
                 $(".form").attr("disabled",true);
                 $("#modalPost1").attr("disabled",true);
                 
              // input 타입을 date로 변경
                 $("#modalHopeDt1").attr("type", "text");
                 
                 $("#modalSendName1").val(result.sendName);
		         $("#modalSendTel1").val(result.sendTel);
		         $("#modalReName1").val(result.reName);
		         $("#modalReTel1").val(result.reTel);
		         $("#modalPost1").val(result.rePost);
		         $("#modalAddress1").val(result.reAddress);
		         $("#modalDeAddress1").val(result.reDeAddress);
		         $("#modalHopeDt1").val(result.hopeDt); 
	         });

			}
		});// 상세 아작 종료
			$("#p1").css("display", "none");
			$("#p2").css("display", "none");
			$("#p3").css("display", "none"); 
			$("#p4").css("display", "none");
			$("#back").css("display", "none");
			$("#p8").css("display", "none");
			$("#p9").css("display", "none");
		});

		// 상세- 수정버튼 클릭시
		$("#edit").on("click",function(){
			 $("#p6").css("display","none");
             $("#p7").css("display","block");
             $("#p5").css("display","block");
             $(".upSpan").css("display","block");
             
             // input 타입을 date로 변경
             $("#modalHopeDt1").attr("type", "date");
                
             //readonly 속성을 제거
             $(".form").removeAttr("readonly");
             $(".form").removeAttr("disabled");
             $(".form-ad").removeAttr("disabled");
             $("#modalPost1").removeAttr("disabled");
			
		});
		
		// modalSendTel 전화번호에 하이픈 생성
		$(document).on("keyup", "#modalSendTel1", function() {
			 let inputVal = $(this).val().replace(/[^0-9]/g, "");
			    if (inputVal.length > 11) {
			        inputVal = inputVal.slice(0, 11);
			    }
			    $(this).val(inputVal.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)([0-9]{4})$/, "$1-$2-$3").replace("--", "-"));
		});

		// modalReTel 전화번호에 하이픈 생성
		$(document).on("keyup", "#modalReTel1", function() {
			 let inputVal = $(this).val().replace(/[^0-9]/g, "");
			    if (inputVal.length > 11) {
			        inputVal = inputVal.slice(0, 11);
			    }
			    $(this).val(inputVal.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)([0-9]{4})$/, "$1-$2-$3").replace("--", "-"));
		});
		
		
		
		// 수정 확인 버튼 클릭시
		$("#update").on("click",function(){
			
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
			    		let pckSeq = $("#modalPckSeq").val(); // modalPckSeq에서 pckSeq 값 가져오기
						let sendName = $("#modalSendName1").val();
						let sendTel = $("#modalSendTel1").val().replace(/-/g, '');
						$("#modalSendTel1").val(sendTel);
						let reName = $("#modalReName1").val(); 
						let reTel = $("#modalReTel1").val().replace(/-/g, '');
						$("#modalReTel1").val(reTel);
						let rePost = $("#modalPost1").val(); 
						let reAddress = $("#modalAddress1").val();
						let reDeAddress = $("#modalDeAddress1").val();
						let hopeDt = $("#modalHopeDt1").val(); 
						console.log("update->pckSeq :", pckSeq);

				let data = {
					"pckSeq" : pckSeq,
					"sendName" : sendName,
					"sendTel" : sendTel,
					"reName" : reName,
					"reTel" : reTel,
					"rePost" : rePost,
					"reAddress" : reAddress,
					"reDeAddress" : reDeAddress,
					"hopeDt" : hopeDt
					
				}
				console.log("update -> data : ", data);

				$.ajax({
					url : "/delivery/resUpdate",
					contentType : "application/json;charset=utf-8",
					data : JSON.stringify(data),
					type : "post",
					dataType : "json",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}",
								"${_csrf.token}");
					},
					success : function(result) {
// 						alert("수정이 완료되었습니다.");
						
						 Swal.fire({
	  	                        icon: 'success',
	  	                        title: '<strong>택배 신청 내역 수정 완료!</strong>',
	  	                        showConfirmButton: false,
	  	                        timer: 1500,
	  	                        showCloseButton: false
	  	                    }).then(() => {
	  	                       // Swal.fire의 타이머가 끝난 후 호출됩니다.
	  	                       location.replace(location.href);
	  	                    });
  	   					
						
						
						 $("#p6").css("display","block");
						 $("#p7").css("display","none");
						 $("#p5").css("display","none");
			             $(".upSpan").css("display","none");
		                    
		                 //readonly 속성 추가
		                 $(".form").attr("readonly",true);
		                 $(".form-ad").attr("disabled",true);
		                 $(".form").attr("disabled",true);
		                 $("#modalPost1").attr("disabled",true);
		                 
		              // input 타입을 date로 변경
		                 $("#modalHopeDt1").attr("type", "text");
		                    
						
						$("#modalDetail").modal("hide");
						console.log("update-> result : ",result);
					}

				});// del 아작 종료
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
			
	// 신청 취소 클릭시
		$("#delUpdate").on("click",function() {
			
			 Swal.fire({
			        title: "정말 신청을 취소하시겠습니까?\n취소시 동일 건 재신청이 불가합니다.",
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
				let pckSeq = $("#modalPckSeq").val(); // modalPckSeq에서 pckSeq 값 가져오기
				console.log("delUpdate->pckSeq :", pckSeq);

				let data = {
					"pckSeq" : pckSeq
				}
				console.log("delUpdate -> data : ", data);

				$.ajax({
					url : "/delivery/resDelUpdate",
					contentType : "application/json;charset=utf-8",
					data : JSON.stringify(data),
					type : "post",
					dataType : "json",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}",
								"${_csrf.token}");
					},
					success : function(result) {
						
						 Swal.fire({
		                        title: '택배 신청이 철회되었습니다!',
		                        icon: 'success',
		                        showConfirmButton: false,
 	                        timer: 1500,
 	                        showCloseButton: false
		                    }).then(function() {
		                    	$('tr[data-pck-seq="'+ pckSeq + '"]').find('td:last').html('<span class="badge border text-white bg-dark-subtle" style="font-size: 16px; font-weight: bold;">신청 철회</span>');
								$("#modalDetail").modal("hide");
								console.log("delUpdate-> result : ",result);
		                    });
		                },
		                error: function() {
		                    Swal.fire({
		                        title: 'Error!',
		                        icon: 'error',
		                        confirmButtonClass: 'btn btn-primary w-xs mt-2',
		                        buttonsStyling: false
		                    });
		                }
		            }
				);
		        } else {
		            Swal.fire({
		                title: '신청이 유지됩니다.',
		                icon: 'error',
		                showConfirmButton: false,
                  timer: 1500,
                  showCloseButton: false
		            });
		        }
		    });
		});

	
// modalSendTel 전화번호에 하이픈 생성
$(document).on("keyup", "#modalSendTel", function() {
	 let inputVal = $(this).val().replace(/[^0-9]/g, "");
	    if (inputVal.length > 11) {
	        inputVal = inputVal.slice(0, 11);
	    }
	    $(this).val(inputVal.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)([0-9]{4})$/, "$1-$2-$3").replace("--", "-"));
});

// modalReTel 전화번호에 하이픈 생성
$(document).on("keyup", "#modalReTel", function() {
	 let inputVal = $(this).val().replace(/[^0-9]/g, "");
	    if (inputVal.length > 11) {
	        inputVal = inputVal.slice(0, 11);
	    }
	    $(this).val(inputVal.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)([0-9]{4})$/, "$1-$2-$3").replace("--", "-"));
});
	
// 자동 완성
$("#auto").on("click", function() {
    // 기존 내용 초기화
    $("#modalPckItem1").val("");
    $("#modalWeigh1").val("");
    $("#modalPrice1").val("");
    $("#modalPckQty1").val("");
    $("#modalCcpyCode1").val("");
    $("#modalHopeDt").val(""); // 날짜 초기화
    $("#modalSendName").val("");
    $("#modalSendTel").val("");
    $("#modalReName").val("");
    $("#modalReTel").val("");
    $("#modalPost").val("");
    $("#modalAddress").val("");
    $("#modalDeAddress").val("");
    $("#uploadFile").val(""); // 파일 업로드 필드 초기화

    // 기본 값 추가
    $("#modalSendName").val("차현수");
    $("#modalSendTel").val("010-7778-5789");
    $("#modalReName").val("김철수");
    $("#modalReTel").val("010-8765-4321");
    $("#modalPost").val("12345");
    $("#modalAddress").val("서울특별시 강남구 테헤란로 123");
    $("#modalDeAddress").val("12층 1201호");
    $("#modalPckItem1").val("package01");
    $("#modalWeigh1").val("2");
    $("#modalPrice1").val("5,000");
    $("#modalPckQty1").val("2");
    $("#modalTotal1").val("10,000");
    $("#modalCcpyCode1").val("CCPY00004");
    $("#modalHopeDt").val("2024-07-17");
    $("#uploadFile").val("");
});
	
	
	
	// 신청 등록
	$("#submit").on("click",function(){
		
		let data = $("#frm").serialize();
		let dataArray = $("#frm").serializeArray();
		
		console.log*("data : ",data);
		console.log*("dataArray : ",dataArray);
		
		let param = {};
		//map : key, value
		dataArray.map(function(data, index){
			//		key			value
			param[data.name] = data.value;
		});
		
		console.log("param : ",param);
		
		let pckSeq = $("#modalPckSeq1").val();
        let hopeDt = $("#modalHopeDt").val();
        let pckItem = $("#modalPckItem1").val();
        let weigh = $("#modalWeigh1").val();
        let price = parseInt($("#modalPrice1").val().replace(/,/g , '')); // 콤마로 string값인 price를 int형으로 변환
        $("#modalPrice1").val(price); // int로 변환한 price값을 넣어주기
        let pckQty = $("#modalPckQty1").val();
        let ccpyCode = $("#modalCcpyCode1").val();
        let pckTotal = price * parseInt(pckQty); 
        let sendName = $("#modalSendName").val();
        let sendTel = $('#modalSendTel').val().replace(/-/g, ''); // 하이픈 제거
        $("#modalSendTel").val(sendTel);
        let reName = $("#modalReName").val();
        let reTel = $('#modalReTel').val().replace(/-/g, '');
        $("#modalReTel").val(reTel);
        let rePost = $("#modalPost").val();
        let reAddress = $("#modalAddress").val();
        let reDeAddress = $("#modalDeAddress").val();
		
		let formData = new FormData($("#frm")[0]);
		  
	
		
		let inputFile = $("#uploadFile");
		let files = inputFile[0].files;
		  
		console.log("files.length : " + files.length);
		    
		for(let i=0;i<files.length;i++){//0,1,2
		    	formData.append("uploadFile",files[i]);
		 }
		
		$.ajax({
			url: "/delivery/create2",
	        type: "post",
	        data: formData,
	        processData: false,
	        contentType: false, // contentType을 false로 설정
	        dataType: "text",
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
			success: function(result){
				console.log("create ->result :",result)
				
				 Swal.fire({
                     icon: 'success',
                     title: '<strong>신청 완료!</strong>',
                     showConfirmButton: false,
                     timer: 1500,
                     showCloseButton: false
                 }).then(() => {
                    // Swal.fire의 타이머가 끝난 후 호출됩니다.
                    location.replace(location.href);
                 });
				
				$("#modalAdd").modal("hide");
				
					 // 신청이 성공하면 모달 내용 초기화
                    $("#frm")[0].reset();
                    $("#pImg").html("");
	            
	        },
	        error: function() {
	            alert("필수 기재 사항이 작성되지 않아 신청되지 않습니다.\n신청서를 다시 작성해주세요." );
	            $("#modalPckItem1").val("");
	            $("#modalWeigh1").val("");
	            $("#modalPrice1").val("");
	            $("#modalPckQty1").val("");
	            $("#modalCcpyCode1").val("");
	            $("#modalHopeDt").val(""); // 날짜 초기화
	            $("#modalSendName").val("");
	            $("#modalSendTel").val("");
	            $("#modalReName").val("");
	            $("#modalReTel").val("");
	            $("#modalPost").val("");
	            $("#modalAddress").val("");
	            $("#modalDeAddress").val("");
	            $("#uploadFile").val(""); // 파일 업로드 필드 초기화
	            // 이미지 미리보기 초기화
	            $("#pImg").html("");
	        }	
		});
})
	$("#cancle").on("click",function(){
		$("#modalPckItem1").val("");
        $("#modalWeigh1").val("");
        $("#modalPrice1").val("");
        $("#modalPckQty1").val("");
        $("#modalCcpyCode1").val("");
        $("#modalHopeDt").val(""); // 날짜 초기화
        $("#modalSendName").val("");
        $("#modalSendTel").val("");
        $("#modalReName").val("");
        $("#modalReTel").val("");
        $("#modalPost").val("");
        $("#modalAddress").val("");
        $("#modalDeAddress").val("");
        $("#uploadFile").val(""); // 파일 업로드 필드 초기화
        // 이미지 미리보기 초기화
        $("#pImg").html("");
		
	});

	// 신청 모달 x로 닫기
	$("#close2").on("click",function(){
		$("#modalPckItem1").val("");
        $("#modalWeigh1").val("");
        $("#modalPrice1").val("");
        $("#modalPckQty1").val("");
        $("#modalCcpyCode1").val("");
        $("#modalHopeDt").val(""); // 날짜 초기화
        $("#modalSendName").val("");
        $("#modalSendTel").val("");
        $("#modalReName").val("");
        $("#modalReTel").val("");
        $("#modalPost").val("");
        $("#modalAddress").val("");
        $("#modalDeAddress").val("");
        $("#uploadFile").val(""); // 파일 업로드 필드 초기화
        // 이미지 미리보기 초기화
        $("#pImg").html("");
		
	});
	
	// 신청 모달 닫기
	$("#close3").on("click",function(){
		$("#modalPckItem1").val("");
        $("#modalWeigh1").val("");
        $("#modalPrice1").val("");
        $("#modalPckQty1").val("");
        $("#modalCcpyCode1").val("");
        $("#modalHopeDt").val(""); // 날짜 초기화
        $("#modalSendName").val("");
        $("#modalSendTel").val("");
        $("#modalReName").val("");
        $("#modalReTel").val("");
        $("#modalPost").val("");
        $("#modalAddress").val("");
        $("#modalDeAddress").val("");
        $("#uploadFile").val(""); // 파일 업로드 필드 초기화
        // 이미지 미리보기 초기화
        $("#pImg").html("");
        
        $("#modalAdd").modal("hide");
		
	});
	
	
	// 등록 모달
	$("#addBtn").on("click", function() {
		
		// 운송 품목 및 택배사 데이터 가져오기
		$.ajax({
			url: "/delivery/getCommDetailVOAndCcpyVO",
			type: "get",
			dataType: "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			success: function(data) {
				console.log("addBtn-> data", data);
				// 운송 품목 데이터 채우기
				 let commDetailOptions = '<option value="" data-price="">선택하세요</option>';
				data.commDetailVOList.forEach(function(item) {
					console.log("Detail -> item",item);
					commDetailOptions += `<option value="\${item.commDetCode}" data-price="\${item.commDetCodeDscr}">\${item.commDetCodeNm}</option>`;
				});
				$("#modalPckItem1").html(commDetailOptions);

				// 택배사 데이터 채우기
				let ccpyOptions = '<option value="">선택하세요</option>';
				data.ccpyVOList.forEach(function(item) {
					console.log("ccpy -> item",item);
					ccpyOptions += `<option value="\${item.ccpyCode}">\${item.ccpyName}</option>`;
				});
				$("#modalCcpyCode1").html(ccpyOptions);

				// 선택된 운송 품목에 따라 가격 설정
				let selectedPrice = $("#modalPckItem1 option:selected").data("price");
				console.log("selectedPrice",selectedPrice);
//					let comPrice = selectedPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				$("#modalPrice1").val(selectedPrice);
				

				// 모달 표시
				$("#modalAdd").modal("show");
			},
			error: function() {
				Swal.fire({
	                title: '데이터를 불러오는 데 실패했습니다.',
	                icon: 'error',
	                showConfirmButton: false,
                 timer: 1500,
                 showCloseButton: false
	            });
			}
		});
		
		
	});


	// 운송 품목 변경 시 가격 업데이트
	$(document).on('change', '#modalPckItem1', function() {
		let selectedPrice = $("#modalPckItem1 option:selected").data("price");
		
		// 3자리마다 콤마 표시
		let selPrice = selectedPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		
		$("#modalPrice1").val(selPrice);
	});
	
	// 총 금액 계산 및 업데이트하는 함수
	function updateTotalAmount() {
		 let intPrice = parseInt($("#modalPrice1").val().replace(/,/g , '')) || 0; //  가격을 숫자로 변환, NaN이면 0으로 설정
		 let qty = parseInt($("#modalPckQty1").val()) || 0; // 수량을 숫자로 변환, NaN이면 0으로 설정
	    // 총 금액 계산
	    let total = intPrice * qty;

	    // 총 금액 포맷팅 (3자리마다 쉼표 표시)
	 	let comTotal = total.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

	    // 총 금액 필드 업데이트
	    $("#modalTotal1").val(comTotal);
	}

	$(document).ready(function() {
	    // 가격 필드 또는 수량 필드가 변경될 때 총 금액 계산
	    $("#modalPrice1, #modalPckQty1").on('input', function() {
	        updateTotalAmount();
	    });

	    // 모달이 처음으로 표시될 때 추가적인 계산 실행
	    $('#modalAdd').on('shown.bs.modal', function() {
	        updateTotalAmount();
	    });

	    // 초기화 시 총 금액 계산
	    updateTotalAmount();

	});

});

// 운송 품목에 따른 무게 제한
const weightSel = document.querySelector("#modalPckItem1");
function fWCheck(pThis){
	let opt = weightSel.options[weightSel.selectedIndex];
	console.log("weightSel:",weightSel);
	console.log("opt:",opt);
	
	let optStr = opt.innerHTML.match(/\/(.*)kg/);
	console.log("optStr:",optStr);
	
	let min = optStr[1].split("~")[0];
	let max = optStr[1].split("~")[1];
	
	console.log("min:",min,",max:", max);
	if(!((pThis.value >= min) && (pThis.value  <= max))){
        	 Swal.fire({
 	            title: '운송 품목에 따른 무게 범위가 맞지 않습니다.<br\>다시 한번 확인해주세요.',
 	            icon: 'warning',
 	            confirmButtonClass: 'btn btn-primary w-xs mt-2',
 	            buttonsStyling: false,
 	            showCloseButton: true
 	        }).then(function() {
 	        	pThis.focus(); // SweetAlert가 닫힌 후 포커스를 제목 입력 필드로 이동
 	        });
 	        return;
		
// 		alert("운송 품목에 따른 무게 범위가 맞지 않습니다.\n다시 한번 확인해주세요.");
	}
	
}

</script>
<script>// 결제창
$("#payBtn").on('click', async function(){
	
	let charge = $('#modalTotal1').val().replace(',', '');
	
	const response = await PortOne.requestPayment({
		// Store ID 설정
		storeId: "store-22c2becf-63f0-4f4d-98fb-6a665ab06ca7",
		// 채널 키 설정
		channelKey: "channel-key-23a08f82-f8a6-4029-86cd-befb632c7108",
		paymentId: crypto.randomUUID(),
		orderName: '택배 결제',
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