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
	
 <!-- chart.js 설치 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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

.text-white {
	color: rgb(133 133 137) !important;
}
</style>



<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="las la-truck"></i><strong>  택배 신청 현황</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">서비스</a></li>
						<li class="breadcrumb-item active">택배 신청 현황</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 차트 크기는 부모 크기를 조절하면 거기에 맞게 자동으로 맹글어짐-->
<div class="col-xl-6" style="float: left;">
	<div class="card">
		<div class="card-header">
			<h4 class="card-title mb-0">요일별 사용 통계</h4>
		</div>
		<div class="card-body">
			<!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
			<canvas id="myChart"></canvas>
		</div>
	</div>
</div>

<!-- 차트 크기는 부모 크기를 조절하면 거기에 맞게 자동으로 맹글어짐-->
<div class="col-xl-6" style="float: left;">
	<div class="card">
		<div class="card-header">
			<h4 class="card-title mb-0">월별 사용 통계</h4>
		</div>
		<div class="card-body">
			<!-- 차트 그릴 위치 지정 canvas webGL(그래픽엔진) 사용 -->
			<canvas id="myChart2"></canvas>
		</div>
	</div>
</div>


<div class="col-12">
	<div class="card">
		<div class="card-header">
			<h3 class="card-title" style="font-size: 40px;">택배 신청 현황</h3>
		</div>
		  <div class="card-body" style="font-size: 16px;">
            <div>
                <select id="ccpyFilter">
                    <option value="all">전체</option>
                    <c:forEach var="ccpy" items="${ccpyVOList}" varStatus="stat">
                        <option value="${ccpy.ccpyCode}" <c:if test="${selectedCcpyCode == ccpy.ccpyCode}">selected</c:if>>${ccpy.ccpyName}</option>
                    </c:forEach>
                </select>
            </div>
			<table id="deliListTable"
				class="display table table-bordered dt-responsive"
				style="width: 100%; text-align: center;">
				<thead 	style="font-size: 16px; background-color:#69bde729;">
					<tr>
						<th>순 번</th>
						<th>신청 일련번호</th>
						<th>택배사</th>
						<th>신청인ID</th>
						<th>운송 품목</th>
						<th>신청 일시</th>
						<th>수거 일시</th>
						<th>처리 여부</th>
					</tr>
				</thead>
				<tbody id="deliListBody" style="font-size: 16px;">
					<c:forEach var="deliveryVO" items="${deliveryVOList}"
						varStatus="stat">
						<tr class="tblRow" data-pck-seq="${deliveryVO.pckSeq}" data-ccpy-code="${deliveryVO.ccpyCode}">
							<td>${deliveryVO.rnum}</td>
							<td>${deliveryVO.pckSeq}</td>
							<td>${deliveryVO.ccpyName}</td>
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
										<span
											class="badge bg-danger" style="font-size: 16px;  width: 90px;">
											반려</span>
									</c:when>
									<c:when test="${deliveryVO.pckStatus == 'N'}">
										<span
											class="badge bg-warning" style="font-size: 16px;">신청
											완료</span>
									</c:when>
									<c:when test="${deliveryVO.pckStatus == 'Y'}">
										<span
											class="badge bg-success" style="font-size: 16px;">수거
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
							<p id="p8" style="display: none;">
								<span class="text-danger" style="font-size: 19px;">※ 택배
									신청이 철회되어 상세 내역만 확인 가능합니다.</span>
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
										전화번호<input type="tel" class="form-control" id="modalSendTel1" name="sendTel" 
											placeholder="휴대폰 번호" disabled readonly/>
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
										전화번호<input type="tel" class="form-control" id="modalReTel1" name="reTel" 
											placeholder="휴대폰 번호" disabled readonly/>
											
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
											name="weigh" disabled readonly>
									</p>
									<p>
										금액<input type="text" class="form-control" id="modalPrice"
											name="price" disabled readonly>
									</p>
									<p>
										수량<input type="text" class="form-control" id="modalPckQty"
											name="pckQty" value="" disabled readonly>
									</p>
									<p>
										총액<input type="text" class="form-control" id="modalPckTotal"
											name="pckTotal" value="" disabled readonly>
									</p>
									<p id="back" style="display: none;">
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
										희망일 <input type="text"
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
									<p id="p9" style="display: none;">
										신청 철회일<input type="text" class="form-control"
											id="modalCancelTm" name="cancelTm" value="" disabled readonly>
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
 
