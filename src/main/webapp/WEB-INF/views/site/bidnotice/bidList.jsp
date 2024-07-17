<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%
        MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
        String memAuth = member != null ? member.getMemAuth() : null;
%>




<script type="text/javascript" src="/resources/js/jquery.min.js"></script>

<script type="text/javascript">
$(function(){
	
    if('<%= memAuth%>' == 'ROLE_MASTER'){
        let htmlStr = '';
        htmlStr += '<button type="button" id="regist" class="btn btn-primary" style="margin-bottom: 5px">등록</button>';
        $('#createbtn').html(htmlStr);
}
	
	
	$("#regist").on("click",function(){
		console.log("등록");
		location.href="/site/bidCreate";
	});
});	
</script>

<div class="main-content">
  <div class="page-content">
      <div class="container-fluid">
          <div class="row" style="margin-top: 50px;">
              <div class="col-lg-12">
                  <div class="card rounded-0 bg-success-subtle mx-n4 mt-n4 border-top">
                      <div class="px-4">
                          <div class="row" style="width: 3500px;">
                              <div class="col-xxl-5 align-self-center">
                                  <div class="row">
                                  	<div class="col-3" style="margin-top: 30px;">
                                      	<h5 style="color:#222; font-size: 2rem; font-weight: 800" class="display-6 coming-soon-text">
                                      	| 입찰공고</h5>
                                      </div>
                               		</div>
                           		</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
 </div>

<!-- ///////////////////////////////////////등록버튼////////////////////////////////////////////// -->
		<div id="createbtn" style="display: flex; justify-content: flex-end;">

		</div>
<!-- ///////////////////////////////////////등록버튼////////////////////////////////////////////// -->
<div class="col-12">
	<div class="card row" >
		<div class="card-body table-responsive p-0" style="font-size:16px; min-height: 600px">
			<table class="table table-hover text-nowrap" >
				<thead>
					<tr align="center">
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
							<td>${bidnoticeVO.rum}</td>
							<td>${bidnoticeVO.bidSeq}</td>
							<td>${bidnoticeVO.bidHow}</td>
							<td align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${bidnoticeVO.bidTitle}</td>
							<td>${bidnoticeVO.bidOutDt}</td>
							<td>
								<c:choose>
									<c:when test="${bidnoticeVO.bidStatus == '입찰'}">
										<span class="badge bg-info" style="font-size: 16px; width: 70px; opacity: 0.99;">${bidnoticeVO.bidStatus}</span>
									</c:when>
									<c:when test="${bidnoticeVO.bidStatus == '유찰'}">
										<span class="badge bg-warning" style="font-size: 16px; width: 70px; opacity: 0.99;">${bidnoticeVO.bidStatus}</span>
									</c:when>
									<c:when test="${bidnoticeVO.bidStatus == '낙찰'}">
										<span class="badge bg-success" style="font-size: 16px; width: 70px; opacity: 0.99;">${bidnoticeVO.bidStatus}</span>
									</c:when>
									<c:when test="${bidnoticeVO.bidStatus == '마감'}">
										<span class="badge bg-dark" style="font-size: 16px; width: 70px; opacity: 0.99;">${bidnoticeVO.bidStatus}</span>
									</c:when>
									<c:when test="${bidnoticeVO.bidStatus == '취소'}">
										<span class="badge bg-danger" style="font-size: 16px; width: 70px; opacity: 0.99;">${bidnoticeVO.bidStatus}</span>
									</c:when>
								</c:choose>
							</td>
							<td>${bidnoticeVO.danjiName}</td>
							<td>${bidnoticeVO.bidStartDt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>

<script>

$(".tblRow").on('click', function(){
	
	var bidSeq = $(this).data('bid-seq');
	location.href = "/site/bidDetail?bidSeq=" + bidSeq;
})
</script>


