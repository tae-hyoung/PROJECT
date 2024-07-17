<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<input type="hidden" class="form-control" id="memId" name = "memId" value="<sec:authentication property='principal.memberVO.memId'/>" readonly>
<style>
	.gridjs-search {
		display: flex;
		margin-left: auto !important;
	}

	th, td {
		font-size: 16px;
	}
</style>
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="ri-file-edit-line"></i><strong> 입주민 현황  </strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">입주민 관리</a></li>
						<li class="breadcrumb-item active">입주민 현황</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>
<div style="width:100%; overflow-x: auto; display: flex; align-items: center;" class="auth-page-content" class="row">
	<div class="col-12">
		<div class="card">
			<div class="card-title"></div>
			<!-- end card header -->
			<div class="card-body">
				<div id="table-search">
					<div role="complementary" class="gridjs gridjs-container" style="width: 100%;">
						<div class="d-flex justify-content-end">
							<div class="gridjs-search">
								<input type="search" placeholder="ID, 회원명 입력" aria-label="검색키워드"
									class="gridjs-input gridjs-search-input" id="searchInput" style="width: 250px;">
							</div>
						</div>
						<div class="gridjs-wrapper" style="height: auto; min-height: 540px">
							<table role="grid" class="gridjs-table" style="height: auto;">
								<thead class="gridjs-thead">
									<tr class="gridjs-tr">
										<th data-column-id="memNo" class="gridjs-th" style="width: 50px; text-align: center;">
											<div class="gridjs-th-content">순번</div>
										</th>
										<th data-column-id="memId" class="gridjs-th" style="width: 150px; text-align: center;">
											<div class="gridjs-th-content">ID</div>
										</th>
										<th data-column-id="memNm" class="gridjs-th" style="width: 100px; text-align: center;">
											<div class="gridjs-th-content">회원명</div>
										</th>
										<th data-column-id="roomCode" class="gridjs-th" style="width: 150px; text-align: center;">
											<div class="gridjs-th-content">입주 세대</div>
										</th>
										<th data-column-id="memTelno" class="gridjs-th" style="width: 150px; text-align: center;">
											<div class="gridjs-th-content">연락처</div>
										</th>
                                        <th data-column-id="memEmail" class="gridjs-th" style="width: 250px; text-align: center;">
											<div class="gridjs-th-content">전자주소</div>
										</th>
                                        <th data-column-id="memBirth" class="gridjs-th" style="width: 100px; text-align: center;">
											<div class="gridjs-th-content">생년월일</div>
										</th>
                                        <th data-column-id="hshldrId" class="gridjs-th" style="width: 150px; text-align: center;">
											<div class="gridjs-th-content">세대주 ID</div>
										</th>
										<th data-column-id="signDt" class="gridjs-th" style="width: 100px; text-align: center;">
											<div class="gridjs-th-content">등록일</div>
										</th>
									</tr>
								</thead>
								<tbody class="gridjs-tbody" >
									<!-- 불러 올 데이터  -->
								</tbody>
							</table>
						</div>
						<div class="gridjs-footer">
							<div class="gridjs-pagination">
								<div role="status" aria-live="polite" class="gridjs-summary" title="Page 1 of 2">
									현재 입주민 수 : <b id="memberCnt"></b>
								</div>
								<nav aria-label="Page navigation example">
									<ul class="pagination justify-content-center" id="pagenation">
										<!-- 페이지 버튼  -->
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
<script>
    const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const itemsPerPage = 10; // 10개씩 나오게 페이징
    let curPage = 1; // 현재 페이지
    let totalItem = 0; // 전체 항목 수
    let totalPages = 0; // 전체 페이지 수
	let startPage = 1; // 시작 페이지
	let keyword = ""; // 검색어
    let memId = $("#memId").val();
    console.log(memId);

    getTotal(); // 가입자 수

	memberList(curPage);

	/* 전체 데이터 수를 알려주는 함수*/
	function getTotal() {
		$.ajax({
			url: "/admin/memberCount",
			type: 'GET',
			data: {
                "memId" : memId,
			    "keyword" : keyword
			},
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function (data) {
				$.each(data, function (index, cnt) {
					totalItem = data.cnt;
					$('#memberCnt').text(data.cnt);
					//페이징
					totalPages = Math.ceil(totalItem / itemsPerPage);
					initPagination();
				});
			}, error: function () {
				console.log("다시 짜라.")
			}
		});
	}

    //입주민 현황
    function memberList(page, keyword){
		$.ajax({
			url: "/admin/memberListAjax",
			type: "GET",
			data: {
                "memId": memId,
				"curPage": page,
				"keyword": keyword
			},
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			beforeSend: function(xhr){
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function(data){
				let tbody = $('.gridjs-tbody')
				tbody.empty();
				$.each(data, function(index, memberVO){

					// memberVO.regDt를 연-월-일 시:분:초 형식으로 변환	
					let signDtDate = new Date(memberVO.signDt);
					let signDtFormatted = signDtDate.getFullYear() + '/' + ('0' + (signDtDate.getMonth() + 1)).slice(-2) + '/' + ('0' + signDtDate.getDate()).slice(-2);
                    
                    let memBirthDate = new Date(memberVO.memBirth);
					let memBirthFormmated = memBirthDate.getFullYear()+'/'+('0' + (memBirthDate.getMonth() + 1)).slice(-2) + '/' + ('0' + memBirthDate.getDate()).slice(-2)
					
                    let memTelno = formatTelno(memberVO.memTelno);
					
					let tr = $('<tr>');
					tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(index + 1 + ( 10 * (curPage - 1)))); // 순번 
					tr.append($('<td>').addClass('gridjs-td').css('text-align', 'left').text(memberVO.memId));
					tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(memberVO.memNm));
					tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(roomFormat(memberVO.roomCode)));
					tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(memTelno));
                    tr.append($('<td>').addClass('gridjs-td').css('text-align', 'left').text(memberVO.memEmail));
                    tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(memBirthFormmated));
                    tr.append($('<td>').addClass('gridjs-td').css('text-align', 'left').text(memberVO.hshldrId));
                    tr.append($('<td>').addClass('gridjs-td').css('text-align', 'center').text(signDtFormatted));   	
					tbody.append(tr);
				});
			},
			error: function(error){
				console.log("에러났다~ " + error)
			}
		});
	}
    function roomFormat(roomCode){
        const parts = roomCode.split('_');

        const danNum = parts[1]+'동';
        const danRoom = parts[2]+'호';

        return danNum + ' ' + danRoom;
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
		memberList(curPage, keyword);
		getTotal();
	})

	/* 페이지네이션 버튼 */
	function initPagination(){
		let paginationContainer = $('#pagenation');
		paginationContainer.empty();

		let endPage = Math.min(startPage + 4, totalPages);

		if(curPage === 1){
			paginationContainer.append('<li class="page-item disabled"><a class="page-link" id="prevPage">이전</a></li>');
		}else{
			paginationContainer.append('<li class="page-item"><a class="page-link" id="prevPage" type="button">이전</a></li>');
		}

		for (let i = startPage; i <= endPage; i++) {
			paginationContainer.append('<li class="page-item ' + (i === curPage ? 'active' : '') + '"><a class="page-link" id="page' + i + '" type="button">' + i + '</a></li>');
		}

		if(endPage === totalPages){
			paginationContainer.append('<li class="page-item disabled"><a class="page-link" id="nextPage">다음</a></li>');
		}
		else{
			paginationContainer.append('<li class="page-item"><a class="page-link" id="nextPage" type="button">다음</a></li>');
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