<c:forEach var="monthList" items="${monthList}" varStatus="stat">
   <input type="hidden" class="monthList${stat.index+1} monthList" data-year-month="${monthList.yearMonth}" data-ccpy-code="${monthList.ccpyCode}" data-count="${monthList.count}"/>
</c:forEach> 
<c:forEach var="dayList" items="${dayList}" varStatus="stat">
   <input type="hidden" class="dayList${stat.index+1} dayList" data-day-of-week="${dayList.dayOfWeek}" data-ccpy-code="${dayList.ccpyCode}" data-count="${dayList.count}"/>
</c:forEach> 
<script>

     const ctx = document.querySelector('#myChart');
     const ctx2 = document.querySelector('#myChart2');

  // 요일별 통계
     let dayTotal = [];

     $(".dayList").each(function(index) {
         let dayOfWeek = $(this).data("dayOfWeek");  // 요일 (1-7)
         let ccpyCode = $(this).data("ccpyCode");
         let count = $(this).data("count");
         
         dayTotal.push({
             dayOfWeek: dayOfWeek,
             ccpyCode: ccpyCode,
             count: count
         });
     });

     console.log("dayTotal ", dayTotal);

     // 요일 라벨
     let days = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];

     // 데이터 배열 초기화
     let ccpy01day = new Array(7).fill(0);
     let ccpy02day = new Array(7).fill(0);
     let ccpy03day = new Array(7).fill(0);
     let ccpy04day = new Array(7).fill(0);
     let ccpy05day = new Array(7).fill(0);
     let ccpyTotalday = new Array(7).fill(0);

     // 데이터 매핑
     dayTotal.forEach(data => {
         console.log("data", data);
         let dayIndex = parseInt(data.dayOfWeek, 10)-1;  // 요일 인덱스 (0-6)
         switch(data.ccpyCode) {
             case 'CCPY00001':
            	 ccpy01day[dayIndex] = data.count;
                 break;
             case 'CCPY00002':
                 ccpy02day[dayIndex] = data.count;
                 break;
             case 'CCPY00003':
                 ccpy03day[dayIndex] = data.count;
                 break;
             case 'CCPY00004':
                 ccpy04day[dayIndex] = data.count;
                 break;
             case 'CCPY00005':
                 ccpy05day[dayIndex] = data.count;
                 break;
             case 'TOTAL':
                 ccpyTotalday[dayIndex] = data.count;
                 break;
         }
     });

     console.log("ccpy01day: ", ccpy01day);
     console.log("ccpy02day: ", ccpy02day);
     console.log("ccpy03day: ", ccpy03day);
     console.log("ccpy04day: ", ccpy04day);
     console.log("ccpy05day: ", ccpy05day);
     console.log("ccpyTotalday: ", ccpyTotalday);

     // 차트 생성
     new Chart(ctx, {
         type: 'bar',  // bar, line, pie, doughnut, radar 등등...
         data: {
             labels: days,
             datasets: [
                 {
                     type: 'bar',
                     label: '총 택배 신청 건수',
                     data: ccpyTotalday,
                     borderWidth: 1,
                     backgroundColor : 'rgb(92, 209, 229, 0.3)',
     				 borderColor : '#38ADC1'
                 },
                 {
                     type: 'line',
                     label: 'CJ대한통운',
                     data: ccpy01day,
                     borderWidth: 1,
                     fill: false,
     				 backgroundColor : 'RED',
     				 borderColor : 'RED',
     				 borderWidth : 2
                 },
                 {
                     type: 'line',
                     label: '롯데택배',
                     data: ccpy02day,
                     borderWidth: 1,
                     fill: false,
     				 backgroundColor : '#FF5E00',
     				 borderColor : '#FF5E00',
     				 borderWidth : 2
                 },
                 {
                     type: 'line',
                     label: '한진택배',
                     data: ccpy03day,
                     borderWidth: 1,
                     fill: false,
     				 backgroundColor : '#FFE400',
     				 borderColor : '#FFE400',
     				 borderWidth : 2
                 },
                 {
                     type: 'line',
                     label: '우체국택배',
                     data: ccpy04day,
                     borderWidth: 1,
                     fill: false,
     				 backgroundColor : 'GREEN',
     				 borderColor : 'GREEN',
     				 borderWidth : 2
                 },
                 {
                     type: 'line',
                     label: '로젠택배',
                     data: ccpy05day,
                     borderWidth: 1,
                     fill: false,
     				 backgroundColor : 'BLUE',
     				 borderColor : 'BLUE',
     				 borderWidth : 2
                 }
             ]
         },
         options: {
             scales: {
                 y: {
                     beginAtZero: true
                 }
             }
         }
     });


