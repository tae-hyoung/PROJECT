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
			<form action="/board/insert?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
				<input type="text" name="memId" style="display: none;" value="<sec:authentication property="principal.memberVO.memId" />" />
				<div class="form-group row">
					<div class="col-2">
						<select name="brdCat" class="form-control">
							<c:if test="${boardCat eq 'board_free'}">
								<option value="board_free" selected>자유 게시판</option>
								<option value="board_trade">중고거래 게시판</option>
							</c:if>
							<c:if test="${boardCat eq 'board_trade'}">
								<option value="board_free">자유 게시판</option>
								<option value="board_trade" selected>중고거래 게시판</option>
							</c:if>
						</select>
					</div>
					<div class="col-10" style="display: flex;">
						<input type="text" class="form-control" id="title" name="title" placeholder="제목" required>
					</div>
				</div>
				<div class="form-group">
					<div class="ckeditor-classic"></div>
					<textarea rows="7" id="content" name="content" style="display: none;" required></textarea>
				</div>
				
				<div class="row">
					<div class="col-8" id="thumbnailDiv"></div>

					<div class="col-3 row" style="margin: 3px; display: flex; justify-content: flex-end; margin-left: 130px;">
						<button type="submit" class="btn btn-outline-primary col-1" style="width: 100px; height: 40px;">등록</button>
						<button type="button" class="btn btn-outline-dark col-1" id="btnCancel" style="width: 100px; height: 40px;">취소</button>
					</div>
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
		$("#content").val(window.editor.getData());
	});
	
	$(".ck-blurred").on("focusout", function(){
		$("#content").val(window.editor.getData());
	});

// 	$("#uploadFile").on("change", handleImg);
	
	$("#btnCancel").on('click', function(){
		location.href = document.referrer;
	})

	if($("select[name='brdCat']").val() == 'board_trade'){
		let str = '';

		str += '<span>대표 이미지&nbsp;&nbsp;&nbsp;&nbsp;</span>';
		str += '<input type="file" name="attach" id="thumbnail" required><br>';
		str += '<div id="preview" style="min-height: 300px;"></div>';
		
		$('#thumbnailDiv').html(str);
	}
});

// $(document).on('change')
$("select[name='brdCat']").on("change", function(){
	$('#thumbnailDiv').html('');
	if($("select[name='brdCat']").val() == 'board_trade'){
		let str = '';

		str += '<span>대표 이미지</span>';
		str += '<input type="file" name="thumbnail" id="thumbnail"><br>';
		str += '<div id="preview" style="min-height: 300px;"></div>';
		
		$('#thumbnailDiv').html(str);
	}
})

//이미지 미리보기
$(document).on("change", "#thumbnail", handleImg);

function handleImg(e) {
	let files = e.target.files;
	let fileArr = Array.prototype.slice.call(files);

	console.log(fileArr);
	
	fileArr.forEach(function(f) {
		if (!f.type.match("image.*")) {
			Swal.fire({
                icon: 'error',
                title: '에러!',
                text: '이미지 확장자만 가능합니다.'
            });
			return;
		}
		let reader = new FileReader();
		$("#preview").html("");
		
		reader.onload = function(e) {
			let str = "<img class='attach-img' style='width: 300px; height: 300px; margin:10px 10px 10px; border:3px dashed #ced4da;' alt='첨부파일' src='"+e.target.result+"'>"; 
			$("#preview").append(str);
		}
		reader.readAsDataURL(f);
	});
}
</script>
