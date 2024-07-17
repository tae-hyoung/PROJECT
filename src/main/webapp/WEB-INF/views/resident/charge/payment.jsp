
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<div style="display: none" id="roomCode"><sec:authentication property="principal.memberVO.roomCode" /></div>


<script src="https://cdn.jsdelivr.net/npm/chart.js"></script> 
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>

<style>
.charge:hover {
	background-color: lightgrey;
}
thead th{
	text-align: center;
}
.expand{
	text-align: right;
}
.right{
	text-align: right;
}
.subTitle{
	font-weight: 600;
}

#chargeTbl td{
	height: 30px;
	font-size: 16px;
}

#detailTbl th, #detailTbl td{
	border-right: 1px solid lightgray;
}

#detailTbl th:nth-child(1), #detailTbl td:nth-child(1) {  
	border: none;
}

.center{
	text-align: center;
}

.right{
	text-align: right;
}

.border-right{
	border-right: 1px solid black;
}
</style>

<div style="display: none" id="memId"><sec:authentication property="principal.memberVO.memId" /></div>
<div style="display: none" id="memNm"><sec:authentication property="principal.memberVO.memNm" /></div>
<div style="display: none" id="nickname"><sec:authentication property="principal.memberVO.nickname" /></div>
<div style="display: none" id="memTelno"><sec:authentication property="principal.memberVO.memTelno" /></div>
<div style="display: none" id="memEmail"><sec:authentication property="principal.memberVO.memEmail" /></div>
<div style="display: none" id="roomCode"><sec:authentication property="principal.memberVO.roomCode" /></div>


<div class="col-12">
	<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
		<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="las la-file-invoice-dollar"></i><strong>    관리비 납부</strong></p>
		<div class="page-title-right">
			<ol class="breadcrumb m-0">
				<li class="breadcrumb-item active">관리비 납부</li>
			</ol>
		</div>
	</div>
</div>

