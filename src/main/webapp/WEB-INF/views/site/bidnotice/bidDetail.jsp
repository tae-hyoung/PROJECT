<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%
	MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
	String memAuth = member != null ? member.getMemAuth() : null;
%>
<style>
        .card-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .card-title {
            font-size: 1.5rem;
            font-weight: bold;
        }

        input[readonly], select[disabled] {
            background-color: #f8f9fa;
        }


        label {
            font-weight: bold;
        }
	
        
        
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
.subT_Bg .subT_Bg4:after{content: '';width: 24px;height: 31px;background: url(../img/common/sTbgBpin.png) no-repeat center;display: block;position: absolute;top: -10px;left:19px;animation: subT_Bg 0.4s both 3s, subT_pin 1s cubic-bezier(0.65, 0.05, 0.36, 1) infinite 3.5s}
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




</style>
	<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
	<script type="text/javascript">
	$(function() {
		// 관리자 권한 확인 후 버튼 생성
		if('<%= memAuth%>' == 'ROLE_MASTER'){
			let htmlStr = '';
			htmlStr += '<input type="button" class="btn btn-info" id="edit" value="수정" />';
			htmlStr += '<input type="button" class="btn btn-danger" id="delete" value="삭제" />';
			htmlStr += '<input type="button" class="btn btn-primary" id="list" value="목록" />';
			$('#p1').html(htmlStr);
		}
				 
		// 기본 데이터 변수 설정
		var bidContent = $("input[name='bidContent']").val();
		var bidTitle = $("input[name='bidTitle']").val();
		var bidExplan = $("input[name='bidExplan']").val();
		var bidExplanDt = $("input[name='bidExplanDt']").val();
		var bidLocation = $("input[name='bidLocation']").val();
		var bidEmergency = $("input[name='bidEmergency']").val();
		var bidDeposit = $("input[name='bidDeposit']").val();
		var bidCirSub = $("input[name='bidCirSub']").val();
		var bidCpcSub = $("input[name='bidCpcSub']").val();
		
		var bidStatus = $("select[name='bidStatus']").val();
		var bidCompany = $("input[name='bidCompany']").val();
		var bidCrn = $("input[name='bidCrn']").val();
		var bidCeo = $("input[name='bidCeo']").val();
		var bidCnum = $("input[name='bidCnum']").val();
		var bidBidDt = $("input[name='bidBidDt']").val();
		var bidBidDeposit = $("input[name='bidBidDeposit']").val();

		$("#list").on("click", function() {
			location.href = "/site/bidList";
		});

		// 수정 확인 버튼 클릭 시
		$("#confirm").on("click", function(){
			let dataArray = $("#frm").serializeArray();
			let data = {};
			dataArray.map(function(row,idx){
				data[row.name] = row.value;
			});

			swal.fire({
				title: '수정하시겠습니까?',
				icon: 'warning',
				showCancelButton: true,
				confirmButtonText: '수정',
				cancelButtonText: '취소'
			}).then((result) => {
				if (result.isConfirmed) {
					$.ajax({
						url:"/site/updateAjax",
						contentType:"application/json;charset=utf-8",
						data:JSON.stringify(data),
						type:"post",
						dataType:"json",
						beforeSend:function(xhr){
							xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
						},
						success:function(result){
							if(result!=null){
								swal.fire({
									title: '수정이 완료되었습니다.',
									icon: 'success',
									confirmButtonText: '확인'
								}).then(() => {
									location.href = "/site/bidDetail?bidSeq=" + result.bidSeq;
								});
							}

							$("#p1").css("display","block");
							$("#p2").css("display","none");
							$(".formdata").attr("readonly", true);
						}
					});
				}
			});
		});
		
		// 삭제 버튼 클릭 시
		$("#delete").on("click", function(){
			swal.fire({
				title: '삭제하시겠습니까?',
				icon: 'warning',
				showCancelButton: true,
				confirmButtonText: '삭제',
				cancelButtonText: '취소'
			}).then((result) => {
				if (result.isConfirmed) {
					let bidSeq = $("input[name='bidSeq']").val();
					let data = { "bidSeq" : bidSeq };

					$.ajax({
						url:"/site/deleteAjax",
						contentType:"application/json;charset=utf-8",
						data:JSON.stringify(data),
						type:"post",
						dataType:"text",
						beforeSend:function(xhr){
							xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
						},
						success:function(result){
							if(result != null){
								swal.fire({
									title: '삭제가 완료되었습니다.',
									icon: 'success',
									confirmButtonText: '확인'
								}).then(() => {
									location.href="/site/bidList";
								});
							}
						}
					});
				}
			});
		});
			
			
			
			

			//일반모드와 수정모드를 toggle
				$("#edit").on("click",function(){

					$("#p1").css("display","none");
					$("#p2").css("display","block");
					$("#pp1").css("display","none");
					$("#pp2").css("display","block");
					$("#auto").css("display","block");
					
					//수정가능 항목 리드온니 제거
					$("input[name='bidTitle'], input[name='bidContent']").removeAttr("readonly");
					$("input[name='bidExplan'], input[name='bidExplanDt'], input[name='bidLocation']").removeAttr("readonly");
					$("input[name='bidEmergency'], input[name='bidDeposit']").removeAttr("readonly");					
					$("input[name='bidCirSub'], input[name='bidCpcSub']").removeAttr("readonly");
					$("select[name='bidStatus']").removeAttr("disabled");
					$("select[name='bidExplanYn']").removeAttr("disabled");
					$("select[name='bidDocYn']").removeAttr("disabled");
					$(".nice-select").removeClass("disabled");
					$("input[name='bidCompany'], input[name='bidCrn'], input[name='bidCeo'], input[name='bidCnum']").removeAttr("readonly");
					$("select[name='bidExplanYn'], select[name='bidDocYn']").removeAttr("readonly");
					$("input[name='bidBidDt'], input[name='bidBidDeposit']").removeAttr("readonly");
					
					
					
					//수정불가 항목 백그라운드 및 디스에이블 처리
					$("input[name='bidStartDt']").css("background-color","lightgray");
					$("input[name='danjiName']").css("background-color","lightgray");
					$("input[name='addr']").css("background-color","lightgray");
					$("input[name='bidNum']").css("background-color","lightgray");
					$("input[name='bidFax']").css("background-color","lightgray");
					$("input[name='cntDong']").css("background-color","lightgray");
					$("input[name='cntTotalRoom']").css("background-color","lightgray");
					$("input[name='bidSeq']").css("background-color","lightgray");
					$("input[name='bidHow']").css("background-color","lightgray");
					$("input[name='bidType']").css("background-color","lightgray");
					$("input[name='bidSuccessHow']").css("background-color","lightgray");
					$("input[name='bidDocDt']").css("background-color","lightgray");
					$("input[name='bidOutDt']").css("background-color","lightgray");
					

					//action속성의 값이 /lprod/ubdatePost
					$("#frm").attr("action","/bidnotice/updatePost")
				});

			//취소 버튼 클릭
					$("#cancel").on("click", function() {
						$("#p1").css("display", "block");
						$("#p2").css("display", "none");
						$("#pp1").css("display","block");
						$("#pp2").css("display","none");
						
						//입력란 초기화
						$("input[name='bidTitle']").val(bidTitle);
						$("input[name='bidContent']").val(bidContent);
						$("input[name='bidExplan']").val(bidExplan);
						$("input[name='bidExplanDt']").val(bidExplanDt);
						$("input[name='bidLocation']").val(bidLocation);
						$("input[name='bidCirSub']").val(bidCirSub);
						$("input[name='bidCpcSub']").val(bidCpcSub);
						$("input[name='bidEmergency']").val(bidEmergency);
						$("input[name='bidDeposit']").val(bidDeposit);

						$("input[name='bidCompany']").val(bidCompany);
						$("input[name='bidCrn']").val(bidCrn);
						$("input[name='bidCeo']").val(bidCeo);
						$("input[name='bidCnum']").val(bidCnum);
						$("input[name='bidBidDt']").val(bidBidDt);
						$("input[name='bidBidDeposit']").val(bidBidDeposit);

						//백그라운드 초기화
						$("input[name='bidStartDt']").css("background-color","white");
						$("input[name='danjiName']").css("background-color","white");
						$("input[name='addr']").css("background-color","white");
						$("input[name='bidNum']").css("background-color","white");
						$("input[name='bidFax']").css("background-color","white");
						$("input[name='cntDong']").css("background-color","white");
						$("input[name='cntTotalRoom']").css("background-color","white");
						$("input[name='bidSeq']").css("background-color","white");
						$("input[name='bidHow']").css("background-color","white");
						$("input[name='bidType']").css("background-color","white");
						$("input[name='bidSuccessHow']").css("background-color","white");
						$("input[name='bidDocDt']").css("background-color","white");
						$("input[name='bidOutDt']").css("background-color","white");
						
						//리드온니 다시 추가
						$("input[name='bidTitle']").attr("readonly", true);
						$("input[name='bidContent']").attr("readonly", true);
						$("input[name='bidExplan']").attr("readonly", true);
						$("input[name='bidExplanDt']").attr("readonly", true);
						$("input[name='bidLocation']").attr("readonly", true);
						$("input[name='bidCirSub']").attr("readonly", true);
						$("input[name='bidCpcSub']").attr("readonly", true);
						$("input[name='bidEmergency']").attr("readonly", true);
						$("input[name='bidDeposit']").attr("readonly", true);

						
					});
		});

	</script>
