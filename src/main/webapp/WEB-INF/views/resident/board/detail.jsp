<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<div style="display: none" id="memId"><sec:authentication property="principal.memberVO.memId" /></div>
<div style="display: none" id="memNm"><sec:authentication property="principal.memberVO.memNm" /></div>
<div style="display: none" id="nickname"><sec:authentication property="principal.memberVO.nickname" /></div>
	
<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="bx bx-edit"></i><strong> 게시판 </strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">게시판</a></li>
						<li class="breadcrumb-item active">상세</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="col-12">
	<!-- 신고 모달 시작 -->
	<div id="reportModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
	    <div class="modal-dialog modal-xs">
	        <div class="modal-content">
	        	<div class="modal-header">
	        		<h1>신고 사유</h1>
	        	</div>
	        	<div class="modal-body">
					<input type="hidden" name="brdNo" value="">
					<input type="hidden" name="repNo" value="">
					<input type="hidden" name="repContent" value="">
        			<div style="margin-left: 10px; display: flex;">
	        			<div class="form-check form-radio-dark" style="margin-right: 20px;">
		                    <input class="form-check-input" type="radio" name="reportReason" id="reason01" value="욕설">
		                    <label class="form-check-label" for="reason01">욕설</label>
		                </div>
	        			<div class="form-check form-radio-dark" style="margin-right: 20px;">
		                    <input class="form-check-input" type="radio" name="reportReason" id="reason02" value="말고">
		                    <label class="form-check-label" for="reason02">사행성</label>
		                </div>
	        			<div class="form-check form-radio-dark" style="margin-right: 20px;">
		                    <input class="form-check-input" type="radio" name="reportReason" id="reason03" value="뭐가">
		                    <label class="form-check-label" for="reason03">음란물</label>
		                </div>
	        			<div class="form-check form-radio-dark" style="margin-right: 20px;">
		                    <input class="form-check-input" type="radio" name="reportReason" id="reason04" value="있지">
		                    <label class="form-check-label" for="reason04">도배</label>
		                </div>
	        			<div class="form-check form-radio-dark" style="margin-right: 20px;">
		                    <input class="form-check-input" type="radio" name="reportReason" id="reason05" value="기타">
		                    <label class="form-check-label" for="reason05">기타</label>
		                </div>
        			</div>
        			<div style="display: flex; justify-content: flex-end;">
        				<label for="etcReason">기타 사유: </label> &nbsp;&nbsp;&nbsp;
        				<textarea id="etcReason" rows="7" cols="57" style="resize: none;" disabled></textarea>
        			</div>
        			<div style="display: flex; justify-content: flex-end;">
	        			<a class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#reportModal">취소</a>
	        			<a class="btn btn-outline-danger" data-bs-toggle="modal" data-bs-target="#reportModal" id="reportSubmit">신고하기</a>
        			</div>
	        	</div>
	        </div>
	    </div>
	</div>
	<!-- 신고 모달 끝 -->
	<div class="card">
		<div class="card-header">
			<div class="row">
				<div class="col-8">
					<h1 class="brd-title">
						${boardVO.title}
						<c:if test="${boardVO.brdCat eq 'board_trade'}">
							<span id="JJIM"><i class="ri-star-line"></i></span>
						</c:if>
					</h1>
				</div>
				<div class="col-4" style="display: flex; justify-content: flex-end;">
					<c:if test="${boardVO.brdCat ne 'board_trade'}">
						<a href="/board/list?boardCat=${boardVO.brdCat}" class="btn btn-soft-dark" style="height: 35px; margin-left: 5px;">목록</a>
					</c:if>
					<c:if test="${boardVO.brdCat eq 'board_trade'}">
						<a href="/board/tradeList" class="btn btn-soft-dark" style="height: 35px; margin-left: 5px;">목록</a>
						<button type="button" class="btn btn-primary" style="height: 35px; margin-left: 5px;" id="sendMsg" data-bs-toggle="modal" data-bs-target="#msgModal">쪽지 보내기</button>
					</c:if>
					<c:if test="${boardVO.brdCat ne 'board_notice'}">
						<button type="button" class="btn btn-soft-info" id="udpBtn" style="height: 35px; margin-left: 5px;">수정</button>
						<button type="button" class="btn btn-soft-danger" id="delBtn" style="height: 35px; margin-left: 5px;">삭제</button>
					</c:if>
				</div>
			</div>
			
			<div class="card-tools">
				<div class="meta" style="display: flex;">
					<table style="width: 100%; font-size: 16px;">
						<tr>
							<td style="display: none;" class="writerId">${boardVO.memId}</td>
							<td width="10%" class="nickname"><a href="#"><i class="ri-user-fill"></i>&nbsp;${boardVO.nickname}</a></td>
							<td width="15%" class="date"><i class="bx bx-time"></i>&nbsp;${boardVO.regDt}</td>
							<td width="15%" class="date"><i class="bx bx-time"></i>&nbsp;${boardVO.updDt}</td>
							<td width="15%" class="comments">
							<c:if test="${boardVO.brdCat ne 'board_notice'}">
								<a href="#"><i class="ri-reply-line"></i>&nbsp;<span class="repCnt">${boardVO.replyVOList.size()}</span> Comments</a>
							</c:if>
							</td>
							<td width="35%"></td>
							<td width="3%" class="views"><i class="ri-eye-line"></i>&nbsp;${boardVO.viewCnt}</td>
							<td width="3%" class="likes"><i class="ri-heart-fill"></i>&nbsp;${boardVO.likeCnt}</td>
							<td width="4%" class="report" data-bs-toggle="modal" data-bs-target="#reportModal">
							<c:if test="${boardVO.brdCat ne 'board_notice'}">
								<i class="ri-alert-fill"></i>&nbsp;신고
							</c:if>
							</td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div class="card-body table-responsive">
			<div class="brd-text" style="min-height: 200px; font-size: 18px;">
				<c:if test="${boardVO.blindYn eq 'Y'}">
					<span style="font-size: 2em; color: red;">관리자에 의해 블라인드 처리된 게시글입니다.<br>작성자는 글을 수정하거나 삭제해주세요.</span>
				</c:if>
				<c:if test="${boardVO.blindYn eq 'N'}">
					${boardVO.content}
				</c:if>
			</div>
			<hr>
			<c:if test="${boardVO.brdCat ne 'board_notice'}">
				<div class="comments-form">
					<form class="form">
						<div class="row" style="margin-left: 10px;">
							<div class="col-12">
								<div class="form-group message" style="display: inline-flex; background-color: white; ">
									<i class="ri-pencil-line"></i>
									<textarea id="replyContent" name="content" rows="3" cols="80" placeholder="댓글을 입력하세요." style="border: none; resize: none"></textarea>
								</div>
							</div>
							<div class="col-12">
								<div class="form-group button">
									<button id="repSubBtn" type="button" class="btn btn-outline-primary">
										<i class="fa fa-send"></i>댓글 등록
									</button>
								</div>
							</div>
						</div>
					</form>
				</div>
				<hr>
				<div class="comments-list">
					<h2>댓글</h2> 
					<table id="replyTbl" style="width: 100%; font-size: 16px;">
						<c:forEach var="replyVO" items="${boardVO.replyVOList}" varStatus="stat">
							<tr class="tblRow">
								<td style="display: none;">${replyVO.repSeq}</td>
								<td width=15% class="repWriter">${replyVO.nickname}</td>
								<td width=61%>${replyVO.content}</td>
								<td width=15%><i class="bx bx-time"></i>&nbsp;${replyVO.regDt}</td>
								<td width=3% class="likes"><i class="ri-heart-fill"></i>&nbsp;${replyVO.likeCnt}</td>
								<td width=4% class="report" data-bs-toggle="modal" data-bs-target="#reportModal"><i class="ri-alert-fill"></i>&nbsp;신고</td>
								<td width=2% class="repDel" style="color: red;"><strong>X</strong></td>
								<td style="display: none;">${replyVO.memId}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</c:if>
		</div>
		
	</div>
	<!-- 쪽지 모달 시작  -->
	<!-- 메세지 전송 모달창  -->	
	<div id="msgModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="myModalLabel">쪽지 보내기</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
				</div>
				<div class="modal-body">
					<div class="mb-3">
                       <label for="receiver" class="col-form-label">받는사람:</label>
                       <input type="text" class="form-control" id="receiver" value="${boardVO.memId}" readonly>
                   </div>
                   <div class="mb-3">
                       <label for="title" class="col-form-label">제목:</label>
                       <input type="text" class="form-control" id="title" placeholder="제목을 입력하세요.">
                   </div>
                   <div class="mb-3">
                       <label for="content" class="col-form-label">내용:</label>
                       <textarea class="form-control" id="content" placeholder="내용을 입력하세요(300자 이하)" maxlength="300" style="height: 200px;"></textarea>
                   </div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" id="send">전송</button>
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->	
</div>

