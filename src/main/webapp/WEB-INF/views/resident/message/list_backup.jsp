<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<div style="top: 100px; margin-top: -100px;" class="auth-page-content">
	<div class="col-lg-12">
		<!-- 메세지 상세 보기 모달창  -->	
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
						<button type="button" id="replyBtn" class="btn btn-warning" style="display: none;">답장</button>
						<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
					</div>
				</div>
			</div>
		</div>
		<div class="card">
			<div class="card-header">
				<h4 class="card-title mb-0">쪽지함</h4>
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
										<button class="btn btn-soft-danger" onclick="deleteMultiple()"><i class="ri-delete-bin-2-line"></i></button>
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
													<input class="form-check-input" type="checkbox" id="checkAllReceived" value="option">
												</div>
											</th>
											<th style="width: 200px;">보낸사람</th>
											<th style="width: 250px;">제목</th>
											<th>내용</th>
											<th class="sort" data-sort="date" id="receiveDate" style="width: 250px; text-align: center;">전송 날짜</th>
										</tr>
									</thead>
									<tbody class="receivelist form-check-all">
										
									</tbody>
								</table>
							</div>
							<div class="gridjs-footer">
								<div class="gridjs-pagination">
									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center" id="pagenationReceiveMsg">
											
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
										<button class="btn btn-soft-danger" onclick="deleteMultiple()"><i class="ri-delete-bin-2-line"></i></button>
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
													<input class="form-check-input" type="checkbox" id="checkAllSent" value="option">
												</div>
											</th>
											<th style="width: 200px;">받는사람</th>
											<th style="width: 250px;">제목</th>
											<th>내용</th>
											<th class="sort" data-sort="date" id="sendDate" style="width: 250px; text-align: center;">전송 날짜</th>
											<th class="sort" id="sortStatus" style="width: 50px; text-align: center;">상태</th>
										</tr>
									</thead>
									<tbody class="sendlist form-check-all">
						
									</tbody>
								</table>
							</div>
							<div class="gridjs-footer">
								<div class="gridjs-pagination">
									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center" id="pagenationSendMsg">
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
    let receivePage = 1; // 받은 쪽지함 현재 페이지
    let sendPage = 1; // 보낸 쪽지함 현재 페이지

    let totalReceiveMsg = 0; // 받은 쪽지함 총 개수
    let totalSendMsg = 0; // 보낸 쪽지함 총 개수

    let totalReceiveMsgPages = 0; // 받은 쪽지함 전체 페이지
    let totalSendMsgPages = 0; // 보낸 쪽지함 전체 페이지

    let startReceiveMsgPage = 1; // 받은 쪽지함 시작페이지
    let startSendMsgPage = 1; // 보낸 쪽지함 시작 페이지

    let receiver = ""; // 받는 놈
    let sender = ""; // 보낸 놈

    let receiveUrl = "/receiveList";
    let receiveUrlAsc = "/receiveListAsc";

    let sendUrl = "/sendList";
    let sendUrlAsc = "/sendListAsc";

	let statusAsc = "/readCheckAsc";
	let statusDesc = "/readCheckDesc";

    // 초기화 함수 호출
    initializeMessages("receive");
    initializeMessages("send");

    // 메시지 초기화
    function initializeMessages(type) {
        if (type === "receive") {
            fetchMessageCount("/receiveCount", "sender", sender, receiveUrl, receivePage, ".receivelist");
        } else if (type === "send") {
            fetchMessageCount("/sendCount", "receiver", receiver, sendUrl, sendPage, ".sendlist");
        }
    }

    // 메시지 수 조회
    function fetchMessageCount(countUrl, userRole, userName, listUrl, page, tableClass) {
        $.ajax({
            url: countUrl,
            type: 'GET',
            data: {
                [userRole]: userName
            },
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(data) {
                if (userRole === "sender") {
                    totalReceiveMsg = data.cnt;
                    totalReceiveMsgPages = Math.ceil(totalReceiveMsg / itemsPerPage);
                    
                } else if (userRole === "receiver") {
                    totalSendMsg = data.cnt;
                    totalSendMsgPages = Math.ceil(totalSendMsg / itemsPerPage);
                }
                fetchMessageList(listUrl, page, userRole, userName, tableClass);
            },
            error: function(error) {
                console.log(error, "다시 짜~");
            }
        });
    }

    // 메시지 목록 조회
    function fetchMessageList(url, page, userRole, userName, tableClass) {
        $.ajax({
            url: url,
            type: 'GET',
            data: {
                [userRole === "sender" ? "receivePage" : "sendPage"]: page,
                [userRole]: userName
            },
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            beforeSend: function(xhr) {
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(data) {
                let tbody = $(tableClass);
                tbody.empty();
                $.each(data, function(index, messageVO) {
                    let sendDate = new Date(messageVO.sendDt);
                    let regSendDt = sendDate.getFullYear() + '/' + ('0' + (sendDate.getMonth() + 1)).slice(-2) + '/' + ('0' + sendDate.getDate()).slice(-2) + ' ' + ('0' + sendDate.getHours()).slice(-2) + ':' + ('0' + sendDate.getMinutes()).slice(-2) + ':' + ('0' + sendDate.getSeconds()).slice(-2);

                    let tr = $('<tr>');
                    tr.append('<th scope="row"><div class="form-check"><input class="form-check-input" type="checkbox" id="msgSeq" name="msgSeq" value="' + messageVO.msgSeq + '"></div></th>');
                    tr.append('<td class="msgSeq" style="display:none;"><a href="javascript:void(0);" class="fw-medium link-primary">#' + messageVO.msgSeq + '</a></td>');
                    tr.append('<td class="' + (userRole === "sender" ? "sender" : "receiver") + '">' + (userRole === "sender" ? messageVO.sender : messageVO.receiver) + '</td>');
                    tr.append('<td class="title"><a href="#" class="link-primary link-offset-2 text-decoration-underline link-underline-opacity-25 link-underline-opacity-100-hover" data-bs-toggle="modal" data-bs-target="#msgModal">' + messageVO.title + '</a></td>');
                    tr.append('<td class="content">' + messageVO.content + '</td>');
                    tr.append('<td class="sendDt" style="text-align: center">' + regSendDt + '</td>');

                    if (userRole === "receiver") {
                        tr.append('<td class="status">' + (messageVO.readYn === 'N' ? '<span class="badge bg-success-subtle text-danger text-uppercase" style="font-size:16px;">안읽음</span>' : '<span class="badge bg-success-subtle text-success text-uppercase" style="font-size:16px;">읽음</span>') + '</td>');
                    }

                    tbody.append(tr);
                });
            },
            error: function(error) {
                console.log(error, "다시 짜~");
            }
        });
    }

    // 받는 사람 입력 시
    $('#receiver').focusout('input', function() {
        receiver = $('#receiver').val().trim();
        receivePage = 1;
        startReceiveMsgPage = 1;
        fetchMessageCount("/receiveCount", "sender", sender, receiveUrl, receivePage, ".receivelist");
    });

    // 보내는 사람 입력 시
    $('#sender').focusout('input', function() {
        sender = $('#sender').val().trim();
        sendPage = 1;
        startSendMsgPage = 1;
        fetchMessageCount("/sendCount", "receiver", receiver, sendUrl, sendPage, ".sendlist");
    });
	
	
    // 상세 보기 클릭 시
    $(document).on('click', '.title a', function(event) {
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
                console.log("쪽지 읽깅");
            },
            error: function(error) {
                console.log(error, "안 됐다.");
            }
        });
    });

	let clickSendDate = 0;
	let clickReceiveDate = 0;
	let clickStatus = 0;
	
	$('#sendDate').on("click", function() {
		clickSendDate = clickSendDate + 1 ;
		
		if(clickSendDate > 1){
			clickSendDate = 0;
		}
		if(clickSendDate === 1){
			fetchMessageCount("/sendCount", "receiver", receiver, sendUrlAsc, sendPage, ".sendlist");
		}else{
			fetchMessageCount("/sendCount", "receiver", receiver, sendUrl, sendPage, ".sendlist");
		}
	});

	$('#receiveDate').on("click", function(){
		clickReceiveDate = clickReceiveDate + 1;
		if(clickReceiveDate > 1){
			clickReceiveDate = 0;
		}
		if(clickReceiveDate === 1){
			fetchMessageCount("/receiveCount", "sender", sender, receiveUrlAsc, receivePage, ".receivelist");
		}else{
			fetchMessageCount("/receiveCount", "sender", sender, receiveUrl, receivePage, ".receivelist");
		}
	})


	$('#sortStatus').on("click", function(){
		clickStatus = clickStatus + 1;
		if(clickStatus > 2){
			clickStatus = 0;
		}

		switch (clickStatus) {
			case 1 :
				fetchMessageCount("/sendCount", "receiver", receiver, statusAsc, sendPage, ".sendlist");			
				break;

			case 2:
				fetchMessageCount("/sendCount", "receiver", receiver, statusDesc, sendPage, ".sendlist");
				break;
		
			default:
				fetchMessageCount("/sendCount", "receiver", receiver, sendUrl, sendPage, ".sendlist");
				break;
		}
	})
	
	$('#checkAllReceived, #checkAllSent').change(function(){
		let isChecked = $(this).is(':checked');
		$('input[name="msgSeq"]').prop('checked', isChecked);
	});

</script>
