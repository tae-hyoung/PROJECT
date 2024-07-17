<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>



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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<style>
div.dataTables_wrapper div.dataTables_paginate ul.pagination {
	justify-content: left;
}

.form-control {
	width: 95%;
	font-size:15px;
}

img {
	width: 100%;
}

.card-title{
	font-weight:bold;
}
</style>


<div class="col-12">
	<div class="card">
		<div class="card-header">
			<h3 class="card-title" style="font-size: 40px;">택배 신청 내역</h3>
		</div>
		<div class="card-body" style="font-size: 16px;">
			<table id="deliListTable"
				class="display table table-bordered dt-responsive"
				style="width: 100%; text-align: center;">
				<thead 	style="font-size: 18px; background-color:#69bde729;">
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
				<tbody>
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
									<c:when test="${deliveryVO.backYn == 'Y'}">
										<span
											class="badge border border-danger text-danger">
											반려</span>
									</c:when>
									<c:when test="${deliveryVO.pckStatus == 'N'}">
										<span
											class="badge border border-warning text-warning">신청
											완료</span>
									</c:when>
									<c:when test="${deliveryVO.pckStatus == 'Y'}">
										<span
											class="badge border border-success text-success">수거
											완료</span>
									</c:when>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
<!-- 			<button type="button" id="addBtn" -->
<!-- 				class="btn btn-soft-success waves-effect waves-light material-shadow-none" -->
<!-- 				style="float: right;">신청</button> -->

			<!-- 상세 modals -->
			<div class="modal fade bd-example-modal-xl" id="modalDetail"
				tabindex="-1" aria-labelledby="exampleModalgridLabel"
				aria-modal="true">
				<div class="modal-dialog modal-xl">
					<div class="modal-content">
						<div class="modal-header">
							<h1 class="modal-title" id="modalDetailTitle" style="font-size: 40px;">택배 상세</h1>
							<hr>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close" id="close"></button>
						</div>
						<div class="modal-body" id="modalDetailBody" style="font-size: 16px;">
							<p id="p1" style="display: none;">
								<span class="text-danger" style="font-size: 19px;">※ 수거 완료되었습니다. 상세 내역만 확인 가능합니다. </span>
							</p>
							<p id="p2" style="display: none;">
								<span class="text-danger" style="font-size: 19px;">※ 반려 처리 되었습니다. 상세 내역만 확인 가능합니다.</span>
							</p>
							<p id="p5" style="display: none;">
								<span class="text-danger" style="font-size: 19px;">* 반려 시 반려 사유를 입력해주세요</span>
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
										이름<input type="text"
											class="form-control" id="modalSendName1" name="sendName"
											disabled readonly>
									</p>
									<p>
										전화번호<input type="text"
											class="form-control" id="modalSendTel1" name="sendTel"
											disabled readonly>
									</p>
									<p>
										주소
										<textarea class="form-control"
											id="modalSendAddr" name="sendAddress" style="resize:none" disabled readonly cols="15" rows="3"></textarea>
									</p>
									<h2>받는 분</h2>
									<hr>
									<p>
										이름<input type="text"
											class="form-control" id="modalReName1" name="reName"
											disabled readonly>
									</p>
									<p>
										전화번호<input type="text"
											class="form-control" id="modalReTel1" name="reTel"
											disabled readonly>
									</p>
									<p>
										주소
										<input type="text" class="form-control" id="modalPost1"
											name="rePost" disabled readonly>
									</p>
									<p>
										<input type="text" class="form-control"
											id="modalAddress1" name="reAddress" disabled readonly>
									</p>
									<p>
										<input type="text" class="form-control"
											id="modalDeAddress1" name="reDeAddress" disabled readonly>
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
										무게<input type="text" class="form-control" id="modalWeigh"
											name="weigh" disabled readonly>kg
									</p>
									<p>
										금액<input type="text" class="form-control" id="modalPrice"
											name="price" disabled readonly>원
									</p>
									<p>
										수량<input type="text" class="form-control" id="modalPckQty"
											name="pckQty" value="" disabled readonly>개
									</p>
									<p>
										총액<input type="text" class="form-control" id="modalPckTotal"
											name="pckTotal" value="" disabled readonly>
									</p>
									<p id="back">
										반려 사유<span class="text-danger" id="backSpan">*</span> 
										<textarea class="form-control form back-form" id="modalBackComment"
											name="backComment" style="resize:none" disabled readonly></textarea>
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
										희망일 <input type="date"
											class="form-control" id="modalHopeDt1" name="hopeDt"
											value="" disabled readonly>
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
										반려일<input type="text" class="form-control"
											id="modalBackTm" name="backTm" value="" disabled readonly>
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
											id="pickUp">수거 완료</button>
										<button type="button"
											class="btn btn-soft-danger waves-effect waves-light material-shadow-none"
											id="backUpdate">반려</button>
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
document.addEventListener('DOMContentLoaded', function() {
	let table = new DataTable('#deliListTable', {
	// 	        "ajax": 'assets/json/datatable.json'
	});
});