<div class="col-12">
	<div class="card">
		<div class="card-header" style="display: flex;">
			<h3 class="card-title" style="font-size: 40px;">관리비 납부</h3>
			<div style="margin-left: 1160px; margin-top: 15px;">
				<a href="#" class="btn btn-outline-primary" id="btnPay" style="height: 40px;">관리비 납부</a>
			</div>
		</div>

		<div class="card-body row" style="margin-left: 35px;">
			<div class="col-6" style="margin-left: -70px; margin-top: 20px;">
				<div id="percent" style="display: none;"><fmt:formatNumber value="${chargeItemVO.totalCharge / avg * 100}" pattern="0" /></div>
				<canvas id="doughnut" width="800" height="240"></canvas>
				<div id="percentDisp1" style="font-size: 2em; display: flex; justify-content: center; margin-left: 50px; margin-top: -80px;"></div>
				<div id="percentDisp2" style="font-size: 2em; display: flex; justify-content: center; margin-left: 50px;"></div>
				
				<div class="row" style="margin-top: 20px; margin-left: 70px; height: 140px; font-size: 16px;">
					<p style="margin-left: 220px;">※ 수 납 은 행 안내 ※</p>
					<div class="col-6" style="margin-top: -20px;">
						<table>
							<tr>
								<td class="center" width="40%">제 일 은 행 : </td>
								<td width="60%">220-10-007003</td>
							</tr>
							<tr>
								<td class="center" width="40%">우 리 은 행 : </td>
								<td width="60%">101-12980-01-001</td>
							</tr>
							<tr>
								<td class="center" width="40%">국 민 은 행 : </td>
								<td width="60%">063-01-0091-580</td>
							</tr>
							<tr>
								<td class="center" width="40%">기 업 은 행 : </td>
								<td width="60%">059-021317-04-001</td>
							</tr>
						</table>
					</div>
					<div class="col-6" style="margin-top: -20px;">
						<table>
							<tr>
								<td class="center" width="40%">하 나 은 행 : </td>
								<td width="60%">204-312551-00105</td>
							</tr>
							<tr>
								<td class="center" width="40%">신 한 은 행 : </td>
								<td width="60%">100-012-833173</td>
							</tr>
							<tr>
								<td class="center" width="40%">우&nbsp;&nbsp;&nbsp;&nbsp;체&nbsp;&nbsp;&nbsp;국  : </td>
								<td width="60%">012906-01-000651</td>
							</tr>
							<tr>
								<td class="center" width="40%">농&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;협  : </td>
								<td width="60%">356-0437-4464-13</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			
			<div class="col-6" style="margin-left: 70px;">
				<div style="width: 650px;">
					<p style="display: flex; justify-content: flex-end;"><span style="color: #299cdb; margin-top: 7px;">${fn:substring(ym, 0, 4)}년 ${fn:substring(ym, 5, 7)}월분</span><span style="font-size: 1.5em; font-weight: 600;">납부하실 금액은</span></p>
					<p style="display: flex; justify-content: flex-end; margin-top: -20px;"><span style="color: red; font-size: 3em; font-weight: 600;"><span><fmt:formatNumber value="${chargeItemVO.totalCharge}" pattern="#,###" /></span>원</span></p>
					<p style="display: flex; justify-content: flex-end; margin-top: -20px;"><span>${fn:substring(ym, 0, 4)}년 ${fn:substring(ym, 5, 7)+1}월 16일까지</span></p>
				</div>
				
				<div class="row" style="display: flex; margin-top: 10px; width: 675px;">
					<div class="col-3" style="display: flex; justify-content: flex-start;">
						<button class="btn btn-light" id="prev"><i class="mdi mdi-chevron-double-left"></i></button>
					</div>
					<div class="col-6" style="display: flex; justify-content: center;"><span id="ym" style="font-size: 2em;">${ym}</span></div>
					<div class="col-3" style="display: flex; justify-content: flex-end;">
						<button class="btn btn-light" id="next"><i class="mdi mdi-chevron-double-right"></i></button>
					</div>
				</div>
				<br>
				<div style="display: flex">
					<div class="card" style="width: 650px; height: 240px;">
						<table id="chargeTbl" style="width:">
							<tr style="background-color: lightgreen">
								<td width= "50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;당월 부과액</td>
								<td width= "50%" class="right"><span id="totalCharge"><fmt:formatNumber value="${chargeItemVO.totalCharge}" pattern="#,###" /></span>원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr>
								<td width= "50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;할인 총계</td>
								<td width= "50%" class="right"><span id="discountCharge">0</span>원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr style="background-color: lightgreen">
								<td width= "50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;미납액</td>
								<td width= "50%" class="right"><span id="unpaiedCharge">0</span>원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr>
								<td width= "50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;미납 연체료</td>
								<td width= "50%" class="right"><span id="unpaiedFee">0</span>원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr style="background-color: lightgreen">
								<td width= "50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;납기 내 금액</td>
								<td width= "50%" class="right"><span id="dueDateFee"><fmt:formatNumber value="${chargeItemVO.totalCharge}" pattern="#,###" /></span>원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr>
								<td width= "50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;납기 후 연체료</td>
								<td width= "50%" class="right"><span id="lateFee"><fmt:formatNumber value="${chargeItemVO.totalCharge * 0.02}" pattern="#,###" /></span>원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr style="background-color: lightgreen">
								<td width= "50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;납기 후 금액</td>
								<td width= "50%" class="right"><span id="afterAmount"></span>원&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
							<tr>
								<td width= "50%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;납부 기한</td>
								<td width= "50%" class="right">익월 16일까지&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div style="display: flex; justify-content: flex-end; margin-right: 114px;">
			<a class="btn btn-outline-info" href="#chargePerMonth" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="chargePerMonth" id="monthDetail">월별 관리비 조회 닫기</a>
		</div>
		
				
				<!-- 상세 모달 시작 -->
				<div id="detailModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				    <div class="modal-dialog modal-xl">
				        <div class="modal-content" style="width: 1050px;">
				        	<div>
				        		<table>
									<tbody>
									    <tr class="center">
									        <td class="se_cell se_align-center" colspan="2" rowspan="1" style="width:15%;height:43.0px;background-color:#fff599;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>관리비&nbsp;구성&nbsp;항목</b></span></div>
									        </td>
									        <td class="se_cell se_align-center" colspan="1" rowspan="1" style="width:85%;height:43.0px;background-color:#fff599;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>구성&nbsp;내용</b></span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center" colspan="1" rowspan="5" style="width:3%;height:316.0px;background-color:#78ccc9;border-color: rgb(0, 118, 200);">
									    		<div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>공<br>용</b></span><span class="se_ff_nanumbarungothic se_fs_T4"><b><br>관<br>리<br>비</b></span></div>
									        </td>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:84.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>일반관리비</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:84.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;관리사무실의&nbsp;운영을&nbsp;위한&nbsp;비용으로&nbsp;관리실&nbsp;직원&nbsp;유지를&nbsp;위해&nbsp;필요한&nbsp;인건비와 부대비용 (수당,&nbsp;복리후생비,&nbsp;퇴직&nbsp;급여&nbsp;등),&nbsp;사무용품비,&nbsp;사무소&nbsp;관련<br>&nbsp;&nbsp;제세공과금&nbsp;등으로&nbsp;구성됨</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:63.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>청소비</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:63.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;아파트&nbsp;청소와&nbsp;관련된&nbsp;인건비&nbsp;등의&nbsp;비용과&nbsp;청소&nbsp;작업에&nbsp;직접&nbsp;소요되는 비용을 포함함</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:63.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>경비비</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:63.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;아파트&nbsp;경비와&nbsp;관련된&nbsp;인건비&nbsp;등의&nbsp;비용과&nbsp;경비&nbsp;업무에&nbsp;직접&nbsp;소요되는&nbsp;비용을 포함함</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>소독비</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;소독&nbsp;관련&nbsp;인건비&nbsp;등의&nbsp;비용과&nbsp;소독&nbsp;작업에&nbsp;직접&nbsp;소요된&nbsp;비용</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:63.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>승강기</b></span><span class="se_ff_nanumbarungothic se_fs_T4"><b>유지비</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:63.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;승강기의&nbsp;효율성을&nbsp;높이거나&nbsp;고장&nbsp;발생&nbsp;시&nbsp;수리를&nbsp;위해&nbsp;소요되는 제비용(장기수선충당금을&nbsp;사용해야&nbsp;하는&nbsp;공사&nbsp;및&nbsp;부품&nbsp;교체는&nbsp;제외)</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center" colspan="1" rowspan="9" style="width:3.5958905%;height:428.0px;background-color:#7ec89d;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>개<br>별<br>사<br>용<br>료</b></span><span class="se_ff_nanumbarungothic se_fs_T4"></span></div>
									        </td>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>난방비</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;난방&nbsp;및&nbsp;급탕에&nbsp;소요된&nbsp;원가(유류대,&nbsp;급탕용수비)에서&nbsp;급탕비를&nbsp;뺀 금액</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>급탕비</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;급탕용&nbsp;유류대&nbsp;및&nbsp;급탕용수비</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>전기공용</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;주차장,&nbsp;가로등,&nbsp;주민시설&nbsp;등&nbsp;공용&nbsp;부분에서&nbsp;발생하는&nbsp;전기&nbsp;비용</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>전기전용</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;세대에서&nbsp;사용하는&nbsp;전기&nbsp;비용,&nbsp;TV수신료&nbsp;포함(또는&nbsp;별도&nbsp;표시)</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>수도료</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;세대에서&nbsp;사용하는&nbsp;수도&nbsp;비용&nbsp;등</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>수선 유지비</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:43.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;장기수선계획에&nbsp;포함되지&nbsp;않는&nbsp;공용&nbsp;부분&nbsp;수선&nbsp;및&nbsp;보수&nbsp;비용</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:63.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>장기수선</b></span><span class="se_ff_nanumbarungothic se_fs_T4"><b>충당금</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:63.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;장기적인&nbsp;계획을&nbsp;통해&nbsp;아파트&nbsp;공용&nbsp;부분의&nbsp;각종&nbsp;시설&nbsp;등에&nbsp;대하여&nbsp;교체&nbsp;등을&nbsp;위하여&nbsp;향후&nbsp;이에&nbsp;필요한&nbsp;자금을&nbsp;마련하고자&nbsp;소유자가&nbsp;미리&nbsp;적립하는&nbsp;금액</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:63.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>입주자</b></span><span class="se_ff_nanumbarungothic se_fs_T4"><br><b>대표회의&nbsp;</b></span><span class="se_ff_nanumbarungothic se_fs_T4"><b>운영비</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:63.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;입주자대표회의의&nbsp;운영을&nbsp;위한&nbsp;업무&nbsp;추진비,&nbsp;출석&nbsp;수당,&nbsp;간식비&nbsp;등</span></div>
									        </td>
									    </tr>
									
									    <tr>
									        <td class="se_cell se_align-center center border-right" colspan="1" rowspan="1" style="width:12%;height:44.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4"><b>기타</b></span></div>
									        </td>
									        <td class="se_cell se_align-left" colspan="1" rowspan="1" style="width:85%;height:44.0px;background-color:;border-color: rgb(0, 118, 200);">
									            <div class="se_cellArea"><span class="se_ff_nanumbarungothic se_fs_T4">&nbsp;&nbsp;생활폐기물&nbsp;수수료,&nbsp;위탁&nbsp;수수료,&nbsp;건물&nbsp;보험료&nbsp;등</span></div>
									        </td>
									    </tr>
									</tbody>
				        		</table>
				        	</div>
				        	<div style="display: flex; justify-content: flex-end; margin-bottom: 10px; width: 1000px;">
						        <button type="button" id="close" class="btn btn-outline-dark" data-bs-toggle="modal" data-bs-target="#detailModal">닫기</button>
				        	</div>
						</div>
					</div>
				</div>
				<!-- 상세 모달 끝 -->
				
		<div class="card-body">
			<div class="collapse row show" id="chargePerMonth">
				<div style="display: flex; justify-content: center;">
					<h2>
						<a role="button" id="lastYear"><i class="mdi mdi-chevron-double-left"></i></a>
						<span id="year">2024</span>년
						<a role="button" id="postYear"><i class="mdi mdi-chevron-double-right"></i></a>
					</h2>
				</div>
				
				<div class="col-12">
					<table id="detailTbl" style="width: 1500px; font-size: 15px;">
						<thead>
							<tr>
								<th width="3%"></th>
								<th width="13%">분류  <i class="ri-question-line" data-bs-toggle="modal" data-bs-target="#detailModal"></i></th>
								<th width="7%" class="right">1월</th>
								<th width="7%" class="right">2월</th>
								<th width="7%" class="right">3월</th>
								<th width="7%" class="right">4월</th>
								<th width="7%" class="right">5월</th>
								<th width="7%" class="right">6월</th>
								<th width="7%" class="right">7월</th>
								<th width="7%" class="right">8월</th>
								<th width="7%" class="right">9월</th>
								<th width="7%" class="right">10월</th>
								<th width="7%" class="right">11월</th>
								<th width="7%" class="right">12월</th>
							</tr>
						</thead>
						<tbody id="chargeDetail">
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#commons" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="commons">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#commons" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="commons">
										<span class="subTitle">일반관리비</span>
									</a>
								</td>
								<td class="right"><span id="commons01" class="charge">0</span>원</td>
								<td class="right"><span id="commons02" class="charge">0</span>원</td>
								<td class="right"><span id="commons03" class="charge">0</span>원</td>
								<td class="right"><span id="commons04" class="charge">0</span>원</td>
								<td class="right"><span id="commons05" class="charge">0</span>원</td>
								<td class="right"><span id="commons06" class="charge">0</span>원</td>
								<td class="right"><span id="commons07" class="charge">0</span>원</td>
								<td class="right"><span id="commons08" class="charge">0</span>원</td>
								<td class="right"><span id="commons09" class="charge">0</span>원</td>
								<td class="right"><span id="commons10" class="charge">0</span>원</td>
								<td class="right"><span id="commons11" class="charge">0</span>원</td>
								<td class="right"><span id="commons12" class="charge">0</span>원</td>
							</tr>
	
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ급여</td>
								<td class="right"><span id="salary01" class="charge">0</span>원</td>
								<td class="right"><span id="salary02" class="charge">0</span>원</td>
								<td class="right"><span id="salary03" class="charge">0</span>원</td>
								<td class="right"><span id="salary04" class="charge">0</span>원</td>
								<td class="right"><span id="salary05" class="charge">0</span>원</td>
								<td class="right"><span id="salary06" class="charge">0</span>원</td>
								<td class="right"><span id="salary07" class="charge">0</span>원</td>
								<td class="right"><span id="salary08" class="charge">0</span>원</td>
								<td class="right"><span id="salary09" class="charge">0</span>원</td>
								<td class="right"><span id="salary10" class="charge">0</span>원</td>
								<td class="right"><span id="salary11" class="charge">0</span>원</td>
								<td class="right"><span id="salary12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ제수당</td>
								<td class="right"><span id="allowance01" class="charge">0</span>원</td>
								<td class="right"><span id="allowance02" class="charge">0</span>원</td>
								<td class="right"><span id="allowance03" class="charge">0</span>원</td>
								<td class="right"><span id="allowance04" class="charge">0</span>원</td>
								<td class="right"><span id="allowance05" class="charge">0</span>원</td>
								<td class="right"><span id="allowance06" class="charge">0</span>원</td>
								<td class="right"><span id="allowance07" class="charge">0</span>원</td>
								<td class="right"><span id="allowance08" class="charge">0</span>원</td>
								<td class="right"><span id="allowance09" class="charge">0</span>원</td>
								<td class="right"><span id="allowance10" class="charge">0</span>원</td>
								<td class="right"><span id="allowance11" class="charge">0</span>원</td>
								<td class="right"><span id="allowance12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ상여금</td>
								<td class="right"><span id="bonus01" class="charge">0</span>원</td>
								<td class="right"><span id="bonus02" class="charge">0</span>원</td>
								<td class="right"><span id="bonus03" class="charge">0</span>원</td>
								<td class="right"><span id="bonus04" class="charge">0</span>원</td>
								<td class="right"><span id="bonus05" class="charge">0</span>원</td>
								<td class="right"><span id="bonus06" class="charge">0</span>원</td>
								<td class="right"><span id="bonus07" class="charge">0</span>원</td>
								<td class="right"><span id="bonus08" class="charge">0</span>원</td>
								<td class="right"><span id="bonus09" class="charge">0</span>원</td>
								<td class="right"><span id="bonus10" class="charge">0</span>원</td>
								<td class="right"><span id="bonus11" class="charge">0</span>원</td>
								<td class="right"><span id="bonus12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ퇴직금</td>
								<td class="right"><span id="rtrPay01" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay02" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay03" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay04" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay05" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay06" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay07" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay08" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay09" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay10" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay11" class="charge">0</span>원</td>
								<td class="right"><span id="rtrPay12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ산재보험료</td>
								<td class="right"><span id="iacIns01" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns02" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns03" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns04" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns05" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns06" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns07" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns08" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns09" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns10" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns11" class="charge">0</span>원</td>
								<td class="right"><span id="iacIns12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ고용보험료</td>
								<td class="right"><span id="empIns01" class="charge">0</span>원</td>
								<td class="right"><span id="empIns02" class="charge">0</span>원</td>
								<td class="right"><span id="empIns03" class="charge">0</span>원</td>
								<td class="right"><span id="empIns04" class="charge">0</span>원</td>
								<td class="right"><span id="empIns05" class="charge">0</span>원</td>
								<td class="right"><span id="empIns06" class="charge">0</span>원</td>
								<td class="right"><span id="empIns07" class="charge">0</span>원</td>
								<td class="right"><span id="empIns08" class="charge">0</span>원</td>
								<td class="right"><span id="empIns09" class="charge">0</span>원</td>
								<td class="right"><span id="empIns10" class="charge">0</span>원</td>
								<td class="right"><span id="empIns11" class="charge">0</span>원</td>
								<td class="right"><span id="empIns12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ국민연금</td>
								<td class="right"><span id="npn01" class="charge">0</span>원</td>
								<td class="right"><span id="npn02" class="charge">0</span>원</td>
								<td class="right"><span id="npn03" class="charge">0</span>원</td>
								<td class="right"><span id="npn04" class="charge">0</span>원</td>
								<td class="right"><span id="npn05" class="charge">0</span>원</td>
								<td class="right"><span id="npn06" class="charge">0</span>원</td>
								<td class="right"><span id="npn07" class="charge">0</span>원</td>
								<td class="right"><span id="npn08" class="charge">0</span>원</td>
								<td class="right"><span id="npn09" class="charge">0</span>원</td>
								<td class="right"><span id="npn10" class="charge">0</span>원</td>
								<td class="right"><span id="npn11" class="charge">0</span>원</td>
								<td class="right"><span id="npn12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ건강보험료</td>
								<td class="right"><span id="hlthIns01" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns02" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns03" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns04" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns05" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns06" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns07" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns08" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns09" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns10" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns11" class="charge">0</span>원</td>
								<td class="right"><span id="hlthIns12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ식대등복리후생비</td>
								<td class="right"><span id="benefits01" class="charge">0</span>원</td>
								<td class="right"><span id="benefits02" class="charge">0</span>원</td>
								<td class="right"><span id="benefits03" class="charge">0</span>원</td>
								<td class="right"><span id="benefits04" class="charge">0</span>원</td>
								<td class="right"><span id="benefits05" class="charge">0</span>원</td>
								<td class="right"><span id="benefits06" class="charge">0</span>원</td>
								<td class="right"><span id="benefits07" class="charge">0</span>원</td>
								<td class="right"><span id="benefits08" class="charge">0</span>원</td>
								<td class="right"><span id="benefits09" class="charge">0</span>원</td>
								<td class="right"><span id="benefits10" class="charge">0</span>원</td>
								<td class="right"><span id="benefits11" class="charge">0</span>원</td>
								<td class="right"><span id="benefits12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ일반사무용품비</td>
								<td class="right"><span id="oprodCt01" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt02" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt03" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt04" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt05" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt06" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt07" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt08" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt09" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt10" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt11" class="charge">0</span>원</td>
								<td class="right"><span id="oprodCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ도서인쇄비</td>
								<td class="right"><span id="printCt01" class="charge">0</span>원</td>
								<td class="right"><span id="printCt02" class="charge">0</span>원</td>
								<td class="right"><span id="printCt03" class="charge">0</span>원</td>
								<td class="right"><span id="printCt04" class="charge">0</span>원</td>
								<td class="right"><span id="printCt05" class="charge">0</span>원</td>
								<td class="right"><span id="printCt06" class="charge">0</span>원</td>
								<td class="right"><span id="printCt07" class="charge">0</span>원</td>
								<td class="right"><span id="printCt08" class="charge">0</span>원</td>
								<td class="right"><span id="printCt09" class="charge">0</span>원</td>
								<td class="right"><span id="printCt10" class="charge">0</span>원</td>
								<td class="right"><span id="printCt11" class="charge">0</span>원</td>
								<td class="right"><span id="printCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ여비교통비</td>
								<td class="right"><span id="tsptCt01" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt02" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt03" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt04" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt05" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt06" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt07" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt08" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt09" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt10" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt11" class="charge">0</span>원</td>
								<td class="right"><span id="tsptCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ통신료</td>
								<td class="right"><span id="commCt01" class="charge">0</span>원</td>
								<td class="right"><span id="commCt02" class="charge">0</span>원</td>
								<td class="right"><span id="commCt03" class="charge">0</span>원</td>
								<td class="right"><span id="commCt04" class="charge">0</span>원</td>
								<td class="right"><span id="commCt05" class="charge">0</span>원</td>
								<td class="right"><span id="commCt06" class="charge">0</span>원</td>
								<td class="right"><span id="commCt07" class="charge">0</span>원</td>
								<td class="right"><span id="commCt08" class="charge">0</span>원</td>
								<td class="right"><span id="commCt09" class="charge">0</span>원</td>
								<td class="right"><span id="commCt10" class="charge">0</span>원</td>
								<td class="right"><span id="commCt11" class="charge">0</span>원</td>
								<td class="right"><span id="commCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ우편료</td>
								<td class="right"><span id="postCt01" class="charge">0</span>원</td>
								<td class="right"><span id="postCt02" class="charge">0</span>원</td>
								<td class="right"><span id="postCt03" class="charge">0</span>원</td>
								<td class="right"><span id="postCt04" class="charge">0</span>원</td>
								<td class="right"><span id="postCt05" class="charge">0</span>원</td>
								<td class="right"><span id="postCt06" class="charge">0</span>원</td>
								<td class="right"><span id="postCt07" class="charge">0</span>원</td>
								<td class="right"><span id="postCt08" class="charge">0</span>원</td>
								<td class="right"><span id="postCt09" class="charge">0</span>원</td>
								<td class="right"><span id="postCt10" class="charge">0</span>원</td>
								<td class="right"><span id="postCt11" class="charge">0</span>원</td>
								<td class="right"><span id="postCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ관리용품구입비</td>
								<td class="right"><span id="cprodCt01" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt02" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt03" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt04" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt05" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt06" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt07" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt08" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt09" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt10" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt11" class="charge">0</span>원</td>
								<td class="right"><span id="cprodCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ잡비</td>
								<td class="right"><span id="etcCt01" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt02" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt03" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt04" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt05" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt06" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt07" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt08" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt09" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt10" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt11" class="charge">0</span>원</td>
								<td class="right"><span id="etcCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ커뮤니티운영비</td>
								<td class="right"><span id="facCt01" class="charge">0</span>원</td>
								<td class="right"><span id="facCt02" class="charge">0</span>원</td>
								<td class="right"><span id="facCt03" class="charge">0</span>원</td>
								<td class="right"><span id="facCt04" class="charge">0</span>원</td>
								<td class="right"><span id="facCt05" class="charge">0</span>원</td>
								<td class="right"><span id="facCt06" class="charge">0</span>원</td>
								<td class="right"><span id="facCt07" class="charge">0</span>원</td>
								<td class="right"><span id="facCt08" class="charge">0</span>원</td>
								<td class="right"><span id="facCt09" class="charge">0</span>원</td>
								<td class="right"><span id="facCt10" class="charge">0</span>원</td>
								<td class="right"><span id="facCt11" class="charge">0</span>원</td>
								<td class="right"><span id="facCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="commons">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ기타</td>
								<td class="right"><span id="commonsOtherCt01" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt02" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt03" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt04" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt05" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt06" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt07" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt08" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt09" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt10" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt11" class="charge">0</span>원</td>
								<td class="right"><span id="commonsOtherCt12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#cleaning" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="cleaning">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#cleaning" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="cleaning">
										<span class="subTitle">청소비</span>
									</a>
								</td>
								<td class="right"><span id="cleaning01" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning02" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning03" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning04" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning05" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning06" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning07" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning08" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning09" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning10" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning11" class="charge">0</span>원</td>
								<td class="right"><span id="cleaning12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="cleaning">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ청소용역비</td>
								<td class="right"><span id="clnSvcCt01" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt02" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt03" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt04" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt05" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt06" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt07" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt08" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt09" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt10" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt11" class="charge">0</span>원</td>
								<td class="right"><span id="clnSvcCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="cleaning">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ규격봉투외 소모품 구입비</td>
								<td class="right"><span id="expendableCt01" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt02" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt03" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt04" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt05" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt06" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt07" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt08" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt09" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt10" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt11" class="charge">0</span>원</td>
								<td class="right"><span id="expendableCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="cleaning">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ공용생활폐기물 처리비</td>
								<td class="right"><span id="wasteCt01" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt02" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt03" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt04" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt05" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt06" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt07" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt08" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt09" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt10" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt11" class="charge">0</span>원</td>
								<td class="right"><span id="wasteCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="cleaning">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ기타</td>
								<td class="right"><span id="cleaningOtherCt01" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt02" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt03" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt04" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt05" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt06" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt07" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt08" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt09" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt10" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt11" class="charge">0</span>원</td>
								<td class="right"><span id="cleaningOtherCt12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#disinfec" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="disinfec">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#disinfec" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="disinfec">
										<span class="subTitle">소독비</span>
									</a>
								</td>
								<td class="right"><span id="disinfec01" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec02" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec03" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec04" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec05" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec06" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec07" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec08" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec09" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec10" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec11" class="charge">0</span>원</td>
								<td class="right"><span id="disinfec12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="disinfec">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ소독비</td>
								<td class="right"><span id="disinfecCt01" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt02" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt03" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt04" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt05" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt06" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt07" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt08" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt09" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt10" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt11" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="disinfec">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ기타</td>
								<td class="right"><span id="disinfecOtherCt01" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt02" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt03" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt04" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt05" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt06" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt07" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt08" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt09" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt10" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt11" class="charge">0</span>원</td>
								<td class="right"><span id="disinfecOtherCt12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#secure" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="secure">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#secure" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="secure">
										<span class="subTitle">경비비</span>
									</a>
								</td>
								<td class="right"><span id="secure01" class="charge">0</span>원</td>
								<td class="right"><span id="secure02" class="charge">0</span>원</td>
								<td class="right"><span id="secure03" class="charge">0</span>원</td>
								<td class="right"><span id="secure04" class="charge">0</span>원</td>
								<td class="right"><span id="secure05" class="charge">0</span>원</td>
								<td class="right"><span id="secure06" class="charge">0</span>원</td>
								<td class="right"><span id="secure07" class="charge">0</span>원</td>
								<td class="right"><span id="secure08" class="charge">0</span>원</td>
								<td class="right"><span id="secure09" class="charge">0</span>원</td>
								<td class="right"><span id="secure10" class="charge">0</span>원</td>
								<td class="right"><span id="secure11" class="charge">0</span>원</td>
								<td class="right"><span id="secure12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="secure">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ경비비</td>
								<td class="right"><span id="secCt01" class="charge">0</span>원</td>
								<td class="right"><span id="secCt02" class="charge">0</span>원</td>
								<td class="right"><span id="secCt03" class="charge">0</span>원</td>
								<td class="right"><span id="secCt04" class="charge">0</span>원</td>
								<td class="right"><span id="secCt05" class="charge">0</span>원</td>
								<td class="right"><span id="secCt06" class="charge">0</span>원</td>
								<td class="right"><span id="secCt07" class="charge">0</span>원</td>
								<td class="right"><span id="secCt08" class="charge">0</span>원</td>
								<td class="right"><span id="secCt09" class="charge">0</span>원</td>
								<td class="right"><span id="secCt10" class="charge">0</span>원</td>
								<td class="right"><span id="secCt11" class="charge">0</span>원</td>
								<td class="right"><span id="secCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="secure">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ기타</td>
								<td class="right"><span id="secOtherCt01" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt02" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt03" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt04" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt05" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt06" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt07" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt08" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt09" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt10" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt11" class="charge">0</span>원</td>
								<td class="right"><span id="secOtherCt12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#elevator" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="elevator">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#elevator" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="elevator">
										<span class="subTitle">승강기유지비</span>
									</a>
								</td>
								<td class="right"><span id="elevator01" class="charge">0</span>원</td>
								<td class="right"><span id="elevator02" class="charge">0</span>원</td>
								<td class="right"><span id="elevator03" class="charge">0</span>원</td>
								<td class="right"><span id="elevator04" class="charge">0</span>원</td>
								<td class="right"><span id="elevator05" class="charge">0</span>원</td>
								<td class="right"><span id="elevator06" class="charge">0</span>원</td>
								<td class="right"><span id="elevator07" class="charge">0</span>원</td>
								<td class="right"><span id="elevator08" class="charge">0</span>원</td>
								<td class="right"><span id="elevator09" class="charge">0</span>원</td>
								<td class="right"><span id="elevator10" class="charge">0</span>원</td>
								<td class="right"><span id="elevator11" class="charge">0</span>원</td>
								<td class="right"><span id="elevator12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="elevator">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ유지보수비</td>
								<td class="right"><span id="evtMgmtCt01" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt02" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt03" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt04" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt05" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt06" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt07" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt08" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt09" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt10" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt11" class="charge">0</span>원</td>
								<td class="right"><span id="evtMgmtCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="elevator">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ검사비</td>
								<td class="right"><span id="evtInspCt01" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt02" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt03" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt04" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt05" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt06" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt07" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt08" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt09" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt10" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt11" class="charge">0</span>원</td>
								<td class="right"><span id="evtInspCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="elevator">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ소모품교체비</td>
								<td class="right"><span id="evtExpendableCt01" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt02" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt03" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt04" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt05" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt06" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt07" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt08" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt09" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt10" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt11" class="charge">0</span>원</td>
								<td class="right"><span id="evtExpendableCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="elevator">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ기타</td>
								<td class="right"><span id="evtOtherCt01" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt02" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt03" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt04" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt05" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt06" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt07" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt08" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt09" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt10" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt11" class="charge">0</span>원</td>
								<td class="right"><span id="evtOtherCt12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#ltrr" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="ltrr">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#ltrr" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="ltrr">
										<span class="subTitle">장기수선충당금</span>
									</a>
								</td>
								<td class="right"><span id="ltrr01" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr02" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr03" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr04" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr05" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr06" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr07" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr08" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr09" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr10" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr11" class="charge">0</span>원</td>
								<td class="right"><span id="ltrr12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="ltrr">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ장기수선충당금</td>
								<td class="right"><span id="ltrrCt01" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt02" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt03" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt04" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt05" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt06" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt07" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt08" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt09" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt10" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt11" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="ltrr">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ기타</td>
								<td class="right"><span id="ltrrOtherCt01" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt02" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt03" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt04" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt05" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt06" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt07" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt08" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt09" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt10" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt11" class="charge">0</span>원</td>
								<td class="right"><span id="ltrrOtherCt12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#facility" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="facility">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#facility" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="facility">
										<span class="subTitle">시설유지비</span>
									</a>
								</td>
								<td class="right"><span id="facilities01" class="charge">0</span>원</td>
								<td class="right"><span id="facilities02" class="charge">0</span>원</td>
								<td class="right"><span id="facilities03" class="charge">0</span>원</td>
								<td class="right"><span id="facilities04" class="charge">0</span>원</td>
								<td class="right"><span id="facilities05" class="charge">0</span>원</td>
								<td class="right"><span id="facilities06" class="charge">0</span>원</td>
								<td class="right"><span id="facilities07" class="charge">0</span>원</td>
								<td class="right"><span id="facilities08" class="charge">0</span>원</td>
								<td class="right"><span id="facilities09" class="charge">0</span>원</td>
								<td class="right"><span id="facilities10" class="charge">0</span>원</td>
								<td class="right"><span id="facilities11" class="charge">0</span>원</td>
								<td class="right"><span id="facilities12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="facility">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ시설유지비</td>
								<td class="right"><span id="facilityMgmtCt01" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt02" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt03" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt04" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt05" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt06" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt07" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt08" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt09" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt10" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt11" class="charge">0</span>원</td>
								<td class="right"><span id="facilityMgmtCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="facility">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ안전점검비</td>
								<td class="right"><span id="facilityChkCt01" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt02" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt03" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt04" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt05" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt06" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt07" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt08" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt09" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt10" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt11" class="charge">0</span>원</td>
								<td class="right"><span id="facilityChkCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="facility">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ재해예방비</td>
								<td class="right"><span id="preventCt01" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt02" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt03" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt04" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt05" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt06" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt07" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt08" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt09" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt10" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt11" class="charge">0</span>원</td>
								<td class="right"><span id="preventCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="facility">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ기타</td>
								<td class="right"><span id="facilitiesOtherCt01" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt02" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt03" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt04" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt05" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt06" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt07" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt08" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt09" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt10" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt11" class="charge">0</span>원</td>
								<td class="right"><span id="facilitiesOtherCt12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#vat" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="vat">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#vat" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="vat">
										<span class="subTitle">부가세</span>
									</a>
								</td>
								<td class="right"><span id="vat01" class="charge">0</span>원</td>
								<td class="right"><span id="vat02" class="charge">0</span>원</td>
								<td class="right"><span id="vat03" class="charge">0</span>원</td>
								<td class="right"><span id="vat04" class="charge">0</span>원</td>
								<td class="right"><span id="vat05" class="charge">0</span>원</td>
								<td class="right"><span id="vat06" class="charge">0</span>원</td>
								<td class="right"><span id="vat07" class="charge">0</span>원</td>
								<td class="right"><span id="vat08" class="charge">0</span>원</td>
								<td class="right"><span id="vat09" class="charge">0</span>원</td>
								<td class="right"><span id="vat10" class="charge">0</span>원</td>
								<td class="right"><span id="vat11" class="charge">0</span>원</td>
								<td class="right"><span id="vat12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="vat">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ관리용역비 부가세</td>
								<td class="right"><span id="msvcCt01" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt02" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt03" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt04" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt05" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt06" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt07" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt08" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt09" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt10" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt11" class="charge">0</span>원</td>
								<td class="right"><span id="msvcCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="vat">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ청소용역비 부가세</td>
								<td class="right"><span id="csvcCt01" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt02" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt03" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt04" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt05" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt06" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt07" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt08" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt09" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt10" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt11" class="charge">0</span>원</td>
								<td class="right"><span id="csvcCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="vat">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ보안용역비 부가세</td>
								<td class="right"><span id="ssvcCt01" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt02" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt03" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt04" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt05" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt06" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt07" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt08" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt09" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt10" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt11" class="charge">0</span>원</td>
								<td class="right"><span id="ssvcCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="vat">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ기타</td>
								<td class="right"><span id="vatOtherCt01" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt02" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt03" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt04" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt05" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt06" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt07" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt08" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt09" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt10" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt11" class="charge">0</span>원</td>
								<td class="right"><span id="vatOtherCt12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#consignment" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="consignment">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#consignment" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="consignment">
										<span class="subTitle">위탁관리수수료</span>
									</a>
								</td>
								<td class="right"><span id="consignment01" class="charge">0</span>원</td>
								<td class="right"><span id="consignment02" class="charge">0</span>원</td>
								<td class="right"><span id="consignment03" class="charge">0</span>원</td>
								<td class="right"><span id="consignment04" class="charge">0</span>원</td>
								<td class="right"><span id="consignment05" class="charge">0</span>원</td>
								<td class="right"><span id="consignment06" class="charge">0</span>원</td>
								<td class="right"><span id="consignment07" class="charge">0</span>원</td>
								<td class="right"><span id="consignment08" class="charge">0</span>원</td>
								<td class="right"><span id="consignment09" class="charge">0</span>원</td>
								<td class="right"><span id="consignment10" class="charge">0</span>원</td>
								<td class="right"><span id="consignment11" class="charge">0</span>원</td>
								<td class="right"><span id="consignment12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="consignment">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ위탁관리 수수료</td>
								<td class="right"><span id="consignmentCt01" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt02" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt03" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt04" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt05" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt06" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt07" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt08" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt09" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt10" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt11" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="consignment">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ기타</td>
								<td class="right"><span id="consignmentOtherCt01" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt02" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt03" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt04" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt05" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt06" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt07" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt08" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt09" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt10" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt11" class="charge">0</span>원</td>
								<td class="right"><span id="consignmentOtherCt12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#meeting" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="meeting">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#meeting" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="meeting">
										<span class="subTitle">입주자대표회의운영비</span>
									</a>
								</td>
								<td class="right"><span id="meeting01" class="charge">0</span>원</td>
								<td class="right"><span id="meeting02" class="charge">0</span>원</td>
								<td class="right"><span id="meeting03" class="charge">0</span>원</td>
								<td class="right"><span id="meeting04" class="charge">0</span>원</td>
								<td class="right"><span id="meeting05" class="charge">0</span>원</td>
								<td class="right"><span id="meeting06" class="charge">0</span>원</td>
								<td class="right"><span id="meeting07" class="charge">0</span>원</td>
								<td class="right"><span id="meeting08" class="charge">0</span>원</td>
								<td class="right"><span id="meeting09" class="charge">0</span>원</td>
								<td class="right"><span id="meeting10" class="charge">0</span>원</td>
								<td class="right"><span id="meeting11" class="charge">0</span>원</td>
								<td class="right"><span id="meeting12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="meeting">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ회장업무추진비</td>
								<td class="right"><span id="cbCt01" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt02" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt03" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt04" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt05" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt06" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt07" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt08" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt09" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt10" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt11" class="charge">0</span>원</td>
								<td class="right"><span id="cbCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="meeting">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ감사업무추진비</td>
								<td class="right"><span id="abCt01" class="charge">0</span>원</td>
								<td class="right"><span id="abCt02" class="charge">0</span>원</td>
								<td class="right"><span id="abCt03" class="charge">0</span>원</td>
								<td class="right"><span id="abCt04" class="charge">0</span>원</td>
								<td class="right"><span id="abCt05" class="charge">0</span>원</td>
								<td class="right"><span id="abCt06" class="charge">0</span>원</td>
								<td class="right"><span id="abCt07" class="charge">0</span>원</td>
								<td class="right"><span id="abCt08" class="charge">0</span>원</td>
								<td class="right"><span id="abCt09" class="charge">0</span>원</td>
								<td class="right"><span id="abCt10" class="charge">0</span>원</td>
								<td class="right"><span id="abCt11" class="charge">0</span>원</td>
								<td class="right"><span id="abCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="meeting">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ출석수당</td>
								<td class="right"><span id="attdcCt01" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt02" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt03" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt04" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt05" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt06" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt07" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt08" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt09" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt10" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt11" class="charge">0</span>원</td>
								<td class="right"><span id="attdcCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="meeting">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ운영비</td>
								<td class="right"><span id="operationCt01" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt02" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt03" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt04" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt05" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt06" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt07" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt08" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt09" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt10" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt11" class="charge">0</span>원</td>
								<td class="right"><span id="operationCt12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="meeting">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ기타</td>
								<td class="right"><span id="meetingOtherCt01" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt02" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt03" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt04" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt05" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt06" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt07" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt08" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt09" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt10" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt11" class="charge">0</span>원</td>
								<td class="right"><span id="meetingOtherCt12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#building" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="building">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#building" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="building">
									<span class="subTitle">건물보험료</span>
									</a>
								</td>
								<td class="right"><span id="building01" class="charge">0</span>원</td>
								<td class="right"><span id="building02" class="charge">0</span>원</td>
								<td class="right"><span id="building03" class="charge">0</span>원</td>
								<td class="right"><span id="building04" class="charge">0</span>원</td>
								<td class="right"><span id="building05" class="charge">0</span>원</td>
								<td class="right"><span id="building06" class="charge">0</span>원</td>
								<td class="right"><span id="building07" class="charge">0</span>원</td>
								<td class="right"><span id="building08" class="charge">0</span>원</td>
								<td class="right"><span id="building09" class="charge">0</span>원</td>
								<td class="right"><span id="building10" class="charge">0</span>원</td>
								<td class="right"><span id="building11" class="charge">0</span>원</td>
								<td class="right"><span id="building12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="building">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ건물보험료</td>
								<td class="right"><span id="buildingInsr01" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr02" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr03" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr04" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr05" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr06" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr07" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr08" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr09" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr10" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr11" class="charge">0</span>원</td>
								<td class="right"><span id="buildingInsr12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#electrocity" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="electrocity">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#electrocity" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="electrocity">
										<span class="subTitle">전기료</span>
									</a>
								</td>
								<td class="right"><span id="electrocity01" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity02" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity03" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity04" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity05" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity06" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity07" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity08" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity09" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity10" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity11" class="charge">0</span>원</td>
								<td class="right"><span id="electrocity12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="electrocity">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ공용전기비</td>
								<td class="right"><span id="sharedElec01" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec02" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec03" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec04" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec05" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec06" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec07" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec08" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec09" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec10" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec11" class="charge">0</span>원</td>
								<td class="right"><span id="sharedElec12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="electrocity">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ개별전기비</td>
								<td class="right"><span id="individualElec01" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec02" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec03" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec04" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec05" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec06" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec07" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec08" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec09" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec10" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec11" class="charge">0</span>원</td>
								<td class="right"><span id="individualElec12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#water" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="water">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#water" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="water">
										<span class="subTitle">수도료</span>
									</a>
								</td>
								<td class="right"><span id="water01" class="charge">0</span>원</td>
								<td class="right"><span id="water02" class="charge">0</span>원</td>
								<td class="right"><span id="water03" class="charge">0</span>원</td>
								<td class="right"><span id="water04" class="charge">0</span>원</td>
								<td class="right"><span id="water05" class="charge">0</span>원</td>
								<td class="right"><span id="water06" class="charge">0</span>원</td>
								<td class="right"><span id="water07" class="charge">0</span>원</td>
								<td class="right"><span id="water08" class="charge">0</span>원</td>
								<td class="right"><span id="water09" class="charge">0</span>원</td>
								<td class="right"><span id="water10" class="charge">0</span>원</td>
								<td class="right"><span id="water11" class="charge">0</span>원</td>
								<td class="right"><span id="water12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="water">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ공용수도료</td>
								<td class="right"><span id="sharedWater01" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater02" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater03" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater04" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater05" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater06" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater07" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater08" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater09" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater10" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater11" class="charge">0</span>원</td>
								<td class="right"><span id="sharedWater12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="water">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ개별수도료</td>
								<td class="right"><span id="individualWater01" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater02" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater03" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater04" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater05" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater06" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater07" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater08" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater09" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater10" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater11" class="charge">0</span>원</td>
								<td class="right"><span id="individualWater12" class="charge">0</span>원</td>
							</tr>
	
							<tr>
								<td class="expand">
									<a class="nav-link menu-link showDetail" href="#heating" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="heating">+</a>
								</td>
								<td>
									<a class="nav-link menu-link showDetail" href="#heating" data-bs-toggle="collapse" role="button" aria-expanded="false" aria-controls="heating">
										<span class="subTitle">난방료</span>
									</a>
								</td>
								<td class="right"><span id="heating01" class="charge">0</span>원</td>
								<td class="right"><span id="heating02" class="charge">0</span>원</td>
								<td class="right"><span id="heating03" class="charge">0</span>원</td>
								<td class="right"><span id="heating04" class="charge">0</span>원</td>
								<td class="right"><span id="heating05" class="charge">0</span>원</td>
								<td class="right"><span id="heating06" class="charge">0</span>원</td>
								<td class="right"><span id="heating07" class="charge">0</span>원</td>
								<td class="right"><span id="heating08" class="charge">0</span>원</td>
								<td class="right"><span id="heating09" class="charge">0</span>원</td>
								<td class="right"><span id="heating10" class="charge">0</span>원</td>
								<td class="right"><span id="heating11" class="charge">0</span>원</td>
								<td class="right"><span id="heating12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="heating">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ공용난방료</td>
								<td class="right"><span id="sharedHeating01" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating02" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating03" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating04" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating05" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating06" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating07" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating08" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating09" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating10" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating11" class="charge">0</span>원</td>
								<td class="right"><span id="sharedHeating12" class="charge">0</span>원</td>
							</tr>
							<tr class="collapse menu-dropdown" id="heating">
								<td></td>
								<td>&nbsp;&nbsp;&nbsp;&nbsp;ㄴ개별난방료</td>
								<td class="right"><span id="individualHeating01" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating02" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating03" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating04" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating05" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating06" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating07" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating08" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating09" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating10" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating11" class="charge">0</span>원</td>
								<td class="right"><span id="individualHeating12" class="charge">0</span>원</td>
							</tr>
							<tr>
								<td></td>
								<td>총액</td>
								<td class="right"><span id="total01" class="charge">0</span>원</td>
								<td class="right"><span id="total02" class="charge">0</span>원</td>
								<td class="right"><span id="total03" class="charge">0</span>원</td>
								<td class="right"><span id="total04" class="charge">0</span>원</td>
								<td class="right"><span id="total05" class="charge">0</span>원</td>
								<td class="right"><span id="total06" class="charge">0</span>원</td>
								<td class="right"><span id="total07" class="charge">0</span>원</td>
								<td class="right"><span id="total08" class="charge">0</span>원</td>
								<td class="right"><span id="total09" class="charge">0</span>원</td>
								<td class="right"><span id="total10" class="charge">0</span>원</td>
								<td class="right"><span id="total11" class="charge">0</span>원</td>
								<td class="right"><span id="total12" class="charge">0</span>원</td>
							</tr>
						</tbody>
					</table>
				</div>
				<hr>
				<div class="col-12" style="min-height: 400px;">
					<canvas id="barChart" width="1500px" height="400px"></canvas>
				</div>
			</div>

		</div>
	</div>
