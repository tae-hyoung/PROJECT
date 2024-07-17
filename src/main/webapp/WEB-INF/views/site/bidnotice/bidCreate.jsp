<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<title>입찰공고 등록페이지</title>
<style>
    #wrapper2 {
        width: 300px;
    }

    #preview2 {
        width: 396%;
        height: 300px;
        border: 2px solid lightgray;
        background-image:url("/resources/images/dreganddrop.jpg");
        background-size: 113% 68%;
        background-position: -66px 62px;
        background-repeat: no-repeat;
        overflow: auto;
    }

    #list2 {
        width: 100%;
/*         border: 2px solid lightgray; */
        height: 200px;
        overflow: auto;
    }

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
            background-color: #ffffff;
            width: 287px;
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
    
    
</style>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
</head>
<body>
	<script type="text/javascript" src="/resources/js/jquery.min.js"></script>
	<script type="text/javascript">
$(function() {
		
		$("#cancel").on("click", function() {
			location.href = "/site/bidList";
		});
		
		$("#apply").on("click",function() {
			
			//AJAX로 파일전송하기 위해 FormData생성
	        let formData = new FormData();

	        //선택된 파일만 가져오깅
	        let selFiles = f_ckFileList();
	        
	        selFiles.forEach(selFile => {
	          formData.append("myFiles", selFile);
	        });
			
	        
			let bidTitle = $("input[name='bidTitle']").val();
			let danjiCode = $("select[name='danjiName']").val();
			let addr = $("input[name='addr']").val();
			let bidNum = $("input[name='bidNum']").val();
			let bidFax = $("input[name='bidFax']").val();
			let bidSeq = $("input[name='bidSeq']").val();
			let bidHow = $("select[name='bidHow']").val();
			let bidType = $("select[name='bidType']").val();
			let bidSuccessHow = $("select[name='bidSuccessHow']").val();
			let bidExplan = $("select[name='bidExplan']").val();
			let bidExplanDt = $("input[name='bidExplanDt']").val();			
			let bidLocation = $("input[name='bidLocation']").val();			
			let bidContent = $("input[name='bidContent']").val();			
			let bidDocDt = $("input[name='bidDocDt']").val();			
			let bidOutDt = $("input[name='bidOutDt']").val();			
			let bidEmergency = $("select[name='bidEmergency']").val();			
			let bidDeposit = $("input[name='bidDeposit']").val();
			let bidCirSub = $("select[name='bidCirSub']").val();	
			let bidCpcSub = $("select[name='bidCpcSub']").val();
			let bidStatus = $("select[name='bidStatus']").val();
			let bidCompany = $("input[name='bidCompany']").val();
			let bidCrn = $("input[name='bidCrn']").val();
			let bidCeo = $("input[name='bidCeo']").val();
			let bidCnum = $("input[name='bidCnum']").val();
			let bidBidDt = $("input[name='bidBidDt']").val();
			let bidExplanYn = $("select[name='bidExplanYn']").val();
			let bidDocYn = $("select[name='bidDocYn']").val();
			let bidBidDeposit = $("input[name='bidBidDeposit']").val();
			
			
			
	        // Convert datetime-local to desired format YYYY-MM-DD HH24:MI:SS
	        function formatDateTime(datetime) {
	            if (!datetime) return "";
	            var dt = new Date(datetime);
	            var year = dt.getFullYear();
	            var month = ("0" + (dt.getMonth() + 1)).slice(-2);
	            var day = ("0" + dt.getDate()).slice(-2);
	            var hours = ("0" + dt.getHours()).slice(-2);
	            var minutes = ("0" + dt.getMinutes()).slice(-2);
	            var seconds = "00"; 
	            return `\${year}-\${month}-\${day} \${hours}:\${minutes}:\${seconds}`;
	        }

	        var formattedbidExplanDt = formatDateTime(bidExplanDt);
	        var formattedbidDocDt = formatDateTime(bidDocDt);
	        var formattedbidOutDt = formatDateTime(bidOutDt);
			
			
// 			let data = {
// 					"bidTitle": bidTitle,
// 					"danjiCode": danjiCode,
// 					"addr": addr,
// 					"bidNum": bidNum,
// 					"bidFax": bidFax,
// 					"bidSeq": bidSeq,
// 					"bidHow": bidHow,
// 					"bidType": bidType,
// 					"bidSuccessHow": bidSuccessHow,
// 					"bidExplan": bidExplan,
// 					"bidExplanDt": formattedbidExplanDt,
// 					"bidLocation": bidLocation,
// 					"bidContent": bidContent,
// 					"bidDocDt": formattedbidDocDt,
// 					"bidOutDt": formattedbidOutDt,
// 					"bidEmergency": bidEmergency,
// 					"bidDeposit": bidDeposit,
// 					"bidCirSub": bidCirSub,
// 					"bidCpcSub": bidCpcSub,
					
// 					"bidStatus": bidStatus,
// 					"bidCompany": bidCompany,
// 					"bidCrn": bidCrn,
// 					"bidCeo": bidCeo,
// 					"bidCnum": bidCnum,
// 					"bidBidDt": bidBidDt,
// 					"bidExplanYn": bidExplanYn,
// 					"bidDocYn": bidDocYn,
// 					"bidBidDeposit": bidBidDeposit,
// 					"bidAttach": bidAttach
					
// 			};
// 			console.log("data : ", data);
			
			formData.append("bidTitle",bidTitle);
			formData.append("danjiCode",danjiCode);
			formData.append("addr",addr);
			formData.append("bidNum",bidNum);
			formData.append("bidFax",bidFax);
			formData.append("bidSeq",bidSeq);
			formData.append("bidHow",bidHow);
			formData.append("bidType",bidType);
			formData.append("bidSuccessHow",bidSuccessHow);
			formData.append("bidExplan",bidExplan);
			formData.append("bidExplanDt",formattedbidExplanDt);
			formData.append("bidLocation",bidLocation);
			formData.append("bidContent",bidContent);
			formData.append("bidDocDt",formattedbidDocDt);
			formData.append("bidOutDt",formattedbidOutDt);
			formData.append("bidEmergency",bidEmergency);
			formData.append("bidDeposit",bidDeposit);
			formData.append("bidCirSub",bidCirSub);
			formData.append("bidCpcSub",bidCpcSub);
			formData.append("bidStatus",bidStatus);
			formData.append("bidCompany",bidCompany);
			formData.append("bidCrn",bidCrn);
			formData.append("bidCeo",bidCeo);
			formData.append("bidCnum",bidCnum);
			formData.append("bidBidDt",bidBidDt);
			formData.append("bidExplanYn",bidExplanYn);
			formData.append("bidDocYn",bidDocYn);
			formData.append("bidBidDeposit",bidBidDeposit);
			
			$.ajax({
				url:"/site/createAjax",
				processData:false,
				contentType:false,
				data:formData,
				type:"post",
				dataType:"text",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success:function(result){
					console.log("result>>>", result);
					location.href = "/site/bidList";
				}
				
			});
		
		});
		
		$('#danjiName').on('change', function(){
			let data = {
				danjiCode: $('#danjiName').val()
			}

			console.log("data: ", data);
			
			$.ajax({
				url : '/site/getDanjiInfo',
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(data),
				type : 'post',
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success : function(result) {
					console.log(result);
					$('input[name="addr"]').val(result.addr);
					$('input[name="cntDong"]').val(result.cntDong);
					$('input[name="cntTotalRoom"]').val(result.cntTotalRoom);
				}
			});
		});
});
	
	</script>
	
	
