<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%
        MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
        String memAuth = member != null ? member.getMemAuth() : null;
%>

<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
<style>

/* --------------------- 테이블 --------------------- */
table b{font-weight: 400}
/* 기본테이블 */
.contTbl{width:100%;margin:5px 0 10px;border:0;border-collapse:separate;border-top: 2px solid #333;border-bottom: 1px solid #ccc;border-right:1px solid #fff;background:#fff;word-break: keep-all;table-layout: fixed;}
.contTbl>*>tr{border-right:2px solid #fff;}
.contTbl>*>tr>th,
.contTbl>*>tr>td {padding: 7px 8px;border-color: #cccccc;border-style:solid;border-width:1px 1px 0 0;vertical-align:middle;line-height: 1.3;}
.contTbl>*>tr>td{font-size: 13px;height: 15px;}
.contTbl>*>tr>td a{color: #0024a5; font-weight: 500;word-break: break-all;}
.contTbl>*>tr>td a:not([class*='btn']):hover{text-decoration: underline;}
.contTbl>*>tr>td p{margin: 3px 0}
.contTbl>*>tr>th{background: #fafafa;color: #333;font-weight: 500;}
.contTbl>*>tr>th[scope=rowgroup],.contTbl>*>tr>th[scope=colgroup],.thBg{background: #f2f2f2 !important}
.contTbl>*>tr>*:last-child{border-right: none;}
.contTbl>thead>tr>th{border-width:0 1px 1px 0;text-align:center;padding: 10px 5px;}
.contTbl>tfoot>tr>th{}
.contTbl > tfoot > * {background: #f7f7f7;font-weight:400;}
.contTbl > tfoot td,.contTbl > tfoot th{border-top: 1px solid #888}
.contTbl>tbody>tr:first-child>th,
.contTbl>tbody>tr:first-child>td{border-top-width:0;}
.contTbl * > table {margin:0 !important;}
.cT_line{border-left: 1px solid #d9d9d9;}
.cT_line>*>tr{border-right: none;}
.contTbl.slim>*>tr>th, .contTbl.slim>*>tr>td{padding: 5px 6px;}
.contTbl.slim>thead>tr>th{padding: 7px 6px;}
.contTbl.slim >*>tr>* {padding-left:3px;padding-right:3px;}
.borR{border-right: 1px solid #ccc !important;}
.required {}
.required:after {color:#c53f3f; content:'*'; display:inline-block; width:5px; height: 5px; margin:0 0 0 3px; }
.reDoclist{color: #195aaa;font-weight: 400;display: inline-block;vertical-align: -3px;position: relative;padding-left: 2px;margin-left: 20px;}
.reDoclist:before{content: "\f069";font-family: 'Font Awesome 5 Free';display: inline-block;font-weight: 900;font-size: 10px;position: absolute;left: 0;top: 2px;}
.reDoclist li{float: left;margin-left: 10px;}

/*상단단지섹션*/
#container .subTop .aptInfo{width: 100%;background: #0581bb;background: linear-gradient(to right, #32afb5 0%,#0a87bb 30%,#1967b4 52%);height: 75px;line-height: 75px;color: #fff;position: relative;/* overflow: hidden; */border-bottom: 1px solid #e0e0e0;box-sizing: border-box;}
#container .subTop .aptInfo .wp1400{height: auto;overflow: hidden;padding-left: 300px;box-sizing: border-box;}
#container .subTop .aptInfo .aptInfo_marker{position: relative;float: left;height: 30px;margin-top: 23px;}
#container .subTop .aptInfo .aptInfo_marker .aIpin{width: 17px;height: 26px;background: url(../img/common/aIpin.png) no-repeat center;display: block;animation:pin 0.5s both;}
#container .subTop .aptInfo .aptInfo_marker .aIspot{width: 15px;height: 7px;background: rgba(255,255,255,0.2);border-radius: 100%;display: block;position: absolute;bottom: 0;left: 50%;margin-left: -7.5px;}
#container .subTop .aptInfo .aptInfo_marker .aIspot:after{content:'';border-radius: 100%;height: 100%;width: 100%;position: absolute;opacity: 0;animation: aIspot 1.2s ease-out infinite;animation-delay: 1.2s; background: rgba(255,255,255,0.2);}
#container .subTop .aptInfo .aptInfo_Tle{float: left;font-family: 'SCoreDream';font-size: 23px;font-weight: 600;letter-spacing: -1.15px;margin-left: 15px;max-width: 338px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
#container .subTop .aptInfo .aptInfo_detail{float: left;margin: 20px 0 0 0;}
#container .subTop .aptInfo .aptInfo_detail li{float: left;letter-spacing: -0.35px;line-height: 18px;margin-left: 45px;max-width: 240px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;}
#container .subTop .aptInfo .aptInfo_detail li b{font-weight: 600;margin-right: 3px;display: block;}
#container .subTop .aptInfo_btn{font-family: 'SCoreDream';float: right;color: #fff;background: rgba(14,93,170,0.8) url(../img/common/aptInB.png) no-repeat 32px center;border: 1px solid rgba(255,255,255,0.8);border-radius: 20px;padding: 0 38px 0 58px;height: 38px;font-size: 14px;font-weight: 200;position: absolute; right: 50%; margin-right: -652px;top: 19px;}
#container .subTop .aptInfo_btn b{font-weight:600}
#container .subTop .aptInfo_btn:after{content: '';width: 45px;height: 45px;border-radius: 100%;display: block;background: #fff url(../img/common/aptInBi.png) no-repeat center top;position: absolute;right: -28px;top: -4px;box-shadow: 4px 4px 8px 0px rgba(0, 0, 0,0.2);transition-duration: 0.3s}
#container .subTop .aptInfo_btn:hover{background-color: #06539e;}
#container .subTop .aptInfo_btn:hover:after{background-position: center -45px}
.subT_Bg{width: 200px;height: 95px;background: url(../img/common/sTbg.png);position: absolute;right: 50%;bottom: 0px;margin-right: -932px;z-index: 999;}
.subT_Bg > span{background: url(../img/common/sTbgB.png) no-repeat;display: block;position: absolute;}
.subT_Bg .subT_Bg1{width: 22px;height: 49px;background-position: left bottom;bottom: 41px;left: 41px;animation-delay: 0.8s;}
.subT_Bg .subT_Bg2{width: 27px;height: 82px;background-position: -31px bottom;bottom: 29px;left: 60px;animation-delay: 1.3s;}
.subT_Bg .subT_Bg3{width: 33px;height: 43px;background-position: -67px bottom;bottom: 45px;right: 47px;animation-delay: 1.8s;}
.subT_Bg .subT_Bg4{width: 50px;height: 68px;background-position: right bottom;bottom: 0;right: 74px;animation-delay: 2.3s;}
.subT_B_ani{animation:subT_B 0.5s both 0.5s;}
.subT_Bg_ani{animation:subT_Bg 1.2s both;}

/* width */
.wpAuto {width:auto !important;}
.wp5  {width:5% !important;}
.wp10 {width:10% !important;}
.wp15 {width:15% !important;}
.wp20 {width:20% !important;}
.wp25 {width:25% !important;}
.wp30 {width:30% !important;}
.wp35 {width:35% !important;}
.wp40 {width:40% !important;}
.wp45 {width:45% !important;}
.wp50 {width:50% !important;}
.wp55 {width:55% !important;}
.wp60 {width:60% !important;}
.wp65 {width:65% !important;}
.wp70 {width:70% !important;}
.wp75 {width:75% !important;}
.wp80 {width:80% !important;}
.wp85 {width:85% !important;}
.wp90 {width:90% !important;}
.wp95 {width:95% !important;}
.wp100 {width:100% !important;}
/* .wp1400{width: 1605px;height: auto;margin: 0 auto;} */
.wp1400{
	height: auto;
	overflow: hidden;
	padding-left: 140px;
	box-sizing: border-box;
}

.btn-primary {
    color: #fff !important;
    background-color: #435ebe !important;
    border-color: #435ebe !important;
}

.btn-warning {
    color: #fff !important;
    background-color: #f6c23e !important;
    border-color: #f6c23e !important;
}

.btn-danger {
    color: #fff !important;
    background-color: #dc3545 !important;
    border-color: #dc3545 !important;
}

.btn-success {
    color: #fff !important;
    background-color: #198754 !important;
    border-color: #198754 !important;
}

.btn-info {
    color: #fff !important;
    background-color: #36b9cc !important;
    border-color: #36b9cc !important;
}

.aptInfo{
	width: 102%;
	background: #0581bb;
	background: linear-gradient(to right, #32afb5 0%,#0a87bb 30%,#1967b4 52%);
	height: 75px;
	line-height: 75px;
	color: #fff;
	position: relative;/* overflow: hidden; */
	border-bottom: 1px solid #e0e0e0;
	box-sizing: border-box;
}


</style>
<script type="text/javascript">
$(function(){
	
	var danjiName = $("input[name='danjiName']").val();
	var danjiCat = $("input[name='danjiCat']").val();
	var addr = $("input[name='addr']").val();
	var addrDeatil = $("input[name='addrDeatil']").val();
	var post = $("input[name='post']").val();
	var saleType = $("input[name='saleType']").val();
	var heatingType = $("input[name='heatingType']").val();
	var hallType = $("input[name='hallType']").val();
	var totalArea = $("input[name='totalArea']").val();
	var residentialArea = $("input[name='residentialArea']").val();
	var approvalDt = $("input[name='approvalDt']").val();
	var cntDong = $("input[name='cntDong']").val();
	var cntTotalRoom = $("input[name='cntTotalRoom']").val();
	var constructor = $("input[name='constructor']").val();
	var underType69 = $("input[name='underType69']").val();
	var type69 = $("input[name='type69']").val();
	var type74 = $("input[name='type74']").val();
	var type84 = $("input[name='type84']").val();
	var moreType84 = $("input[name='moreType84']").val();
	var danjiLayout = $("input[name='danjiLayout']").val();
	var danjiPicture = $("input[name='danjiPicture']").val();
	
	var tbody = '';
	
	
	$(document).on('click', "#btnList", function(){
	location.href = "/site/danji";
	})
	
	 // 초기 상태에서 파일 입력 요소 숨기기
    $('input[type="file"]').hide();
	
	//일반모드와 수정모드를 toggle
	$(document).on("click","#edit",function(){
		
		$("#p1").css("display","none");
		$("#p2").css("display","block");
		
		$(".editel").removeAttr("readonly")
		$(".editel").removeAttr("style");
		$("#danjiLayout").removeAttr("input");
		tbody = $('#tbody').html();
		
        // 파일 입력 요소 보이기
        $('input[type="file"]').show();
		
	});
	
	//취소 버튼 클릭
	$(document).on("click", "#cancel",function() {
		$("#p1").css("display", "block");
		$("#p2").css("display", "none");
		$(".editel").attr("readonly","readonly")
	
		
		//입력란 초기화
		$("input[name='danjiName']").val(danjiName);
		$("input[name='danjiCat']").val(danjiCat);
		$("input[name='addr']").val(addr);
		$("input[name='addrDeatil']").val(addrDeatil);
		$("input[name='post']").val(post);
		$("input[name='saleType']").val(saleType);
		$("input[name='heatingType']").val(heatingType);
		$("input[name='hallType']").val(hallType);
		$("input[name='totalArea']").val(totalArea);
		$("input[name='residentialArea']").val(residentialArea);
		$("input[name='approvalDt']").val(approvalDt);
		$("input[name='cntDong']").val(cntDong);
		$("input[name='cntTotalRoom']").val(cntTotalRoom);
		$("input[name='constructor']").val(constructor);
		$("input[name='underType69']").val(underType69);
		$("input[name='type69']").val(type69);
		$("input[name='type74']").val(type74);
		$("input[name='type84']").val(type84);
		$("input[name='moreType84']").val(moreType84);
		$("input[name='danjiLayout']").val(danjiLayout);
		$("input[name='danjiPicture']").val(danjiPicture);
		
		$('#tbody').html(tbody);
		
        // 파일 입력 요소 숨기기
        $('input[type="file"]').hide();
	});
	
	//확인버튼 클릭 시
	$(document).on("click", "#confirm", function(){
		
		let danjiCode = $("input[name='danjiCode']").val();
		let danjiName = $("input[name='danjiName']").val();
		let danjiCat = $("input[name='danjiCat']").val();
		let addr = $("input[name='addr']").val();
		let addrDetail = $("input[name='addrDetail']").val();
		let post = $("input[name='post']").val();
		let saleType = $("input[name='saleType']").val();
		let heatingType = $("input[name='heatingType']").val();
		let hallType = $("input[name='hallType']").val();
		let totalArea = $("input[name='totalArea']").val();
		let residentialArea = $("input[name='residentialArea']").val();
		let approvalDt = $("input[name='approvalDt']").val();
		let cntDong = $("input[name='cntDong']").val();
		let cntTotalRoom = $("input[name='cntTotalRoom']").val();
		let constructor = $("input[name='constructor']").val();
		let developer = $("input[name='developer']").val();
		let underType69 = $("input[name='underType69']").val();
		let type69 = $("input[name='type69']").val();
		let type74 = $("input[name='type74']").val();
		let type84 = $("input[name='type84']").val();
		let moreType84 = $("input[name='moreType84']").val();
		let danjiLayoutFile = $("input[name='danjiLayoutFile']").prop('files');
		let danjiPictureFile = $("input[name='danjiPictureFile']").prop('files');
		
			//JSON 오브젝트
		let data = {
				"danjiCode":danjiCode,
				"danjiName":danjiName,
				"danjiCat":danjiCat,
				"addr":addr,
				"addrDetail":addrDetail,
				"post":post,
				"saleType":saleType,
				"heatingType":heatingType,
				"hallType":hallType,
				"totalArea":totalArea,
				"residentialArea":residentialArea,
				"approvalDt":approvalDt,
				"cntDong":cntDong,
				"cntTotalRoom":cntTotalRoom,
				"constructor":constructor,
				"developer":developer,
				"underType69":underType69,
				"type69":type69,
				"type74":type74,
				"type84":type84,
				"moreType84":moreType84,
				"danjiLayoutFile":danjiLayoutFile,
				"danjiPictureFile":danjiPictureFile
		};
		
		console.log("data : ", data);
		
		
		if (confirm("수정하시겠습니까?")) {
			$.ajax({
				url:"/site/danji/updateAjax",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				contentType : false,
				processData : false,
				dataType:"json",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					console.log("result : ", result);
					
					$('.toast').toast('show');
					
			        let str = "";
			        
			        str += `
			        	<tr >
			    		<th>명칭</th>
			    		<td> <input class="editel form-control" name="danjiName" value="\${result.danjiName}" style="border: none; width: 300px;" readonly> </td>
			    		<th>단지분류</th>
			    		<td> <input class="editel form-control" name="danjiCat" value="\${result.danjiCat}" style="border: none; width: 300px;" readonly> </td>
			    	</tr>
			    	
			    	<tr>
			    		<th>법정동주소</th>
			    		<td><input class="editel form-control" name="addr" value="\${result.addr}" style="border: none; width: 300px;" readonly> </td>
			    		<th>도로명주소</th>
			    		<td><input class="editel form-control" name="addrDetail" value="\${result.addrDetail}" style="border: none; width: 300px;" readonly> </td>
			    	</tr>
			    	
			    	<tr>
			    		<th>우편번호</th>
			    		<td><input class="editel form-control" name="post" value="\${result.post}" style="border: none; width: 300px;" readonly> </td>
			    		<th>분양형태</th>
			    		<td><input class="editel form-control" name="saleType" value="\${result.saleType}" style="border: none; width: 300px;" readonly> </td>
			    	</tr>
			    	
			    	<tr>
			    		<th>난방방식</th>
			    		<td><input class="editel form-control" name="heatingType" value="\${result.heatingType}" style="border: none; width: 300px;" readonly> </td>
			    		<th>복도유형</th>
			    		<td><input class="editel form-control" name="hallType" value="\${result.hallType}" style="border: none; width: 300px;" readonly> </td>
			    	</tr>
			    	
			    	<tr>
			    		<th>연면적</th>
			    		<td><input class="editel form-control" name="totalArea" value="\${result.totalArea}" style="border: none; width: 300px;" readonly></td>
			    		<th>주거전용면적</th>
			    		<td><input class="editel form-control" name="residentialArea" value="\${result.residentialArea}" style="border: none; width: 300px;" readonly></td>
			    	</tr>
			    	
			    	<tr>
			    		<th>사용승인일(준공일)</th>
			    		<td><input class="editel form-control" name="approvalDt" value="\${result.approvalDt}" style="border: none; width: 300px;" readonly></td>
			    		<th>동수</th>
			    		<td><input class="editel form-control" name="cntDong" value="\${result.cntDong}" style="border: none; width: 300px;" readonly></td>
			    		<td>개동 </td>
			    	</tr>
			    	
			    	<tr>
			    		<th>세대수</th>
			    		<td><input class="editel form-control" name="cntTotalRoom" value="\${result.cntTotalRoom}" style="border: none; width: 300px;" readonly></td>
			    		<th>시공사</th>
			    		<td><input class="editel form-control" name="constructor" value="\${result.constructor}" style="border: none; width: 300px;" readonly></td>
			    	</tr>
			    	
			    	<tr>
			    		<th>시행사</th>
			    		<td><input class="editel form-control" name="developer" value="\${result.developer}" style="border: none; width: 300px;" readonly></td>
			    		<th>69미만</th>
			    		<td><input class="editel form-control" name="underType69" value="\${result.underType69}" style="border: none; width: 300px;" readonly></td>
			    	</tr>
			    		
			    	<tr>	
			    		<th>69타입</th>
			    		<td><input class="editel form-control" name="type69" value="\${result.type69}" style="border: none; width: 300px;" readonly></td>
			    		<th>74타입</th>
			    		<td><input class="editel form-control" name="type74" value="\${result.type74}" style="border: none; width: 300px;" readonly></td>
			    	</tr>
			    	
			    	<tr>	
			    		<th>84타입</th>
			    		<td><input class="editel form-control" name="type84" value="\${result.type84}" style="border: none; width: 300px;" readonly></td>
			    		<th>84초과</th>
			    		<td><input class="editel form-control" name="moreType84" value="\${result.moreType84}" style="border: none; width: 300px;" readonly></td>
			    	</tr>
			        `
			        
			        let row1 = "";
			        row1 += `
			        	<input type="file" id="danjiLayout" name="danjiLayoutFile">
						<img name="danjiPicture" style="width: 700px; height: 500px; margin-top: 20px" alt="단지사진"
							src="/upload\${result.danjiLayout}">			        
			        `;
			        
			        let row2 = "";
			        row2 += `
			        	<input type="file" id="danjiPicture" name="danjiPictureFile">
						<img name="danjiPicture" style="width: 700px; height: 500px; margin-top: 20px" alt="단지사진"
							src="/upload\${result.danjiPicture}">    
			        `;
			        
					$("#tbody").html(str);
					$("#div1").html(row1);
					$("#div2").html(row2);
					
				}
			});
		}
	});
	
	
	$(document).on("click","#delete", function(){
		if(confirm("삭제하시겠습니까?")){
			let danjiCode = $("input[name='danjiCode']").val();
	
			let data = {
				"danjiCode" : danjiCode
			};
			console.log("data : " + data);
	
			$.ajax({
				url:"/site/danji/deleteAjax",
				contentType:"application/json;charset=utf-8",
				data:JSON.stringify(data),
				type:"post",
				dataType:"text",
				beforeSend:function(xhr){
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					console.log("result : ", result);
	
					if(result != null){
						alert("삭제가 완료되었습니다.");
						location.href="/site/danji";
					}
				}
			});
		}
	});
	
	$(document).ready(function(){
		
		
	    if('<%= memAuth%>' == 'ROLE_MASTER'){
	        let htmlStr = '';
	        htmlStr += '<input type="button" class="btn btn-info" id="edit" value="수정" />';
	        htmlStr += '<input type="button" style="margin-left:3px" class="btn btn-danger" id="delete" value="삭제" />';
	        htmlStr += '<input type="button" style="margin-left:3px" class="btn btn-primary" id="btnList" value="목록" />';
	        $('#p1').html(htmlStr);
		}

	});
	
});
	
</script>
<div class="subTop" style="margin-left: -100px;">
	<div class="aptInfo">
		<div class="wp1400">
			 	<strong id="pp1" class="card-title aptInfo_Tle" style="font-size: 25px;">단지소개 상세페이지</strong>
				<strong id="pp2" class="card-title aptInfo_Tle" style="font-size: 25px; display: none;">단지소개 수정페이지</strong>
		</div>
	</div>
</div>




<div class="col-12" style="margin-top: 20px">
	<div class="card">
		<div class="card-body table-responsive p-10">
			<h4 style="font-weight: 900;" class="mb-sm-0">${danjiVO.danjiName}</h4>
			<form id="frm" name="frm" action="/site/danji/updateAjax?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
				<input type="hidden" class="editel form-control" name="danjiCode" value="${danjiVO.danjiCode}" style="border: none; width: 300px;" readonly> 
			<table class="contTbl txtC" style="text-align: center; margin-top: 20px">
			  <colgroup>
			       <col class="wp15">
			       <col class="wp30">
			       <col class="wp15">
			       <col class="wp30">
			  </colgroup>
			  <tbody>
			  <tr>
			      <th scope="col"><strong>명칭(단지명)</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="danjiName" value="${danjiVO.danjiName}"  readonly>
			      </td>
			      <th scope="col"><strong>단지분류</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="danjiCat" value="${danjiVO.danjiCat}" readonly>
			      </td>
			  </tr>
			  <tr>
			      <th scope="col"><strong>법정 동주소</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="addr" value="${danjiVO.addr}" readonly>
			      </td>
			      <th scope="col"><strong>도로명 주소</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="addrDetail" value="${danjiVO.addrDetail}" readonly>
			      </td>
			  </tr>
			  <tr>
			      <th scope="col"><strong>우편번호</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="post" value="${danjiVO.post}" readonly>
			      </td>
			      <th scope="col"><strong>분양형태</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="saleType" value="${danjiVO.saleType}" readonly>
			      </td>
			  </tr>
			  <tr>
			      <th scope="col"><strong>난방방식</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="heatingType" value="${danjiVO.heatingType}" readonly>
			      </td>
			      <th scope="col"><strong>복도유형</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="hallType" value="${danjiVO.hallType}" readonly>
			      </td>
			  </tr>
			  <tr>
			      <th scope="col"><strong>연면적</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="totalArea" value="${danjiVO.totalArea} m&sup2;" readonly>
			      </td>
			      <th scope="col"><strong>주거전용면적</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="residentialArea" value="${danjiVO.residentialArea} m&sup2;" readonly>
			      </td>
			  </tr>
			  <tr>
			      <th scope="col"><strong>사용승인일(준공일)</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="approvalDt" value="${danjiVO.approvalDt}" readonly>
			      </td>
			      <th scope="col"><strong>동수</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="cntDong" value="${danjiVO.cntDong}개동" readonly>
			      </td>
			  </tr>
			  <tr>
			      <th scope="col"><strong>세대수</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="cntTotalRoom" value="${danjiVO.cntTotalRoom}세대" readonly>
			      </td>
			      <th scope="col"><strong>시공사</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="constructor" value="${danjiVO.constructor}" readonly>
			      </td>
			  </tr>
			  <tr>
			      <th scope="col"><strong>시행사</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="developer" value="${danjiVO.developer}" readonly>
			      </td>
			      <th scope="col"><strong>69미만</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="underType69" value="${danjiVO.underType69}" readonly>
			      </td>
			  </tr>
			  <tr>
			      <th scope="col"><strong>69타입</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="type69" value="${danjiVO.type69}" readonly>
			      </td>
			      <th scope="col"><strong>74타입</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="type74" value="${danjiVO.type74}" readonly>
			      </td>
			  </tr>
			  <tr>
			      <th scope="col"><strong>84타입</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="type84" value="${danjiVO.type84}" readonly>
			      </td>
			      <th scope="col"><strong>84초과</strong></th>
			      <td>
			        <input type="text" class="editel form-control" name="moreType84" value="${danjiVO.moreType84}" readonly>
			      </td>
			  </tr>
			  </tbody>
			</table>
			
			<div class="row">
				<div style="margin-top: 50px" class="col-6">
					<div>
						<div
							class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
							<h4 style="font-weight: 600;" class="mb-sm-0">단지 배치도</h4>
						</div>
						<div id = "div1">
							<input type="file" id="danjiLayout" name="danjiLayoutFile">
							<img name="danjiLayout" style="width: 700px; height: 500px; margin-top: 20px;" alt="단지배치도"
								src="/upload${danjiVO.danjiLayout}">
						</div>
					</div>
				</div>
			
				<div style="margin-top: 50px" class="col-6">
					<div>
							<div
								class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
								<h4 style="font-weight: 600;" class="mb-sm-0">단지 사진</h4>
							</div>
							<div id="div2">
				<!-- 				<input type="file"/> -->
								<input type="file" id="danjiPicture" name="danjiPictureFile">
								
								<img name="danjiPicture" style="width: 700px; height: 500px; margin-top: 20px" alt="단지사진"
									src="/upload${danjiVO.danjiPicture}">
							</div>
						
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>
</div>
						<div class="row" style=" margin: 3px; text-align: right;" >
							<!-- ///// 일반모드 시작 ///// -->
							<p id="p1" style="margin-top:5px;">
								<input type="button" class="btn btn-primary" id="btnList" value="목록" />
							</p>
							<!-- ///// 일반모드 끝  ///// -->
							<!-- ///// 수정모드 시작 ///// -->
							<p id="p2" style="display:none; margin-top:5px;">
							
								<input type="button" class="btn btn-warning" id="cancel" value="취소" />
								<input type="submit" class="btn btn-primary" id="confirmAsync" value="확인" />
								
							
							</p>
							<!-- ///// 수정모드 끝  ///// -->
						</div>

<div class="toast-container" style="position: absolute; top: 0; right: 0;">
   <div class="toast" role="alert" aria-live="assertive" aria-atomic="true" >
    <div class="toast-header bg-success text-white">
        <i data-feather="alert-circle"></i>
        <strong class="mr-auto">삭제 성공!</strong>
        <small class="text-white-50 ml-2">just now</small>
        <button class="ml-2 mb-1 btn-close btn-close-white" type="button" data-bs-dismiss="toast" aria-label="Close"></button>
    </div>
    <div class="toast-body">수정완료</div>
   </div>
</div>
