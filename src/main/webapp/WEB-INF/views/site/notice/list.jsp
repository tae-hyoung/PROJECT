<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%
	MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
	String memAuth = member != null ? member.getMemAuth() : null;
%>

<style>
tbody tr:hover{
	background-color: lightgrey;
}
</style>

<!--  -->
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
                                                   <h5 style="color:#222; font-size: 2rem; font-weight: 800" class="display-6 coming-soon-text">| 공지사항</h5>
                                                </div>
                                          </div>
                                      </div>
                                <!-- end card body -->
                            </div>
                            <!-- end card -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
 </div>    
<!--  -->


				<div class="card-tools" style="display: flex; justify-content: flex-end; margin-bottom: 5px; margin-top: -20px;">
					<div class="input-group input-group-sm" style="width: 300px;">
						<input type="text" name="table_search" id="brdKeyword" class="form-control float-right" placeholder="Search">
						<div class="input-group-append">
							<button type="button" class="btn btn-default" id="brdSearch"><i class="bx bx-search-alt-2"></i></button>
						</div>
					</div>
				</div>

<div class="col-12">
	<div class="card row">

			<table class="table table-head-fixed text-nowrap">
				<thead>
					<tr style="text-align: center">
						<th>순번</th>
						<th>공지사항번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>등록일</th>
						<th>조회수</th>
						<th>추천수</th>
					</tr>
				</thead>
				<tbody id="trShow">
					<c:forEach var="boardVO" items="${articlePage.content}" varStatus="stat">
						<tr class="tblRow" style="text-align: center">
							<td class="col-1">${boardVO.rnum}</td>
							<td class="col-1">${boardVO.brdSeq}</td>
							<td style="text-align: left;">${boardVO.title}</td>
							<td class="col-1">${boardVO.nickname}</td>
							<td class="col-1">${boardVO.regDt}</td>
							<td class="col-1">${boardVO.viewCnt}</td>
							<td class="col-1">${boardVO.likeCnt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		<div class="row">
			<div class="col-5"></div>	
	        <div class="col-5 clsPagingArea" style="float: left; margin-bottom: 30px;">
	           ${articlePage.pagingArea}
	        </div>
	        <div style="text-align: center;" class="col-2" id="btns"></div>
		</div>
	</div>

</div>

<script>
$(function(){
	if('<%= memAuth%>' == 'ROLE_MASTER'){
		let htmlStr = '';
		htmlStr += '<a href="/site/notice/insert" class="btn btn-primary" style=" margin-left: 80px;"> 게시글 등록 </a>';
		$('#btns').html(htmlStr);
	}
});

$(document).on('click', ".tblRow", function(){
	console.log($(this).children().eq(1).html());
	location.href = "/site/notice/detail?brdNo="+$(this).children().eq(1).html();
})

$("#brdSearch").on('click', function(){
	let keyword = $("#brdKeyword").val();
	console.log("keyword: ", keyword);
	getList(keyword, 1);
})

function getList(keyword, currentPage){
	let data = {
		"boardCat": '${boardCat}',
		"keyword": keyword,
		"currentPage": currentPage
	};
	
	$.ajax({
		url:"/board/list",
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
			
			$.each(result.content, function(idx,boardVO){
				str += "<tr class='tblRow' style='text-align: center'>";
				str += "<td class='col-1'>"+(boardVO.rnum)+"</td>";
				str += "<td class='col-1'>"+(boardVO.brdSeq)+"</td>";
				str += "<td style='text-align: left;'>"+boardVO.title+"</td>";
				str += "<td class='col-1'>"+boardVO.nickname+"</td>";
				str += "<td class='col-1'>"+boardVO.regDt+"</td>";
				str += "<td class='col-1'>"+boardVO.viewCnt+"</td>";
				str += "<td class='col-1'>"+boardVO.likeCnt+"</td>";
				str += "</tr>";
			});
			
			$(".clsPagingArea").html(result.pagingArea);
			$("#trShow").html(str);
		}
	});
}
</script>