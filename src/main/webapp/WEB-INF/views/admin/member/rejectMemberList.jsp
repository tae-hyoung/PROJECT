<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
	.gridjs-search {
		display: flex;
		margin-left: auto !important;
	}
	
	th, td {
		font-size: 16px;
	}
</style>
<div style="width:100%; overflow-x: auto; display: flex; align-items: center;" class="auth-page-content" class="row">
	<div class="col-lg-12">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title mb-0">입주민 반려 현황</h3>
			</div>
			<!-- end card header -->
			<div class="card-body">
				<div id="table-search">
					<div role="complementary" class="gridjs gridjs-container" style="width: 100%;">
						<div class="d-flex justify-content-end">
							<div class="gridjs-search">
								<input type="search" placeholder="ID 또는 신청자 명 입력" aria-label="검색키워드"
									class="gridjs-input gridjs-search-input" id="searchInput">
							</div>
						</div>
						<div class="gridjs-wrapper" style="height: auto;">
							<table role="grid" class="gridjs-table" style="height: auto;">
								<thead class="gridjs-thead">
									<tr class="gridjs-tr">
										<th data-column-id="memId" class="gridjs-th" style="width: 150px; text-align: center;">
											<div class="gridjs-th-content">ID</div>
										</th>
										<th data-column-id="memNm" class="gridjs-th" style="width: 250px; text-align: center;">
											<div class="gridjs-th-content">신청자 명</div>
										</th>
										<th data-column-id="roomCode" class="gridjs-th" style="width: 250px; text-align: center;">
											<div class="gridjs-th-content">호실 번호</div>
										</th>
										<th data-column-id="memTelno" class="gridjs-th" style="width: 250px; text-align: center;">
											<div class="gridjs-th-content">연락처</div>
										</th>
										<th data-column-id="memBirth" class="gridjs-th" style="width: 250px; text-align: center;">
											<div class="gridjs-th-content">생년월일</div>
										</th>
										<th data-column-id="hshldrId" class="gridjs-th" style="width: 150px; text-align: center; ">
											<div class="gridjs-th-content">세대주 ID</div>
										</th>
										<th data-column-id="regDt" class="gridjs-th" style="width: 150px; text-align: center;">
											<div class="gridjs-th-content">가입 신청일</div>
										</th>
										<th data-column-id="check" class="gridjs-th" style="width: 150px; text-align: center;">
											<div class="gridjs-th-content">승인 여부</div>
										</th>
									</tr>
								</thead>
								<tbody class="gridjs-tbody">
									<!-- 불러 올 데이터  -->
								</tbody>
							</table>
						</div>
						<div class="gridjs-footer">
							<div class="gridjs-pagination">
								<div role="status" aria-live="polite" class="gridjs-summary" title="Page 1 of 2">
									현재 대기자 수 : <b id="waitCnt"></b>
								</div>
								<nav aria-label="Page navigation example">
									<ul class="pagination justify-content-center" id="pagenation">
										<!-- <li class="page-item disabled">
											<a class="page-link" id="prevPage">Prev</a>
										</li>
										<li class="page-item active" aria-current="page">
											<span class="page-link" id="btn1">1</span>
										</li>
										<li class="page-item"><a class="page-link" id="btn2" type="button">2</a></li>
										<li class="page-item"><a class="page-link" id="btn3" type="button">3</a></li>
										<li class="page-item"><a class="page-link" id="btn4" type="button">4</a></li>
										<li class="page-item"><a class="page-link" id="btn5" type="button">5</a></li>
										<li class="page-item">
											<a class="page-link" id="nextPage" type="button">Next</a>
										</li> -->
									</ul>
								</nav>
							</div>
						</div>
						<div id="gridjs-temp" class="gridjs-temp"></div>
					</div>
				</div>
			</div>
			<!-- end card-body -->
		</div>
		<!-- end card -->
	</div>
	<!-- end col -->
