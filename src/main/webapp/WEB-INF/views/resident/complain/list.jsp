<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script
   src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<div style="display: none" id="memNm"><sec:authentication property="principal.memberVO.memNm" /></div>
<div style="display: none" id="nickname"><sec:authentication property="principal.memberVO.nickname" /></div>

<style>
tbody tr:hover{
	background-color: lightgray;
}
</style>

<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="ri-file-edit-line"></i><strong> 민원 </strong>
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
			
		</div>
		
		<div class="card-body table-responsive" style="min-height: 600px;">
			<div class="listArea" style="min-height: 400px;">
				<table class="table table-striped">
					<thead>
						<tr style="text-align: center">
							<th width="20%"></th>
							<th width="20%">민원</th>
							<th width="20%"></th>
							<th width="20%">등록일</th>
							<th width="10%">상태</th>
							<th width="10%">삭제</th>
						</tr>
					</thead>
					<tbody id="trShow">
						<c:if test="${fn:length(articlePage.content)==0}">
							<tr style="text-align: center">
								<td colspan="6" align="center">신청한 민원이 없습니다.</td>
							</tr>
						</c:if>
						<c:forEach var="complainVO" items="${articlePage.content}" varStatus="stat">
							<tr style="font-size: 16px;" class="showDetail" href="#reply[${stat.count}]" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="reply">
								<td class="tblRow" style="display: none">${complainVO.compSeq}</td>
								<td class="tblRow" colspan="3">${complainVO.compContent}</td>
								<td class="tblRow" style="text-align: center">${complainVO.regDt}</td>
								<td class="tblRow" style="text-align: center">
									<c:if test="${complainVO.reply eq null}"><span class="badge bg-warning">민원접수</span></c:if>
									<c:if test="${complainVO.reply ne null}"><span class="badge bg-success">답변완료</span></c:if>
								</td>
								<td style="text-align: center"><span class="compDel btn btn-outline-danger">X</span></td>
							</tr>
							<tr class="collapse menu-dropdown" id="reply[${stat.count}]">
								<td>답변: </td>
								<td colspan="5">
									<c:if test="${complainVO.reply eq null}">아직 답변이 등록되지 않았습니다.</c:if>
									<c:if test="${complainVO.reply ne null}">${complainVO.reply}</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			
	        <div style="margin-left: 700px;">${articlePage.pagingArea}</div>
			
<!-- 			<div class="replyArea" style="min-height: 200px;"> -->
<!-- 				<div class="card"> -->
<!-- 					<div class="card-body" style="min-height: 200px; border: 1px dotted black;"> -->
<!-- 						<p>답변: </p> -->
<!-- 						<div id="detail">민원을 선택해주세요.</div> -->
<!-- 					</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
		</div>
	</div>
</div>

<script>
// 	$('.tblRow').on('click', function(){
// 		let repStr = $(this).parent().children().eq(0).text();
// 		if(!repStr){
// 			repStr = '아직 답변이 등록되지 않았습니다.';
// 		}
		
// 		let rephtml = '';
// 		rephtml += '<p>';
// 		rephtml += repStr;
// 		rephtml += '</p>';
// 		$('#detail').html(repStr);
// 	})
	
	$(".compDel").on('click', function(){
		let compSeq = $(this).parent().parent().children().eq(1).text();
		
		Swal.fire({
			title: "민원을 취소하시겠습니까?",
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
				let data = {
					compSeq: compSeq
				};
					
// 				console.log(data);
				
				$.ajax({
					url: "/complain/delete",
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
			} 
		});
	})
</script>


	
