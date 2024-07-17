<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
   src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>

<style>
.right{
	text-align: right;	
}

.temp{
 	border-color: #effcf5;
	width: 200px;
	height: 30px;
	background-color: #effcf5;
	font-size: 20px;
}
</style>

<div style="display: none" id="roomCode"><sec:authentication property="principal.memberVO.roomCode" /></div>
<div style="display: none" id="memId"><sec:authentication property="principal.memberVO.memId" /></div>
<div style="display: none" id="memNm"><sec:authentication property="principal.memberVO.memNm" /></div>
<div style="display: none" id="memTelno"><sec:authentication property="principal.memberVO.memTelno" /></div>
<div style="display: none" id="memEmail"><sec:authentication property="principal.memberVO.memEmail" /></div>

<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="ri-file-edit-line"></i><strong> 퇴거신청 </strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">퇴거신청1</a></li>
						<li class="breadcrumb-item active">퇴거신청2</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="col-12">
	<div class="card">
		<div class="card-body">
			<div style="height: 350px; display: flex;">
				<img style="width: 100%; height: 100%;" src="/resources/images/퇴거.png">
				<div class="temp" style="margin-left: -1020px; margin-top: 170px;"><span><i class="bx bx-file"></i> 퇴거신청 접수</span></div>
				<div class="temp" style="margin-left: 55px; margin-top: 170px; text-align: center;"><span><i class="ri-checkbox-circle-line"></i> 관리자 승인</span></div>
				<div class="temp" style="margin-left: 70px; margin-top: 170px; text-align: center;"><span><i class="ri-money-dollar-box-line"></i> 관리비 중간정산</span></div>
				<div class="temp" style="margin-left: 70px; margin-top: 170px; text-align: center;"><span"><i class="bx bx-door-open"></i> 퇴거</span></div>
			</div>
		</div>
		<div class="card-body row">
			<div class="col-5">
				<form action="/moveout/insert" method="post">
					<input type="hidden" class="form-control" name="mvoSeq" value="" />
					<input type="hidden" class="form-control" name="memId" value="<sec:authentication property="principal.memberVO.memId" />" />
					<input type="hidden" class="form-control" name="roomCode" value="<sec:authentication property="principal.memberVO.roomCode" />" />
					<table style="margin-left: 60px; font-size: 16px;">
						<tr>
							<td>신청인</td>
							<td><input type="text" class="form-control" name="applicant" required/></td>
						</tr>
						<tr><td><br></td></tr>
						<tr>
							<td>연락처</td>
							<td><input type="text" class="form-control" name="applicantTelno" required/></td>
						</tr>
						<tr><td><br></td></tr>
						<tr>
							<td>퇴거예정날짜</td>
							<td><input type="date" class="form-control" name="estDt" required/></td>
						</tr>
						<tr><td><br></td></tr>
						<tr>
							<td>퇴거 방식</td>
							<td>
								<select class="form-control" name="method" required>
									<option value="">선택하세요</option>
									<option value="엘레베이터">엘레베이터</option>
									<option value="사다리차">사다리차</option>
								</select>
							</td>
						</tr>
						<tr><td><br></td></tr>
						<tr>
							<td colspan="2">
								<label for="agree">민원처리정보알림수신동의</label>
								<input type="checkbox" name="check" id="agree" required/>
								<p style="color: red;">※ 민원처리결과 알림메세지 발송에 대한 수신동의 입니다.</p>
							</td>
						</tr>
					</table>
					<div class="row">
						<div class="col-6"></div>
						<div class="col-6">
							<input type="button" class="btn btn-warning" id="delBtn" value="삭제" disabled>
							<input type="submit" class="btn btn-info" value="저장">
						</div>
					</div>
				<sec:csrfInput />
				</form>
			</div>
			<div class="col-7" style="min-height: 350px;">
				<div style="display: flex; justify-content: flex-start;">
					<h3>관리비 정산</h3>
					<span style="color: red;">&nbsp;&nbsp;&nbsp;&nbsp; ※ 저장 후 관리자가 승인하면 정산된 관리금이 출력됩니다.</span>
				</div>
				<table style="width: 800px; font-size: 16px;">
					<tr style="background-color: lightgreen">
						<td width="40%">&nbsp;&nbsp;당월 부과액</td>
						<td class="right" width="30%"><span id="totalCharge">0</span>원</td>
						<td width="30%"></td>
					</tr>
					<tr>
						<td width="40%">&nbsp;&nbsp;할인 총계</td>
						<td class="right" width="30%"><span id="discountCharge">0</span>원</td>
						<td width="30%"></td>
					</tr>
					<tr style="background-color: lightgreen">
						<td width="40%">&nbsp;&nbsp;미납액</td>
						<td class="right" width="30%"><span id="unpaiedCharge">0</span>원</td>
						<td width="30%"></td>
					</tr>
					<tr>
						<td width="40%">&nbsp;&nbsp;미납 연체료</td>
						<td class="right" width="30%"><span id="unpaiedFee">0</span>원</td>
						<td width="30%"></td>
					</tr>
					<tr style="background-color: lightgreen">
						<td width="40%">&nbsp;&nbsp;납기 내 금액</td>
						<td class="right" width="30%"><span id="dueDateFee">0</span>원</td>
						<td width="30%"></td>
					</tr>
					<tr>
						<td width="40%">&nbsp;&nbsp;납기 후 연체료</td>
						<td class="right" width="30%"><span id="lateFee">0</span>원</td>
						<td width="30%"></td>
					</tr>
					<tr style="background-color: lightgreen">
						<td width="40%">&nbsp;&nbsp;납기 후 금액</td>
						<td class="right" width="30%"><span id="afterAmount">0</span>원</td>
						<td width="30%"></td>
					</tr>
					<tr>
						<td width="40%">&nbsp;&nbsp;납부 기한</td>
						<td class="right" width="30%" id="dueDate">--</td>
						<td width="30%"></td>
					</tr>
				</table>
				<div style="display: flex; justify-content: flex-end; margin-right: 110px;">
					<button class="btn btn-outline-primary" id="btnPay" disabled>관리비 납부</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$('input[name="applicantTelno"]').on('keyup', function(){
	let length = $(this).val().length;
	if(length == 3){
		$(this).val($(this).val() + "-");
	}
	if(length == 8){
		$(this).val($(this).val() + "-");
	}
	console.log(length);
})

