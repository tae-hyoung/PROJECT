<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
   src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<div style="display: none" id="roooooom"><sec:authentication property="principal.memberVO.roomCode" /></div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
<style>
label{
  font-size: 1.5em;
}
input[type='checkbox']{
  margin-right: 20px;
}
.late{
	background-color: #ffbcbc;
}
table th{
	text-align: center;
}
.right{
	text-align: right;
}
.center{
	text-align: center;
}

table {
  caption-side: top;
}
</style>

<div class="card">
	<div class="card-body">
		<h1 class="text-muted">관리비 등록</h1>
		<form action="/charge/admin/insert?${_csrf.parameterName}=${_csrf.token}" method="POST" enctype="multipart/form-data">
			<input type="file" name="file"> 
			<input type="submit" value="등록">
		</form>
		<hr>
	</div>
	
	<div class="card-body">
		<div class="row" style="display: flex">
			<div class="col-7">
				<h1 class="text-muted">관리비 납부현황</h1>
			</div>
			<div class="input-group input-group-sm col-5" style="width: 600px;">
				<div>
					<label for="toggleNonPay" style="font-size: 1em;">미납자만 보기</label>
					<div class="form-check form-switch form-switch-xs" dir="ltr" style="margin-top: 5px; margin-top: -10px;">
						<c:if test="${articlePage.payYn eq true}">
							<input type="checkbox" class="form-check-input" id="toggleNonPay" checked>
						</c:if>
						<c:if test="${articlePage.payYn ne true}">
							<input type="checkbox" class="form-check-input" id="toggleNonPay">
						</c:if>
					</div>
				</div>
				<input type="text" name="table_search" id="chargeKeyword" class="form-control float-right" placeholder="Search" style="margin-left: 40px;">
				<div class="input-group-append">
					<button type="button" class="btn btn-default" id="chargeSearch" style="font-size: 20px;"><i class="bx bx-search-alt-2"></i></button>
				</div>
			</div>
		</div>
		<table class="table table-striped" id="chargeTbl">
			<thead>
				<tr>
					<th width="11%">년</th>
					<th width="11%">월</th>
					<th width="11%">동</th>
					<th width="11%">호</th>
					<th width="8%">관리비</th>
					<th width="10%">납부여부</th>
					<th width="24%">납부일시</th>
					<th width="8%">연체료</th>
					<th width="5%"></th>
				</tr>
			</thead>
			<tbody id="tbdy">
				<c:forEach var="chargeVO" items="${articlePage.content}" varStatus="stat">
					<tr class="trs">
						<td width="11%" class="center">${fn:substring(chargeVO.ym, 0, 4)}</td>
						<td width="11%" class="center">${fn:substring(chargeVO.ym, 5, 7)}</td>
						<td width="11%" class="center">${fn:substring(chargeVO.roomCode, 5, 8)}</td>
						<td width="11%" class="center">${fn:substring(chargeVO.roomCode, 9, 12)}</td>
						<td width="8%" class='right'><span id="${chargeVO.roomCode}_${chargeVO.ym}"><fmt:formatNumber value="${chargeVO.totalCharge}" pattern="#,###" /></span>원</td>
						<td width="11%" class="center">${chargeVO.payYn}</td>
						<td width="24%" class="center">${chargeVO.payDt}</td>
						<td width="8%" class='right'><span><fmt:formatNumber value="${chargeVO.lateCt}" pattern="#,###" /></span>원</td>
						<td width="5%"><span class="badge badge-label bg-info updCharge" data-bs-toggle="modal" data-bs-target="#updChargeModal">수정</span></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="row">
			<div class="col-5"></div>	
	        <div class="col-4 clsPagingArea" style="float: left">${articlePage.pagingArea}</div>
			<div class="col-3 row">
				<div class="col-4"></div>
				<div class="col-4">
					<input type="button" id="lateProcBtn" class="btn btn-danger" style="margin-top: 10px;" value="일괄 연체" disabled />
				</div>
				<div class="col-4">
					<a class="btn btn-info" data-bs-toggle="modal" data-bs-target="#chartModal" style="margin-top: 10px;">통계보기</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 통계 모달 시작 -->
	<div id="chartModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	    <div class="modal-dialog modal-xl">
	        <div class="modal-content">
	        	<div class="modal-header">
	        		<h1>통계</h1>
	        	</div>
	        	<div class="modal-body">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs nav-justified mb-3" role="tablist">
						<li class="nav-item" role="presentation">
							<a class="nav-link active" data-bs-toggle="tab" href="#ymDiv" role="tab" aria-selected="false" tabindex="-1"> 월별 통계 </a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" data-bs-toggle="tab" href="#dongDiv" role="tab" aria-selected="false" tabindex="-1"> 동별 통계 </a>
						</li>
					</ul>
					
					<!-- Tab panes -->
					<div class="tab-content  text-muted" style="min-height: 500px;">
						<div class="tab-pane active show" id="ymDiv" role="tabpanel">
							<div>
								<div style="width: 1000px; display: flex; justify-content: center;">
									<h4>
										<a role="button" id="lastYear">-</a>
										<span id="year">2024</span>년
										<a role="button" id="postYear">+</a>
									</h4>
								</div>
								<canvas id="barYm" style="width: 1000px;"></canvas>
							</div>
						</div>
						
						<div class="tab-pane" id="dongDiv" role="tabpanel">
							<div>
								<canvas id="barDong" style="width: 1000px;"></canvas>
							</div>
						</div>
					</div>
	        	</div>
			</div>
		</div>
	</div>
	<!-- 통계 모달 끝 -->
	
	<!-- 수정 모달 시작 -->
	<div id="updChargeModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	    <div class="modal-dialog modal-xl">
	        <div class="modal-content">
	        	<div class="modal-header">
	        		<h1>
		        		<span id="yearModal"></span>년&nbsp;
		        		<span id="monthModal"></span>월&nbsp;&nbsp;&nbsp;&nbsp;
		        		<span id="dongModal"></span>동&nbsp;
		        		<span id="roomModal"></span>호&nbsp;&nbsp;&nbsp;&nbsp;관리비&nbsp;상세
	        		</h1>
	        	</div>
	        	<div class="modal-body">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs nav-justified mb-3" role="tablist">
						<li class="nav-item" role="presentation">
							<a class="nav-link active" data-bs-toggle="tab" href="#individual" role="tab" aria-selected="false" tabindex="-1"> 전기, 수도, 난방 </a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" data-bs-toggle="tab" href="#common1" role="tab" aria-selected="false" tabindex="-1"> 일반, 청소 </a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" data-bs-toggle="tab" href="#common2" role="tab" aria-selected="false" tabindex="-1"> 소독, 경비, 승강기, 장기수선충당금, 시설 </a>
						</li>
						<li class="nav-item" role="presentation">
							<a class="nav-link" data-bs-toggle="tab" href="#common3" role="tab" aria-selected="false" tabindex="-1"> 부가세, 위탁관리, 회의운영, 건물보험 </a>
						</li>
					</ul>
					
					<!-- Tab panes -->
					<div class="tab-content  text-muted" style="min-height: 500px;">
						<div class="tab-pane active show" id="individual" role="tabpanel">
							<table style="width: 1000px">
								<caption>전기료</caption>
								<tr>
									<td width="20%"><label for="idvElecUsage">개별사용량</label></td>
									<td width="30%"><input type="number" id="idvElecUsage" name="idvElecUsage" value=""></td>
									<td width="20%"><label for="idvElecPrice">단가</label></td>
									<td width="30%"><input type="number" id="idvElecPrice" name="idvElecPrice" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="shElecUsage">공용사용량</label></td>
									<td width="30%"><input type="number" id="shElecUsage" name="shElecUsage" value=""></td>
									<td width="20%"><label for="shElecPrice">단가</label></td>
									<td width="30%"><input type="number" id="shElecPrice" name="shElecPrice" value=""></td>
								</tr>
							</table>
							<table style="width: 1000px">
								<caption>수도료</caption>
								<tr>
									<td width="20%"><label for="dvWaterUsage">개별사용량</label></td>
									<td width="30%"><input type="number" id="idvWaterUsage" name="idvWaterUsage" value=""></td>
									<td width="20%"><label for="iidvWaterPrice">단가</label></td>
									<td width="30%"><input type="number" id="idvWaterPrice" name="idvWaterPrice" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="shWaterUsage">공용사용량</label></td>
									<td width="30%"><input type="number" id="shWaterUsage" name="shWaterUsage" value=""></td>
									<td width="20%"><label for="shWaterPrice">단가</label></td>
									<td width="30%"><input type="number" id="shWaterPrice" name="shWaterPrice" value=""></td>
								</tr>
							</table>
							<table style="width: 1000px">
								<caption>난방료</caption>
								<tr>
									<td width="20%"><label for="idvHeatingUsage">개별사용량</label></td>
									<td width="30%"><input type="number" id="idvHeatingUsage" name="idvHeatingUsage" value=""></td>
									<td width="20%"><label for="idvHeatingPrice">단가</label></td>
									<td width="30%"><input type="number" id="idvHeatingPrice" name="idvHeatingPrice" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="shHeatingUsage">공용사용량</label></td>
									<td width="30%"><input type="number" id="shHeatingUsage" name="shHeatingUsage" value=""></td>
									<td width="20%"><label for="shHeatingPrice">단가</label></td>
									<td width="30%"><input type="number" id="shHeatingPrice" name="shHeatingPrice" value=""></td>
								</tr>
							</table>
						</div>
						<div class="tab-pane" id="common1" role="tabpanel">
							<table style="width: 1000px">
								<caption>일반관리비</caption>
								<tr>
									<td width="20%"><label for="salary">급여</label></td>
									<td width="30%"><input type="number" id="salary" name="salary" value=""></td>
									<td width="20%"><label for="allowance">제수당</label></td>
									<td width="30%"><input type="number" id="allowance" name="allowance" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="bonus">상여금</label></td>
									<td width="30%"><input type="number" id="bonus" name="bonus" value=""></td>
									<td width="20%"><label for="rtrPay">퇴직금</label></td>
									<td width="30%"><input type="number" id="rtrPay" name="rtrPay" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="iacIns">산재보험료</label></td>
									<td width="30%"><input type="number" id="iacIns" name="iacIns" value=""></td>
									<td width="20%"><label for="empIns">고용보험료</label></td>
									<td width="30%"><input type="number" id="empIns" name="empIns" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="npn">국민연금</label></td>
									<td width="30%"><input type="number" id="npn" name="npn" value=""></td>
									<td width="20%"><label for="hlthIns">건강보험료</label></td>
									<td width="30%"><input type="number" id="hlthIns" name="hlthIns" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="benefits">식대등복리후생비</label></td>
									<td width="30%"><input type="number" id="benefits" name="benefits" value=""></td>
									<td width="20%"><label for="oprodCt">일반사무용품구입비</label></td>
									<td width="30%"><input type="number" id="oprodCt" name="oprodCt" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="printCt">도서인쇄비</label></td>
									<td width="30%"><input type="number" id="printCt" name="printCt" value=""></td>
									<td width="20%"><label for="tsptCt">여비교통비</label></td>
									<td width="30%"><input type="number" id="tsptCt" name="tsptCt" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="commCt">통신료</label></td>
									<td width="30%"><input type="number" id="commCt" name="commCt" value=""></td>
									<td width="20%"><label for="postCt">우편료</label></td>
									<td width="30%"><input type="number" id="postCt" name="postCt" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="cprodCt">관리용품구입비</label></td>
									<td width="30%"><input type="number" id="cprodCt" name="cprodCt" value=""></td>
									<td width="20%"><label for="etcCt">잡비</label></td>
									<td width="30%"><input type="number" id="etcCt" name="etcCt" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="facCt">커뮤니티운영비</label></td>
									<td width="30%"><input type="number" id="facCt" name="facCt" value=""></td>
									<td width="20%"><label for="commonsOtherCt">기타</label></td>
									<td width="30%"><input type="number" id="commonsOtherCt" name="commonsOtherCt" value=""></td>
								</tr>
							</table>
							<table style="width: 1000px">
								<caption>청소비</caption>
								<tr>
									<td width="20%"><label for="clnSvcCt">청소용역비</label></td>
									<td width="30%"><input type="number" id="clnSvcCt" name="clnSvcCt" value=""></td>
									<td width="20%"><label for="expendableCt">규격봉투외소모품</label></td>
									<td width="30%"><input type="number" id="expendableCt" name="expendableCt" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="wasteCt">공용생활폐기물처리비</label></td>
									<td width="30%"><input type="number" id="wasteCt" name="wasteCt" value=""></td>
									<td width="20%"><label for="cleaningOtherCt">기타</label></td>
									<td width="30%"><input type="number" id="cleaningOtherCt" name="cleaningOtherCt" value=""></td>
								</tr>
							</table>
						</div>
						<div class="tab-pane" id="common2" role="tabpanel">
							<table style="width: 1000px">
								<caption>소독비</caption>
								<tr>
									<td width="20%"><label for="disinfecCt">소독비</label></td>
									<td width="30%"><input type="number" id="disinfecCt" name="disinfecCt" value=""></td>
									<td width="20%"><label for="disinfecOtherCt">기타</label></td>
									<td width="30%"><input type="number" id="disinfecOtherCt" name="disinfecOtherCt" value=""></td>
								</tr>
							</table>
							<table style="width: 1000px">
								<caption>경비비</caption>
								<tr>
									<td width="20%"><label for="secCt">경비비</label></td>
									<td width="30%"><input type="number" id="secCt" name="secCt" value=""></td>
									<td width="20%"><label for="secOtherCt">기타</label></td>
									<td width="30%"><input type="number" id="secOtherCt" name="secOtherCt" value=""></td>
								</tr>
							</table>
							<table style="width: 1000px">
								<caption>승강기유지비</caption>
								<tr>
									<td width="20%"><label for="evtMgmtCt">유지보수비</label></td>
									<td width="30%"><input type="number" id="evtMgmtCt" name="evtMgmtCt" value=""></td>
									<td width="20%"><label for="evtInspCt">검사비</label></td>
									<td width="30%"><input type="number" id="evtInspCt" name="evtInspCt" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="evtExpendableCt">소모품교체비</label></td>
									<td width="30%"><input type="number" id="evtExpendableCt" name="evtExpendableCt" value=""></td>
									<td width="20%"><label for="evtOtherCt">기타</label></td>
									<td width="30%"><input type="number" id="evtOtherCt" name="evtOtherCt" value=""></td>
								</tr>
							</table>
							<table style="width: 1000px">
								<caption>장기수선충당금</caption>
								<tr>
									<td width="20%"><label for="ltrrCt">장기수선충당금</label></td>
									<td width="30%"><input type="number" id="ltrrCt" name="" value="ltrrCt"></td>
									<td width="20%"><label for="ltrrOtherCt">기타</label></td>
									<td width="30%"><input type="number" id="ltrrOtherCt" name="ltrrOtherCt" value=""></td>
								</tr>
							</table>
							<table style="width: 1000px">
								<caption>시설유지비</caption>
								<tr>
									<td width="20%"><label for="facilityMgmtCt">시설유지비</label></td>
									<td width="30%"><input type="number" id="facilityMgmtCt" name="facilityMgmtCt" value=""></td>
									<td width="20%"><label for="facilityChkCt">안전점검비</label></td>
									<td width="30%"><input type="number" id="facilityChkCt" name="facilityChkCt" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="preventCt">재해예방비</label></td>
									<td width="30%"><input type="number" id="preventCt" name="preventCt" value=""></td>
									<td width="20%"><label for="facilitiesOtherCt">기타</label></td>
									<td width="30%"><input type="number" id="facilitiesOtherCt" name="facilitiesOtherCt" value=""></td>
								</tr>
							</table>
						</div>
						<div class="tab-pane" id="common3" role="tabpanel">
							<table style="width: 1000px">
								<caption>부가세</caption>
								<tr>
									<td width="20%"><label for="msvcCt">관리용역비</label></td>
									<td width="30%"><input type="number" id="msvcCt" name="" value="msvcCt"></td>
									<td width="20%"><label for="csvcCt">청소용역비</label></td>
									<td width="30%"><input type="number" id="csvcCt" name="csvcCt" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="ssvcCt">보안용역비</label></td>
									<td width="30%"><input type="number" id="ssvcCt" name="ssvcCt" value=""></td>
									<td width="20%"><label for="vatOtherCt">기타</label></td>
									<td width="30%"><input type="number" id="vatOtherCt" name="vatOtherCt" value=""></td>
								</tr>
							</table>
							<table style="width: 1000px">
								<caption>위탁관리수수료</caption>
								<tr>
									<td width="20%"><label for="consignmentCt">위탁관리수수료</label></td>
									<td width="30%"><input type="number" id="consignmentCt" name="consignmentCt" value=""></td>
									<td width="20%"><label for="consignmentOtherCt">기타</label></td>
									<td width="30%"><input type="number" id="consignmentOtherCt" name="consignmentOtherCt" value=""></td>
								</tr>
							</table>
							<table style="width: 1000px">
								<caption>대표회의운영비</caption>
								<tr>
									<td width="20%"><label for="cbCt">회장업무추진비</label></td>
									<td width="30%"><input type="number" id="cbCt" name="cbCt" value=""></td>
									<td width="20%"><label for="abCt">감사업무추진비</label></td>
									<td width="30%"><input type="number" id="abCt" name="abCt" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="attdcCt">출석수당</label></td>
									<td width="30%"><input type="number" id="attdcCt" name="attdcCt" value=""></td>
									<td width="20%"><label for="operationCt">운영비</label></td>
									<td width="30%"><input type="number" id="operationCt" name="operationCt" value=""></td>
								</tr>
								<tr>
									<td width="20%"><label for="meetingOtherCt">기타</label></td>
									<td width="30%"><input type="number" id="meetingOtherCt" name="meetingOtherCt" value=""></td>
									<td width="20%"></td>
									<td width="30%"></td>
								</tr>
							</table>
							<table style="width: 1000px">
								<caption>건물보험료</caption>
								<tr>
									<td width="20%"><label for="buildingInsr">건물보험료</label></td>
									<td width="30%"><input type="number" id="buildingInsr" name="buildingInsr" value=""></td>
									<td width="20%"></td>
									<td width="30%"></td>
								</tr>
							</table>
						</div>
					</div>
					
					<div style="display: flex; justify-content: flex-end;">
						<span class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#updChargeModal">취소</span>
						<span class="btn btn-info" id="updBtn">수정</span>
					</div>
	        	</div>
			</div>
		</div>
	</div>
	<!-- 수정 모달 끝 -->