<div class="subTop" style="margin-left: -45px;">
	<div class="aptInfo">
		<div class="wp1400">
			<strong class="card-title aptInfo_Tle" style="font-size: 25px;">전자입찰 공고문 작성페이지</strong>
		</div>
	</div>
</div>


	<div class="col-12" style="margin-top: 20px">
		<div class="card">
<!-- ///////////////////////////////////////form /////////////////////////////////////////////////////////////////////// -->
			<div class="card-body table-responsive p-10">
							<button class="btn btn-primary col-sm-1 auto" id="auto">자동입력</button>
				<form id="frm" name="frm" action="/bidnotice/createAjax?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
					<!-- 폼데이터 -->
					<div style="margin-top: 20px;" class="row">
						<div style="float: right;" class="col-sm-8"></div>

						<div style="float: right; text-align: center;" class="col-sm-2">
							<label for="bidStatus">상태</label>
								<br>
								<select name="bidStatus">
								<option style="background-color:white;" value="입찰">입찰</option>
								<option style="background-color:white;" value="유찰">유찰</option>
								<option style="background-color:white;" value="낙찰">낙찰</option>
								<option style="background-color:white;" value="취소">취소</option>
								<option style="background-color:white;" value="마감">마감</option>
								</select>
						</div>
						<div style="float: right; text-align: center;" class="col-sm-2">
							<label for="bidStartDt">공고일</label>
							<input style="background-color:white;" type="text" class="form-control" name="bidStartDt"  />
						</div>
					</div>

					<div class="row"
						style="margin-top: 20px; text-align: center; padding: -12px">
						<input style="background-color:white; text-align: center; font-size: 2rem;" type="text"	class="form-control" id="bidTitle" name="bidTitle" placeholder="제목을 입력하세요"/>
					</div>
					