<script>
$(function(){
	
	// 해당 게시물 열었을 때 찜 테이블에서 해당 게시글 번호에 대한 목록을 가져와서
	let JJIMList = getJJIMList();
	// 로그인한 회원의 아이디가 존재할 경우 별 색 칠해놓기
	
	
	$(document).on('click', ".likes",  function(){
		let brdNo = '${boardVO.brdSeq}';
		let repNo = $(this).parent().children().eq(0).text();
		
		let like = $(this);
		let likeStr = '<i class="ri-heart-fill"></i>&nbsp;';
		
		console.log(repNo);
		
		if(repNo.indexOf('REP') == -1){
			repNo = null;
		}
		
		console.log("brdNo: ", brdNo);
		console.log("repNo: ", repNo);
		
		let data = {
				brdNo: brdNo,
				repNo: repNo
		};
	
		$.ajax({
			url: "/board/countLike",
			contentType: "application/json;charset=utf-8",
			data: JSON.stringify(data), 
			type: "post", 
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(result){
				console.log("result: ", result);
				likeStr += result;
				like.html(likeStr);
			}
		});
	});
	
	$(document).on('click', '.report', function(){
		let brdNo = '${boardVO.brdSeq}';
		let repNo = $(this).parent().children().eq(0).text();
		let repContent = $(this).parent().children().eq(2).text();
		
		if(!isNaN($.trim(repNo))){
			repNo = null;
		}
		
		$('input[name="brdNo"]').val(brdNo);
		$('input[name="repNo"]').val(repNo);
		$('input[name="repContent"]').val(repContent);
	})
	
	$("#reportSubmit").on('click', function(){
		if($('input[name="reportReason"]:checked').length == 0){
			Swal.fire({
                icon: 'error',
                title: '에러!',
                text: '신고 사유를 선택해주세요.'
            });
			return;
		}
		
		let brdNo = $('input[name="brdNo"]').val();
		let repNo = $('input[name="repNo"]').val();
		let repContent = $('input[name="repContent"]').val();
		let category = $('input[name="reportReason"]:checked').val();
		let reason = $('#etcReason').val();
		
		if(category != '기타'){
			reason = '';
		}
		
		let str;
		if(repNo.indexOf('REP') != -1)	str = repContent + "\n댓글을 신고하시겠습니까?";
		else						str = "게시글을 신고하시겠습니까?";
		
		
		
		Swal.fire({
	        title: str,
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
				data = {
						reporter: $('#memId').text(),
						brdNo: brdNo,
						repNo: repNo,
						category: category,
						reason: reason
				}
//	 			console.log('data: ', data);

				$.ajax({
					url: "/board/report",
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
			                title: '신고!',
			                text: '신고가 완료되었습니다.'
			            });
					}
				})
	        } 
	    });
		
		
	});
	
	$(document).on('click', '.repDel', function(){
		let memId = $('#memId').text().trim();
		let writer = $(this).parent().children().eq(7).text().trim();
		
		console.log("memId: ", memId);
		console.log("writer: ", writer);

		if(memId != writer){
			Swal.fire({
                icon: 'error',
                title: '에러!',
                text: '권한이 없습니다.'
            });
			return;
		};
		
		let brdNo = '${boardVO.brdSeq}';
		let repNo = $(this).parent().children().eq(0).text();
		let repContent = $(this).parent().children().eq(2).text();
		
		let data = {
				delYn: 'Y',
				brdNo: brdNo,
				repNo: repNo
		};
		
		Swal.fire({
	        title: repContent + "\n댓글을 삭제하시겠습니까?",
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
				$.ajax({
					url: "/board/repDel",
					contentType: "application/json;charset=utf-8",
					data: JSON.stringify(data), 
					type: "post", 
					beforeSend:function(xhr){
						xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
					},
					success: function(result){
						console.log("result: ", result);
						Swal.fire({
			                icon: 'info',
			                title: '삭제!',
			                text: '댓글이 삭제되었습니다.'
			            });
						
						let replyStr = '';
						for(let i=0; i<result.length; i++){
							
							replyStr += '<tr class="tblRow">';
							replyStr += '<td style="display: none;">'+result[i].repSeq+'</td>';
							replyStr += '<td width=15%>'+result[i].memId+'</td>';
							replyStr += '<td width=61%>'+result[i].content+'</td>';
							replyStr += '<td width=15%><i class="bx bx-time"></i>&nbsp;'+result[i].regDt+'</td>';
							replyStr += '<td width=3% class="likes"><i class="ri-heart-fill"></i>&nbsp;'+result[i].likeCnt+'</td>';
							replyStr += '<td width=4% class="report" data-bs-toggle="modal" data-bs-target="#reportModal"><i class="ri-alert-fill"></i>&nbsp;신고</td>';
							replyStr += '<td width=2% class="repDel" style="color: red;"><strong>X</strong></td>';
							replyStr += '<td style="display: none;">'+result[i].memId+'</td>';
							replyStr += '</tr>';
						}
						
						$("#replyTbl").html(replyStr);
						$("#replyContent").val("");
						
						$('.repCnt').text(result.length);
					}
				})
	        } 
	    });
		
	})
	
	$("#repSubBtn").on('click', function(){
		let brdNo = '${boardVO.brdSeq}';
		let memId = $('#memId').text();
		console.log("memId: ", memId);
		
		let data = {
				brdSeq: brdNo, 
				memId: memId,
				content: $("#replyContent").val()
		};
		
		$.ajax({
			url: "reply",
			contentType: "application/json;charset=utf-8",
			data: JSON.stringify(data), 
			type: "post", 
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
			},
			success: function(result){
				console.log("result: ", result);
				
				let replyStr = '';
				for(let i=0; i<result.length; i++){
					
					replyStr += '<tr class="tblRow">';
					replyStr += '<td style="display: none;">'+result[i].repSeq+'</td>';
					replyStr += '<td width=15%>'+result[i].nickname+'</td>';
					replyStr += '<td width=61%>'+result[i].content+'</td>';
					replyStr += '<td width=15%><i class="bx bx-time"></i>&nbsp;'+result[i].regDt+'</td>';
					replyStr += '<td width=3% class="likes"><i class="ri-heart-fill"></i>&nbsp;'+result[i].likeCnt+'</td>';
					replyStr += '<td width=4% class="report" data-bs-toggle="modal" data-bs-target="#reportModal"><i class="ri-alert-fill"></i>&nbsp;신고</td>';
					replyStr += '<td width=2% class="repDel" style="color: red;"><strong>X</strong></td>';
					replyStr += '<td style="display: none;">'+result[i].memId+'</td>';
					replyStr += '</tr>';
				}
				
				$("#replyTbl").html(replyStr);
				$("#replyContent").val("");
				
				$('.repCnt').text(result.length);
			}
		});
		
	});
	
	$("#udpBtn").on('click', function(){
		let memId = $('#memId').text().trim();
		let writer = $('.writerId').text().trim();
		
		console.log("memId: ", memId);
		console.log("writer: ", writer);

		if(memId != writer){
			Swal.fire({
                icon: 'error',
                title: '에러!',
                text: '권한이 없습니다.'
            });
			return;
		}
		
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
				location.href = "/board/update?brdSeq=${boardVO.brdSeq}";
	        } 
	    });
	});
	
	$("#delBtn").on('click', function(){
		let memId = $('#memId').text().trim();
		let writer = $('.writerId').text().trim();
		
		console.log("memId: ", memId);
		console.log("writer: ", writer);

		if(memId != writer){
			Swal.fire({
                icon: 'error',
                title: '에러!',
                text: '권한이 없습니다.'
            });
			return;
		}

		Swal.fire({
	        title: "삭제하시겠습니까?",
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
				location.href = "/board/delete?brdSeq=${boardVO.brdSeq}&brdCat=${boardVO.brdCat}";
	        } 
	    });
	});
	
	$('input[name="reportReason"]').on('change', function(){
		if($('#reason05')[0].checked == true){
			$('#etcReason').removeAttr('disabled');
		}else{
			$('#etcReason').attr('disabled', true);
		}
	});
})

