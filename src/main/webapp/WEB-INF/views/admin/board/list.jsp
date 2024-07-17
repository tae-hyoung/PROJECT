<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
   src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<link rel="stylesheet"
   href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
<!--datatable responsive css-->
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">
<!-- datatable js -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>

<style>
th{
	text-align: center;
}

.center{
	text-align: center;
}

.right{
	text-align: right;
}

tbody tr:hover{
	background-color: lightgrey;
}
#replyTbl {
    width: 100% !important;
}

/* 정렬 버튼의 기본 크기와 위치 재정의 */
.dataTables_wrapper .dataTables_scrollHead .sorting:after,
.dataTables_wrapper .dataTables_scrollHead .sorting_asc:after,
.dataTables_wrapper .dataTables_scrollHead .sorting_desc:after {
    font-size: 5px; /* 정렬 버튼의 크기 조정 */
    right: 10px; /* 정렬 버튼의 오른쪽 위치 조정 */
    top: 50%; /* 정렬 버튼의 상단 위치 조정 */
    transform: translateY(-50%); /* 수직 중앙 정렬 */
}
/* 개별 열 너비 조정 */
#replyTbl th, #replyTbl td {
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
}
#replyTbl th:nth-child(2), #replyTbl td:nth-child(2) {
    width: 15%; /* 작성자 열 너비 */
}
#replyTbl th:nth-child(3), #replyTbl td:nth-child(3) {
    width: 55%; /* 댓글 열 너비 */
}
#replyTbl th:nth-child(4), #replyTbl td:nth-child(4) {
    width: 10%; /* 작성일 열 너비 */
}
#replyTbl th:nth-child(5), #replyTbl td:nth-child(5) {
    width: 5%; /* 추천수 열 너비 */
}
#replyTbl th:nth-child(6), #replyTbl td:nth-child(6) {
    width: 5%; /* 누적신고수 여부 열 너비 */
}
#replyTbl th:nth-child(7), #replyTbl td:nth-child(7) {
    width: 5%; /* 삭제 여부 열 너비 */
}
#replyTbl th:nth-child(8), #replyTbl td:nth-child(8) {
    width: 5%; /* 삭제 열 너비 */
}

#reportTbl th, #replyTbl td {
    white-space: nowrap; 
}
#reportTbl th:nth-child(1), #reportTbl td:nth-child(1) {
    width: 10%; 
}
#reportTbl th:nth-child(2), #reportTbl td:nth-child(2) {
    width: 20%; 
}
#reportTbl th:nth-child(3), #reportTbl td:nth-child(3) {
    width: 5%; 
}
#reportTbl th:nth-child(4), #reportTbl td:nth-child(4) {
    width: 65%; 
}

.minHeight{
	min-height: 150px;
}
</style>