<!-- ////////////////////////////////////////////////낙찰 업체 입력 ////////////////////////////////////////////////////////////////// -->
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
					                <input style="background-color:white;" type="text" class="form-control" name="bidCompany" />
					              </td>
					              <td>
					                <input style="background-color:white;" type="text" class="form-control" name="bidCrn" />
					              </td>
					              <td>
					                <input style="background-color:white;" type="text" class="form-control" name="bidCeo" />
					              </td>
					              <td>
					                <input style="background-color:white;" type="text" class="form-control" name="bidCnum" />
					              </td>
					              <td>
					                <input style="background-color:white;" type="date" class="form-control" name="bidBidDt" />
					              </td>
					              <td>
									<select name="bidExplanYn">
					                  <option style="background-color:white;" value="Y">Y</option>
					                  <option style="background-color:white;" value="N">N</option>
					                  </select>
					              </td>
					              <td>
									<select name="bidDocYn">
					                  <option style="background-color:white;" value="Y">Y</option>
					                  <option style="background-color:white;" value="N">N</option>
					                </select>
					              </td>
					              <td>
					                <input style="background-color:white;" type="text" class="form-control" name="bidBidDeposit" />
					              </td>
					          </tr>
					      </tbody>
					  </table>
					</div>
<!-- ////////////////////////////////////////////////낙찰 업체 입력종료 ////////////////////////////////////////////////////////////////// -->					

<!-- /////////////////////////////////////////////////단지 입력 시작///////////////////////////////////////////////////////// -->
					<div class="row" style=" margin-top: 20px; text-align: center; ">
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
					                    <select name="danjiName" id="danjiName">
					                        <option value="000">단   지</option>
					                        <c:forEach var="danjiVO" items="${danjiVOList}" varStatus="stat">
					                            <option value="${danjiVO.danjiCode}">${danjiVO.danjiName}</option>
					                        </c:forEach>
					                    </select>
					                </td>
					                <td>
					                    <input style="background-color:white;" type="text" class="form-control" name="addr" />
					                </td>
					                <td>
					                    <input style="background-color:white;" type="text" class="form-control" id="bidNum" name="bidNum" />
					                <td>
					                    <input style="background-color:white;" type="text" class="form-control" id="bidFax" name="bidFax" />
					                </td>
					                <td>
					                    <input style="background-color:white;" type="text" class="form-control" name="cntDong" />
					                </td>
					                <td>
					                    <input style="background-color:white;" type="text" class="form-control" name="cntTotalRoom" />
					                </td>
					            </tr>
					        </tbody>
					    </table>
					</div>