function handleImg(e){
	   let files = e.target.files;
	   let fileArr = Array.prototype.slice.call(files);
	   
	   fileArr.forEach(function(f){
	      if(!f.type.match("image.*")){
	         alert("이미지 확장자만 가능합니다.");
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
			url : "/delivery/partners/deliveryDetail",
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
				
				if (result.backYn == 'Y') {// 반려 처리된 상태일때
					$("#pickUp").hide();
					$("#backUpdate").hide();
					$("#backSpan").hide();
					$("#confirm").show();
					$("#back").show();
					$("#p2").css("display", "block");
					$("#p4").css("display", "block");
					$("#modalDetail").modal("show");
				} else if (result.pckStatus == 'N') { // 신청완료된 상태일때
					$("#backUpdate").show();
					$("#backSpan").hide();
					$("#pickUp").show();
					$("#back").show();
					$("#confirm").show();
					$("#modalDetail").modal("show");
				} else if (result.pckStatus == 'Y') {// 수거완료된 상태일때
					$("#pickUp").hide();
					$("#backUpdate").hide();
					$("#back").hide();
					$("#confirm").show();
					$("#p1").css("display", "block");
					$("#p3").css("display", "block");
					$("#modalDetail").modal("show");
				}
				
				// 상세페이지- 금액, 총액  콤마 찍기
				let pPrice = result.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				let pTotal = result.pckTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
				
				$("#modalPckSeq").val(result.pckSeq);
				$("#modalPckItem").val(result.commDetailVOList[0].commDetCodeNm);
				$("#modalWeigh").val(result.weigh);
				$("#modalPrice").val(pPrice);
				$("#modalPckQty").val(result.pckQty);
				$("#modalPckTotal").val(pTotal);
				$("#modalCcpyCode").val(result.commDetailVOList[1].ccpyName);
				$("#modalRegDt").val(result.regDt);
				$("#modalAttach").attr("src",'/upload'+result.attach);
				$("#modalCancelTm").val(result.cancelTm);
				$("#modalPickUpDt").val(result.pickUpDt);
	            $("#modalHopeDt1").val(result.hopeDt); 
	            $("#modalSendName1").val(result.sendName);
	            $("#modalSendTel1").val(result.sendTel);
	            $("#modalReName1").val(result.reName);
	            $("#modalReTel1").val(result.reTel);
	            $("#modalPost1").val(result.rePost);
	            $("#modalAddress1").val(result.reAddress);
	            $("#modalDeAddress1").val(result.reDeAddress);
	            $("#modalSendAddr").val(result.sendAddress);
	            $("#modalBackTm").val(result.backTm);
	            $("#modalBackComment").val(result.backComment);
	            
	           
	            
	         // 반려 사유 취소 클릭시
				$("#upCalcel").on("click",function(){
	                 $("#p6").css("display","block");
					 $("#p7").css("display","none");
					 $("#p5").css("display","none");
	                    
	                 //readonly 속성을 제거
	                 $(".form").attr("readonly",true);
	                 $(".back-form").attr("disabled",true);
	                 
	                 $("#modalBackComment").val(result.backComment);
			            
					
				});
	         
	         // 반려 사유 x 클릭시
	         $("#close").on("click",function(){
	        	 $("#p6").css("display","block");
				 $("#p7").css("display","none");
				 $("#p5").css("display","none");
                    
                 //readonly 속성을 제거
                 $(".form").attr("readonly",true);
                 $(".back-form").attr("disabled",true);
                 
                 $("#modalBackComment").val(result.backComment);

			  });
			}
		});// 상세 아작 종료
			$("#p1").css("display", "none");
			$("#p2").css("display", "none");
			$("#p3").css("display", "none");
			$("#p4").css("display", "none");
		});

		// 상세 반려버튼 클릭시
		$("#backUpdate").on("click",function(){
			 $("#p5").css("display","block");
			 $("#p6").css("display","none");
             $("#p7").css("display","block");
             $("#backSpan").show();
                
             //readonly 속성을 제거
             $(".form").removeAttr("readonly");
             $(".back-form").removeAttr("disabled");
			
		});
		
		
		// 반려 사유 - 저장 버튼 클릭시
		$("#update").on("click",function(){
			let pckSeq = $("#modalPckSeq").val(); // modalPckSeq에서 pckSeq 값 가져오기
			let backComment = $("#modalBackComment").val(); 
			
			console.log("backUdate->pckSeq :", pckSeq);
			
			
			let re = confirm("정말 반려 처리하시겠습니까? \n 반려시 수정이 불가능합니다. ");
			console.log("re :", re);
			if (re > 0) {

				let data = {
					"pckSeq" : pckSeq,
					"backComment" : backComment
				}
				console.log("backUdate -> data : ", data);

				$.ajax({
					url : "/delivery/partners/back",
					contentType : "application/json;charset=utf-8",
					data : JSON.stringify(data),
					type : "post",
					dataType : "json",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}",
								"${_csrf.token}");
					},
					success : function(result) {
						alert("반려 처리가 완료되었습니다.");
						$('tr[data-pck-seq="'+ pckSeq + '"]').find('td:last').html('<span class="badge border border-danger text-danger">반려</span>');
						
						 $("#p6").css("display","block");
						 $("#p7").css("display","none");
						 $("#p5").css("display","none");
						 
						$(".form").attr("readonly",true); 
						$(".back-form").attr("disabled",true);
						
						$("#modalDetail").modal("hide");
						console.log("update-> result : ",result);
					}

				});// del 아작 종료
			} else {
				alert("수정이 취소되었습니다.")
			}
		});
			
	// 수거 완료 클릭시
		$("#pickUp").on("click",function() {
			let pckSeq = $("#modalPckSeq").val(); // modalPckSeq에서 pckSeq 값 가져오기
			console.log("pickUp->pckSeq :", pckSeq);

			let re = confirm("수거 완료 하시겠습니까?");
			console.log("re :", re);
			if (re > 0) {

				let data = {
					"pckSeq" : pckSeq
				}
				console.log("pickUp -> data : ", data);

				$.ajax({
					url : "/delivery/partners/pickUp",
					contentType : "application/json;charset=utf-8",
					data : JSON.stringify(data),
					type : "post",
					dataType : "json",
					beforeSend : function(xhr) {
						xhr.setRequestHeader("${_csrf.headerName}",
								"${_csrf.token}");
					},
					success : function(result) {
						alert("수거 완료 처리 되었습니다.");
						
						// 현재 날짜와 시간을 YYYY-MM-DD HH24:MI:SS 형식으로 포맷팅
		                let now = new Date();
		                let formattedDateTime = now.getFullYear() + '/' +
		                    ('0' + (now.getMonth() + 1)).slice(-2) + '/' +
		                    ('0' + now.getDate()).slice(-2) + ' ' +
		                    ('0' + now.getHours()).slice(-2) + ':' +
		                    ('0' + now.getMinutes()).slice(-2) + ':' +
		                    ('0' + now.getSeconds()).slice(-2);

		                // pickUpDt 필드 업데이트
		                $('tr[data-pck-seq="'+ pckSeq + '"]').find('td:nth-child(6)').html(formattedDateTime);
						
						$('tr[data-pck-seq="'+ pckSeq + '"]').find('td:last').html('<span class="badge border border-success text-success">수거 완료</span>');
						$("#modalDetail").modal("hide");
						console.log("delUpdate-> result : ",result);
					}

				});// del 아작 종료
			} else {
				alert("그대로 신청 유지중입니다.")
			}
		});

});




</script>