</div>
<!-- SweetAlert  -->
<link href="/resources/assets/libs/sweetalert2/sweetalert2.min.css" rel="stylesheet" type="text/css" />
<script src="/resources/assets/libs/sweetalert2/sweetalert2.min.js"></script>
<script>
	
	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const itemsPerPage = 10; // 10개씩 나오게 페이징
	let curPage = 1; // 현재 페이지
	let totalItem = 0; // 전체 항목 수
	let totalPages = 0; // 전체 페이지 수
	let startPage = 1; // 시작 페이지
	let keyword = ""; // 검색어
	
	//총 대기자 조회
	getTotal();
	/* 디폴트 1*/
	memberList(curPage);

	
	/* 전체 데이터 수를 알려주는 함수*/
	function getTotal() {
		$.ajax({
			url: "/admin/rejectCount",
			type: 'GET',
			data: {
				keyword: keyword
			},
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function (data) {
				$.each(data, function (index, cnt) {
					totalItem = data.cnt;
					$('#waitCnt').text(data.cnt);
					//페이징
					totalPages = Math.ceil(totalItem / itemsPerPage);
					initPagination();
				});
			}, error: function () {
				console.log("다시 짜라.")
			}
		});
	}


	function roomDecode(roomCode){
        const parts = roomCode.split('_');

        const danNum = parts[1]+'동';
        const danRoom = parts[2]+'호';

        return danNum + ' ' + danRoom;
    }


	//페이지 회원목록 불러오기
	function memberList(page, keyword) {
		$.ajax({
			url: "/admin/rejectMemberAjax",
			type: "GET",
			data: { 
				curPage: page,
				keyword: keyword					
				},
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function (data) {
				let tbody = $('.gridjs-tbody')
				tbody.empty();
				$.each(data, function (index, memberVO) {
					// memberVO.memBirth를 연-월-일 형식으로 변환
					let memBirthDate = new Date(memberVO.memBirth);
					let memBirthFormatted = memBirthDate.getFullYear() + '/' + ('0' + (memBirthDate.getMonth() + 1)).slice(-2) + '/' + ('0' + memBirthDate.getDate()).slice(-2);

					// memberVO.regDt를 연-월-일 시:분:초 형식으로 변환	
					let regDtDate = new Date(memberVO.regDt);
					let regDtFormatted = regDtDate.getFullYear() + '/' + ('0' + (regDtDate.getMonth() + 1)).slice(-2) + '/' + ('0' + regDtDate.getDate()).slice(-2);
					
					let memTelno = formatTelno(memberVO.memTelno);	
					let room = roomDecode(memberVO.roomCode)

					let tr = $('<tr>');
					tr.append($('<td>').addClass('gridjs-td').text(memberVO.memId));
					tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(memberVO.memNm));
					tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(room));
					tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(memTelno));
					tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(memBirthFormatted));
					tr.append($('<td>').addClass('gridjs-td').text(memberVO.hshldrId));
					tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(regDtFormatted))
					
					//버트은~
					let okBtn = $('<button>')
						.addClass('btn btn-success')
						.text('승인')
						.click(function () {
							signAction(memberVO.memId + "님의 회원가입을 승인 하시겠습니까?", "/admin/signOk", memberVO.memId, "처리 완료");
						})

					let rejectBtn = $('<button>')
						.addClass('btn btn-danger')
						.text('삭제')
						.click(function () {
							signAction(memberVO.memId + "님의 회원정보를 삭제 하시겠습니까?", "/admin/deleteMem", memberVO.memId, "처리 완료");
						});

					let actionCell = $('<td>').addClass('gridjs-td');
					actionCell.append(okBtn).append(' ').append(rejectBtn);
					tr.append(actionCell);

					tbody.append(tr);

				})
			},
			error: function () {
				alert("에러 문의 사항 : 정명진 <- 허접")
			}
		});	
	}

	// 회원 동작 함수
	function signAction(text, url, memId, action){
		console.log(memId);
		Swal.fire({
			title: text,
			icon: 'warning',
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '확인',
			cancelButtonText: '취소'
		}).then((result) => {
			if(result.isConfirmed){
				$.ajax({
					url: url,
					type: 'POST',
					data: memId,
					dataType: "text",
					contentType: "application/json;charset=utf-8",
					beforeSend: function (xhr) {
						xhr.setRequestHeader(csrfHeader, csrfToken);
					},
					success: function(data){
						Swal.fire(	
							action,
							"",
							'success'
						)
						memberList(curPage);
						getTotal();
					},
					error: function(xhr, status, error){
						console.log("요 에러임 -> " + error);
						alert("문의사항 -> 정명진");
					}
				});
			}
		})
	}

	// 전화번호 형식 변환 함수
	function formatTelno(memTelno) {
		if (memTelno.length === 11) {
			return memTelno.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
		} else if (memTelno.length === 10) {
			if (memTelno.startsWith("02")) {
				return memTelno.replace(/(02)(\d{4})(\d{4})/, '$1-$2-$3');
			} else {
				return memTelno.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
			}
		} else if (memTelno.length === 9 && memTelno.startsWith("02")) {
			return memTelno.replace(/(02)(\d{3})(\d{4})/, '$1-$2-$3');
		} else if (memTelno.length === 8) {
			return memTelno.replace(/(\d{4})(\d{4})/, '$1-$2');
		}
		return memTelno;
	}

	/* 검색 결과 */	
	$('#searchInput').on('input',function(){
		keyword = $('#searchInput').val().trim();
		curPage = 1;
		startPage = 1;
		getTotal();
		memberList(curPage, keyword);		
	});

	/* 페이지네이션 버튼 */
	function initPagination(){
		let paginationContainer = $('#pagenation');
		paginationContainer.empty();

		let endPage = Math.min(startPage + 4, totalPages);

		if(curPage === 1){
			paginationContainer.append('<li class="page-item disabled"><a class="page-link" id="prevPage">Prev</a></li>');
		}else{
			paginationContainer.append('<li class="page-item"><a class="page-link" id="prevPage" type="button">Prev</a></li>');
		}

		for (let i = startPage; i <= endPage; i++) {
			paginationContainer.append('<li class="page-item ' + (i === curPage ? 'active' : '') + '"><a class="page-link" id="page' + i + '" type="button">' + i + '</a></li>');
		}

		if(curPage === totalPages){
			paginationContainer.append('<li class="page-item disabled"><a class="page-link" id="nextPage">Next</a></li>');
		}else{
			paginationContainer.append('<li class="page-item"><a class="page-link" id="nextPage" type="button">Next</a></li>');
		}

		// 페이지 버튼 클릭 이벤트 설정
		paginationContainer.off('click', '.page-link').on('click', '.page-link', function (event) {
			event.preventDefault();
			const pageText = $(this).text().trim();

			if (!isNaN(pageText)) {
				curPage = parseInt(pageText);
				memberList(curPage);
				initPagination();
			}
		});

		$('#prevPage').click(function () {
			startPage = Math.max(startPage - 5, 1);
			curPage = Math.max(curPage - 5, 1);
			memberList(curPage);
			initPagination()
			
			console.log(curPage);
		});
		
		$('#nextPage').click(function(){
			startPage = Math.min(startPage + 5, totalPages);
			curPage = Math.min(curPage + 5, totalPages);
			memberList(curPage);
			initPagination()

			console.log(curPage);
		})
	}
	

</script>