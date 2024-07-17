<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
tbody tr:hover{
	background-color: lightgrey;
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
<!-- 					<h3 class="card-title" style="font-size: 25px;">중고거래게시판</h3> -->
				</div>
				<div>
					<img alt="중고거래배너" src="/resources/images/trade.png" style="width:1555px; height:165px; border-radius:5px; border:1px solid white; margin-bottom:30px; margin-left:10px;" >
				</div>
				<div class="d-flex justify-content-end">
					<div class="input-group input-group-sm" style="width: 300px;  margin-bottom:10px; margin-right:10px;">
						<input type="text" name="table_search" id="brdKeyword" class="form-control float-right" placeholder="Search">
						<div class="input-group-append">
							<button type="button" class="btn btn-outline-dark" id="brdSearch"><i class="bx bx-search-alt-2"></i></button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="card-body table-responsive" style="min-height: 600px; display: flex; flex-wrap: wrap; justify-content: flex-start;">
			<c:forEach var="boardVO" items="${boardVOList}" varStatus="stat">
				<figure style="width: 300px;">
					<img src="/upload${boardVO.thumbnail}" alt="썸네일" data-brdNo="${boardVO.brdSeq}" data-brdCat="${boardVO.brdCat}" class="thumbnail" width="250px" height="250px" style="margin-left: 50px; border-radius:5px; margin-top: 20px;">
					<figcaption style="text-align: center; font-size: 19px; margin-top:10px; width:250px;  margin-left:50px;"><b>${boardVO.title}</b></figcaption>
				</figure>
			</c:forEach>
		</div>
		<div class="row" style="margin-bottom: 10px;">
			<div class="col-5"></div>	
	        <div class="col-6 clsPagingArea" style="float: left">
	        </div>
	        <div class="col-1">
	        	<a href="/board/insert?boardCat=board_trade" class="btn btn-outline-primary"> 게시글 등록 </a>
	        </div>
		</div>
	</div>
</div>

<script>
$(document).on('click', ".thumbnail", function(){
// 	console.log($(this)[0].dataset.brdno);
	location.href = "/board/detail?boardCat="+$(this)[0].dataset.brdcat+"&brdNo="+$(this)[0].dataset.brdno;
})
</script>