// 월별 통계
let monthTotal = [];

$(".monthList").each(function(index){
	let yearMonth = $(this).data("yearMonth");
	let ccpyCode = $(this).data("ccpyCode");
	let count = $(this).data("count");
	
	monthTotal.push({
		yearMonth : yearMonth,
		ccpyCode : ccpyCode,
		count : count
	});
	
});

console.log("monthTotal ", monthTotal);


//데이터 배열 초기화
let labels = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
let ccpy01 = new Array(12).fill(0);
let ccpy02 = new Array(12).fill(0);
let ccpy03 = new Array(12).fill(0);
let ccpy04 = new Array(12).fill(0);
let ccpy05 = new Array(12).fill(0);
let ccpyTotal = new Array(12).fill(0);

// 데이터 매핑
monthTotal.forEach(data => {
	console.log("data",data)
    let monthIndex = parseInt(data.yearMonth.split('-')[1], 10) - 1;
    switch(data.ccpyCode) {
        case 'CCPY00001':
        	ccpy01[monthIndex] = data.count;
            break;
        case 'CCPY00002':
        	ccpy02[monthIndex] = data.count;
            break;
        case 'CCPY00003':
        	ccpy03[monthIndex] = data.count;
            break;
        case 'CCPY00004':
        	ccpy04[monthIndex] = data.count;
            break;
        case 'CCPY00005':
        	ccpy05[monthIndex] = data.count;
            break;
        case 'TOTAL':
        	ccpyTotal[monthIndex] = data.count;
            break;
    }
});

console.log("ccpy01: ", ccpy01);
console.log("ccpy02: ", ccpy02);
console.log("ccpy03: ", ccpy03);
console.log("ccpy04: ", ccpy04);
console.log("ccpy05: ", ccpy05);
console.log("ccpyTotal: ", ccpyTotal);



//만들위치, 설정값객체
 new Chart(ctx2, {
     type: 'bar',  // bar, line, pie, doughnut, radar 등등...
     data: {
   	  labels: labels,
         datasets: [
       	  {
       		  type: 'bar',
                 label: '총 택배 신청 건수',
                 data: ccpyTotal,
                 borderWidth: 1,
                 backgroundColor : 'rgb(92, 209, 229, 0.3)',
 				 borderColor : '#38ADC1'
 				 
             },
             {
           	  type: 'line',
                 label: 'CJ대한통운',
                 data: ccpy01,
                 borderWidth: 1,
                 fill: false,
 				 backgroundColor : 'RED',
 				 borderColor : 'RED',
 				 borderWidth : 2
             },
             {
           	  type: 'line',
                 label: '롯데택배',
                 data: ccpy02,
                 borderWidth: 1,
                 fill: false,
 				 backgroundColor : '#FF5E00',
 				 borderColor : '#FF5E00',
 				 borderWidth : 2
             },
             {
           	  type: 'line',
                 label: '한진택배',
                 data: ccpy03,
                 borderWidth: 1,
                 fill: false,
 				 backgroundColor : '#FFE400',
 				 borderColor : '#FFE400',
 				 borderWidth : 2
             },
             {
           	  type: 'line',
                 label: '우체국택배',
                 data: ccpy04,
                 borderWidth: 1,
                 fill: false,
 				 backgroundColor : 'GREEN',
 				 borderColor : 'GREEN',
 				 borderWidth : 2
             },
             {
           	  type: 'line',
                 label: '로젠택배',
                 data: ccpy05,
                 borderWidth: 1,
                 fill: false,
 				 backgroundColor : 'BLUE',
 				 borderColor : 'BLUE',
 				 borderWidth : 2
             }
         ]
     },
     options: {
         scales: {
             y: {
                 beginAtZero: true
             }
         }
     }
 });




// document.addEventListener('DOMContentLoaded', function() {
// 	let table = new DataTable('#deliListTable', {
// 	// 	        "ajax": 'assets/json/datatable.json'
// 	});
// });

