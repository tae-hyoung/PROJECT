<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/resources/assets/libs/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
<script src="/resources/assets/js/pages/form-editor.init.js"></script>

<div class="col-12">
	<div class="card">
		<div class="card-header">
			<h1>게시글 등록</h1>
		</div>

		<div class="card-body table-responsive" style="height: 500px;">
			<form action="/site/notice/update?${_csrf.parameterName}=${_csrf.token}" method="post">
				<input type="text" name="brdSeq" style="display: none;" value="${boardVO.brdSeq}" />
				<input type="text" name="memId" style="display: none;" value="admin" />
				<div class="form-group row">
					<input type="text" id="brdCat" name="brdCat" value="board_site" hidden="hidden">
					<div class="col-5">
						<label for="title" >제목  </label>
						<input type="text" style="width: 1461px"id="title" name="title" value="${boardVO.title}" required>
					</div>
				</div>
				<div class="form-group">
					<div class="ckeditor-classic"></div>
					<textarea rows="7" id="notice" name="content" style="display: none;" required>${boardVO.content}</textarea>
				</div>
				
				<div class="row" style="margin: 3px;">
					<button type="button" class="btn btn-warning col-1" id="btnCancel">취소</button>
					<button type="submit" class="btn btn-primary col-1">수정</button>
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
			editor.ui.view.editable.element.style.height = '200px';
		})
		.catch(function(error) {
    		console.error( error );
		});
});


$(function(){
	window.editor.setData($("textarea[name='content']").val());
	
	$('.ck-blurred').keydown(function(){
		console.log("str: " + window.editor.getData());
		$("textarea[name='content']").val(window.editor.getData());
	});
	
	$(".ck-blurred").on("focusout", function(){
		$("textarea[name='content']").val(window.editor.getData());
	});

	
	$("#btnCancel").on('click', function(){
		location.href = document.referrer;
	})
});

</script>