$('#JJIM').on('click', function(){
	
	let JJIM;
	if($(this).css('color') == 'rgb(73, 80, 87)'){
		$(this).html('<i class="ri-star-fill"></i>');
		$(this).css('color', 'gold');
		JJIM = 'Y';
	}else{
		$(this).html('<i class="ri-star-line"></i>');
		$(this).css('color', 'rgb(73, 80, 87)');
		JJIM = 'N';
	}

	let data = {
			brdSeq: '${boardVO.brdSeq}',
			memId: $('#memId').text(),
			JJIM: JJIM
	};
	
	// 즐겨찾기에 추가 or 삭제
	$.ajax({
		url: "/board/JJIM",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data), 
		type: "post", 
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
			console.log("result: ", result);
			// 여기서 header.jsp의 getJJIMList(); 함수 호출하고 싶은데
		}
	})
})

function getJJIMList(){
	let memId = $('#memId').text();
	console.log('memId: ', memId);
	let JJIMList;
	
	let data = {
			brdSeq: '${boardVO.brdSeq}'
	};
	
	$.ajax({
		url: "/board/getJJIMList",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data), 
		type: "post", 
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
			console.log("result: ", result);
			for(let i=0; i<result.length; i++){
				if(memId == result[i].memId){
					$('#JJIM').html('<i class="ri-star-fill"></i>');
					$('#JJIM').css('color', 'gold');
					return;
				}
			}
		}
	});
}

$('#send').click(function(){
	let receiver = $('#receiver').val();
	let title = $('#title').val();
	let content = $('#content').val();
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
							if(result.isConfirmed){
						       $('#msgModal').modal('hide');
							}
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