<div class="subTop" style="margin-left: -100px;">
	<div class="aptInfo">
		<div class="wp1400">
			 	<strong id="pp1" class="card-title aptInfo_Tle" style="font-size: 25px;">전자입찰 공고문</strong>
				<strong id="pp2" class="card-title aptInfo_Tle" style="font-size: 25px; display: none;">입찰공고 수정</strong>
		</div>
	</div>
</div>



<div class="col-12" style="margin-top: 20px">
		<div class="card">
<!-- ///////////////////////////////////////form /////////////////////////////////////////////////////////////////////// -->
			<div class="card-body table-responsive p-10">
			<button style="display: none;" class="btn btn-primary col-sm-1 auto" id="auto">자동입력</button>
				<form id="frm" name="frm" action="/bidnotice/updatePost" method="post">
					<!-- 폼데이터 -->
					<div style="margin-top: 20px;" class="row">
						<div style="float: right;" class="col-sm-8"></div>
						<div style="float: right; text-align: center;" class="col-sm-2">
							<label for="bidStatus">상태</label>
								<br>
								<select name="bidStatus" disabled>
									<c:choose>
										<c:when test="${bidnoticeVO.bidStatus == '입찰'}">
											<option style="background-color:white;" value="입찰" selected>입찰</option>
											<option style="background-color:white;" value="유찰">유찰</option>
											<option style="background-color:white;" value="낙찰">낙찰</option>
											<option style="background-color:white;" value="취소">취소</option>
											<option style="background-color:white;" value="마감">마감</option>
										</c:when>
										<c:when test="${bidnoticeVO.bidStatus == '유찰'}">
											<option style="background-color:white;" value="입찰" >입찰</option>
											<option style="background-color:white;" value="유찰" selected>유찰</option>
											<option style="background-color:white;" value="낙찰">낙찰</option>
											<option style="background-color:white;" value="취소">취소</option>
											<option style="background-color:white;" value="마감">마감</option>
										</c:when>
										<c:when test="${bidnoticeVO.bidStatus == '낙찰'}">
											<option style="background-color:white;" value="입찰" >입찰</option>
											<option style="background-color:white;" value="유찰">유찰</option>
											<option style="background-color:white;" value="낙찰" selected>낙찰</option>
											<option style="background-color:white;" value="취소">취소</option>
											<option style="background-color:white;" value="마감">마감</option>
										</c:when>
										<c:when test="${bidnoticeVO.bidStatus == '취소'}">
											<option style="background-color:white;" value="입찰" >입찰</option>
											<option style="background-color:white;" value="유찰">유찰</option>
											<option style="background-color:white;" value="낙찰">낙찰</option>
											<option style="background-color:white;" value="취소" selected>취소</option>
											<option style="background-color:white;" value="마감">마감</option>
										</c:when>
										<c:when test="${bidnoticeVO.bidStatus == '마감'}">
											<option style="background-color:white;" value="입찰" >입찰</option>
											<option style="background-color:white;" value="유찰">유찰</option>
											<option style="background-color:white;" value="낙찰">낙찰</option>
											<option style="background-color:white;" value="취소">취소</option>
											<option style="background-color:white;" value="마감" selected>마감</option>
										</c:when>
									</c:choose>
								</select>
						</div>
						<div style="float: right; text-align: center;" class="col-sm-2">
							<label for="bidStartDt">공고일</label>
							<input style="background-color:white; text-align: center;" type="text" class="form-control" name="bidStartDt" value="${bidnoticeVO.bidStartDt}" readonly />
						</div>
					</div>

					<div class="row col-sm-12 justify-content-center"
						style="margin-top: 20px; text-align: center; padding: 20px">
						<input style="background-color:white; text-align: center; font-size: 2rem;" type="text"
							class="form-control" name="bidTitle" value="${bidnoticeVO.bidTitle}" readonly />
					</div>