</div>

<script>

$("#prev").on('click', function(){
	let ym = $('#ym').text();
	year = Number(ym.split('-')[0]);
	month = Number(ym.split('-')[1]);
	month--;
	if(month<1){
		month = '12';
		year--;
	}else if(month > 12){
		month = '01';
		year++;
	}else if(month<10)	month = '0' + month;
	else			month = month.toString();
	ym = year + '-' + month;
	$('#ym').text(ym);
	getMonthCharge(ym);
});

$("#next").on('click', function(){
	let ym = $('#ym').text();
	year = Number(ym.split('-')[0]);
	month = Number(ym.split('-')[1]);
	month++;
	if(month<1){
		month = '12';
		year--;
	}else if(month > 12){
		month = '01';
		year++;
	}else if(month<10)	month = '0' + month;
	else			month = month.toString();
	ym = year + '-' + month;
	$('#ym').text(ym);
	getMonthCharge(ym);
});

function getMonthCharge(ym){
	let roomCode = $('#roomCode').text();

	let data = {
			roomCode: roomCode,
			ym: ym
	};
	
	$.ajax({
		url : '/charge/getInfo',
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(data),
		type : 'post',
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(result) {
			console.log("result: ", result);
			if(result.length<1){
				$('#totalCharge').text(0);
	 			$('#discountCharge').text(0);
	 			$('#unpaiedCharge').text(0);
	 			$('#unpaiedFee').text(0);
				$('#dueDateFee').text(0);
				$('#lateFee').text(0);
				$('#afterAmount').text(0);
				return;
			}
			$('#totalCharge').text(result[0].totalCharge.toLocaleString('ko-KR'));
// 			$('#discountCharge').text(result[0].totalCharge);
// 			$('#unpaiedCharge').text(result[0].totalCharge);
// 			$('#unpaiedFee').text(result[0].totalCharge);
			$('#dueDateFee').text(result[0].totalCharge.toLocaleString('ko-KR'));
			$('#lateFee').text(Math.round(result[0].totalCharge*0.02).toLocaleString('ko-KR'));
			let totalLate = result[0].totalCharge + Math.round(result[0].totalCharge*0.02);
			$('#afterAmount').text(totalLate.toLocaleString('ko-KR'));
		}
	});
}