</div>

<script>
let avgYm;
let avgDong;
let dongList = [];
$(function(){
	const barYm = document.querySelector('#barYm');
	const barDong = document.querySelector('#barDong');
	
	$.ajax({
		url: "/charge/getAvgs",
		contentType: "application/json;charset=utf-8",
		type: "post", 
		dataType: "json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
			avgYm = result[0];
// 			console.log(avgYm);
			newBarYm();
			
			avgDong = result[1];
// 			console.log(avgDong);
			newBarDong();
		}
	});
	

	$.ajax({
		url: "/charge/getDongList",
		contentType: "application/json;charset=utf-8",
		type: "post", 
		dataType: "json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
// 			console.log(result);
			$.each(result, function(idx, dong){
				dongList.push(dong.substr(5, 3) + '동');
			})
// 			console.log("dongList: ", dongList);
		}
	});
	
	payUpdate();
		
});

function payUpdate(){
	let trs = $('.trs');
	for(let i=0; i<trs.length; i++){
		if(trs.eq(i).children().eq(5).text() == 'Y'){
			trs.eq(i).removeClass('late');
			trs.eq(i).children().eq(8).children().eq(0).removeAttr('data-bs-toggle');
			trs.eq(i).children().eq(8).children().eq(0).removeAttr('data-bs-target');
			trs.eq(i).children().eq(8).children().eq(0).css('color', 'lightgray');
		}
	}
}