<!-- ////////////////////////////////////////////////낙찰 업체 시작 ////////////////////////////////////////////////////////////////// -->
					<div class="row" style="margin-top: 20px; text-align: center; ">
					    <table class="contTbl txtC">
					        <colgroup>
					            <col>
					            <col class="wp10">
					            <col class="wp10">
					            <col class="wp10">
					            <col class="wp10">
					            <col class="wp10">
					            <col class="wp10">
					            <col class="wp10">
					        </colgroup>
					        <thead>
					            <tr>
					                <th scope="colgroup" colspan="8">낙찰업체 정보</th>
					            </tr>
					            <tr>
					                <th scope="col">낙찰회사</th>
					                <th scope="col">사업자등록번호</th>
					                <th scope="col">대표자</th>
					                <th scope="col">전화번호</th>
					                <th scope="col">응찰일시</th>
					                <th scope="col">현장설명<br>참석여부</th>
					                <th scope="col">입찰구비서류<br>적정여부</th>
					                <th scope="col">입찰금액</th>
					            </tr>
					        </thead>
					        <tbody>
					            <tr class="">
					                <td>
					                    <input style="background-color:white;" type="text" class="form-control" id="bidCompany" name="bidCompany" value="${bidnoticeVO.bidCompany}" readonly/>
					                </td>
					                <td>
					                    <input style="background-color:white;" type="text" class="form-control" id="bidCrn" name="bidCrn" value="${bidnoticeVO.bidCrn}" readonly/>
					                </td>
					                <td>
					                    <input style="background-color:white;" type="text" class="form-control" id="bidCeo" name="bidCeo" value="${bidnoticeVO.bidCeo}" readonly/>
					                </td>
					                <td>
					                    <input style="background-color:white;" type="text" class="form-control" id="bidCnum" name="bidCnum" value="${bidnoticeVO.bidCnum}" readonly/>
					                </td>
					                <td>
					                    <input style="background-color:white;" type="date" class="form-control" id="bidBidDt" name="bidBidDt" value="${bidnoticeVO.bidBidDt}" readonly/>
					                </td>
					                <td>
					                    <select id="bidExplanYn" name="bidExplanYn" disabled>
					                        <c:choose>
					                            <c:when test="${bidnoticeVO.bidExplanYn == 'Y'}">
					                                <option  value="Y" selected>Y</option>
					                                <option  value="N">N</option>
					                            </c:when>
					                            <c:when test="${bidnoticeVO.bidExplanYn != 'Y'}">
					                                <option  value="Y" >Y</option>
					                                <option  value="N" selected>N</option>
					                            </c:when>
					                        </c:choose>
					                    </select>
					                </td>
					                <td>
					                    <select id="bidDocYn" name="bidDocYn" disabled>
					                        <c:choose>
					                            <c:when test="${bidnoticeVO.bidDocYn == 'Y'}">
					                                <option style="background-color:white;" value="Y" selected>Y</option>
					                                <option style="background-color:white;" value="N">N</option>
					                            </c:when>
					                            <c:when test="${bidnoticeVO.bidDocYn != 'Y'}">
					                                <option style="background-color:white;" value="Y" >Y</option>
					                                <option style="background-color:white;" value="N" selected>N</option>
					                            </c:when>
					                        </c:choose>
					                    </select>
					                </td>
					                <td>
					                    <input style="background-color:white;" type="text" class="form-control" id="bidBidDeposit" name="bidBidDeposit" value="${bidnoticeVO.bidBidDeposit}" readonly/>
					                </td>
					            </tr>
					        </tbody>
					    </table>
					</div>
