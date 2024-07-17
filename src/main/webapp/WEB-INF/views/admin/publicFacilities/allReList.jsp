<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<!-- 차트 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>

<!--datatable css-->
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
<!--datatable responsive css-->
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">


<!--datatable js-->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>


<script src="/resources/js/jquery.min.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	let table = new DataTable('.tt', {
		"searching": true,
		"paging": true,
        "info": false,
        "lengthChange": false,
        "pageLength": 10,
		  "language": {
	            "zeroRecords": "예약 내역이 없습니다.",
	            "paginate": {
	                "next": "다음",
	                "previous": "이전"
	            },
	            "search": "검색 : ",
		  }
	});
});


$(document).ready(function() {

    /** 
    * 예약 상세 정보를 담을 모달
    * reserveSeq를 파라미터로 받아 정보 불러오기
    */
    $(document).on('click', '.reView', function(event) {
        event.preventDefault();
        console.log("음?");

        var row = $(this).closest('tr');
        var reserveSeq = row.children().eq(2).text().trim();
        console.log("음? reserveSeq", reserveSeq);

        let data = {
            "reserveSeq": reserveSeq
        };
        console.log(data);

        $.ajax({
            url: "/reDetail",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                console.log(">>", result);
                
                // 전화번호 형식 바꾸기
            	let memTel = result.memberVOList[0].memTelno.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})(\d+)(\d{4})$/, "$1-$2-$3").replace("--", "-");
				console.log("memTel: ", memTel);

                $("#modalReserveSeq").html(result.reserveSeq);
                $("#modalFacCode").html(result.facCode);
                $("#modalRegDt").html(result.regDt);
                $("#modalBeginTm").html(result.beginTm);
                $("#modalEndTm").html(result.endTm);
                $("#modalSeat").html(result.seat);
                $("#modalNop").html(result.nop);
                $("#modalCancleDt").html(result.cancleDt);
                $("#modalMemId").html(result.memId);
                $("#modalMemNm").html(result.memberVOList[0].memNm);
                $("#modalMemtelNo").html(memTel);
                $("#modalRoomCode").html(result.memberVOList[0].roomCode);
            }
        });

        var myModal = new bootstrap.Modal(document.getElementById('reDetailModal'));
        myModal.show();
    });
    

    /**
    * 카테고리 선택 시 각 시설물 별로 예약 정보를 분류 해서 볼 수 있음
    * 파라미터로 facCode를 받아 리스트를 뿌려준다
    */
    $("#selectCa").on("change", function() {
        let selectCa = $(this).val();
        console.log(">>>>", selectCa);

        let data = {
            "facCode": selectCa
        };
        console.log("data >>>>", data);

        $.ajax({
            url: "/selectCa",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                console.log("요깅>>> ", result);

                let str = "";
                if (result.length > 0) {
                    result.forEach(function(reserve) {
                        str += "<tr>";
                        if (reserve.facCode === 'facility01') {
                            str += "<td>테니스장</td>";
                        } else if (reserve.facCode === 'facility02') {
                            str += "<td>스크린골프</td>";
                        } else {
                            str += "<td>독서실</td>";
                        }
                        str += "<td>" + reserve.memId + "</td>";
                        str += "<td><a class='reView' data-reserve-seq='${reserveVO.reserveSeq}'>" + reserve.reserveSeq + "</a></td>";
                        str += "<td>" + reserve.regDt + "</td>";
                        str += "<td>" + reserve.beginTm + "</td>";
                        str += "<td>" + reserve.endTm + "</td>";
                        str += "<td>" + reserve.seat + "</td>";
                        str += "<td>" + reserve.nop + "</td>";
                        str += "<td>" + reserve.cancleYn + "</td>";
                        str += "<td>" + (reserve.cancleDt ? reserve.cancleDt : "-") + "</td>";
                        str += "</tr>";
                    });
                } else {
                    str = "<tr><td colspan='10' style='vertical-align: middle; text-align: center;'>예약이 없습니다.</td></tr>";
                }

                $("#tbodyShow").html(str);
            }
        });
    });
});
</script>
<style>
/* 몇개씩 나올지 선택하는 박스 지우기 */
#DataTables_Table_0_length {
	display: none;
}

#DataTables_Table_0_paginate{
	margin-right: 729px;
}
table, td, th {
  border-bottom : 1px solid black;
  border-collapse : collapse;
}
th, td {
  text-align: center;
  font-size: 16px;
  font-family:"trana";
  font-weight: 400;
  font-style: normal;
}
thead{
 background-color:  #e9f7ff;
}
th{
  font-weight: bold;
}
table {
    border: 1px solid gray;
}
#selectCa { 
   	width: 103px;
    height: 29px;
    display: flex;
}
</style>



<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class=" las la-dragon"></i><strong>전체 예약신청 목록</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">공동시설물</a></li>
						<li class="breadcrumb-item active">전체 예약신청 목록</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>



