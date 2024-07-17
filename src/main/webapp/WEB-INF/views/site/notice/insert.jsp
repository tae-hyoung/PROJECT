<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="/resources/assets/libs/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
<script src="/resources/assets/js/pages/form-editor.init.js"></script>


<div class="col-12">
	<div class="card">
		<div class="card-header">
			<h1>게시글 등록</h1>
		</div>

		<div class="card-body table-responsive" style="min-height: 500px;">
			<form action="/site/notice/insert?${_csrf.parameterName}=${_csrf.token}" method="post">
				<input type="text" name="memId" style="display: none;" value="admin" />
				<div class="form-group row">
					<input type="text" id="brdCat" name="brdCat" value="board_site" hidden="hidden">
					<div class="col-5">
						<label for="title" >제목  </label>
						<input type="text" id="title" name="title" placeholder="제목" required>
					</div>
				</div>
				<div class="form-group">
					<div class="ckeditor-classic"></div>
					<textarea rows="7" id="noticeCnt" name="content" style="display: none;" required></textarea>
				</div>
				
				<div class="row" style="margin: 3px;">
					<button type="submit" class="btn btn-primary col-1">등록</button>
					<button type="button" class="btn btn-light col-1" id="btnCancel">취소</button>
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
	$('.ck-blurred').keydown(function(){
		console.log("str: " + window.editor.getData());
		$("#noticeCnt").val(window.editor.getData());
	});
	
	$(".ck-blurred").on("focusout", function(){
		$("#noticeCnt").val(window.editor.getData());
	});

// 	$("#uploadFile").on("change", handleImg);
	
	$("#btnCancel").on('click', function(){
		location.href = document.referrer;
	})
});

</script>
