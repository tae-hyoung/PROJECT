<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(function(){
	
	$("#btnCancel").on('click', function(){
		location.href = document.referrer;
	})
	
	    $("#danjiLayout").on('change', function(){
        readURL(this, '#danjiLayoutPreview');
    });

    $("#danjiPicture").on('change', function(){
        readURL(this, '#danjiPicturePreview');
    });

    function readURL(input, target) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $(target).attr('src', e.target.result).show();
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
});
</script>
<style>
	table, th, td {
	text-align: center;
	margin:5px 0 10px;
	border:0;
	border-top: 2px solid #333;
	border-bottom: 2px solid #ccc;
	border-right:1px solid #fff;
	background:#fff;
	word-break: keep-all;
	table-layout: fixed;
	margin-top: 30px;
	padding: 7px 8px;
	border-color: #cccccc;
	border-style: solid;
	line-height: 1.3;
	
	}
	
	th{
	color: #333;
	background: #fafafa;
	
	}
</style>

<form action="/site/danji/create?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
<div style="margin-top: 50px"class="row">
	<div class="col-12">
		<div
			class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
			<h4 style="font-weight: 900;" class="mb-sm-0">단지코드<input size="10" type="text" id="danjiCode" name="danjiCode" required></h4>
		</div>
	</div>
</div>

<table>
	<tr >
		<th width=20% >명칭</th>
		<td width=30%><input size="50" type="text" id="danjiName" name="danjiName" required></td>
		<th width=20%>단지분류</th>
		<td width=30%><input size="50" type="text" id="danjiCat" name="danjiCat" required> </td>
	</tr>
	
	<tr>
		<th>법정동주소</th>
		<td><input size="50" type="text" id="addr" name="addr" > </td>
		<th>도로명주소</th>
		<td><input size="50" type="text" id="addrDetail" name="addrDetail" > </td>
	</tr>
	
	<tr>
		<th>우편번호</th>
		<td><input size="50" type="text" id="post" name="post" > </td>
		<th>분양형태</th>
		<td><input size="50" type="text" id="saleType" name="saleType" > </td>
	</tr>
	
	<tr>
		<th>난방방식</th>
		<td><input size="50" type="text" id="heatingType" name="heatingType" > </td>
		<th>복도유형</th>
		<td><input size="50" type="text" id="hallType" name="hallType" > </td>
	</tr>
	
	<tr>
		<th>연면적</th>
		<td><input size="50" type="text" id="totalArea" name="totalArea" > </td>
		<th>주거전용면적</th>
		<td><input size="50" type="text" id="residentialArea" name="residentialArea" > </td>
	</tr>
	
	<tr>
		<th>사용승인일</th>
		<td><input size="50" type="text" id="approvalDt" name="approvalDt" > </td>
		<th>동수</th>
		<td><input size="50" type="text" id="cntDong" name="cntDong" > </td>
	</tr>
	
	<tr>
		<th>세대수</th>
		<td><input size="50" type="text" id="cntTotalRoom" name="cntTotalRoom" > </td>
		<th>시공사</th>
		<td><input size="50" type="text" id="constructor" name="constructor" > </td>
	</tr>
	
	<tr>
		<th>시행사</th>
		<td><input size="50" type="text" id="developer" name="developer" > </td>
		<th>69미만</th>
		<td><input size="50" type="text" id="underType69" name="underType69" > </td>
	</tr>
		
	<tr>	
		<th>69타입</th>
		<td><input size="50" type="text" id="type69" name="type69" > </td>
		<th>74타입</th>
		<td><input size="50" type="text" id="type74" name="type74" > </td>		
	</tr>
	
	<tr>	
		<th>84타입</th>
		<td><input size="50" type="text" id="type84" name="type84" > </td>
		<th>84초과</th>
		<td><input size="50" type="text" id="moreType84" name="moreType84" > </td>		
	</tr>
	
	
</table>
<div class="row">
	<div style="margin-top: 50px" class="col-6">
		<div>
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<h4 style="font-weight: 600;" class="mb-sm-0">단지 배치도</h4>
			</div>
			<div>
				<input type="file" id="danjiLayout" name="danjiLayoutFile">
				<img id="danjiLayoutPreview" src="#" alt="단지 배치도 미리보기" style="display: none; width: 100%; max-width: 700px; height: 500px; margin-top: 20px;">
			</div>
		</div>
	</div>

	<div style="margin-top: 50px" class="col-6">
		<div>
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<h4 style="font-weight: 600;" class="mb-sm-0">단지 사진</h4>
			</div>
			<div>
				<input type="file" id="danjiPicture" name="danjiPictureFile">
				<img id="danjiPicturePreview" src="#" alt="단지 사진 미리보기" style="display: none; width: 100%; max-width: 700px; height: 500px; margin-top: 20px;">
			</div>
		</div>
	</div>
	<div class="row" style=" margin: 3px; justify-content: flex-end" >
		<button type="button" class="btn btn-danger col-1" id="btnCancel">취소</button>
		<button type="submit" style="margin-left:3px" class="btn btn-primary col-1">등록</button>
	</div>
</div>
</form>