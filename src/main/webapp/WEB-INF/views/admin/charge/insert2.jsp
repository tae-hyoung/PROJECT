<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

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

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<style>
/* 임시 경계선 클래스 */
.border{
	border: 1px solid black;
}
/* 임시 경계선 클래스 */

tbody tr:hover{
	background-color: lightgrey;
}

tfoot{
	font-weight: 600;
}

.topTotal{
	 min-height: 100px;
	 display: flex;
	 justify-content: center;
	 font-size: 2em;
	 font-weight: bolder;
	 color: white;
}

table th{
	height: 40px;
}

.chargeTbl th, .chargeTbl td {
    white-space: nowrap; 
    font-size: 16px;
}
.chargeTbl th:nth-child(1), .chargeTbl td:nth-child(1) {
    width: 10%; 
}
.chargeTbl th:nth-child(2), .chargeTbl td:nth-child(2) {
    width: 10%; 
}
.chargeTbl th:nth-child(3), .chargeTbl td:nth-child(3) {
    width: 20%; 
}
.chargeTbl th:nth-child(4), .chargeTbl td:nth-child(4) {
    width: 10%; 
}
.chargeTbl th:nth-child(5), .chargeTbl td:nth-child(5) {
    width: 40%; 
}
.chargeTbl th:nth-child(6), .chargeTbl td:nth-child(6) {
    width: 10%; 
}
.minHeight{
	min-height: 450px;
}
.center{
	text-align: center;
}
.right{
	text-align: right;
}

</style>

<div class="col-12">
	<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
		<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="mdi mdi-chart-bar"></i><strong>    관리비 현황</strong></p>
		<div class="page-title-right">
			<ol class="breadcrumb m-0">
				<li class="breadcrumb-item active">관리비 현황</li>
			</ol>
		</div>
	</div>
</div>

<div class="card">
	<div class="card-body row">
		<div style="font-size: 3em; display: flex; justify-content: center;">
			<button id="prev" style="border: none; background-color: inherit;"><i class="mdi mdi-chevron-double-left"></i></button>
			<span id="year">2024</span>년
			<button id="next" style="border: none; background-color: inherit;"><i class="mdi mdi-chevron-double-right"></i></button>
		</div>
		
		<div style="display: flex; justify-content: flex-end; margin-top: -70px; height: 40px;">
			<input type="button" id="lateProcBtn" class="btn btn-danger" value="연체료 부과" disabled style="display: none;"/>
			<input type="button" class="btn btn-soft-info" value="관리비 부과" data-bs-toggle="modal" data-bs-target="#insertModal">
		</div>
		
		<div class="col-3">
			<div class="card topTotal" style="background-color: #1fab89;">
				<span style="display: flex; justify-content: center;">총액 &nbsp;&nbsp;<span id="total">0</span>원</span>
			</div>
		</div>
		<div class="col-3">
			<div class="card topTotal" style="background-color: #299cdb;">
				<span style="display: flex; justify-content: center; ">납부액 &nbsp;&nbsp;<span id="payTotal">0</span>원</span>
			</div>
		</div>
		<div class="col-3">
			<div class="card topTotal" style="background-color: #f7b84b;">
				<span style="display: flex; justify-content: center;">미납료 &nbsp;&nbsp;<span id="nonPayTotal">0</span>원</span>
			</div>
		</div>
		<div class="col-3">
			<div class="card topTotal" style="background-color: #fe4880;">
				<span style="display: flex; justify-content: center;">연체료 &nbsp;&nbsp;<span id="lateTotal">0</span>원</span>
			</div>
		</div>
	</div>
	
	<!-- 관리비 부과 모달 시작 -->
	<div id="insertModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	    <div class="modal-dialog modal-md">
	        <div class="modal-content">
	        	<div class="modal-header"><h1>관리비 부과</h1></div>
	        	<div class="modal-body">
	        		<p style="color: red;">※ 관리비가 기재된 엑셀 파일을 업로드해주세요.</p>
					<form action="/charge/admin/insert?${_csrf.parameterName}=${_csrf.token}" method="POST" enctype="multipart/form-data">
			    		<input type="file" name="file" required><br><br>
			    		<div style="display: flex; justify-content: flex-end;">
							<input type="button" class="btn btn-outline-dark" value="닫기" data-bs-toggle="modal" data-bs-target="#insertModal">
							<input type="submit" class="btn btn-soft-primary" value="등록">
			    		</div>
					</form>
	        	</div>
			</div>
		</div>
	</div>
	<!-- 관리비 부과 모달 끝 -->
	
	<div class="border" style="min-height: 500px;">
		<canvas id="yearChart" width="1600px;" height="500px;"></canvas>
	</div>