<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="bx bx-edit"></i><strong> 게시판 관리 </strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">게시판</a></li>
						<li class="breadcrumb-item active">관리</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="col-12">
	<div class="card">
		<div class="card-header">
			<ul class="nav nav-tabs nav-justified mb-3" role="tablist">
				<li class="nav-item" role="presentation">
					<a class="nav-link active" id="manageTab" data-bs-toggle="tab" href="#manage" role="tab" aria-selected="false" tabindex="-1"> 게시판 관리 </a>
				</li>
				<li class="nav-item" role="presentation">
					<a class="nav-link" id="chartTap" data-bs-toggle="tab" href="#chart" role="tab" aria-selected="false" tabindex="-1"> 통계 </a>
				</li>
			</ul>
		</div>

		<div class="card-body table-responsive" style="min-height: 600px;">
			<div class="tab-content  text-muted" style="min-height: 550px;">
				<!-- 상세 모달 시작 -->
				<div id="boardModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				    <div class="modal-dialog modal-xl">
				        <div class="modal-content">
				        	<div class="modal-header row">
								<div class="col-6"><h1 id="brdNo"></h1></div>
								<div class="col-6" style="display: flex; justify-content: flex-end;">
									<button type="button" id="close" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#boardModal">닫기</button>
									<button type="button" id="delBtn" class="btn btn-outline-danger">삭제</button>
									<div class="form-check form-switch form-switch-lg" dir="ltr" style="margin-top: 5px; margin-left: 10px;">
										<input type="checkbox" class="form-check-input" id="toggleBlind">
										<label for="toggleBlind">블라인드</label>
									</div>
								</div>
				        	</div>
				        	<div class="modal-body">
								<div style="min-height: 300px;">
									<span>게시글 내용: </span>
									<div id="brdContent"></div>
								</div>
								<hr>
								<div style="min-height: 300px;">
									<span>댓글 목록: </span>
									<div id="replyList"></div>
								</div>
			        			<div style="display: flex; justify-content: flex-end;">
			        			</div>
				        	</div>
						</div>
					</div>
				</div>
				<!-- 상세 모달 끝 -->
				<!-- 신고 사유 모달 시작 -->
				<div id="reportModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				    <div class="modal-dialog modal-lg">
				        <div class="modal-content">
				        	<div class="modal-header row">
								<div class="col-6"><h1>신고 사유</h1></div>
								<div class="col-6" style="display: flex; justify-content: flex-end;">
									<button type="button" id="close" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#reportModal">닫기</button>
								</div>
				        	</div>
				        	<div class="modal-body" id="reportReason"></div>
						</div>
					</div>
				</div>
				<!-- 신고 사유 모달 끝 -->
				<div class="tab-pane active show" id="manage" role="tabpanel">
					<div class="row" id="filter">
						<div class="col-6">
							<select name="selCat" id="selCat" class="form-control">
								<option value="board_all">전체 보기</option>
								<option value="board_notice">공지 게시판</option>
								<option value="board_free">자유 게시판</option>
								<option value="board_trade">중고 게시판</option>
							</select>
						</div>
						<div class="col-6" style="display: flex; justify-content: flex-end;">
							<span style="color: red; margin-right: 10px; margin-top: 18px;">※ 누적 신고수를 클릭하면 신고 내역을 볼 수 있습니다.</span>
							<div class="input-group input-group-sm" style="width: 300px;">
								<input type="text" name="table_search" id="brdKeyword" class="form-control float-right" placeholder="Search">
								<div class="input-group-append">
									<button type="button" class="btn btn-outline-dark" id="brdSearch"><i class="bx bx-search-alt-2"></i></button>
								</div>
							</div>
						</div>
					</div>
					<div style="min-height: 490px;">
						<table class="table table-head-fixed text-nowrap test">
							<thead>
								<tr>
									<th>카테고리</th>
									<th>작성자</th>
									<th>제목</th>
									<th>등록일</th>
									<th>최종수정일</th>
									<th>조회수</th>
									<th>추천수</th>
									<th>누적 신고수</th>
									<th>블라인드 여부</th>
									<th>삭제 여부</th>
									<th></th>
								</tr>
							</thead>
							<tbody id="trShow" style="font-size: 16px;">
								<c:forEach var="boardVO" items="${articlePage.content}" varStatus="stat">
									<tr>
										<td style="display: none">${boardVO.brdSeq}</td>
										<td style="display: none">${boardVO.content}</td>
										<td class="center">
											<c:if test="${boardVO.brdCat eq 'board_notice'}">공지게시판</c:if> 
											<c:if test="${boardVO.brdCat eq 'board_free'}">자유게시판</c:if> 
											<c:if test="${boardVO.brdCat eq 'board_trade'}">중고거래게시판</c:if> 
										</td>
										<td>${boardVO.memId}</td>
										<td>${boardVO.title}</td>
										<td class="center">${boardVO.regDt}</td>
										<td class="center">${boardVO.updDt}</td>
										<td class="center">${boardVO.viewCnt}</td>
										<td class="center">${boardVO.likeCnt}</td>
										<td class="center reportDetail" data-bs-toggle="modal" data-bs-target="#reportModal">${boardVO.reportCnt}</td>
										<td class="center">${boardVO.blindYn}</td>
										<td class="center">${boardVO.delYn}</td>
										<td><span class="badge badge-label bg-primary detail" data-bs-toggle="modal" data-bs-target="#boardModal" ><i class="mdi mdi-circle-medium"></i>상세보기</span></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="row">
						<div class="col-5"></div>	
				        <div class="col-3 clsPagingArea" style="float: left">
				           ${articlePage.pagingArea}
				        </div>
				        <div class="col-4 row">
				        	<div class="col-8">
				        	</div>
				        	<div class="col-4">
					        	<a href="/board/admin/insert" class="btn btn-outline-primary"> 게시글 등록 </a>
				        	</div>
				        </div>
					</div>
				</div>
				<div class="tab-pane" id="chart" role="tabpanel">
					<div style="display: flex;">
						<canvas id="dateChart" width="800px" height="500px"></canvas>
						<canvas id="cateChart" width="800px" height="500px"></canvas>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>

