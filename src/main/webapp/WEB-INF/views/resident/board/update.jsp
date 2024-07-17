<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/resources/assets/libs/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
<script src="/resources/assets/js/pages/form-editor.init.js"></script>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<div style="display: none" id="memNm"><sec:authentication property="principal.memberVO.memNm" /></div>
<div style="display: none" id="nickname"><sec:authentication property="principal.memberVO.nickname" /></div>

<div class="col-12">
	<div class="card">
		<div class="card-header">
			<h1>게시글 등록</h1>
		</div>

		<div class="card-body table-responsive" style="min-height: 500px;">
			<form action="/board/update?${_csrf.parameterName}=${_csrf.token}" method="post">
				<input type="text" name="brdSeq" style="display: none;" value="${boardVO.brdSeq}" />
				<input type="text" name="memId" style="display: none;" value="<sec:authentication property="principal.memberVO.nickname" />" />
				<div class="form-group row">
					<div class="col-2">
						<select name="brdCat" class="form-control">
							<option value="board_free">자유 게시판</option>
							<option value="board_trade">중고거래 게시판</option>
						</select>
					</div>
					<div class="col-10">
						<input type="text" class="form-control" id="title" name="title" value="${boardVO.title}" required>
					</div>
				</div>
				<div class="form-group">
					<div class="ckeditor-classic"></div>
					<textarea rows="7" id="content" name="content" style="display: none;" required>${boardVO.content}</textarea>
				</div>
				
				<div class="row" style="margin: 3px;">
					<button type="button" class="btn btn-outline-dark col-1" id="btnCancel">취소</button>
					<button type="submit" class="btn btn-outline-success col-1">수정</button>
				</div>
			</form>
		</div>


	</div>
</div>
<script>
var ckClassicEditor = document.querySelectorAll(".ckeditor-classic")
ckClassicEditor.forEach(function () {
	ClassicEditor.create(document.querySelector('.ckeditor-classic'), {ckfinder:{uploadUrl:'/image/upload?${_csrf.parameterName}=${_csrf.token}'}})
		.then(function(editor) {
			window.editor=editor;
			editor.ui.view.editable.element.style.height = 'auto';
		})
		.catch(function(error) {
    		console.error( error );
		});
});


$(function(){
	window.editor.setData($("#content").val());
	
	$('.ck-blurred').keydown(function(){
		console.log("str: " + window.editor.getData());
		$("#content").val(window.editor.getData());
	});
	
	$(".ck-blurred").on("focusout", function(){
		$("#content").val(window.editor.getData());
	});

	
	$("#btnCancel").on('click', function(){
		location.href = document.referrer;
	})
});

</script>