<!-- /////////////////////////////////////////////////단지 입력 종료///////////////////////////////////////////////////////// -->


<!-- ///////////////////////////////////////////////공고 내용 입력 시작//////////////////////////////////////////////////////// -->
					<div class="row" style=" margin-top: -5px; text-align: center; padding: 20px;">
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
						            <input style="background-color:white;" type="text" class="form-control" id="bidSeq" name="bidSeq"/>
						        </td>
						    </tr>
						    <tr>
						        <th scope="col">입찰방법</th>
						        <td>
						            <select name="bidHow">
						                <option style="background-color:white;" value="전자입찰">전자입찰</option>
						                <option style="background-color:white;" value="직접입찰">직접입찰</option>
						            </select>
						        </td>
						        <th scope="col">
						                입찰 마감일
						        </th>
						        <td>
						            <input style="background-color:white;" type="datetime-local" class="form-control" id="bidOutDt" name="bidOutDt" />
						        </td>
						    </tr>
						    <tr>
						        <th scope="col">입찰제목</th>
						        <td>
						            <input style="background-color:white;" type="text" class="form-control" id="bidTitle2" name="bidTitle" />
						        </td>
						        <th scope="col">긴급입찰여부</th>
						        <td>
						            <select name="bidEmergency">
						                <option style="background-color:white;" value="긴급">긴급</option>
						                <option style="background-color:white;" value="일반">일반</option>
						            </select>
						        </td>
						    </tr>
						    <tr>
						        <th scope="col">입찰종류</th>
						        <td>
						            <select name="bidType">
						                <option style="background-color:white;" value="일반경쟁">일반경쟁</option>
						                <option style="background-color:white;" value="제한경쟁">제한경쟁</option>
						            </select>
						        </td>
						        <th scope="col">낙찰방법</th>
						        <td>
						            <select name="bidSuccessHow">
						                <option style="background-color:white;" value="최저가">최저가</option>
						                <option style="background-color:white;" value="적격심사">적격심사</option>
						            </select>
						        </td>
						    </tr>
						    <tr>
						        <th scope="col">입찰분류</th>
						        <td>
						                사업자 - 용역 - 기타 용역
						        </td>
						        <th scope="col">신용평가등급확인서<br>제출여부</th>
						        <td>
						            <select name="bidCirSub">
						                <option style="background-color:white;" value="제출">제출</option>
						                <option style="background-color:white;" value="없음">없음</option>
						            </select>
						        </td>
						    </tr>
						    <tr>
						        <th scope="col">현장설명</th>
						        <td>
						            <select name="bidExplan">
						                <option style="background-color:white;" value="필수">필수</option>
						                <option style="background-color:white;" value="없음">없음</option>
						            </select>
						        </td>
						        <th scope="col">관리(공사용역)<br>실적증명서 제출여부</th>
						        <td>
						            <select name="bidCpcSub">
						                <option style="background-color:white;" value="제출">제출</option>
						                <option style="background-color:white;" value="없음">없음</option>
						            </select>
						        </td>
						    </tr>
						    <tr>
						        <th scope="col">현장설명일시</th>
						        <td>
						            <input style="background-color:white;" type="datetime-local" class="form-control" id="bidExplanDt" name="bidExplanDt" />
						        </td>
						        <th scope="col">현장설명장소</th>
						        <td>
						            <input style="background-color:white;" type="text" class="form-control" id="bidLocation" name="bidLocation"  />
						        </td>
						    </tr>
						    <tr>
						        <th scope="col">서류제출마감일</th>
						        <td>
						            <input style="background-color:white;" type="datetime-local" class="form-control" id="bidDocDt" name="bidDocDt"	/>
						        </td>
						        <th scope="col">입찰보증금</th>
						        <td>
						            <input style="background-color:white;" type="text" class="form-control" id="bidDeposit" name="bidDeposit"  />
						        </td>
						    </tr>
						    <tr>
						        <th scope="col">내용</th>
						        <td colspan="3">
						            <input style="background-color:white;" type="text" class="form-control" id="bidContent" name="bidContent"  />
						        </td>
						    </tr>
						    <tr>
						        <th scope="col">파일첨부</th>
						        <td colspan="3">
						            <div id="wrapper2">
						                <div id="preview2" ondragover="f_over()" ondrop="f_drop()">
						                </div>
						                <div style="margin-top: 20px; text-align: left;" id="list2" >
						                    <h5>파일 리스트</h5>
						                </div>
						            </div>
						        </td>
						    </tr>
						    </tbody>
						</table>
					</div>