$(function(){
	const dateChart = document.querySelector('#dateChart');
	const cateChart = document.querySelector('#cateChart');
	getChartData();
})

function getChartData(){
	$.ajax({
		url:"/board/admin/chartData",
		contentType:"application/json;charset=utf-8",
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			console.log(result);
			// 차트 그리기
			let dateDataset = result[0];
			let dateLabel = [];
			let dateData = [];
			for(let i=0; i<dateDataset.length; i++){
				dateLabel.push(dateDataset[i].REG_DT);
				dateData.push(dateDataset[i].CNT);
			}
			
			let cateDataset = result[1];
			let cateLabel = [];
			let cateData = [];
			for(let i=0; i<cateDataset.length; i++){
				let brdCat;
				switch(cateDataset[i].BRD_CAT){
					case 'board_free': brdCat = '자유게시판'; 		break;
					case 'board_notice': brdCat = '공지게시판';		break;
					case 'board_trade': brdCat = '중고거래게시판';
				}
				cateLabel.push(brdCat);
				cateData.push(cateDataset[i].CNT);
			}
			
			// dateChart
			new Chart(dateChart, {
				type: 'line',
				data: {
					labels: dateLabel,
					datasets:[{
						label: '일별 게시글 등록 현황',
						data: dateData,
					}]
				},
				options: {
					responsive: false,
					
				}
			});
			
			// cateChart
			new Chart(cateChart, {
				type: 'pie',
				data: {
					labels: cateLabel,
					datasets:[{
						data: cateData,
					}]
				},
				options: {
					responsive: false,
					plugins:{
		                datalabels: {
		                    color: 'white',
		                    font: {
		                        size: 20,
		                        weight: 'bold'
		                    },
		                    formatter: (value) => {
		                        return value;
		                    }
		                }
					}
				},
				plugins: [ChartDataLabels],
			});
		}
	})
}