</div>

<div class="card">
	<div class="card-body row" style="min-height: 300px;">
		<div class="col-6 border">
			<input type="number" class="codeSrch" id="dongCode" placeholder="동" value="">
			<input type="number" class="codeSrch" id="roomCode" placeholder="호" value="">
			<table class="chargeTbl">
				<thead>
					<tr>
						<th class="center">동</th>
						<th class="center">호</th>
						<th class="center">관리비</th>
						<th class="center">납부여부</th>
						<th class="center">납부일시</th>
						<th class="center">연체료</th>
					</tr>
				</thead>
				<tbody id="trShow"></tbody>
				<tfoot>
					<tr id="totalSticky">
						<td>총액</td>
						<td></td>
						<td class="right" id="totalOnList">0</td>
						<td></td>
						<td></td>
						<td class="right" id="lateTotalOnList">0</td>
					</tr>
				</tfoot>
			</table>
		</div>
		<div class="col-6 border">
			<div id="monthChartDiv" style="display: block">
				<canvas id="monthChart" width="700px;" height="500px;"></canvas>
			</div>
			<div id="roomChartDiv" style="display: none;">
				<button id="closeRoomChartBtn" style="border: none; background-color: white; margin-top: 10px; margin-left: 750px; font-size: 1.5em;">×</button>
				<canvas id="roomChart" width="750px;" height="500px;"></canvas>
			</div>
		</div>
	</div>
</div>


<script>

const yearChart = $('#yearChart');
const monthChart = $('#monthChart');
const roomChart = $('#roomChart');


$('#prev').on('click', function(){
	let year = Number($('#year').text());
	year--;
	$('#year').text(year);
	getYearAvg();
})

$('#next').on('click', function(){
	let year = Number($('#year').text());
	year++;
	$('#year').text(year);
	getYearAvg();
})

let totalCt = [];
let payCt = [];
let nonPayCt = [];
let lateCt = [];
function getYearAvg(){
	totalCt = [];
	payCt = [];
	nonPayCt = [];
	lateCt = [];
	
	let data = {
			year: $('#year').text(),
			danjiCode: 'D001'
	};

	$.ajax({
		url:"/charge/getYearAvg",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
// 			console.log(result);
			let total = 0;
			let payTotal = 0;
			let nonPayTotal = 0;
			let lateTotal = 0;
			for(let i=0; i<result.length; i++){
				total += result[i].payCt + result[i].nonPayCt + result[i].lateCt;
				payTotal += result[i].payCt;
				nonPayTotal += result[i].nonPayCt;
				lateTotal += result[i].lateCt;
				
				totalCt.push(result[i].payCt + result[i].nonPayCt + result[i].lateCt);
				payCt.push(result[i].payCt);
				nonPayCt.push(result[i].nonPayCt);
				lateCt.push(result[i].lateCt);
				
			}
			
			$('#total').text(total.toLocaleString('ko-KR'));
			$('#payTotal').text(payTotal.toLocaleString('ko-KR'));
			$('#nonPayTotal').text(nonPayTotal.toLocaleString('ko-KR'));
			$('#lateTotal').text(lateTotal.toLocaleString('ko-KR'));
			newYearChart(totalCt, payCt, nonPayCt, lateCt);
		}
	});
}

function newYearChart(totalCt, payCt, nonPayCt, lateCt){
	let chartStatus = Chart.getChart('yearChart');
	Chart.defaults.font.size = 16;
	if (chartStatus === undefined) {
		new Chart(yearChart, {
		    type: 'bar',
		    data: {
		    	labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    	datasets: [{
		    		label: '월별 총액',
		    		backgroundColor: '#1fab89',
		    		data: totalCt,
		    	},{
		    		label: '월별 납부액',
		    		backgroundColor: '#299cdb',
		    		data: payCt,
		    	}, {
		    		label: '월별 미납액',
		    		backgroundColor: '#f7b84b',
		    		data: nonPayCt,
		    	}, {
		    		label: '월별 연체액',
		    		backgroundColor: '#fe4880',
		    		data: lateCt,
		    	}],
		    },
		    options: {
				responsive: false,
		    }
		});
	}else{
		chartStatus.data.labels = ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'];
		chartStatus.data.datasets[0].data =  totalCt;
		chartStatus.data.datasets[1].data =  payCt;
		chartStatus.data.datasets[2].data =  nonPayCt;
		chartStatus.data.datasets[3].data =  lateCt;
		chartStatus.update();
	}
}