/* barYm */
$('#lastYear').on('click', function() {
	let year = Number($('#year').text());
	year -= 1;
	$('#year').text(year);

	newBarYm();
})

$('#postYear').on('click', function() {
	let year = Number($('#year').text());
	year += 1;
	$('#year').text(year);

	newBarYm();
})

function getbarYmData(avgYm){
	let datasets = [];
	let year = $('#year').text();
	
	$.each(avgYm, function(idx){
		if(avgYm[idx].YM.startsWith(year)){
			datasets.push(Number(avgYm[idx].AVG_YM));
		}
	});
// 	console.log("datasets: ", datasets);
	return datasets;
}

function newBarYm(){
	let chartStatus = Chart.getChart('barYm');
	if (chartStatus === undefined) {
		new Chart(barYm, {
		    type: 'bar',
		    data: {
		    	labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    	datasets: [{
		    		label: '월별 평균값',
		    		data: getbarYmData(avgYm),
		    	}],
		    },
		    options: {
				responsive: false,
		    }
		});
	}else{
		chartStatus.data.labels = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
		chartStatus.data.datasets[0].data = getbarYmData(avgYm);
		chartStatus.update();
	}
}
/* barYm */


/* barDong */

function getbarDongData(avgDong){
	let datasets = [];
	
// 	console.log("언제실행됨?", avgDong);
	// 동리스트를 받아오고 avgDong.DONG_CODE와 같은 경우 datasets에 추가
	$.each(avgDong, function(idx){
		datasets.push(Number(avgDong[idx].AVG_DONG));
	});
	
// 	console.log("datasets: ", datasets);
	return datasets;
}