$(document).on('click', ".detail", function(){
	$('#brdNo').text($(this).parent().parent().children().eq(0).text());
	$('#brdContent').html($(this).parent().parent().children().eq(1).html());
	let delYn = $(this).parent().parent().children().eq(11).text();
	let blindYn = $(this).parent().parent().children().eq(10).text();
	
	if(delYn == 'Y'){
		$('#delBtn').text('삭제 취소');
	}else{
		$('#delBtn').text('삭제')
	}
	
	if(blindYn == 'Y'){
		$('#toggleBlind')[0].checked = true;
	}else{
		$('#toggleBlind')[0].checked = false;
	}
	
	let data = {
			admin: 'admin',
			brdNo: $(this).parent().parent().children().eq(0).text()
	}
	
	$.ajax({
		url:"/board/replyList",
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
			
			str += '<table id="replyTbl" class="display">';
			str += '<thead>';
			str += '<tr>';
			str += '<th style="display: none;"></th>';
			str += '<th>작성자</th>';
			str += '<th>댓글</th>';
			str += '<th>작성일</th>';
			str += '<th>추천수</th>';
			str += '<th>누적신고수</th>';
			str += '<th>삭제여부</th>';
			str += '<th></th>';
			str += '</tr>';
			str += '</thead>';
			str += '<tbody>';
			for(let i=0; i<result.length; i++){
				str += '<tr>';
				str += '<td style="display: none;">'+ result[i].repSeq +'</td>';
				str += '<td>'+ result[i].memId +'</td>';
				str += '<td>'+ result[i].content +'</td>';
				str += '<td class="center">'+ result[i].regDt +'</td>';
				str += '<td class="center">'+ result[i].likeCnt +'</td>';
				str += '<td class="center">'+ result[i].reportCnt +'</td>';
				str += '<td class="center">'+ result[i].delYn +'</td>';
				if(result[i].delYn == 'Y')	str += '<td class="center replyDel">'+ '<a>삭제취소</a>' +'</td>';
				else						str += '<td class="center replyDel">'+ '<a>삭제</a>' +'</td>';
				str += '</tr>';
			}
			str += '</tbody>';
			str += '</table>';
			
			$('#replyList').html(str);
			

			$('#replyTbl').DataTable({
		        "autoWidth": false,
		        "searching": false,
		        "paging": true,
		        "ordering": false,
		        "info": true,
		        "lengthChange": false,
		        "pageLength": 5,
		        "language": {
		            "zeroRecords": "등록된 댓글이 없습니다.",
		            "search": "",
		            "paginate": {
		                "next": "다음",
		                "previous": "이전"
		            },
		            "info": "TOTAL :  _TOTAL_ 건<br>PAGE : _PAGE_ 페이지/ _PAGES_ 페이지 "
		        },
                "initComplete": function(settings, json) {
                    $('#replyTbl_wrapper .row:eq(1)').addClass('minHeight'); // 원하는 클래스 추가
                }
		    });
		}
	})
});

let btnFlag = false;
$("#brdSearch").on('click', function(){
	btnFlag = true;
	let keyword = $("#brdKeyword").val();
// 	console.log("keyword: ", keyword);
	getList(keyword, 1);
})

function getList(keyword, currentPage){
	let data = {
		"keyword": keyword,
		"currentPage": currentPage
	};
	
	$.ajax({
		url:"/board/admin/list",
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
			let brdCat = "";
			$.each(result.content, function(idx,boardVO){
				if(boardVO.brdCat == 'board_notice')	brdCat = "공지게시판";
				if(boardVO.brdCat == 'board_free')		brdCat = "자유게시판";
				if(boardVO.brdCat == 'board_trade')		brdCat = "중고거래게시판";
				
				str += "<tr>";
				str += "<td style='display: none'>"+(boardVO.brdSeq)+"</td>";
				str += "<td style='display: none'>"+(boardVO.content)+"</td>";
				str += "<td class='center'>"+brdCat+"</td>";
				str += "<td>"+boardVO.memId+"</td>";
				str += "<td>"+boardVO.title+"</td>";
				str += "<td class='center'>"+boardVO.regDt+"</td>";
				str += "<td class='center'>"+boardVO.updDt+"</td>";
				str += "<td class='center'>"+boardVO.viewCnt+"</td>";
				str += "<td class='center'>"+boardVO.likeCnt+"</td>";
				str += "<td class='center reportDetail' data-bs-toggle='modal' data-bs-target='#reportModal'>"+boardVO.reportCnt+"</td>";
				str += "<td class='center'>"+boardVO.blindYn+"</td>";
				str += "<td class='center'>"+boardVO.delYn+"</td>";
				str += "<td><span class='badge badge-label bg-primary detail' data-bs-toggle='modal' data-bs-target='#boardModal' ><i class='mdi mdi-circle-medium'></i>상세보기</span></td>";
				str += "</tr>";
			});
			
			$(".clsPagingArea").html(result.pagingArea);
			$("#trShow").html(str);
		}
	});
}

