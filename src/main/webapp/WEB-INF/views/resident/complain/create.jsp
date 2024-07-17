<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<div style="display: none" id="memNm"><sec:authentication property="principal.memberVO.memNm" /></div>
<div style="display: none" id="nickname"><sec:authentication property="principal.memberVO.nickname" /></div>

<script src="/resources/assets/libs/@ckeditor/ckeditor5-build-classic/build/ckeditor.js"></script>
<script src="/resources/assets/js/pages/form-editor.init.js"></script>

<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="bx bx-message-rounded-edit"></i><strong>    민원 신청</strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">민원</a></li>
						<li class="breadcrumb-item active">민원신청</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="col-11 mx-auto">
	<div>
		<img alt="민원내용" src="/resources/images/complain.png" style="width:1471px; height:162px; border-radius:7px; border:1px solid white;" >
	</div>
	<div class="card" style=" margin-top:25px; border-radius:7px;">
		<div class="card-header">
			<h3 class="card-title" style="font-size: 24px;"><i class="bx bx-message-rounded-edit"></i>    민원 신청</h3>
			
		</div>
		
		<div class="card-body table-responsive" style="min-height: 500px;">
			<form action="/complain/create?${_csrf.parameterName}=${_csrf.token}" method="post">
				<input type="text" name="memId" style="display: none;" value="<sec:authentication property="principal.memberVO.nickname" />" />
				<div class="form-group">
					<div class="ckeditor-classic"></div>
					<textarea rows="7" id="compContent" name="compContent" style="display: none;" required></textarea>
				</div>
				
				<div class="row" style="display: flex; justify-content: flex-end; margin-top:20px; gap:5px;">
					<button type="submit" class="btn btn-primary col-1">등록</button>
					<button type="button" class="btn btn-light col-1" id="btnCancel" style="background-color: lightgray; margin-right:11px;">취소</button>
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
	$('.ck-blurred').keydown(function(){
		console.log("str: " + window.editor.getData());
		$("#compContent").val(window.editor.getData());
	});
	
	$(".ck-blurred").on("focusout", function(){
		$("#compContent").val(window.editor.getData());
	});

// 	$("#uploadFile").on("change", handleImg);
	
	$("#btnCancel").on('click', function(){
		location.href = document.referrer;
	})
});
</script>