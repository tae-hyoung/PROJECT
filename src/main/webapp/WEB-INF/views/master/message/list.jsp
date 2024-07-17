<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
	th, td {
		font-size: 16px;
	}
</style>
<div style="top: 100px; margin-top: -100px;" class="auth-page-content">
	<div class="col-lg-12">
		<!-- 보낸 메세지 상세 보기 모달창  -->	
		<div id="msgModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="myModalLabel">쪽지 상세</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label for="msgSender" class="col-form-label">보낸사람:</label>
							<input type="text" class="form-control" id="msgSender" readonly>
						</div>
						<div class="mb-3">
							<label for="msgReceiver" class="col-form-label">받는사람:</label>
							<input type="text" class="form-control" id="msgReceiver" readonly>
						</div>
						<div class="mb-3">
							<label for="msgTitle" class="col-form-label">제목:</label>
							<input type="text" class="form-control" id="msgTitle" readonly>
						</div>
						<div class="mb-3">
							<label for="msgContent" class="col-form-label">내용:</label>
							<textarea class="form-control" id="msgContent" style="height: 200px;" readonly></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 받은 메세지 상세보기 모달창  -->
		<div id="receiveMsgModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="myModalLabel">쪽지 상세</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<div class="mb-3">
							<label for="rMsgSender" class="col-form-label">보낸사람:</label>
							<input type="text" class="form-control" id="rMsgSender" readonly>
						</div>
						<div class="mb-3">
							<label for="rMsgReceiver" class="col-form-label">받는사람:</label>
							<input type="text" class="form-control" id="rMsgReceiver" readonly>
						</div>
						<div class="mb-3">
							<label for="rMsgTitle" class="col-form-label">제목:</label>
							<input type="text" class="form-control" id="rMsgTitle" readonly>
						</div>
						<div class="mb-3">
							<label for="rMsgContent" class="col-form-label">내용:</label>
							<textarea class="form-control" id="rMsgContent" style="height: 200px;" readonly></textarea>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" id="replyBtn" class="btn btn-warning">답장</button>
						<button type="button" id="reply" class="btn btn-warning" style="display: none;">전송</button>
						<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<div class="container-fluid">
			<div class="row">
				<div class="col-12">
					<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
						<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="ri-file-edit-line"></i><strong> 쪽지  </strong></p>
						<div class="page-title-right">
							<ol class="breadcrumb m-0">
								<li class="breadcrumb-item"><a href="javascript: void(0);">쪽지</a></li>
							</ol>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="card">
			<div class="card-header">
				<h4 class="card-title mb-0">쪽지</h4>
			</div><!-- end card header -->
			<div class="card-body">
				<!-- Tab Navigation -->
				<ul class="nav nav-pills nav-tabs mb-3" role="tablist">
                    <li class="nav-item waves-effect waves-light" role="presentation">
                        <a class="nav-link active" data-bs-toggle="tab" href="#received" role="tab" aria-selected="true">
                            받은 쪽지 목록
                        </a>
                    </li>
                    <li class="nav-item waves-effect waves-light" role="presentation">
                        <a class="nav-link" data-bs-toggle="tab" href="#sent" role="tab" aria-selected="false" tabindex="-1">
                            보낸 쪽지 목록
                        </a>
                    </li>
                </ul>
				<div class="tab-content" id="myTabContent">
					<!-- Received Messages Tab -->
					<div class="tab-pane fade show active" id="received" role="tabpanel" aria-labelledby="received-tab">
						<div class="listjs-table" id="receivedList">
							<div class="row g-4 mb-3">
								<div class="col-sm-auto">
									<div>
										<button class="btn btn-soft-danger" onclick="deleteReceiveMsg()"><i class="ri-delete-bin-2-line"></i></button>
									</div>
								</div>
								<div class="col-sm">
									<div class="d-flex justify-content-sm-end">
										<div class="search-box ms-2">
											<input type="text" class="form-control search" placeholder="발신자 ID" id="sender" name="sender">
											<i class="ri-search-line search-icon"></i>
										</div>
									</div>
								</div>
							</div>

							<div class="table-responsive table-card mt-3 mb-1">
								<table class="table align-middle table-nowrap" id="receivedTable">
									<thead class="table-light">
										<tr>
											<th scope="col" style="width: 50px;">
												<div class="form-check">
													<input class="form-check-input" type="checkbox" id="checkAllReceived">
												</div>
											</th>
											<th style="width: 200px;">보낸사람</th>
											<th style="width: 250px;">제목</th>
											<th style="width: 400px;">내용</th>
											<th class="sort" data-sort="date" id="receiveDate" style="width: 150px; text-align: center;">전송 날짜</th>
										</tr>
									</thead>
									<tbody class="receivelist form-check-all">
										
									</tbody>
								</table>
							</div>
							<div class="gridjs-footer">
								<div class="gridjs-pagination">
									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center" id="receivePaging">
											
										</ul>
									</nav>
								</div>
							</div>
						</div>
					</div>
					<!-- Sent Messages Tab -->
					<div class="tab-pane fade" id="sent" role="tabpanel" aria-labelledby="sent-tab">
						<div class="listjs-table" id="sentList">
							<div class="row g-4 mb-3">
								<div class="col-sm-auto">
									<div>
										<button class="btn btn-soft-danger" onclick="deleteSendMsg()"><i class="ri-delete-bin-2-line"></i></button>
									</div>
								</div>
								<div class="col-sm">
									<div class="d-flex justify-content-sm-end">
										<div class="search-box ms-2">
											<input type="text" class="form-control search" placeholder="수신자 ID" id="receiver" name="receiver">
											<i class="ri-search-line search-icon"></i>
										</div>
									</div>
								</div>
							</div>

							<div class="table-responsive table-card mt-3 mb-1">
								<table class="table align-middle table-nowrap" id="sentTable">
									<thead class="table-light">
										<tr>
											<th scope="col" style="width: 50px;">
												<div class="form-check">
													<input class="form-check-input" type="checkbox" id="checkAllSent">
												</div>
											</th>
											<th style="width: 200px;">받는사람</th>
											<th style="width: 250px;">제목</th>
											<th style="width: 400px;">내용</th>
											<th class="sort" data-sort="date" id="sendDate" style="width: 150px; text-align: center;">전송 날짜</th>
											<th class="sort" id="sortStatus" style="width: 100px; text-align: center;">상태</th>
										</tr>
									</thead>
									<tbody class="sendlist form-check-all">
						
									</tbody>
								</table>
							</div>
							<div class="gridjs-footer">
								<div class="gridjs-pagination">
									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center" id="sendPaging">
										</ul>
									</nav>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div><!-- end card -->
		</div>
		<!-- end col -->
	</div>