function newBarDong(){
	let chartStatus = Chart.getChart('barDong');
	if (chartStatus === undefined) {
		new Chart(barDong, {
		    type: 'bar',
		    data: {
		    	labels: dongList,
		    	datasets: [{
		    		label: '동별 평균값',
		    		data: getbarDongData(avgDong),
		    	}],
		    },
		    options: {
				responsive: false,
		    }
		});
	}else{
		chartStatus.data.labels = dongList,
		chartStatus.data.datasets[0].data = getbarDongData(avgDong);
		chartStatus.update();
	}
}
/* barDong */

$('#toggleNonPay').on('change', function(){
	let payYn = $('#toggleNonPay')[0].checked;
// 	console.log("payYn: ", payYn);
	getList('', 1, payYn);
});

$('#chargeSearch').on('click', function(){
		let keyword = $("#chargeKeyword").val();
		let payYn = $('#toggleNonPay')[0].checked;
		getList(keyword, 1, payYn);
});

function getList(keyword, currentPage, payYn){
	let data = {
		"payYn": payYn,
		"keyword": keyword,
		"currentPage": currentPage
	};
	
	$.ajax({
		url:"/charge/list",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
// 			console.log("result : ", result);

			let str = "";
			$.each(result.content, function(idx,chargeVO){
				if(chargeVO.payYn == 'N' && chargeVO.lateCt > 0){
					str += "<tr class='trs late'>";
				}else{
					str += "<tr class='trs'>";
				}
				str += "<td width='11%' class='center'>"+ chargeVO.ym.substr(0, 4) +"</td>";
				str += "<td width='11%' class='center'>"+ chargeVO.ym.substr(5, 2) +"</td>";
				str += "<td width='11%' class='center'>"+ chargeVO.roomCode.substr(5, 3) +"</td>";
				str += "<td width='11%' class='center'>"+ chargeVO.roomCode.substr(9, 3) +"</td>";
				str += "<td width='8%' class='right'><span>"+ chargeVO.totalCharge.toLocaleString('ko-KR') +"</span>원</td>";
				str += "<td width='11%' class='center'>"+ chargeVO.payYn +"</td>";
				str += "<td width='24%' class='center'>";
				if(chargeVO.payDt != null){
					str += chargeVO.payDt;
				}
				str += "</td>";
				str += "<td width='8%' class='right'><span>"+ chargeVO.lateCt.toLocaleString('ko-KR') +"</span>원</td>";
				str += "<td width='5%'><span class='badge badge-label bg-info updCharge' data-bs-toggle='modal' data-bs-target='#updChargeModal'>수정</span></td>";
				str += "</tr>";
			});
			
			$(".clsPagingArea").html(result.pagingArea);
			$("#tbdy").html(str);
			payUpdate();
		}
	});
}