getYearAvg();

let ym;
$('#yearChart').on('click', function(evt){
	let myChart = Chart.getChart('yearChart');
	const point = myChart.getElementsAtEventForMode(evt, 'nearest', {intersect: true}, true);
	
// 	console.log(">>", point);
	if(point.length){
		const firstPoint = point[0];
		let label = myChart.data.labels[firstPoint.index];
// 		console.log(">>>", label);
		
		let year = $("#year").text();
		let month = Number(label.split('월')[0]);
		
		if(month < 10)	month = '0' + month;
		
		ym = year + "-" + month;
// 		console.log("ym", ym);
		
		window.scrollTo(0, 500);
		
		getMonthList(ym, 'D001', '', '');
	}
})

$('.codeSrch').on('keyup', function(){

    if (!$.fn.DataTable.isDataTable('.chargeTbl')) {
		return;
    }
    
	let dongCode = $("#dongCode").val();
	let roomCode = $("#roomCode").val();
	
	getMonthList(ym, 'D001', dongCode, roomCode);
})

function getMonthList(ym, danjiCode, dongCode, roomCode){
	let data = {
		ym: ym,	
		danjiCode: danjiCode, 
		dongCode: dongCode, 
		roomCode: roomCode
	};
	
	$.ajax({
		url:"/charge/getMonthList",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			console.log(result);
			let str = '';
			
			let totalOnList = 0;
			let lateTotalOnList = 0;
			
			let cntPay = 0;		// payDt가 y인 사람
			let cntNonPay = 0;	// payDt가 n이면서 lateCt가 0인 사람
			let cntLate = 0;	// payDt가 n이면서 lateCt가 0보다 큰 사람
			for(let i=0; i<result.length; i++){
				if(result[i].payYn == 'Y' && result[i].lateCt == 0)	cntPay++;
				if(result[i].payYn == 'N' && result[i].lateCt == 0)	cntNonPay++;
				if(result[i].lateCt > 0)							cntLate++;
				
				totalOnList += Number(result[i].totalCt);
				lateTotalOnList += Number(result[i].lateCt);
				
				str += '<tr class="detail">';
				str += '<td class="center">' + result[i].roomCode.substr(5, 3) + '</td>';
				str += '<td class="center">' + result[i].roomCode.substr(9, 4) + '</td>';
				str += '<td class="right">' + result[i].totalCt.toLocaleString('ko-KR') + '원</td>';
				if(result[i].payYn == 'Y')	str += '<td class="center">' + '납부' + '</td>';
				else						str += '<td class="center">' + '미납' + '</td>';
				if(!result[i].payDt)		str += '<td class="center">' + '-' + '</td>';
				else						str += '<td class="center">' + result[i].payDt.split('.')[0] + '</td>';
				str += '<td class="right">' + result[i].lateCt.toLocaleString('ko-KR') + '원</td>';
				str += '</tr>';
			}
			
	        // 기존 DataTable 인스턴스 제거
	        if ($.fn.DataTable.isDataTable('.chargeTbl')) {
	            $('.chargeTbl').DataTable().destroy();
	        }
	        
			// 동별 차트 그리기
			newMonthChart(cntPay, cntNonPay, cntLate);
			
			$('#trShow').html(str);
			
			$('#totalOnList').text(totalOnList.toLocaleString('ko-KR') + '원');
			$('#lateTotalOnList').text(lateTotalOnList.toLocaleString('ko-KR') + '원');

			$('.chargeTbl').DataTable({
				"fixedHeader": true,
				"scrollY": '400px',
		        "autoWidth": false,
		        "order": [[0, "asc"]], 
		        "searching": false,
		        "paging": false,
		        "ordering": true,
		        "info": true,
		        "lengthChange": false,
		        "language": {
		            "zeroRecords": "부과된 관리비가 없습니다.",
		            "search": "",
		            "paginate": {
		                "next": "다음",
		                "previous": "이전"
		            },
		            "info": "TOTAL :  _TOTAL_ 건"
		        }
		    });
		}
	})
}