function getInfo(){
	$.ajax({
		url: "/moveout/getInfo",
		contentType: "application/json;charset=utf-8",
		type: "post", 
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
			console.log(result);
			$('input[name="mvoSeq"]').val(result.mvoSeq);
			$('input[name="applicant"]').val(result.applicant);
			$('input[name="applicantTelno"]').val(result.applicantTelno);
			$('input[name="estDt"]').val(result.estDt.replaceAll('/', '-'));
			$('option[value='+result.method+']').attr('selected', true);
			$('#delBtn').removeAttr('disabled');
	
			if(result.status == '정산금 미납'){
				$('#totalCharge').text(result.charge.toLocaleString('ko-KR'));
				$('#dueDateFee').text(result.charge.toLocaleString('ko-KR'));
				$('#lateFee').text(Math.round(result.charge*0.02).toLocaleString('ko-KR'));
				$('#afterAmount').text((result.charge + Math.round(result.charge*0.02)).toLocaleString('ko-KR'));
				$('#dueDate').text(result.estDt + ' 까지');
				
				$('input').attr('disabled', true);
				$('#delBtn').removeAttr('disabled');
				$('select').attr('disabled', true);
				$('#btnPay').removeAttr('disabled');
			}else if(result.status == '정산 완료'){
				$('#totalCharge').text(result.charge.toLocaleString('ko-KR'));
				$('#dueDateFee').text(result.charge.toLocaleString('ko-KR'));
				$('#lateFee').text(Math.round(result.charge*0.02).toLocaleString('ko-KR'));
				$('#afterAmount').text((result.charge + Math.round(result.charge*0.02)).toLocaleString('ko-KR'));
				$('#dueDate').text(result.estDt + ' 까지');
				
				$('input').attr('disabled', true);
				$('select').attr('disabled', true);
				$('#btnPay').text('정산 완료');
			}
		}
	})
}
getInfo();

$('#delBtn').on('click', function(){
	 Swal.fire({
	        title: "신청을 취소하시겠습니까?",
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
	    				mvoSeq: $('input[name="mvoSeq"]').val()
	    		};
	    		
	    		$.ajax({
	    			url: "/moveout/delete",
	    			contentType: "application/json;charset=utf-8",
	    			data: JSON.stringify(data),
	    			type: "post", 
	    			beforeSend:function(xhr){
	    				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	    			},
	    			success: function(result){
	    				console.log(result);
	    				Swal.fire({
	    	                icon: 'info',
	    	                title: '취소!',
	    	                text: '취소가 완료되었습니다.'
	    	            });
	    				location.reload();
	    			}
	    		});
	        } 
	    });
	
})

$("#btnPay").on('click', async function(){

	data = {
			mvoSeq: $('input[name="mvoSeq"]').val(),
			roomCode: $('#roomCode').text()
	}
	console.log(data);
	
	const response = await PortOne.requestPayment({
		// Store ID 설정
		storeId: "store-22c2becf-63f0-4f4d-98fb-6a665ab06ca7",
		// 채널 키 설정
		channelKey: "channel-key-23a08f82-f8a6-4029-86cd-befb632c7108",
// 		paymentId: $('#roomCode').text() + '_' + $('#ym').text(),
		paymentId: crypto.randomUUID(),
		orderName: '퇴거 관리비 정산',
		totalAmount: Number($('#totalCharge').text().replace(',', '')),
		currency: "CURRENCY_KRW",
		payMethod: "CARD",
		customer:{
			customerId: $('#memId').text(),
			fullName: $('#memNm').text(),
			phoneNumber: $('#memTelno').text(),
			email: $('#memEmail').text(),
		},
	});

	if (response.code != null) {
		return alert(response.message);
	}
	
	$.ajax({
		url: "/moveout/paySuccess",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post", 
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
			console.log(result);
			location.reload();
		}
	})
});

</script>