function chkLate(){
	let trs = $('.trs')
	for(let i=0; i<trs.length; i++){
		let me = trs.eq(i);
		let payYn = me.children().eq(5).text();
		let lateCt = me.children().eq(7).children().eq(0).text();
		
		if(payYn == 'N' && lateCt != 0){
			me.addClass('late');
		}
// 		console.log("lateCt: ", lateCt);
	}
}
chkLate();


/* 연체 처리 로직 */
let date = new Date();
if(date.getDate() >= 22){
	$('#lateProcBtn').removeAttr('disabled');
}

$('#lateProcBtn').on('click', function(){
	$.ajax({
		url:"/charge/lateProc",
		contentType:"application/json;charset=utf-8",
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
// 			console.log(result);
			if(result == 0){
	            Swal.fire({
	                icon: 'error',
	                title: '에러!',
	                text: '이번달은 이미 연체료를 부과하였습니다.'
	            });
			}
			getList('', 1, false);
		}
	});
})

/* 관리비 수정 */
$(document).on('click', ".updCharge", function(){
	let year = $(this).parent().parent().children().eq(0).text();
	let month = $(this).parent().parent().children().eq(1).text();
	let dong = $(this).parent().parent().children().eq(2).text();
	let room = $(this).parent().parent().children().eq(3).text();
	
	$('#yearModal').text(year);
	$('#monthModal').text(month);
	$('#dongModal').text(dong);
	$('#roomModal').text(room);
	
	data = {
			year: year,
			month: month,
			dong: dong,
			room: room 
	};
	
	$.ajax({
		url:"/charge/admin/getInfo",
		contentType:"application/json;charset=utf-8",
		data: JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
// 			console.log(result);
			
			$('#idvElecUsage').val(result.idvElecUsage);
			$('#idvElecPrice').val(result.idvElecPrice);
			$('#shElecUsage').val(result.shElecUsage);
			$('#shElecPrice').val(result.shElecPrice);
			$('#idvWaterUsage').val(result.idvWaterUsage);
			$('#idvWaterPrice').val(result.idvWaterPrice);
			$('#shWaterUsage').val(result.shWaterUsage);
			$('#shWaterPrice').val(result.shWaterPrice);
			$('#idvHeatingUsage').val(result.idvHeatingUsage);
			$('#idvHeatingPrice').val(result.idvHeatingPrice);
			$('#shHeatingUsage').val(result.shHeatingUsage);
			$('#shHeatingPrice').val(result.shHeatingPrice);
			$('#salary').val(result.salary);
			$('#allowance').val(result.allowance);
			$('#bonus').val(result.bonus);
			$('#rtrPay').val(result.rtrPay);
			$('#iacIns').val(result.iacIns);
			$('#empIns').val(result.empIns);
			$('#npn').val(result.npn);
			$('#hlthIns').val(result.hlthIns);
			$('#benefits').val(result.benefits);
			$('#oprodCt').val(result.oprodCt);
			$('#printCt').val(result.printCt);
			$('#tsptCt').val(result.tsptCt);
			$('#commCt').val(result.commCt);
			$('#postCt').val(result.postCt);
			$('#cprodCt').val(result.cprodCt);
			$('#etcCt').val(result.etcCt);
			$('#facCt').val(result.facCt);
			$('#commonsOtherCt').val(result.commonsOtherCt);
			$('#clnSvcCt').val(result.clnSvcCt);
			$('#expendableCt').val(result.expendableCt);
			$('#wasteCt').val(result.wasteCt);
			$('#cleaningOtherCt').val(result.cleaningOtherCt);
			$('#disinfecCt').val(result.disinfecCt);
			$('#disinfecOtherCt').val(result.disinfecOtherCt);
			$('#secCt').val(result.secCt);
			$('#secOtherCt').val(result.secOtherCt);
			$('#evtMgmtCt').val(result.evtMgmtCt);
			$('#evtInspCt').val(result.evtInspCt);
			$('#evtExpendableCt').val(result.evtExpendableCt);
			$('#evtOtherCt').val(result.evtOtherCt);
			$('#ltrrCt').val(result.ltrrCt);
			$('#ltrrOtherCt').val(result.ltrrOtherCt);
			$('#facilityMgmtCt').val(result.facilityMgmtCt);
			$('#facilityChkCt').val(result.facilityChkCt);
			$('#preventCt').val(result.preventCt);
			$('#facilitiesOtherCt').val(result.facilitiesOtherCt);
			$('#msvcCt').val(result.msvcCt);
			$('#csvcCt').val(result.csvcCt);
			$('#ssvcCt').val(result.ssvcCt);
			$('#vatOtherCt').val(result.vatOtherCt);
			$('#consignmentCt').val(result.consignmentCt);
			$('#consignmentOtherCt').val(result.consignmentOtherCt);
			$('#cbCt').val(result.cbCt);
			$('#abCt').val(result.abCt);
			$('#attdcCt').val(result.attdcCt);
			$('#operationCt').val(result.operationCt);
			$('#meetingOtherCt').val(result.meetingOtherCt);
			$('#buildingInsr').val(result.buildingInsr);
		}
	})
	
});