function newMonthChart(cntPay, cntNonPay, cntLate){
	let chartStatus = Chart.getChart('monthChart');
	if (chartStatus === undefined) {
		new Chart(monthChart, {
		    type: 'pie',
		    data: {
		    	labels: ['납부자 수', '미납자 수', '연체자 수'],
		    	datasets: [{
		    		data: [cntPay, cntNonPay, cntLate],
		    		backgroundColor: ['#299cdb', '#f7b84b', '#fe4880'],
		    	}]
		    },
		    options: {
				responsive: false,
			    indexAxis: 'y',
			    plugins:{
					datalabels: {
						color: 'white',
						font: {
							size: 20,
							weight: 'bold'
						},
				    }
			    }
		    },
		    plugins: [ChartDataLabels],
		});
	}else{
		chartStatus.data.labels = ['납부자 수', '미납자 수', '연체자 수'];
		chartStatus.data.datasets[0].data =  [cntPay, cntNonPay, cntLate];
		chartStatus.data.datasets[0].backgroundColor =  ['#299cdb', '#f7b84b', '#fe4880'];
		chartStatus.update();
	}
}


$(document).on('click', ".detail", function(){
	let roomNum = $(this).children().eq(0).text() + "동" + $(this).children().eq(1).text() + "호";
	let data = {
			roomCode: 'D001_' + $(this).children().eq(0).text() + "_" + $(this).children().eq(1).text(),
			ym: ym
	};
	
// 	console.log("detail->data: ", data);

	$.ajax({
		url:"/charge/getDetail",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			console.log(result);
			
			let chartData = [];
			chartData.push(result.commons);
			chartData.push(result.cleaning);
			chartData.push(result.disinfec);
			chartData.push(result.secure);
			chartData.push(result.elevator);
			chartData.push(result.ltrr);
			chartData.push(result.facilities);
			chartData.push(result.vat);
			chartData.push(result.consignment);
			chartData.push(result.meeting);
			chartData.push(result.buildingInsr);
			chartData.push(result.electrocity);
			chartData.push(result.water);
			chartData.push(result.heating);
			
			let bgColor = [];
			for(let i=0; i<14; i++){
				let color = 'rgba('+Math.round(Math.random()*255)+', '+Math.round(Math.random()*255)+', '+Math.round(Math.random()*255)+', 0.7)';
				bgColor.push(color);
			}
			newRoomChart(roomNum, chartData, bgColor);
		}
	});
})

function newRoomChart(roomCode, data, bgColor){
	let chartStatus = Chart.getChart('roomChart');
	if (chartStatus === undefined) {
		$('#monthChartDiv').css('display', 'none');
		$('#roomChartDiv').css('display', 'block');
		new Chart(roomChart, {
		    type: 'bar',
		    data: {
		    	labels: ['일반관리비', '소독비', '청소비', '경비비', '승강기유지비', '장기수선충당금', '시설유지비', '부가세', '위탁관리수수료', '입주자대표회의운영비', '건물보험료', '전기료', '수도료', '난방료'],
		    	datasets: [{
		    		label: roomCode,
		    		data: data,
		    		backgroundColor: bgColor,
		    	}]
		    },
		    options: {
				responsive: false,
			    indexAxis: 'y',
		    }
		});
	}else{
		chartStatus.data.labels = ['일반관리비', '소독비', '청소비', '경비비', '승강기유지비', '장기수선충당금', '시설유지비', '부가세', '위탁관리수수료', '입주자대표회의운영비', '건물보험료', '전기료', '수도료', '난방료'];
		chartStatus.data.datasets[0].label =  roomCode;
		chartStatus.data.datasets[0].data =  data;
		chartStatus.data.datasets[0].backgroundColor =  bgColor;
		chartStatus.update();
	}
}

$('#closeRoomChartBtn').on('click', function(){
	let chartStatus = Chart.getChart('roomChart');
	if (chartStatus !== undefined) {
		chartStatus.destroy();
		$('#monthChartDiv').css('display', 'block');
		$('#roomChartDiv').css('display', 'none');
	}
})

/* 연체 처리 로직 */
let date = new Date();
if(date.getDate() >= 22){
	$('#lateProcBtn').removeAttr('disabled');
}

$('#lateProcBtn').on('click', function(){
	Swal.fire({
		title: "연체료를 부과하시겠습니까?",
		icon: "warning",
        showCancelButton: true,
        confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
        cancelButtonClass: 'btn btn-danger w-xs mt-2',
        confirmButtonText: "예",
        cancelButtonText: "아니오",
        buttonsStyling: false,
        showCloseButton: true
	}).then(function (result) {
		if(result.value){
			$.ajax({
				url:"/charge/lateProc",
				contentType:"application/json;charset=utf-8",
				type:"post",
				dataType:"json",
				beforeSend: function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
//		 			console.log(result);
					if(result == 0){
			            Swal.fire({
			                icon: 'error',
			                title: '에러!',
			                text: '이번달은 이미 연체료를 부과하였습니다.'
			            });
					}else{
						location.reload();
					}
				}
			});
		}
	});
	
})
</script>