$('#delBtn').on('click', function(){
	/* 페이징 및 키워드 추출 시작 */
	let currentPage;	
	let keyword;
	let queryString = window.location.search;
	if(queryString){
		let parameters = queryString.split('&');
		
		currentPage = parameters[0].split('=')[1];
		keyword = parameters[1].split('=')[1];
	}
	if(btnFlag){
		currentPage = 1;
		keyword = $('#brdKeyword').val();
	}
	if(currentPage == null)	currentPage = 1;
	if(keyword == null)	keyword = '';
	/* 페이징 및 키워드 추출 끝 */
	
	status = $(this).text();
	console.log('status: ', status);
	if(status == '삭제'){
		delYn = 'Y';
		confirmStr = '삭제하시겠습니까?';
	}
	else{
		delYn = 'N';
		confirmStr = '삭제를 취소 하시겠습니까?';
	}
	let data = {
			brdSeq: $('#brdNo').text(),
			delYn: delYn
	}
	console.log('data', data);
	
	
	
	Swal.fire({
		title: "삭제 하시겠습니까?",
		icon: "warning",
        showCancelButton: true,
        confirmButtonClass: 'btn btn-outline-primary w-xs me-2 mt-2',
        cancelButtonClass: 'btn btn-outline-danger w-xs mt-2',
        confirmButtonText: "예",
        cancelButtonText: "아니오",
        buttonsStyling: false,
        showCloseButton: true
	}).then(function (result) {
		if(result.value){
			$.ajax({
				url:"/board/admin/delete",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"json",
				beforeSend: function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success:function(result){
					console.log("result : ", result);
					getList(keyword, currentPage);
					
					if(status == '삭제')	{
						$('#delBtn').text('삭제 취소');
			            Swal.fire({
			                icon: 'warning',
			                title: '삭제!',
			                text: '삭제가 완료되었습니다.'
			            });
					}
					else{
						$('#delBtn').text('삭제');
			            Swal.fire({
			                icon: 'warning',
			                title: '삭제 취소!',
			                text: '삭제가 취소되었습니다.'
			            });
					}
				}
			});
		}else{
            Swal.fire({
                title: '삭제가 취소되었습니다.',
                icon: 'error',
                showConfirmButton: false,
                timer: 1500,
                showCloseButton: false
            });
		}
	});
	
	
	
	
	
// 	if(confirm(confirmStr)){
// 		$.ajax({
// 			url:"/board/admin/delete",
// 			contentType:"application/json;charset=utf-8",
// 			data:JSON.stringify(data),
// 			type:"post",
// 			dataType:"json",
// 			beforeSend: function(xhr){
// 				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
// 			},
// 			success:function(result){
// 				console.log("result : ", result);
// 				getList(keyword, currentPage);
				
// 				if(status == '삭제')	{
// 					$('#delBtn').text('삭제 취소');
// 		            Swal.fire({
// 		                icon: 'info',
// 		                title: '삭제!',
// 		                text: '삭제가 완료되었습니다.'
// 		            });
// 				}
// 				else{
// 					$('#delBtn').text('삭제');
// 		            Swal.fire({
// 		                icon: 'info',
// 		                title: '삭제 취소!',
// 		                text: '삭제가 취소되었습니다.'
// 		            });
// 				}
// 			}
// 		});
// 	}


})

$('#toggleBlind').on('change', function(){
	let currentPage;	
	let keyword;
	
	let queryString = window.location.search;
	if(queryString){
		let parameters = queryString.split('&');
		
		currentPage = parameters[0].split('=')[1];
		keyword = parameters[1].split('=')[1];
	}

// 	console.log(btnFlag);
	if(btnFlag){
		currentPage = 1;
		keyword = $('#brdKeyword').val();
	}
	
	if(currentPage == null)	currentPage = 1;
	if(keyword == null)	keyword = '';
// 	console.log("currentPage: ", currentPage);
// 	console.log("keyword: ", keyword);
	
	let data = {
			brdSeq: $('#brdNo').text(),
			blind: $("#toggleBlind")[0].checked
	}
	
// 	console.log("data: ", data);
	
	$.ajax({
		url:"/board/blind",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			console.log("result : ", result);
			getList(keyword, currentPage);
		}
	})

})