</div>

<script>
    // 기본 설정
    const csrfHeader = "${_csrf.headerName}";
    const csrfToken = "${_csrf.token}";
    const itemsPerPage = 10;
	

	/* 받은 쪽지 스크립트 */
	let sender = ""; // 나한테 보낸 사람
	let receiveUrl = "/receiveList" // 기본 URL
	let receiveDateAsc = "/receiveListAsc" // 날짜 기준 정렬 
	let receiveTotal = 0; // 받은 메세지 개수 초기화
	let receiveTotalPages =  0; // 받은 메세지 개수 페이징
	let receiveStartPage = 1;
	let receiveCurPage = 1;
	let clickReceiveDate = 0;

	/* 받은 쪽지 목록 호출*/
	getReceiveMessage();
	receiveMessageList(receiveUrl, sender, receiveCurPage);

	function getReceiveMessage(){
		$.ajax({
			url: "/receiveCount",
			type: 'GET',
			data:{
				"sender" : sender
			},
			dataType: "JSON",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function(data){
				$.each(data, function(index, cnt){
					receiveTotal = data.cnt;
					console.log(receiveTotal);
					receiveTotalPages = Math.ceil(receiveTotal / itemsPerPage);
					initReceivePagination(receiveStartPage, receiveTotalPages, receiveCurPage);
				})
			}
		})
	}

	function receiveMessageList(url, sender, page){
		$.ajax({
			url : url,
			type : 'GET',
			data: {
				"receivePage" : page,
				"sender": sender
			},
			dataType: "json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function(data){
				let tbody = $(".receivelist");
				tbody.empty();
				$.each(data, function(index, messageVO){
					let sendDate = new Date(messageVO.sendDt);
					let regSendDt = sendDate.getFullYear() + '/' + ('0' + (sendDate.getMonth() + 1)).slice(-2) + '/' + ('0' + sendDate.getDate()).slice(-2) + ' ' + ('0' + sendDate.getHours()).slice(-2) + ':' + ('0' + sendDate.getMinutes()).slice(-2) + ':' + ('0' + sendDate.getSeconds()).slice(-2);
					let tr = $('<tr>');
                    tr.append('<th scope="row"><div class="form-check"><input class="form-check-input" type="checkbox" id="receiveMsgSeq" name="receiveMsgSeq" value="' + messageVO.msgSeq + '"></div></th>');
                    tr.append('<td class="msgSeq" style="display:none;"><a href="javascript:void(0);" class="fw-medium link-primary">#' + messageVO.msgSeq + '</a></td>');
                    tr.append('<td class="sender">' +  messageVO.sender + '</td>');
                    tr.append('<td class="title" id="receiveTitle">' + 
                    	    (messageVO.readYn === 'N' 
                    	        ? '<a href="#" class="link-primary link-offset-2 text-decoration-underline link-underline-opacity-25 link-underline-opacity-100-hover" data-bs-toggle="modal" data-bs-target="#receiveMsgModal"><i class="ri-mail-fill"></i>' + messageVO.title + '</a>' 
                    	        : '<a href="#" class="link-secondary link-offset-2 text-decoration-underline link-underline-opacity-25 link-underline-opacity-100-hover" data-bs-toggle="modal" data-bs-target="#receiveMsgModal"><i class="ri-mail-open-line"></i>' + messageVO.title + '</a>'
                    	    ) + 
                    	'</td>');
                    tr.append('<td class="content">' + messageVO.content + '</td>');
                    tr.append('<td class="sendDt" style="text-align: center">' + regSendDt + '</td>');

					tbody.append(tr);
				})
			},error: function(error){
				console.log(error, "다시 하세요.");
			}
		})
	}

	// 받은 메세지 페이징
	function initReceivePagination(startPage, totalPages, curPage){
		let paginationContainer = $('#receivePaging');
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

		if(endPage === totalPages){
			paginationContainer.append('<li class="page-item disabled"><a class="page-link" id="nextPage">Next</a></li>');
		}
		else{
			paginationContainer.append('<li class="page-item"><a class="page-link" id="nextPage" type="button">Next</a></li>');
		}

		// 페이지 버튼 클릭 이벤트 설정
		paginationContainer.off('click', '.page-link').on('click', '.page-link', function (event) {
			event.preventDefault();
			const pageText = $(this).text().trim();
			$('#checkAllReceived').prop('checked', false);

			if (!isNaN(pageText)) {
				curPage = parseInt(pageText);
				receiveMessageList(receiveUrl, sender, curPage);
				initReceivePagination(startPage, totalPages, curPage);
			}
		});

		$('#prevPage').click(function () {
			startPage = Math.max(startPage - 5, 1);
			curPage = Math.max(curPage - 5, 1); 
			receiveMessageList(receiveUrl, sender, curPage);
			initReceivePagination(startPage, totalPages, curPage);
			$('#checkAllReceived').prop('checked', false);
		});
		
		$('#nextPage').click(function(){
			startPage = Math.min(startPage + 5, totalPages);
			curPage = Math.min(curPage + 5, totalPages); 
			receiveMessageList(receiveUrl, sender, curPage);
			initReceivePagination(startPage, totalPages, curPage);
			$('#checkAllReceived').prop('checked', false);
		});
	}

	// 발신자 검색 기능
	$('#sender').focusout(function(){
		sender = $('#sender').val().trim();
		receiveCurPage = 1;
		receiveStartPage = 1;
		getReceiveMessage();
		receiveMessageList(receiveUrl, sender, receiveCurPage);
	})


	$('#receiveDate').on("click", function(){
		clickReceiveDate = clickReceiveDate + 1;
		if(clickReceiveDate > 1){
			clickReceiveDate = 0;
		}
		if(clickReceiveDate === 1){
			getReceiveMessage();
			receiveMessageList(receiveDateAsc, sender, receiveCurPage);
		}else{
			getReceiveMessage();
			receiveMessageList(receiveUrl, sender, receiveCurPage);
		}
	})

	/*삭제 관련*/
	$('#checkAllReceived').change(function() {
		let isChecked = $(this).prop('checked');
		$('input[name="receiveMsgSeq"]').prop('checked', isChecked);
	});

	function deleteReceiveMsg(){
		let selectedReceiveSeq = [];

		$('.form-check-input').each(function(){
			if ($(this).prop('checked')) {
				selectedReceiveSeq.push($(this).val());
			}
		});

		selectedReceiveSeq = selectedReceiveSeq.filter(item => item !== 'on');

		Swal.fire({
			icon: "warning",
			title: "쪽지 삭제",
			text: "선택한 쪽지를 삭제할까요?",
			icon: "warning",
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '확인',
			cancelButtonText: '취소'
		}).then((result) => {
			if(result.isConfirmed){
				$.ajax({
					url: '/receiveDel',
					type: 'POST',
					contentType: "application/json;charset=utf-8",
					data: JSON.stringify(selectedReceiveSeq),
					beforeSend: function(xhr) {
						xhr.setRequestHeader(csrfHeader, csrfToken);
					},
					success: function(response){
						Swal.fire("삭제 완료", "쪽지가 삭제 되었습니다.", "success");
						getReceiveMessage();
						receiveMessageList(receiveUrl, sender, receiveCurPage);
					},
					error:function(){
						Swal.fire("삭제 실패", "알 수 없는 오류로 인해 실패", "error");
					}
				})
			}
			
		})
	}
	/*받은 쪽지 종료*/

	/*보내는 쪽지 스크립트*/
	//보낸 쪽지 관련
	let receiver = ""; // 나한테 받은 사람
	let sendUrl = "/sendList"; // 기본 URL
	let sendDateAsc = "/sendListAsc"; // 날짜 기준 정렬 
	let readAsc = "/readCheckAsc";
	let readDesc = "/readCheckDesc";
	let sendTotal = 0; // 받은 메세지 개수 초기화
	let sendTotalPages =  0; // 받은 메세지 개수 페이징
	let sendStartPage = 1;
	let sendCurPage = 1;
	let clickSendDate = 0;
	let clickSendStatus = 0;

	/* 보낸 쪽지 목록 호출*/
	getSendMessage();
	sendMessageList(sendUrl, receiver, sendCurPage);

	function getSendMessage(){
		$.ajax({
			url: "/sendCount",
			type: 'GET',
			data:{
				"receiver" : receiver
			},
			dataType: "JSON",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function(data){
				$.each(data, function(index, cnt){
					sendTotal = data.cnt;
					console.log("총 메세지 개수 : ", data.cnt)
					console.log(sendTotal);
					sendTotalPages = Math.ceil(sendTotal / itemsPerPage);
					console.log("보낸 쪽지 페이지 : ",sendTotalPages);
					initSendPagination(sendStartPage, sendTotalPages, sendCurPage);
				})
			}
		})
	}

	function sendMessageList(url, receiver, page){
		$.ajax({
			url : url,
			type : 'GET',
			data: {
				"sendPage" : page,
				"receiver": receiver
			},
			dataType: "json",
			beforeSend: function (xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function(data){
				let tbody = $(".sendlist");
				tbody.empty();
				$.each(data, function(index, messageVO){
					let sendDate = new Date(messageVO.sendDt);
					let regSendDt = sendDate.getFullYear() + '/' + ('0' + (sendDate.getMonth() + 1)).slice(-2) + '/' + ('0' + sendDate.getDate()).slice(-2) + ' ' + ('0' + sendDate.getHours()).slice(-2) + ':' + ('0' + sendDate.getMinutes()).slice(-2) + ':' + ('0' + sendDate.getSeconds()).slice(-2);
					let tr = $('<tr>');
                    tr.append('<th scope="row"><div class="form-check"><input class="form-check-input" type="checkbox" id="sendMsgSeq" name="sendMsgSeq" value="' + messageVO.msgSeq + '"></div></th>');
                    tr.append('<td class="msgSeq" style="display:none;"><a href="javascript:void(0);" class="fw-medium link-primary">#' + messageVO.msgSeq + '</a></td>');
                    tr.append('<td class="receiver">' +  messageVO.receiver + '  <i class="ri-mail-send-fill" style="font-size:20px;"></i></td>');
                    tr.append('<td class="title" id="sendTitle"><a href="#" class="link-primary link-offset-2 text-decoration-underline link-underline-opacity-25 link-underline-opacity-100-hover" data-bs-toggle="modal" data-bs-target="#Modal">' + messageVO.title + '</a></td>');
                    tr.append('<td class="content">' + messageVO.content + '</td>');
                    tr.append('<td class="sendDt" style="text-align: center;">' + regSendDt + '</td>');
					tr.append('<td class="status" style="text-align: center;">' + (messageVO.readYn === 'N' ? '<span class="badge bg-success-subtle text-danger text-uppercase" style="font-size:16px;">안읽음</span>' : '<span class="badge bg-success-subtle text-success text-uppercase" style="font-size:16px;">읽음</span>') + '</td>');
					tbody.append(tr);
				})
			},error: function(error){
				console.log(error, "다시 하세요.");
			}
		})
	}

	// 보낸 메세지 페이징
	function initSendPagination(startPage, totalPages, curPage){
		let paginationContainer = $('#sendPaging');
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

		if(endPage === totalPages){
			paginationContainer.append('<li class="page-item disabled"><a class="page-link" id="nextPage">Next</a></li>');
		}
		else{
			paginationContainer.append('<li class="page-item"><a class="page-link" id="nextPage" type="button">Next</a></li>');
		}

		// 페이지 버튼 클릭 이벤트 설정
		paginationContainer.off('click', '.page-link').on('click', '.page-link', function (event) {
			event.preventDefault();
			const pageText = $(this).text().trim();
			$('#checkAllSent').prop('checked', false);

			if (!isNaN(pageText)) {
				curPage = parseInt(pageText);
				sendMessageList(sendUrl, receiver, curPage);
				initSendPagination(startPage, totalPages, curPage);
			}
		});

		$('#prevPage').click(function () {
			startPage = Math.max(startPage - 5, 1);
			curPage = Math.max(curPage - 5, 1); 
			sendMessageList(sendUrl, receiver, curPage);
			initSendPagination(startPage, totalPages, curPage);
			$('#checkAllSent').prop('checked', false);
		});
		
		$('#nextPage').click(function(){
			startPage = Math.min(startPage + 5, totalPages);
			curPage = Math.min(curPage + 5, totalPages); 
			sendMessageList(sendUrl, receiver, curPage);
			initSendPagination(startPage, totalPages, curPage);
			$('#checkAllSent').prop('checked', false);
		});
	}

	// 수신자 검색 기능
	$('#receiver').focusout(function(){
		receiver = $('#receiver').val().trim();
		receiveCurPage = 1;
		receiveStartPage = 1;
		getSendMessage();
		sendMessageList(sendUrl, receiver, sendCurPage);
	})

	// 보낸 쪽지 날짜 정렬
	$('#sendDate').on("click", function(){
		clickSendDate = clickSendDate + 1;
		if(clickSendDate > 1){
			clickSendDate = 0;
		}
		if(clickSendDate === 1){
			getSendMessage();
			sendMessageList(sendDateAsc, receiver, sendCurPage);
		}else{
			getSendMessage();
			sendMessageList(sendUrl, receiver, sendCurPage);
		}
	});
	
	//상태 정렬
	$('#sortStatus').on("click", function(){
		clickSendStatus = clickSendStatus + 1;
		if(clickSendStatus > 2){
			clickSendStatus = 0;
		}

		switch(clickSendStatus){
			case 1:
				getSendMessage();
				sendMessageList(readAsc, receiver, sendCurPage);
				break;
			case 2:
				getSendMessage();
				sendMessageList(readDesc, receiver, sendCurPage);
				break;
			default :
				getSendMessage();
				sendMessageList(sendUrl, receiver, sendCurPage);
				break;
		}
	});

	// 삭제 기능
	function deleteSendMsg(){
		let selectedSendSeq = [];

		$('.form-check-input').each(function(){
			if ($(this).prop('checked')) {
				selectedSendSeq.push($(this).val());
			}
		});

		selectedSendSeq = selectedSendSeq.filter(item => item !== 'on');

		Swal.fire({
			icon: "warning",
			title: "쪽지 삭제",
			text: "선택한 쪽지를 삭제할까요?",
			icon: "warning",
			showCancelButton: true,
			confirmButtonColor: '#3085d6',
			cancelButtonColor: '#d33',
			confirmButtonText: '확인',
			cancelButtonText: '취소'
		}).then((result) => {
			if(result.isConfirmed){
				$.ajax({
					url: '/sendDel',
					type: 'POST',
					contentType: "application/json;charset=utf-8",
					data: JSON.stringify(selectedSendSeq),
					beforeSend: function(xhr) {
						xhr.setRequestHeader(csrfHeader, csrfToken);
					},
					success: function(response){
						Swal.fire("삭제 완료", "쪽지가 삭제 되었습니다.", "success");
						getSendMessage();
						sendMessageList(sendUrl, receiver, sendCurPage);
					},
					error:function(){
						Swal.fire("삭제 실패", "알 수 없는 오류로 인해 실패", "error");
					}
				})
			}	
		})
	}

	/*메세지 내용 자세히 보기 */
	$(document).on('click', '#sendTitle', function(event) {
		event.preventDefault();
		let tr = $(this).closest('tr');
		let msgSeq = tr.find('.msgSeq a').text().replace('#', '');

		$.ajax({
			url: '/msgDetail',
			type: 'GET',
			data: {
				"msgSeq": msgSeq
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function(data) {
				if (data.length > 0) {
					let message = data[0];

					$('#msgSender').val(message.sender);
					$('#msgReceiver').val(message.receiver);
					$('#msgTitle').val(message.title);
					$('#msgContent').val(message.content);

					$('#msgModal').modal('show');
				} else {
					Swal.fire("불러오기 실패", "메세지 불러오기 실패", "error");
				}
			},
			error: function(error) {
				console.log("에러 남 : ", error);
			}
		});
		$.ajax({
			url: '/readCheck',
			type: 'POST',
			data: {
				"msgSeq": msgSeq
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function(data) {
				getReceiveMessage();
				receiveMessageList(receiveUrl, sender, receiveCurPage);
			},
			error: function(error) {
				console.log(error, "안 됐다.");
			}
		});
    });

	/* 답장 가능한 모달 */
	/*메세지 내용 자세히 보기 */
	$(document).on('click', '#receiveTitle', function(event) {
		event.preventDefault();
		let tr = $(this).closest('tr');
		let msgSeq = tr.find('.msgSeq a').text().replace('#', '');

		$.ajax({
			url: '/msgDetail',
			type: 'GET',
			data: {
				"msgSeq": msgSeq
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function(data) {
				if (data.length > 0) {
					let message = data[0];

					$('#rMsgSender').val(message.sender);
					$('#rMsgReceiver').val(message.receiver);
					$('#rMsgTitle').val(message.title);
					$('#rMsgContent').val(message.content);

					$('#receiveMsgModal').modal('show');
				} else {
					Swal.fire("불러오기 실패", "메세지 불러오기 실패", "error");
				}
			},
			error: function(error) {
				console.log("에러 남 : ", error);
			}
		});
		$.ajax({
			url: '/readCheck',
			type: 'POST',
			data: {
				"msgSeq": msgSeq
			},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			},
			success: function(data) {
				getReceiveMessage();
				receiveMessageList(receiveUrl, sender, receiveCurPage);
			},
			error: function(error) {
				console.log(error, "안 됐다.");
			}
		});
    });

	$('#replyBtn').click(function(){
		let sender = $('#rMsgSender').val();
		$('#rMsgReceiver').val(sender);
		// 보낸사람 입력창 숨기기
		$('#rMsgSender').closest('.mb-3').hide();
		
		$('#rMsgTitle').val('').prop('readonly', false);
        $('#rMsgContent').val('').prop('readonly', false);

		$('#replyBtn').hide();
		$('#reply').show();
	});

	$('#receiveMsgModal').on('hidden.bs.modal', function () {
		// 모달이 숨겨질 때 처리할 내용
		$('#replyBtn').show();
		$('#reply').hide();
	});
	
	
	$('#reply').click(function(){
		let receiver = $('#rMsgReceiver').val();
		let title = $('#rMsgTitle').val();
		let content = $('#rMsgContent').val();
		let chk = 0;
		console.log(receiver);
		$.ajax({
			url:"/checkReceiver",
			type:'POST',
			data: receiver,
			dataType: "json",
			contentType: "application/json;charset=utf-8",
			beforeSend: function (xhr) {
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(data){
				if(data.cnt > 0){
					let messageVO = {
						"title": title,
						"receiver": receiver,
						"content": content
					}
					$.ajax({
						url:"/sendMsg",
						type: 'POST',
						data: JSON.stringify(messageVO),
						dataType: "json",
						contentType: "application/json;charset=utf-8",
						beforeSend: function (xhr) {
							xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
						success:function(response){
							Swal.fire("전송 완료", "쪽지가 전송되었습니다", "success").then((result) => {
								$('#receiveMsgModal').modal('hide');
							});
						},
						error:function(error){
							console.log("뜻대로 되지 않는 코딩...")
						}
					});
				}else{
					Swal.fire("전송 실패", "수신자 ID를 확인해주세요", "error");
				}
			},
			error: function(error){
				console.log(error);
			}
		});
	});	
	
</script>