$(document).ready(function() {
    $('#deliListTable').DataTable({
        "paging": true,
        "ordering": true,
        "info": false,
        "lengthChange": false,
        "pageLength": 10,
        "language": {
            "zeroRecords": "검색 결과가 없습니다.",
            "search": "검색:",
            "paginate": {
                "next": "다음",
                "previous": "이전"
            },
        }
    });
    
    $("#ccpyFilter").on("change", function() {
        let ccpyFilter = $(this).val();
        
        let data = {
            "ccpyCode": ccpyFilter
        };

        $.ajax({
            url: "/delivery/admin/ccpyFilter",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                let str = "";
                if(result.length > 0) {
                    result.forEach(function(deliveryVO) {
                        str += `
                            <tr class='tblRow' data-pck-seq='\${deliveryVO.pckSeq}' data-ccpy-code='\${deliveryVO.ccpyCode}'>
                                <td>\${deliveryVO.rnum}</td>
                                <td>\${deliveryVO.pckSeq}</td>
                                <td>\${deliveryVO.ccpyName}</td>
                                <td>\${deliveryVO.memId}</td>
                                <td>\${deliveryVO.commDetailVOList[0].commDetCodeNm}</td>
                                <td>\${deliveryVO.regDt}</td>
                                <td>\${deliveryVO.pickUpDt == null ? "-" : deliveryVO.pickUpDt}</td>
                                <td>
                                    <span class="badge \${deliveryVO.cancelYn == 'Y' ? 'border text-white bg-dark-subtle' : deliveryVO.backYn == 'Y' ? 'badge bg-danger' : deliveryVO.pckStatus == 'N' ? 'badge bg-warning' : 'badge bg-success'}" 
                                    	style="\${deliveryVO.cancelYn == 'Y' ? 'font-size: 16px; font-weight: bold;' : deliveryVO.backYn == 'Y' ? 'font-size: 16px; width: 90px;' : deliveryVO.pckStatus == 'N' ? 'font-size: 16px;' : 'font-size: 16px;'}">
                                        \${deliveryVO.cancelYn == 'Y' ? '신청 철회' : deliveryVO.backYn == 'Y' ? '반려' : deliveryVO.pckStatus == 'N' ? '신청 완료' : '수거 완료'}
                                    </span>
                                </td>
                            </tr>
                        `;
                    });
                } else {
                    str = `<tr><td colspan="8">검색 결과가 없습니다.</td></tr>`;
                }
                $("#deliListBody").html(str);
            }
        });
    });
});