<!-- ////////////////////////////////////////////////낙찰 업체 종료 ////////////////////////////////////////////////////////////////// -->					
					
<!-- /////////////////////////////////////////////////단지 시작///////////////////////////////////////////////////////// -->
					<div class="row"
						style=" margin-top: 20px; text-align: center; ">
						    <table class="contTbl txtC">
						        <colgroup>
						            <col class="wp20">
						            <col class="">
						            <col class="wp10">
						            <col class="wp10">
						            <col class="wp5">
						            <col class="wp5">
						        </colgroup>
						        <tbody>
						            <tr>
						                <th scope="col">단지명</th>
						                <th scope="col">관리사무소 주소</th>
						                <th scope="col">전화번호</th>
						                <th scope="col">팩스번호</th>
						                <th scope="col">동수</th>
						                <th scope="col">세대수</th>
						            </tr>
						            <tr>
						                <td>
						                    <input style="background-color:white;" type="text" class="form-control" name="danjiName" value="${bidnoticeVO.danjiName}" readonly />
						                </td>
						                <td>
						                    <input style="background-color:white;" type="text" class="form-control" name="addr" value="${bidnoticeVO.addr}" readonly />
						                </td>
						                <td>
						                    <input style="background-color:white;" type="text" class="form-control" name="bidNum" value="${bidnoticeVO.bidNum}" readonly />
						                </td>
						                <td>
						                    <input style="background-color:white;" type="text" class="form-control" name="bidFax" value="${bidnoticeVO.bidFax}"	readonly />
						                </td>
						                <td>
						                    <input style="background-color:white;" type="text" class="form-control" name="cntDong" value="${bidnoticeVO.cntDong}" readonly />
						                </td>
						                <td>
						                    <input style="background-color:white;" type="text" class="form-control" name="cntTotalRoom"	value="${bidnoticeVO.cntTotalRoom}" readonly />
						                </td>
						            </tr>
						        </tbody>
						    </table>
					</div>