$(document).on('click', ".reportDetail", function(){
	let data = {
			brdNo: $(this).parent().children().eq(0).text()
	};
// 	console.log(data);
	
	$.ajax({
		url:"/board/admin/reportList",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			console.log("result : ", result);
			
			let str = '';
			str += '<table id="reportTbl">';
			str += '<thead>';
			str += '<tr>';
			str += '<th>신고자</th>';
			str += '<th>신고일시</th>';
			str += '<th>신고사유</th>';
			str += '<th>상세사유</th>';
			str += '</tr>';
			str += '</thead>';
			str += '<tbody>';
			for(let i=0; i<result.length; i++){
				str += '<tr>';
				str += '<td>' + result[i].reporter + '</td>'
				str += '<td class="center">' + result[i].regDt + '</td>'
				str += '<td class="center">' + result[i].rptCat + '</td>'
				if(result[i].reason == null)	reason = '';
				else							reason = result[i].reason;
				str += '<td>' + reason + '</td>'
				str += '</tr>';
			}
			str += '</tbody>';
			str += '</table>';
			
			$('#reportReason').html(str);

			$('#reportTbl').DataTable({
		        "autoWidth": false,
		        "searching": false,
		        "paging": true,
		        "ordering": false,
		        "info": true,
		        "lengthChange": false,
		        "pageLength": 5,
		        "language": {
		            "zeroRecords": "해당 게시물은 신고된 적이 없습니다.",
		            "search": "",
		            "paginate": {
		                "next": "다음",
		                "previous": "이전"
		            },
		            "info": "TOTAL :  _TOTAL_ 건<br>PAGE : _PAGE_ 페이지/ _PAGES_ 페이지 "
		        },
                "initComplete": function(settings, json) {
                    $('#replyTbl_wrapper .row:eq(1)').addClass('minHeight'); // 원하는 클래스 추가
                }
		    });
		}
	})
})

$(document).on('click', ".replyDel", function(){
	let brdNo = $('#brdNo').text();
	let repNo = $(this).parent().children().eq(0).text();
	let status = $(this).parent().children().eq(6).text();
	let delYn = '';
	let confirmStr = '';
	
	if(status == 'Y'){
		confirmStr = '삭제를 취소하시겠습니까?';
		delYn = 'N';
	}else{
		confirmStr = '댓글을 삭제하시겠습니까?';
		delYn = 'Y';
	}
	
	let data = {
			admin: 'admin',
			delYn: delYn,
			brdNo: brdNo,
			repNo: repNo
	};
// 	console.log("data:", data);
	
	if(confirm(confirmStr)){
		$.ajax({
			url:"/board/repDel",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend: function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success:function(result){
				console.log("result : ", result);
	
				let str = '';
				
				str += '<table id="replyTbl" class="display">';
				str += '<thead>';
				str += '<tr>';
				str += '<th style="display: none;"></th>';
				str += '<th>작성자</th>';
				str += '<th>댓글</th>';
				str += '<th>작성일</th>';
				str += '<th>추천수</th>';
				str += '<th>누적신고수</th>';
				str += '<th>삭제여부</th>';
				str += '<th></th>';
				str += '</tr>';
				str += '</thead>';
				str += '<tbody>';
				for(let i=0; i<result.length; i++){
					str += '<tr>';
					str += '<td style="display: none;">'+ result[i].repSeq +'</td>';
					str += '<td>'+ result[i].memId +'</td>';
					str += '<td>'+ result[i].content +'</td>';
					str += '<td class="center">'+ result[i].regDt +'</td>';
					str += '<td class="center">'+ result[i].likeCnt +'</td>';
					str += '<td class="center">'+ result[i].reportCnt +'</td>';
					str += '<td class="center">'+ result[i].delYn +'</td>';
					if(result[i].delYn == 'Y')	str += '<td class="center replyDel">'+ '<a>삭제취소</a>' +'</td>';
					else						str += '<td class="center replyDel">'+ '<a>삭제</a>' +'</td>';
					str += '</tr>';
				}
				str += '</tbody>';
				str += '</table>';
				
				$('#replyList').html(str);
				
	
				$('#replyTbl').DataTable({
			        "autoWidth": false,
			        "searching": false,
			        "paging": true,
			        "ordering": false,
			        "info": true,
			        "lengthChange": false,
			        "pageLength": 5,
			        "language": {
			            "zeroRecords": "등록된 댓글이 없습니다.",
			            "search": "",
			            "paginate": {
			                "next": "다음",
			                "previous": "이전"
			            },
			            "info": "TOTAL :  _TOTAL_ 건<br>PAGE : _PAGE_ 페이지/ _PAGES_ 페이지 "
			        },
	                "initComplete": function(settings, json) {
	                    $('#replyTbl_wrapper .row:eq(1)').addClass('minHeight'); // 원하는 클래스 추가
	                }
			    });
			}
		})
	}
});

