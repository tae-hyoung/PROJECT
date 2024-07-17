<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
tbody tr:hover{
	background-color: lightgray;
}

.myBg{
	text-align: center;
	width: 80px;
}

.center{
	text-align: center;
}
</style>

<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="bx bx-message-rounded-edit"></i><strong> 민원 </strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">민원</a></li>
						<li class="breadcrumb-item active">민원내역</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="col-12">
	<div class="card">
		<div class="card-header">
			<h3 class="card-title" style="font-size: 40px;">민원 신청 내역</h3>
		</div>
		
		<div id="myModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
		    <div class="modal-dialog modal-xl">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="myModalLabel">민원 답변</h5>
		                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
		            </div>
		            <div class="modal-body">
		                <h5 class="fs-15" id="complainModal">
		                    Insert complain Here.
		                </h5>
		                <p class="text-muted"><textarea rows="6" cols="170" id="replyModal" placeholder="답변을 입력하세요." name="reply"></textarea></p>
		            </div>
		            <div class="modal-footer">
		                <input type="hidden" id="compSeqModal" />
		                <button type="button" class="btn btn-outline-dark" data-bs-dismiss="modal">취소</button>
		                <button type="button" class="btn btn-outline-success" id="submitBtn">저장</button>
		            </div>
		
		        </div><!-- /.modal-content -->
		    </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->

		<div class="card-body table-responsive" style="min-height: 600px;">
			<div class="listArea" style="min-height: 600px;">
				<table class="table table-striped" style="font-size: 16px;">
					<thead>
						<tr>
							<th class="center">민원인ID</th>
							<th class="center">민원</th>
							<th class="center">등록일</th>
							<th class="center">상태</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${fn:length(articlePage.content)==0}">
							<tr>
								<td colspan="4" align="center">신청한 민원이 없습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="complainVO" items="${articlePage.content}" varStatus="stat">
							<tr class="tblRow" data-bs-toggle="modal" data-bs-target="#myModal">
								<td style="display: none">${complainVO.reply}</td>
								<td style="display: none">${complainVO.compSeq}</td>
								<td>${complainVO.memId}</td>
								<td>${complainVO.compContent}</td>
								<td class="center">${complainVO.regDt}</td>
								<td class="center">
									<c:if test="${complainVO.delYn eq 'Y'}">
									<span class="badge myBg" style="font-size: 16px; background-color: lightgray; color: black;">삭제</span>
									</c:if>
									<c:if test="${complainVO.delYn ne 'Y' and complainVO.reply eq null}">
									<span class="badge myBg bg-warning" style="font-size: 16px;">미응답</span>
									</c:if>
									<c:if test="${complainVO.delYn ne 'Y' and complainVO.reply ne null}">
									<span class="badge myBg bg-success" style="font-size: 16px;">응답완료</span>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
	        <div style="margin-left: 720px;">${articlePage.pagingArea}</div>
			
		</div>
	</div>
</div>

<script>
$(".tblRow").on('click', function(){
	let complain = $(this).children().eq(3).text();
	let compSeq = $(this).children().eq(1).text();
	let reply = $(this).children().eq(0).text();
	
	$("#complainModal").text(complain);
	$("#compSeqModal").text(compSeq);
	$("#replyModal").val(reply);
})

$("#submitBtn").on('click', function(){
	let data = {
			reply: $('textarea[name="reply"]').val(),
			compSeq: $('#compSeqModal').text()
	};
	
	console.log("data: ", data);
	$.ajax({
		url: "/complain/admin/reply",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
			console.log("result: ", result);
			location.reload();
		}
	})
})
</script>