<!-- /////////////////////////////////////////////////단지 종료///////////////////////////////////////////////////////// -->


<!-- ///////////////////////////////////////////////공고 내용 시작//////////////////////////////////////////////////////// -->

					<table class="contTbl" style="text-align: center;">
					    <colgroup>
					        <col class="wp15">
					        <col>
					        <col class="wp15">
					        <col class="wp30">
					    </colgroup>
					    <tbody>
					    <tr>
					        <th scope="col">입찰번호</th>
					        <td colspan="3">
					            <input style="background-color:white;" type="text" class="form-control" name="bidSeq" value="${bidnoticeVO.bidSeq}" readonly />
					        </td>
					    </tr>
					    <tr>
					        <th scope="col">입찰방법</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidHow" value="${bidnoticeVO.bidHow}" readonly />
					        </td>
					        <th scope="col">
					                입찰 마감일
					        </th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidOutDt" value="${bidnoticeVO.bidOutDt}" readonly />
					        </td>
					    </tr>
					    <tr>
					        <th scope="col">입찰제목</th>
					        <td>
					            <input style="background-color:white;" type="text"	class="form-control" name="bidTitle" value="${bidnoticeVO.bidTitle}" readonly />
					        </td>
					        <th scope="col">긴급입찰여부</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidEmergency"	value="${bidnoticeVO.bidEmergency}" readonly />
					        </td>
					    </tr>
					    <tr>
					        <th scope="col">입찰종류</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidType" value="${bidnoticeVO.bidType}" readonly />
					        </td>
					        <th scope="col">낙찰방법</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidSuccessHow" value="${bidnoticeVO.bidSuccessHow}" readonly />
					        </td>
					    </tr>
					    <tr>
					        <th scope="col">입찰분류</th>
					        <td>
					            	사업자 - 용역 - 기타 용역
					        </td>
					        <th scope="col">신용평가등급확인서<br>제출여부</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidCirSub" value="${bidnoticeVO.bidCirSub}" readonly />
					        </td>
					    </tr>
					    <tr>
					        <th scope="col">현장설명</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidExplan" value="${bidnoticeVO.bidExplan}" readonly />
					            <p style="text-align: left; color: red;" class="font_red">*현장설명이 있을 시, 불참업체는  낙찰 선정에 불이익을 받으실 수 있습니다.</p>
					        </td>
					        <th scope="col">관리(공사용역)<br>실적증명서 제출여부</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidCpcSub" value="${bidnoticeVO.bidCpcSub}" readonly />
					        </td>
					    </tr>
					    <tr>
					        <th scope="col">현장설명일시</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidExplanDt" value="${bidnoticeVO.bidExplanDt}" readonly />
					        </td>
					        <th scope="col">현장설명장소</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidLocation" value="${bidnoticeVO.bidLocation}" readonly />
					        </td>
					    </tr>
					    <tr>
					        <th scope="col">서류제출마감일</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidDocDt"	value="${bidnoticeVO.bidDocDt}" readonly />
					        </td>
					        <th scope="col">입찰보증금</th>
					        <td>
					            <input style="background-color:white;" type="text" class="form-control" name="bidDeposit" value="${bidnoticeVO.bidDeposit}" readonly />
					        </td>
					    </tr>
					    <tr>
					        <th scope="col">내용</th>
					        <td colspan="3">
					                <div style="max-height:200px; overflow:auto;">
					                    <input style="background-color:white;" type="text" class="form-control" name="bidContent" value="${bidnoticeVO.bidContent}" readonly />
					                </div>
					        </td>
					    </tr>
					    <tr>
					        <th scope="col">파일첨부</th>
					        <td colspan="3">
					        	<div class="form-control" id="fileContainer" style="width: 100%; height: 100px; text-align: left; font-size: 1.5em;">
					        		<img alt="" src="/resources/images/download.png"> <a href="/upload${bidnoticeVO.bidAttach}" download="${fn:split(bidnoticeVO.bidAttach, '_')[1]}"> ${fn:split(bidnoticeVO.bidAttach, '_')[1]}</a>
					        	</div>
					        </td>
					    </tr>
					    </tbody>
					</table>