getChargeInfo();
let totalCharge = Number($('#totalCharge').text().replace('원', '').replace(',', ''));
let lateFee = Number($('#lateFee').text().replace('원', '').replace(',', ''));

let totalLate = totalCharge + lateFee;

$("#afterAmount").text(totalLate.toLocaleString('ko-KR'));

$('#monthDetail').on('click', function(){
	if($(this).text() == '월별 관리비 조회 닫기'){
		$(this).text('월별 관리비 조회 열기');
		$(this).removeClass('btn-outline-info');
		$(this).addClass('btn-info');
	}else{
		$(this).text('월별 관리비 조회 닫기');
		$(this).removeClass('btn-info');
		$(this).addClass('btn-outline-info');
	}
})

$('#lastYear').on('click', function() {
	let year = Number($('#year').text());
	year -= 1;
	$('#year').text(year);

	getChargeInfo();
})

$('#postYear').on('click', function() {
	let year = Number($('#year').text());
	year += 1;
	$('#year').text(year);

	getChargeInfo();
})

$('.showDetail').on('click', function(){
	if($(this).parent().parent().children().eq(0).children().eq(0).text() == '+'){
		$(this).parent().parent().children().eq(0).children().eq(0).text('-');
	}else{
		$(this).parent().parent().children().eq(0).children().eq(0).text('+');
	}
		
})