<!--통계 차트 -->
<div class="col-xl-6" style="float: left;">
	<div class="card">
		<div class="card-header">
			<h4 class="card-title mb-0">요일별 사용 통계</h4>
		</div>
		<div class="card-body">
			<canvas id="myChart1" width="400" height="180" style="display: block;"></canvas>
		</div>
	</div>
</div>

<div class="col-xl-6" style="float: left;">
	<div class="card">
		<div class="card-header">
			<h4 class="card-title mb-0">월별 사용 통계</h4>
		</div>
		<div class="card-body">
			<canvas id="myChart2" width="400" height="180" style="display: block;"></canvas>
		</div>
	</div>
</div>


<c:forEach var="total1" items="${totalRe}" varStatus="stat">
	   <input type="hidden" class="cnt${stat.index+1} cnt" data-month="${total1.month}" data-fac-code="${total1.facCode}" data-total="${total1.totalRe}"/>
</c:forEach>

<c:forEach var="dayCnt" items="${dayCntList}" varStatus="stat">
   <input type="hidden" class="dayCnt${stat.index+1} dayCnt" data-weekday="${dayCnt.weekday}" data-re-cnt="${dayCnt.reCnt}"  data-fac-code="${dayCnt.facCode}" />
</c:forEach>

<!-- 통계차트 용 스크립트 -->
<script>

// 요일별 통계 정보를 담을 빈 배열
let allDay = [];

$(".dayCnt").each(function(index) {
  let weekday = $(this).data("weekday");
console.log("weekday: ", weekday);
  let reCnt = $(this).data("reCnt");
console.log("reCnt: ", reCnt);
  let facCode = $(this).data("facCode");
console.log("facCode: ", facCode);

  allDay.push({
    weekday: weekday,
    reCnt: reCnt,
    facCode: facCode,
  });
});

console.log("allDay: ", allDay);

//데이터 배열 초기화
const weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일','일요일'];

// 각 시설별로 일주일 동안의 데이터를 0으로 초기화
let facility01 = Array(7).fill(0);
let facility02 = Array(7).fill(0);
let facility03 = Array(7).fill(0);

// 데이터를 처리하여 요일별 통계를 갱신
allDay.forEach(data => {
    let weekdayIndex = weekdays.indexOf(data.weekday.trim()); // 요일을 인덱스로 변환
    switch (data.facCode) {
        case 'facility01':
            facility01[weekdayIndex] = data.reCnt;
            break;
        case 'facility02':
            facility02[weekdayIndex] = data.reCnt;
            break;
        case 'facility03':
            facility03[weekdayIndex] = data.reCnt;
            break;
    }
});

console.log("facility01: ", facility01);
console.log("facility02: ", facility02);
console.log("facility03: ", facility03);


const ctx1 = document.getElementById('myChart1').getContext('2d');
const myChart1 = new Chart(ctx1, {
    type: 'bar',
    data: {
        labels: weekdays,
        datasets: [{
            label: '테니스',
            data: facility01,
            backgroundColor: '#1fab89',
            borderColor: '#1fab89',
            borderWidth: 2
        }, {
            label: '스크린 골프',
            data: facility02,
            backgroundColor: '#f7b84b',
            borderColor: '#f7b84b',
            borderWidth: 2
        }, {
            label: '독서실',
            data: facility03,
            backgroundColor: '#fe4880',
            borderColor: '#fe4880',
            borderWidth: 2
        }]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true,
                ticks: {
                    stepSize: 1
                }
            }
        },
        plugins: {
            legend: {
                display: true,
                position: 'right'
            }
        }
    }
});


	
	
// 월별 통계를 담을 빈 배열
let allData = [];

$(".cnt").each(function(index) {
    let month = $(this).data("month");
    let facCode = $(this).data("facCode");
    let total = $(this).data("total");
    
    allData.push({
        month: month,
        facCode: facCode,
        total: total
    });
});

console.log("allData: ", allData);

// 데이터 배열 초기화
let labels = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
let facility01Data = new Array(12).fill(0);
let facility02Data = new Array(12).fill(0);
let facility03Data = new Array(12).fill(0);
let allDataTotals = new Array(12).fill(0);

// 데이터 매핑
allData.forEach(data => {
    let monthIndex = parseInt(data.month, 10) - 1;
    switch(data.facCode) {
        case 'facility01':
            facility01Data[monthIndex] = data.total;
            break;
        case 'facility02':
            facility02Data[monthIndex] = data.total;
            break;
        case 'facility03':
            facility03Data[monthIndex] = data.total;
            break;
        case 'ALL':
            allDataTotals[monthIndex] = data.total;
            break;
    }
});

console.log("facility01Data: ", facility01Data);
console.log("facility02Data: ", facility02Data);
console.log("facility03Data: ", facility03Data);
console.log("allDataTotals: ", allDataTotals);