<!-- ///////////////////////////////////////////////공고 내용 종료//////////////////////////////////////////////////////// -->

					<!-- ///// 일반모드 시작 ///// -->
					<p id="p1" style="margin-top: 10px; text-align: end;">

						<input type="button" class="btn btn-primary " id="list" value="목록" />
					</p>
					<!-- ///// 일반모드 끝  ///// -->
					<!-- ///// 수정모드 시작 ///// -->
					<p id="p2" style="display: none; margin-top: 10px; text-align: end;">
						<input type="button" class="btn btn-warning" id="cancel" value="취소" />
						<input type="button" class="btn btn-primary" id="confirm" value="확인" />
					</p>
					<!-- ///// 수정모드 끝  ///// -->
					
				</form>
			</div>
		</div>
	</div>
<script>
$('#auto').on('click', function(){
   $('#bidCompany').val('(주)태형엘리베이터');
   $('#bidCrn').val('306-82-05291');
   $('#bidCeo').val('김태형');
   $('#bidCnum').val('042-485-1388');
   $('#bidBidDt').val('2024-07-16');
   $('#bidBidDeposit').val('100,000,000원');
   
//    $('input[name="surveyDetails[0].svdItem"]').val('1112312');
//    $('input[name="surveyDetails[1].svdItem"]').val('1112312');
//    $('input[name="surveyDetails[2].svdItem"]').val('1112312');
})

if ($('select[name="bidStatus"]').val() === '낙찰') {
    $('#bidCompany, #bidCrn, #bidCeo, #bidCnum, #bidBidDt, #bidExplanYn, #bidDocYn, #bidBidDeposit').css('background-color', 'pink');
    
}

</script>