function getChargeInfo() {
	let year = $('#year').text();
	let roomCode = $('#roomCode').text();

	let data = {
		roomCode: roomCode,
		year : year
	}

	$.ajax({
		url : '/charge/getInfo',
		contentType : "application/json;charset=utf-8",
		data : JSON.stringify(data),
		type : 'post',
		beforeSend : function(xhr) {
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success : function(result) {
			console.log("result: ", result);

			$(".charge").text(0);

			$.each(result, function(idx, chargeItemVO) {
				$('#commons' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.commons.toLocaleString('ko-KR'));
				$('#salary' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.salary.toLocaleString('ko-KR'));
				$('#allowance' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.allowance.toLocaleString('ko-KR'));
				$('#bonus' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.bonus.toLocaleString('ko-KR'));
				$('#rtrPay' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.rtrPay.toLocaleString('ko-KR'));
				$('#iacIns' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.iacIns.toLocaleString('ko-KR'));
				$('#empIns' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.empIns.toLocaleString('ko-KR'));
				$('#npn' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.npn.toLocaleString('ko-KR'));
				$('#hlthIns' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.hlthIns.toLocaleString('ko-KR'));
				$('#benefits' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.benefits.toLocaleString('ko-KR'));
				$('#oprodCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.oprodCt.toLocaleString('ko-KR'));
				$('#printCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.printCt.toLocaleString('ko-KR'));
				$('#tsptCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.tsptCt.toLocaleString('ko-KR'));
				$('#commCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.commCt.toLocaleString('ko-KR'));
				$('#postCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.postCt.toLocaleString('ko-KR'));
				$('#cprodCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.cprodCt.toLocaleString('ko-KR'));
				$('#etcCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.etcCt.toLocaleString('ko-KR'));
				$('#facCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.facCt.toLocaleString('ko-KR'));
				$('#commonsOtherCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.commonsOtherCt.toLocaleString('ko-KR'));

				$('#cleaning' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.cleaning.toLocaleString('ko-KR'));
				$('#clnSvcCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.clnSvcCt.toLocaleString('ko-KR'));
				$('#expendableCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.expendableCt.toLocaleString('ko-KR'));
				$('#wasteCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.wasteCt.toLocaleString('ko-KR'));
				$('#cleaningOtherCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.cleaningOtherCt.toLocaleString('ko-KR'));

				$('#disinfec' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.disinfec.toLocaleString('ko-KR'));
				$('#disinfecCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.disinfecCt.toLocaleString('ko-KR'));
				$('#disinfecOtherCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.disinfecOtherCt.toLocaleString('ko-KR'));

				$('#secure' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.secure.toLocaleString('ko-KR'));
				$('#secCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.secCt.toLocaleString('ko-KR'));
				$('#secOtherCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.secOtherCt.toLocaleString('ko-KR'));

				$('#elevator' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.elevator.toLocaleString('ko-KR'));
				$('#evtMgmtCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.evtMgmtCt.toLocaleString('ko-KR'));
				$('#evtInspCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.evtInspCt.toLocaleString('ko-KR'));
				$('#evtExpendableCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.evtExpendableCt.toLocaleString('ko-KR'));
				$('#evtOtherCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.evtOtherCt.toLocaleString('ko-KR'));

				$('#ltrr' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.ltrr.toLocaleString('ko-KR'));
				$('#ltrrCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.ltrrCt.toLocaleString('ko-KR'));
				$('#ltrrOtherCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.ltrrOtherCt.toLocaleString('ko-KR'));

				$('#facilities' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.facilities.toLocaleString('ko-KR'));
				$('#facilityMgmtCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.facilityMgmtCt.toLocaleString('ko-KR'));
				$('#facilityChkCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.facilityChkCt.toLocaleString('ko-KR'));
				$('#preventCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.preventCt.toLocaleString('ko-KR'));
				$('#facilitiesOtherCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.facilitiesOtherCt.toLocaleString('ko-KR'));

				$('#vat' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.vat.toLocaleString('ko-KR'));
				$('#msvcCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.msvcCt.toLocaleString('ko-KR'));
				$('#csvcCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.csvcCt.toLocaleString('ko-KR'));
				$('#ssvcCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.ssvcCt.toLocaleString('ko-KR'));
				$('#vatOtherCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.vatOtherCt.toLocaleString('ko-KR'));

				$('#consignment' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.consignment.toLocaleString('ko-KR'));
				$('#consignmentCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.consignmentCt.toLocaleString('ko-KR'));
				$('#consignmentOtherCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.consignmentOtherCt.toLocaleString('ko-KR'));

				$('#meeting' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.meeting.toLocaleString('ko-KR'));
				$('#cbCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.cbCt.toLocaleString('ko-KR'));
				$('#abCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.abCt.toLocaleString('ko-KR'));
				$('#attdcCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.attdcCt.toLocaleString('ko-KR'));
				$('#operationCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.operationCt.toLocaleString('ko-KR'));
				$('#meetingOtherCt' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.meetingOtherCt.toLocaleString('ko-KR'));

				$('#building' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.buildingInsr.toLocaleString('ko-KR'));
				$('#buildingInsr' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.buildingInsr.toLocaleString('ko-KR'));

				$('#electrocity' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.electrocity.toLocaleString('ko-KR'));
				$('#sharedElec' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.sharedElec.toLocaleString('ko-KR'));
				$('#individualElec' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.individualElec.toLocaleString('ko-KR'));

				$('#water' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.water.toLocaleString('ko-KR'));
				$('#sharedWater' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.sharedWater.toLocaleString('ko-KR'));
				$('#individualWater' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.individualWater.toLocaleString('ko-KR'));

				$('#heating' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.heating.toLocaleString('ko-KR'));
				$('#sharedHeating' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.sharedHeating.toLocaleString('ko-KR'));
				$('#individualHeating' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.individualHeating.toLocaleString('ko-KR'));
				
				$('#total' + chargeItemVO.ym.substr(5, 2)).text(chargeItemVO.totalCharge.toLocaleString('ko-KR'));
			});
			newBarChart();
		}
	})
}

function getDoughnutColor(){
	let percent = Math.round($("#percent").text() / 2);
	console.log(percent);
	let backgroundColors = [];

	for(let i=0; i<30; i++){
		let red = i*7;
		let green = 150+i*3;
		let blue = i;
		
		percent--;
		if(percent == 0){
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+0+', '+0+', '+0+', 1)');
		}else{
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
		}
	}
	for(let i=0; i<20; i++){
		let red = 210+i*2;
		let green = 240+i*2;
		let blue = 30+i;
		
		percent--;
		if(percent == 0){
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+0+', '+0+', '+0+', 1)');
		}else{
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
		}
	}
	for(let i=0; i<20; i++){
		let red = 240;
		let green = 280-i*2;
		let blue = 50-i;
		
		percent--;
		if(percent == 0){
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+0+', '+0+', '+0+', 1)');
		}else{
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
		}
	}
	for(let i=0; i<30; i++){
		let red = 240;
		let green = 240-i*7;
		let blue = 20-i;
		
		percent--;
		if(percent == 0){
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+0+', '+0+', '+0+', 1)');
		}else{
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
			backgroundColors.push('rgba('+red+', '+green+', '+blue+', 1)');
		}
	}


	return backgroundColors;
}
   
function getDoughnutLabel(){
	let data = [];
	for(let i=0; i<200; i++){
		data.push(i);
	}
	return data;
}
   
function getDoughnutData(){
	let data = [];
	for(let i=0; i<200; i++){
		data.push(1);
	}
	return data;
}

function percentDisp(){
	let percent = $('#percent').text();
	let str1 = '평균 대비 ';
	let str2 = '';
	if(percent > 100){
		str1 += (Number(percent)-100) + '%';
		str2 += '<span style="color: red;">많이 </span> 사용했습니다.';
	}else{
		str1 += (100 - Number(percent)) + '%';
		str2 += '<span style="color: blue;">적게 </span> 사용했습니다.';
	}
	
	$('#percentDisp1').html(str1);
	$('#percentDisp2').html(str2);
}
percentDisp();




function newBarChart(){
	
	let chartStatus = Chart.getChart('barChart');
	if (chartStatus !== undefined) {
		chartStatus.destroy();
	}
	
	new Chart(barChart, {
	    type: 'bar',
	    data: {
	        labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        datasets: getBarDatasets(),
	    },
	    options: {
			responsive: false,
			plugins:{
				legend:{
					position: 'left'
				},
			},
	        scales: {
	            x: {
	            	stacked: true, 
	            },
		        y: {
		        	stacked: true, 
		            beginAtZero: true
		        }
	        },
	    },
	});
}
	
function getBarDatasets(){

	let datasets = [];
	
	let engId = ['commons', 'cleaning', 'disinfec', 'secure', 'elevator', 'ltrr', 'facilities', 'vat', 'consignment', 'meeting', 'building', 'electrocity', 'water', 'heating'];
	let korId = ['일반관리비', '청소비', '소독비', '경비비', '승강기유지비', '장기수선충당금', '시설유지비', '부가세', '위탁관리수수료', '대표회의운영비', '건물보험료', '전기료', '수도료', '난방료'];
	let colors = ['rgba(255, 99, 132, 0.5)', 'rgba(54, 162, 235, 0.5)', 'rgba(255, 206, 86, 0.5)', 'rgba(75, 192, 192, 0.5)', 'rgba(153, 102, 255, 0.5)', 'rgba(255, 159, 64, 0.5)', 'rgba(178, 255, 192, 0.5)',
				'rgba(92, 255, 213, 0.5)', 'rgba(235, 235, 0, 0.5)', 'rgba(0, 255, 235, 0.5)', 'rgba(255, 0, 235, 0.5)', 'rgba(123, 123, 123, 0.5)', 'rgba(194, 980, 73, 0.5)', 'rgba(100, 46, 200, 0.5)'];
	
	for(let i=0; i<14; i++){
		let data = [];
		for(let j=1; j<=12; j++){
			let idx;
			if(j<10){
				idx = '0'+j;
			}else{
				idx = j;
			}
			data.push(Number($("#"+engId[i]+idx).text().replace(',', '')));
		}
		
		let dataset = {
				label: korId[i],
				data: data,
				backgroundColor: colors[i], 
				borderWidth:1
		};
		datasets.push(dataset);
	}
	
	return datasets;
}


$(function(){
	const doughnut = document.querySelector('#doughnut');
	const barChart = document.querySelector('#barChart');

	new Chart(doughnut, {
		type: 'doughnut',
		data: {

			labels: getDoughnutLabel(),
			datasets:[{
				backgroundColor: getDoughnutColor(), 
				data: getDoughnutData()
			}]
		},

		options: {
			responsive: false,
			plugins:{
				legend: {
					display: false,
				},
				tooltip:{
					enabled: false
				}
			},
			rotation: -90,
			circumference: 180,
			borderWidth: 0,
		}
	});
	
	newBarChart();
});

$("#btnPay").on('click', async function(){

	data = {
			roomCode: $('#roomCode').text(),
			ym: $('#ym').text()
	}
	
	let payYn = 'N';
	$.ajax({
		url: "/charge/getPayYN",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post", 
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		async: false,
		success: function(result){
			console.log(result);
			if(result == 'Y'){
				payYn = 'Y';
				Swal.fire({
	                icon: 'error',
	                title: '에러!',
	                text: '이미 결제하였습니다.'
	            });
			}
		}
	});
	
	console.log("payYn: ", payYn);
	
	if(payYn == 'Y'){
		return;
	}
	console.log(">>>>", $('#totalCharge').text().replace(',', ''));
	const response = await PortOne.requestPayment({
		// Store ID 설정
		storeId: "store-22c2becf-63f0-4f4d-98fb-6a665ab06ca7",
		// 채널 키 설정
		channelKey: "channel-key-23a08f82-f8a6-4029-86cd-befb632c7108",
// 		paymentId: $('#roomCode').text() + '_' + $('#ym').text(),
		paymentId: crypto.randomUUID(),
		orderName: $('#ym').text()+' 관리비',
		totalAmount: Number($('#totalCharge').text().replace(',', '')),
		currency: "CURRENCY_KRW",
		payMethod: "CARD",
		customer:{
			customerId: $('#memId').text(),
			fullName: $('#memNm').text(),
			phoneNumber: $('#memTelno').text(),
			email: $('#memEmail').text(),
		},
	});

	if (response.code != null) {
		return alert(response.message);
	}
	
	$.ajax({
		url: "/charge/paySuccess",
		contentType: "application/json;charset=utf-8",
		data: JSON.stringify(data),
		type: "post", 
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success: function(result){
			console.log(result);
		}
	})
});

</script>