$('#selCat').on('change', function(){
	/* 페이징 및 키워드 추출 시작 */
	let currentPage;	
	let keyword;
	let queryString = window.location.search;
	if(queryString){
		let parameters = queryString.split('&');
		
		currentPage = parameters[0].split('=')[1];
		keyword = parameters[1].split('=')[1];
	}
	if(btnFlag){
		currentPage = 1;
		keyword = $('#brdKeyword').val();
	}
	if(currentPage == null)	currentPage = 1;
	if(keyword == null)	keyword = '';
	/* 페이징 및 키워드 추출 끝 */
	
	let data = {
		"boardCat": $(this).val(),
		"keyword": keyword,
		"currentPage": currentPage
	};
	
	$.ajax({
		url:"/board/ListByCat",
		contentType:"application/json;charset=utf-8",
		data:JSON.stringify(data),
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
 			console.log("result : ", result);
			
			let str = "";
			let brdCat = "";
			$.each(result.content, function(idx,boardVO){
				if(boardVO.brdCat == 'board_notice')	brdCat = "공지게시판";
				if(boardVO.brdCat == 'board_free')		brdCat = "자유게시판";
				if(boardVO.brdCat == 'board_trade')		brdCat = "중고거래게시판";
				
				str += "<tr>";
				str += "<td style='display: none'>"+(boardVO.brdSeq)+"</td>";
				str += "<td style='display: none'>"+(boardVO.content)+"</td>";
				str += "<td class='center'>"+brdCat+"</td>";
				str += "<td>"+boardVO.memId+"</td>";
				str += "<td>"+boardVO.title+"</td>";
				str += "<td class='center'>"+boardVO.regDt+"</td>";
				str += "<td class='center'>"+boardVO.updDt+"</td>";
				str += "<td class='center'>"+boardVO.viewCnt+"</td>";
				str += "<td class='center'>"+boardVO.likeCnt+"</td>";
				str += "<td class='center reportDetail' data-bs-toggle='modal' data-bs-target='#reportModal'>"+boardVO.reportCnt+"</td>";
				str += "<td class='center'>"+boardVO.blindYn+"</td>";
				str += "<td class='center'>"+boardVO.delYn+"</td>";
				str += "<td><span class='badge badge-label bg-primary detail' data-bs-toggle='modal' data-bs-target='#boardModal' ><i class='mdi mdi-circle-medium'></i>상세보기</span></td>";
				str += "</tr>";
			});
			
			$(".clsPagingArea").html(result.pagingArea);
			$("#trShow").html(str);
		}
	});
})

$('.nav-link').on('click', tabColor);
$('#manageTab').css('background-color', 'lightgray');
function tabColor(){
	if($('.nav-link').attr('aria-selected')){
		$('#manageTab').css('background-color', 'white');
		$('#chartTap').css('background-color', 'white');
		$(this).css('background-color', 'lightgray');
	}
}
</script>