<!-- ///////////////////////////////////////////////공고 내용 입력 종료//////////////////////////////////////////////////////// -->
					<div class="form-actions" style="margin-top:20px; text-align: right;">
						<button type="button" class="btn btn-warning" id="cancel">취소</button>
						<button type="button" class="btn btn-primary" id="apply">등록</button> 
					</div>
				<sec:csrfInput/>
			</form>
		</div>
	</div>
</div>

<script>
$('#auto').on('click', function(){
   $('#bidTitle').val('승강기 유지관리업체 선정 공고');
   $('#bidSeq').val('BID007');
   $('#bidTitle2').val('승강기 유지관리업체 선정 공고');
   $('#bidNum').val('0424856678');
   $('#bidFax').val('0424856678');
   $('#bidExplanDt').val('2024-07-16 11:00');
   $('#bidDocDt').val('2024-07-23 11:00');
   $('#bidOutDt').val('2024-07-23 11:00');
   $('#bidLocation').val('대전광역시 중구 태평동 422-7');
   $('#bidDeposit').val('입찰가격의[5]% 이상 제출');
   $('#bidContent').val('입찰공고문참조');
   
//    $('input[name="surveyDetails[0].svdItem"]').val('1112312');
//    $('input[name="surveyDetails[1].svdItem"]').val('1112312');
//    $('input[name="surveyDetails[2].svdItem"]').val('1112312');
})
</script>

 <script>
  // 고정 전역변수(동적생성 아닌 DOM)
  const myPreview = document.querySelector("#preview2");
  const myList = document.querySelector("#list2");

  // DROP 이벤트 처리
  let attachFileList = [];   // 첨부파일 리스트를 위한 전역변수
  let fileIdIndex = 1;       // 첨부파일(이미지) 아이디 시작넘버

  // 체크박스에 체크된 파일만 전송
  function f_send() {

      //AJAX로 파일전송하기 위해 FormData생성
      let formData = new FormData();

      //선택된 파일만 가져오깅
      let selFiles = f_ckFileList()
      selFiles.forEach(selFile => {
          formData.append("myFiles", selFile);
      })

      // FormData 디버깅시 사용하면 Good!
      console.log("************ 서버에 보내려는 파일 *************");
      for (let [key, value] of formData) {
          console.log(key, value);
      }
      console.log("***********************************************");

      let xhr = new XMLHttpRequest();
      xhr.open("post", "/서버사이드URL", true);
      xhr.onreadystatechange = () => {
          if (xhr.readyState == 4 && xhr.status == 200) {
              console.log("꼭 체크습관", xhr.responseText);
          }
      }
      // 성공이든 실패든 발생하는 onloadend이벤트를 이용, 404처리
      xhr.onloadend = () => {
          if (xhr.status == "404") {
              Swal.fire("백엔드 맹글고 하는거 맞아용?");
          }
      }

      xhr.onerror = () => {
          console.log("에러났넹" + xhr.status);
      }

      xhr.send(formData);

  }

  // 체크된 체크박스들의 value를 이용 파일 골라내깅
  function f_ckFileList() {
      //체크된 체크박스들
      let ckCheckboxes = myList.querySelectorAll("input:checked");

      //파일 고르깅
      let selFiles = attachFileList.filter(aFile => {
          for (let i = 0; i < ckCheckboxes.length; i++) {
              if (aFile.name == ckCheckboxes[i].value) {
                  return true;
              }
          }
          return false;
      })

      return selFiles;
  }

  //파일 중복 여부 체크 함수, 일단 그냥 파일명으로 비교
  function f_isRepeat(pFile) {
      for (let i = 0; i < attachFileList.length; i++) {
          if (pFile.name == attachFileList[i].name) {
              return true;  // 중복
          }
      }
      return false;      // 안 중복
  }

  // 파일 1개씩 비동기로 읽어서 처리
  function f_readOneFile(pInx, pFile) {

      // 파일중복여부 체크 
      if (f_isRepeat(pFile)) {
          Swal.fire({
              title: "미안행~~",
              text: "너가 이미 선택한 파일이얌!!~~ㅠㅠ",
              icon: "warning"
          });
          return;  // 그냥 종료
      }
      attachFileList.push(pFile);

      // console.log("파일리스트:", attachFileList);

      // 파일 읽어주는 아저씨 생성, 사람은 바이너리 파일을 못 읽음
      let v_fileReader = new FileReader();
      // 끌어온 파일 읽으라고 지시 
      v_fileReader.readAsDataURL(pFile);
      // 파일 내용을 다 읽었다면, load이벤트 발생(비동기)
      // 읽은 결과는 result속성에 담기게 된당.
      v_fileReader.onload = function () {

          //비동기로 처리됨을 확인할 로그
          //   console.log("체에킁:", pInx, pFile);

          //myPreview.innerHTML = "";  // 이전 내용 클리엉
          let v_img = document.createElement("img");
          v_img.setAttribute("src", v_fileReader.result);
          v_img.id = "fId" + fileIdIndex;
          v_img.style.width = "50%";
          v_img.style.height = "50%";
          //img 태그에 줄 id값 증가
          fileIdIndex++;

          // checkbox와 text를 가진 div 맹글어서 추강!
          let fileDetail = document.createElement("div");
          let chkBox = document.createElement("input");
          chkBox.type = "checkbox";
          chkBox.value = pFile.name;
          chkBox.fileId = v_img.id;
          chkBox.checked = true;     // 디폴트 체크
          chkBox.addEventListener("change", function () {
              //this가 무얼가리키는지 디버깅, 화살표함수로 바꾸면?
              //console.log("체킁:", this);
              let selectImg = document.querySelector("#" + this.fileId);
              if (this.checked) {
                  selectImg.style.display = "inline-block";
              } else {
                  selectImg.style.display = "none";
              }
          })

          let txtBox = document.createElement("input");
          txtBox.type = "text";
          txtBox.readOnly = true;
          txtBox.style.border = "none";
          txtBox.value = pFile.name;

          fileDetail.appendChild(chkBox);
          fileDetail.appendChild(txtBox);
          fileDetail.appendChild(document.createElement("br"));

//           myPreview.appendChild(v_img); //파일 미리보기
          myList.appendChild(fileDetail);
          //스크롤바 아래로 내리깅!
          myPreview.scrollTo(0, myPreview.scrollHeight);
          myList.scrollTo(0, myList.scrollHeight);
      }
  }


  //브라우져가 지원하는 파일 자동으로 여는 거 막기 위함
  function f_over() {
      event.preventDefault();
      event.stopPropagation();
  }

  // Drop 이벤트 기본기능 막고, 원하는 기능 넣기
  function f_drop() {
      event.preventDefault();
      event.stopPropagation();

      // 마우스로 끌어온 파일, 일단 1개만
      let v_files = event.dataTransfer.files;
      for (let i = 0; i < v_files.length; i++) {
          f_readOneFile(i, v_files[i]);
      }
  }

  // Drop 영역외에 파일 끌어다 놓았을 때 브라우져 동작막깅
  window.addEventListener("dragover", function () {
      event.preventDefault();
  });

  window.addEventListener("drop", function () {
      event.preventDefault();
  });

</script>
</body>
</html>