function handleImg(e){
	   let files = e.target.files;
	   let fileArr = Array.prototype.slice.call(files);
	   
	   fileArr.forEach(function(f){
	      if(!f.type.match("image.*")){
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
			url : "/delivery/admin/deliveryDetail",
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
				
				if (result.cancelYn == 'Y') { // 신청 철회된 상태일때 
					$("#pickUp").hide();
					$("#backUpdate").hide();
					$("#back").hide();
					$("#confirm").show();
					$("#p8").css("display", "block");
					$("#p9").css("display", "block");
					$("#modalDetail").modal("show");
				} else if (result.backYn == 'Y') {// 반려 처리된 상태일때
					$("#pickUp").hide();
					$("#backUpdate").hide();
					$("#backSpan").hide();
					$("#confirm").show();
					$("#back").show();
					$("#p2").css("display", "block");
					$("#p4").css("display", "block");
					$("#modalDetail").modal("show");
				} else if (result.pckStatus == 'N') { // 신청 완료된 상태일때
					$("#backUpdate").show();
					$("#pickUp").show();
					$("#confirm").show();
					$("#back").hide();
					$("#modalDetail").modal("show");
				} else if (result.pckStatus == 'Y') {// 수거 완료된 상태일때
					$("#pickUp").hide();
					$("#backUpdate").hide();
					$("#back").hide();
					$("#confirm").show();
					$("#p1").css("display", "block");
					$("#p3").css("display", "block");
					$("#modalDetail").modal("show");
				} 
				
				// 상세페이지- 금액, 총액  콤마 찍기
				let pPrice = result.price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") +" 원";
				let pTotal = result.pckTotal.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+" 원";
				
				// 전화번호 하이픈 넣기
				let sTel = result.sendTel.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})(\d+)(\d{4})$/, "$1-$2-$3").replace("--", "-");
				console.log("sTel:", sTel);
				let rTel = result.reTel.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})(\d+)(\d{4})$/, "$1-$2-$3").replace("--", "-");
				console.log("sTel:", sTel);
				
				let kg = result.weigh + " kg";
				let qty = result.pckQty +" 개";
				
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
	            $("#modalSendAddr").val(result.sendAddress);
	            $("#modalBackTm").val(result.backTm);
	            $("#modalBackComment").val(result.backComment);
	            
	           
	            
	         // 반려 사유 취소 클릭시
				$("#upCalcel").on("click",function(){
	                 $("#p6").css("display","block");
					 $("#p7").css("display","none");
					 $("#p5").css("display","none");
					 $("#back").hide();
	                    
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
				 $("#back").hide();
                    
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
			$("#p8").css("display", "none");
			$("#p9").css("display", "none");
		});

		// 상세 반려버튼 클릭시
		$("#backUpdate").on("click",function(){
			 $("#p5").css("display","block");
			 $("#p6").css("display","none");
             $("#p7").css("display","block");
             $("#back").show();
             $("#backSpan").show();
                
             //readonly 속성을 제거
             $(".form").removeAttr("readonly");
             $(".back-form").removeAttr("disabled");
			
		});
		
		
		// 반려 사유 - 저장 버튼 클릭시
		$("#update").on("click",function(){
			
			let backComment = $("#modalBackComment").val(); 
			  if (!backComment) {
		        	 Swal.fire({
		 	            title: '반려 사유를 작성해주세요',
		 	            icon: 'warning',
		 	            confirmButtonClass: 'btn btn-primary w-xs mt-2',
		 	            buttonsStyling: false,
		 	            showCloseButton: true
		 	        }).then(function() {
		 	        	backComment.focus(); // SweetAlert가 닫힌 후 포커스를 제목 입력 필드로 이동
		 	        });
		 	        return;
			
			  }
			
			Swal.fire({
		        title: "정말 반려 처리하시겠습니까? \n 반려시 재복구 불가능합니다.",
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
			//let backComment = $("#modalBackComment").val(); 
			
			console.log("backUdate->pckSeq :", pckSeq);

				let data = {
					"pckSeq" : pckSeq,
					"backComment" : backComment
				}
				console.log("backUdate -> data : ", data);

				$.ajax({
					url : "/delivery/admin/back",
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
	                        title: '반려 처리 되었습니다!',
	                        icon: 'success',
	                        showConfirmButton: false,
	                        timer: 1500,
	                        showCloseButton: false
	                    }).then(function() {
						
					
						$('tr[data-pck-seq="'+ pckSeq + '"]').find('td:last').html('<span class="badge bg-danger" style="font-size: 16px; width: 90px;">반려</span>');
						
						 $("#p6").css("display","block");
						 $("#p7").css("display","none");
						 $("#p5").css("display","none");
						 $("#back").hide();
						 $("#backSpan").hide();
						$(".form").attr("readonly",true); 
						$(".back-form").attr("disabled",true);
						
						$("#modalDetail").modal("hide");
						console.log("update-> result : ",result);
	                    });
					}

				});// del 아작 종료
			} else {
				Swal.fire({
	                title: '신청 그대로 유지됩니다.',
	                showConfirmButton: false,
	                icon: 'error',
		            timer: 1500,
		            showCloseButton: false
	            }).then(function(){
	            	$("#p6").css("display","block");
					 $("#p7").css("display","none");
					 $("#p5").css("display","none");
					 $("#back").hide();
	                    
	                 //readonly 속성을 제거
	                 $(".form").attr("readonly",true);
	                 $(".back-form").attr("disabled",true);
	                 
	                 $("#modalBackComment").val(result.backComment);
	            });
				
			}
		});
			
		});
			
	// 수거 완료 클릭시
		$("#pickUp").on("click",function() {
			 Swal.fire({
			        title: "수거 완료 하시겠습니까?",
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
			console.log("pickUp->pckSeq :", pckSeq);

				let data = {
					"pckSeq" : pckSeq
				}
				console.log("pickUp -> data : ", data);

				$.ajax({
					url : "/delivery/admin/pickUp",
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
		                        title: '수거 완료!',
		                        icon: 'success',
		                        showConfirmButton: false,
	                        timer: 1500,
	                        showCloseButton: false
		                    }).then(function() {
						
						
						// 현재 날짜와 시간을 YYYY-MM-DD HH24:MI:SS 형식으로 포맷팅
		                let now = new Date();
		                let formattedDateTime = now.getFullYear() + '/' +
		                    ('0' + (now.getMonth() + 1)).slice(-2) + '/' +
		                    ('0' + now.getDate()).slice(-2);

		                // pickUpDt 필드 업데이트
		                $('tr[data-pck-seq="'+ pckSeq + '"]').find('td:nth-child(6)').html(formattedDateTime);
						
						$('tr[data-pck-seq="'+ pckSeq + '"]').find('td:last').html('<span class="badge bg-success" style="font-size: 16px;">수거 완료</span>');
						$("#modalDetail").modal("hide");
						console.log("delUpdate-> result : ",result);
						location.href = "/delivery/admin/delivery";
					});
					}

				});// del 아작 종료
			
			} else {
				Swal.fire({
	                title: '수거 완료시 다시 눌러 주세요.',
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
 