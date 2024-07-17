<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<style>
tbody tr:hover{
	background-color: lightgrey;
}

.center{
	text-align: center;
}

.right{
	text-align: right;
}

</style>

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
						<li class="breadcrumb-item active">목록</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="col-12">
	<div class="card">
		<div class="card-header">
			<div class="row">
				<div class="col-9">
					<h3 class="card-title" style="font-size: 25px;">
						<c:if test="${boardCat eq 'board_notice'}">공지게시판</c:if> 
						<c:if test="${boardCat eq 'board_free'}">자유게시판</c:if> 
					</h3>
				</div>
				<div class="card-tools col-3">
					<div class="input-group input-group-sm" style="width: 300px;">
						<input type="text" name="table_search" id="brdKeyword" class="form-control float-right" placeholder="Search">
						<div class="input-group-append">
							<button type="button" class="btn btn-outline-dark" id="brdSearch"><i class="bx bx-search-alt-2"></i></button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="card-body table-responsive" style="height: 600px; font-size: 16px">
			<table class="table table-head-fixed text-nowrap">
				<thead>
					<tr style="text-align: center">
						<th width="10%">번호</th>
						<c:if test="${boardCat eq 'board_notice'}">
							<th width="50%">제목</th>
						</c:if>
						<c:if test="${boardCat eq 'board_free'}">
							<th width="40%">제목</th>
							<th width="10%">작성자</th>
						</c:if>
						<th width="20%">등록일</th>
						<th width="10%">조회수</th>
						<th width="10%">추천수</th>
					</tr>
				</thead>
				<tbody id="trShow">
					<c:forEach var="boardVO" items="${articlePage.content}" varStatus="stat">
						<tr class="tblRow">
							<td style="display: none">${boardVO.brdSeq}</td>
							<td style="display: none">${boardVO.brdCat}</td>
							<td class="center">${articlePage.total + 1 - boardVO.rnum}</td>
							<c:if test="${boardCat eq 'board_notice'}">
								<td>${boardVO.title}</td>
							</c:if>
							<c:if test="${boardCat eq 'board_free'}">
								<td>${boardVO.title}</td>
								<td>${boardVO.nickname}</td>
							</c:if>
							<td class="center">${fn:substring(boardVO.regDt, 0, 10)}</td>
							<td class="center">${boardVO.viewCnt}</td>
							<td class="center">${boardVO.likeCnt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="col-5"></div>	
	        <div class="col-6 clsPagingArea" style="float: left">
	           ${articlePage.pagingArea}
	        </div>
	        <div class="col-1">
	        	<c:if test="${boardCat ne 'board_notice'}">
		        	<a href="/board/insert?boardCat=${boardCat}" class="btn btn-outline-primary"> 게시글 등록 </a>
	        	</c:if>
	        </div>
		</div>
	</div>
</div>

<script>
$(document).on('click', ".tblRow", function(){
	console.log($(this).children().eq(0).html());
	location.href = "/board/detail?boardCat="+$(this).children().eq(1).html()+"&brdNo="+$(this).children().eq(0).html();
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
			let brdCat = "";
			$.each(result.content, function(idx,boardVO){
				let rnum = Number(result.total) - Number(boardVO.rnum) + 1;
				str += "<tr class='tblRow'>";
				str += "<td style='display: none'>"+(boardVO.brdSeq)+"</td>";
				str += "<td class='center'>"+ rnum +"</td>";
				str += "<td>"+boardVO.title+"</td>";
				str += "<td>"+boardVO.nickname+"</td>";
				str += "<td class='center'>"+boardVO.regDt.substring(0, 10)+"</td>";
				str += "<td class='center'>"+boardVO.viewCnt+"</td>";
				str += "<td class='center'>"+boardVO.likeCnt+"</td>";
				str += "</tr>";
			});
			
			$(".clsPagingArea").html(result.pagingArea);
			$("#trShow").html(str);
		}
	});
}
</script>