const ctx2 = document.getElementById('myChart2').getContext('2d');
const myChart2 = new Chart(ctx2, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [
            {
                type: 'bar',
                label: '전체 총 예약수',
                data: allDataTotals,
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            },
            {
                type: 'line',
                label: '테니스',
                data: facility01Data,
                backgroundColor: '#1fab89',
                borderColor: '#1fab89',
                borderWidth: 2,
                fill: false
            },
            {
                type: 'line',
                label: '스크린 골프',
                data: facility02Data,
                backgroundColor: '#f7b84b',
                borderColor: '#f7b84b',
                borderWidth: 2,
                fill: false
            },
            {
                type: 'line',
                label: '독서실',
                data: facility03Data,
                backgroundColor: '#fe4880',
                borderColor: '#fe4880',
                borderWidth: 2,
                fill: false
            }
        ]
    },
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        },
	    plugins: {
            legend: {
                display: true,
                position: 'right'
            }
        }
    }
});
</script>

<div class="col-12">
	<div class="card">
		<div class="card-header">
			<h3 class="card-title" style="font-size: 40px;">전체 예약신청 목록</h3>
			<br> 
		</div>

		<div class="card-body table-responsive p-0" style="min-height: 600px;">
			<select id="selectCa">
				<option value="all">전체보기</option>
				<option value="facility01">테니스장</option>
				<option value="facility02">스크린 골프</option>
				<option value="facility03">독서실</option>
			</select>
			<table class="table table-hover text-nowrap tt"  style="width: 100%;padding: 5px;">
				<thead>
					<tr>
						<th>시설물 명</th>
						<th>회원ID</th>
						<th>예약일련번호</th>
						<th>신청일</th>
						<th>사용 시작 일시</th>
						<th>사용 종료 일시</th>
						<th>자리</th>
						<th>인원</th>
						<th>취소현황</th>
						<th>취소일시</th>
					</tr>
				</thead>
				<tbody id="tbodyShow">
					<c:forEach var="reserveVO" items="${reserveVOList}" varStatus="stat">
						<tr class="reView" data-reserve-seq="${reserveVO.reserveSeq}">
						
							<td>
								<c:choose>
										<c:when test="${reserveVO.facCode == 'facility01'}">
							            	테니스장
							        	</c:when>
										<c:when test="${reserveVO.facCode == 'facility02'}">
							    		        스크린골프
							        	</c:when>
										<c:when test="${reserveVO.facCode == 'facility03'}">
							    		        독서실
							        	</c:when>
								</c:choose>
							</td>
							<td>${reserveVO.memId}</td>
							<td>${reserveVO.reserveSeq}</td>
							<td>${reserveVO.regDt}</td>
							<td>${reserveVO.beginTm}</td>
							<td>${reserveVO.endTm}</td>
							<td>${reserveVO.seat}번</td>
							<td>${reserveVO.nop}명</td>
							<td>${reserveVO.cancleYn}</td>
							<td>
							    <c:choose>
							        <c:when test="${reserveVO.cancleDt == null}">
							            -
							        </c:when>
							        <c:otherwise>
							            ${reserveVO.cancleDt}
							        </c:otherwise>
							    </c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="row clsPagingArea" id="pa1" style="float: left">
				${articlePage.pagingArea}</div>
		</div>
	</div>


	<div class="modal fade bd-example-modal-lg" id="reDetailModal"
		tabindex="-1" aria-labelledby="reDetailModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h2 class="modal-title">예약 상세</h2>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body" style="font-size: 16px;">
					<div class="dd">
						<p>
							<strong>예약 일련 번호 :&nbsp; </strong> <span id="modalReserveSeq"></span>
						</p>
						<p>
							<strong>시설물 코드 :&nbsp; </strong> <span id="modalFacCode"></span>
						</p>
						<p>
							<strong>예약일 :&nbsp; </strong> <span id="modalRegDt"></span>
						</p>
						<p>
							<strong>사용 시작 일시 :&nbsp; </strong> <span id="modalBeginTm"></span>
						</p>
						<p>
							<strong>사용 종료 일시 :&nbsp; </strong> <span id="modalEndTm"></span>
						</p>
						<p>
							<strong>위치 :&nbsp; </strong> <span id="modalSeat"></span>
						</p>
						<p>
							<strong>인원수 :&nbsp; </strong> <span id="modalNop"></span>
						</p>
						<p>
							<strong>취소일시 :&nbsp; </strong> <span id="modalCancleDt"></span>
						</p>
						<hr>
						<h5>신청자 정보</h5>
						<hr>
						<p>
							<strong>회원 ID :&nbsp; </strong> <span id="modalMemId"></span>
						</p>
						<p>
							<strong>이름 :&nbsp; </strong> <span id="modalMemNm"></span>
						</p>
						<p>
							<strong>전화번호 :&nbsp; </strong> <span id="modalMemtelNo"></span>
						</p>
						<p>
							<strong>단지코드_동_호수 :&nbsp; </strong> <span id="modalRoomCode"></span>
						</p>
					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

</div>