$('#updBtn').on('click', function(){

	Swal.fire({
        title: "수정하시겠습니까?",
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
    		let danjiCode = $('#roooooom').text().substr(0, 4);
    		
    		let data = {
    				roomCode: danjiCode + "_" + $('#dongModal').text() + "_" + $('#roomModal').text(),
    				ym: $('#yearModal').text() + "-" + $('#monthModal').text(),
    				
    				idvElecUsage: $('#idvElecUsage').val(),
    				idvElecPrice: $('#idvElecPrice').val(),
    				shElecUsage: $('#shElecUsage').val(),
    				shElecPrice: $('#shElecPrice').val(),
    				idvWaterUsage: $('#idvWaterUsage').val(),
    				idvWaterPrice: $('#idvWaterPrice').val(),
    				shWaterUsage: $('#shWaterUsage').val(),
    				shWaterPrice: $('#shWaterPrice').val(),
    				idvHeatingUsage: $('#idvHeatingUsage').val(),
    				idvHeatingPrice: $('#idvHeatingPrice').val(),
    				shHeatingUsage: $('#shHeatingUsage').val(),
    				shHeatingPrice: $('#shHeatingPrice').val(),
    				salary: $('#salary').val(),
    				allowance: $('#allowance').val(),
    				bonus: $('#bonus').val(),
    				rtrPay: $('#rtrPay').val(),
    				iacIns: $('#iacIns').val(),
    				empIns: $('#empIns').val(),
    				npn: $('#npn').val(),
    				hlthIns: $('#hlthIns').val(),
    				benefits: $('#benefits').val(),
    				oprodCt: $('#oprodCt').val(),
    				printCt: $('#printCt').val(),
    				tsptCt: $('#tsptCt').val(),
    				commCt: $('#commCt').val(),
    				postCt: $('#postCt').val(),
    				cprodCt: $('#cprodCt').val(),
    				etcCt: $('#etcCt').val(),
    				facCt: $('#facCt').val(),
    				commonsOtherCt: $('#commonsOtherCt').val(),
    				clnSvcCt: $('#clnSvcCt').val(),
    				expendableCt: $('#expendableCt').val(),
    				wasteCt: $('#wasteCt').val(),
    				cleaningOtherCt: $('#cleaningOtherCt').val(),
    				disinfecCt: $('#disinfecCt').val(),
    				disinfecOtherCt: $('#disinfecOtherCt').val(),
    				secCt: $('#secCt').val(),
    				secOtherCt: $('#secOtherCt').val(),
    				evtMgmtCt: $('#evtMgmtCt').val(),
    				evtInspCt: $('#evtInspCt').val(),
    				evtExpendableCt: $('#evtExpendableCt').val(),
    				evtOtherCt: $('#evtOtherCt').val(),
    				ltrrCt: $('#ltrrCt').val(),
    				ltrrOtherCt: $('#ltrrOtherCt').val(),
    				facilityMgmtCt: $('#facilityMgmtCt').val(),
    				facilityChkCt: $('#facilityChkCt').val(),
    				preventCt: $('#preventCt').val(),
    				facilitiesOtherCt: $('#facilitiesOtherCt').val(),
    				msvcCt: $('#msvcCt').val(),
    				csvcCt: $('#csvcCt').val(),
    				ssvcCt: $('#ssvcCt').val(),
    				vatOtherCt: $('#vatOtherCt').val(),
    				consignmentCt: $('#consignmentCt').val(),
    				consignmentOtherCt: $('#consignmentOtherCt').val(),
    				cbCt: $('#cbCt').val(),
    				abCt: $('#abCt').val(),
    				attdcCt: $('#attdcCt').val(),
    				operationCt: $('#operationCt').val(),
    				meetingOtherCt: $('#meetingOtherCt').val(),
    				buildingInsr: $('#buildingInsr').val()
    		};
//     	 	console.log('data: ', data);

    		$.ajax({
    			url:"/charge/admin/update",
    			contentType:"application/json;charset=utf-8",
    			data: JSON.stringify(data),
    			type:"post",
    			dataType:"json",
    			beforeSend: function(xhr){
    				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    			},
    			success:function(result){
//     				console.log(result);
    	            Swal.fire({
    	                icon: 'info',
    	                title: '수정!',
    	                text: '수정이 완료되었습니다.'
    	            });
    			}
    		})
        } 
    });
	
})

</script>
