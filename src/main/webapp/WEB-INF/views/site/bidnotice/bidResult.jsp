<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	$("#regist").on("click",function(){
		console.log("등록");
		location.href="/site/bidCreate";
	});
});	
</script>



<div class="col-12">
	<div class="card">
		<div class="card-header" style="display: flex;">
			<p class="card-title" style="font-size: 25px;">입찰공고</p>
		</div>
		<div class="card-body table-responsive p-0" style="font-size:15px;">
			<table class="table table-hover text-nowrap" >
				<thead>
					<tr align="center">
<!-- 						<th><input type="checkbox" id="chkAll"/></th> -->
						<th>순번</th>
						<th>입찰공고번호</th>
						<th>입찰방법</th>
						<th>입찰공고명</th>
						<th>입찰마감일</th>
						<th>상태</th>
						<th>단지명</th>
						<th>공고일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="bidnoticeVO" items="${bidnoticeVOList}" varStatus="stat">
						
						<tr class="tblRow" align="center" data-bid-seq ="${bidnoticeVO.bidSeq}">
<!-- 							<td><input type="checkbox" /></td> -->
							<td>${bidnoticeVO.rum}</td>
							<td>${bidnoticeVO.bidSeq}</td>
							<td>${bidnoticeVO.bidHow}</td>
							<td>${bidnoticeVO.bidTitle}</td>
							<td>${bidnoticeVO.bidOutDt}</td>
							<td>
								<c:choose>
									<c:when test="${bidnoticeVO.bidStatus == '입찰'}">
										<span class="badge bg-info">${bidnoticeVO.bidStatus}</span>
									</c:when>
									<c:when test="${bidnoticeVO.bidStatus == '유찰'}">
										<span class="badge bg-warning">${bidnoticeVO.bidStatus}</span>
									</c:when>
									<c:when test="${bidnoticeVO.bidStatus == '낙찰'}">
										<span class="badge bg-success">${bidnoticeVO.bidStatus}</span>
									</c:when>
									<c:when test="${bidnoticeVO.bidStatus == '마감'}">
										<span class="badge bg-success">${bidnoticeVO.bidStatus}</span>
									</c:when>
									<c:when test="${bidnoticeVO.bidStatus == '취소'}">
										<span class="badge bg-danger">${bidnoticeVO.bidStatus}</span>
									</c:when>
								</c:choose>
							</td>
							<td>${bidnoticeVO.danjiName}</td>
							<td>${bidnoticeVO.bidStartDt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div>
			<button type="button" id="regist" class="btn btn-primary">등록</button>
			</div>
		</div>
	</div>
</div>

<script>

$(".tblRow").on('click', function(){
	
	var bidSeq = $(this).data('bid-seq');
	location.href = "/site/bidDetail?bidSeq=" + bidSeq;
})
</script>


