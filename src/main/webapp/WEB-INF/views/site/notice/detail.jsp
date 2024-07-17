<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%
	MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
	String memAuth = member != null ? member.getMemAuth() : null;
%>

<div class="col-11">
	<img alt="" src="/resources/images/BG.jpg" style="width: 1400px; height: 200px;">
	<hr>
	<div class="card">
		<div class="card-header">
			<div class="row">
				<div class="col-10">
					<h1 class="brd-title">${boardVO.title}</h1>
				</div>
				<div class="col-2" id="btns" style="text-align: end;">
	                <a href="/site/notice?boardCat=${boardVO.brdCat}" class="btn btn-primary">목록</a>
				</div>
			</div>
			<div class="card-tools">
				<div class="meta" style="display: flex;">
					<table style="width: 100%;">
						<tr>
							<td style="display: none;">0</td>
							<td width="6%" class="writer"><a href="#"><i class="ri-user-fill"></i>&nbsp;${boardVO.nickname}</a></td>
							<td width="20%" class="date"><i class="bx bx-time"></i>&nbsp;${boardVO.regDt}</td>
							<td width="66%"></td>
							<td width="5%" class="views"><i class="ri-eye-line"></i>&nbsp;${boardVO.viewCnt}</td>
							<td width="5%" class="likes"><i class="ri-heart-fill"></i>&nbsp;${boardVO.likeCnt}</td>
							<td width="0%"></td>
						</tr>
					</table>
				</div>
			</div>
		</div>

		<div class="card-body table-responsive">
			<div class="brd-text" style="min-height: 200px;">${boardVO.content}</div>
		</div>
		
		<div style="padding: 20px;">
			<hr>
				<a href="#" title="다음글" id="nextNotice"> 
					<strong>▲ 다음글</strong>&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="nextTitle">글 제목</span>
				</a>
			<hr>
				<a href="#" title="이전글" id="prevNotice"> 
					<strong>▼ 이전글</strong>&nbsp;&nbsp;&nbsp;&nbsp;
					<span id="prevTitle">글 제목</span>
				</a>
			<hr>
		</div>
		
	</div>

</div>

<script>
$(function(){
	if('<%= memAuth%>' == 'ROLE_MASTER'){
		let htmlStr = '';
		htmlStr += '<a href="/site/notice/update?brdSeq=${boardVO.brdSeq}" class="btn btn-info">수정</a>';
		htmlStr += '<button type="button" style="margin-left:3px" class="btn btn-danger" id="delBtn">삭제</button>';
		htmlStr += '<a href="/site/notice?boardCat=${boardVO.brdCat}" style="margin-left:3px" class="btn btn-primary">목록</a>';
		$('#btns').html(htmlStr);
	}
	
	$(document).on('click', ".likes",  function(){
		let brdNo = '${boardVO.brdSeq}';
		let repNo = $(this).parent().children().eq(0).text();
		
		let like = $(this);
		let likeStr = '<i class="ri-heart-fill"></i>&nbsp;';
		
		if(!isNaN($.trim(repNo))){
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
	
	$("#delBtn").on('click', function(){
		if(confirm('삭제하시겠습니까?')){
			location.href = "/site/notice/delete?brdSeq=${boardVO.brdSeq}&brdCat=${boardVO.brdCat}";
		}
	})
	
	let brdSeq = "${boardVO.brdSeq}";
	let data = {
			num: brdSeq.substr(4, 3)
	};
	console.log(data);
	$.ajax({
		url: '/site/getNext',
		contentType: 'application/json;charset=utf-8', 
		data: JSON.stringify(data),
		type: "post", 
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
			console.log('next', result);
			if(result == ''){
				$('#nextTitle').text('다음 글이 없습니다.');
				return;
			}
			$('#nextTitle').text(result.TITLE);
			$('#nextNotice').attr('href', '/site/notice/detail?brdNo='+result.BRD_SEQ);
		}
	})
	$.ajax({
		url: '/site/getPrev',
		contentType: 'application/json;charset=utf-8', 
		data: JSON.stringify(data),
		type: "post", 
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
			console.log('prev', result);
			if(result == ''){
				$('#prevTitle').text('이전 글이 없습니다.');
				return;
			}
			$('#prevTitle').text(result.TITLE);
			$('#prevNotice').attr('href', '/site/notice/detail?brdNo='+result.BRD_SEQ);
		}
	})
});



</script>
