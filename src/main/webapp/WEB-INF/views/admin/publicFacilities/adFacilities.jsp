<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>


<!-- 스위트 알러트 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<!--datatable css-->
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
<!--datatable responsive css-->
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">


<!--datatable js-->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>


<script src="/resources/js/calll.js"></script>
<script src="/resources/js/jquery.min.js"></script>


<style>
table, td, th {
  border-bottom : 1px solid black;
  border-collapse : collapse;
}
th, td {
  text-align: center;
  font-size: 16px;
  font-family:"trana";
  font-weight: 400;
  font-style: normal;
}
thead{
 background-color:  #e9f7ff;
}
th{
  font-weight: bold;
}
table {
    border: 1px solid gray;
}
#titt {
	border: 2px solid black;
}
#tennisImg {
	width: 50%;
	height: 100%;
}
.contt {
	border: 1px solid #acacac;
	width: 48%;
	height: 450px;
	flex: 1;
	border-radius: 5px; 
}
#now {
	border: 2px solid white;
	text-align: center;
	border-radius: 5px;
	background-color: pink;
	font-size: 18px;
}
#boardd {
	border: 2px solid black;
	text-align: center;
}
#mBtn {
	float: right;
	width: 95px;
	height: 35px;
	font-weight: bold;
}
p {
	margin-top: -6px;
}
pre {
	white-space: pre-wrap;
}
/* 설명 */
.menu_bar {
	display: flex;
	background-color: white;
	flex-direction: column;
	border: 0px solid white;
	width: 50%;
	float: inline-end;
	margin-top: 14%;
    height: 337px;
}
#con {
	width: 48%;
	height: 450px;
	flex: 1;
	margin-left: 10px;
	background-color: #f5f5f5;
    border: 1px solid #acacac;
    border-radius: 5px;
}
.oneset {
	border: 1px solid #dfdfdf;
	float: left;
	width: 259px;
	height: 450px;
}
/*테니스*/
.cott {
	border: 2px solid white;
	float: left;
	width: 38%;
	height: 150px;
	margin: 43px 14px 15px 14px;
	background-color: green;
	font-size: 18px;
	padding-left: 5px;
	color: white;
}
.flex-container {
	display: flex;
	justify-content: space-between;
}
/* 스크린골프 */
#container {
    border: 1px solid #aaaaaa;
    border-radius: 5px;
	width: 48%;
	flex: 1;
	height: 450px;
	margin-left: 10px;
}
.room {
	border: 2px solid rgb(255, 255, 255);
	width: 120px;
	height: 200px;
	background-color: rgb(81, 180, 89);
	margin: 0px 19px 44px 16px;
	float: left;
	font-size: 18px;
	padding-left: 5px;
	color: white;
}
/* 독서실 */
#container2 {
    border: 1px solid #aaaaaa;
    border-radius: 5px;
	width: 48%;
	flex: 1;
	height: 450px;
	margin-left: 10px;
}
.Sroom {
	border: 2px solid rgb(255, 255, 255);
	width: 100px;
	height: 80px;
	background-color: rgb(185, 198, 255);
	margin: 4px 22px 35px 31px;
	float: left;
	font-size: 18px;
	padding-left: 5px;
	color: black;
}
.memNmATag {
    margin-left: 11px;
    color: white;
    font-size: 18px;
    font-weight: bold;
}
</style>

<script>

$(document).ready(function () {

    // 초기 로드 시 첫 번째 시설 정보 로드
    loadFacilityData("facility01");
    liveRe("facility01");
    
    // setInterval(liveRe, 3000); 

    $(".nav-link").on('click', function() {
        let facCode = $(this).children().eq(1).val();
        console.log("facCode: ", facCode);
        liveRe(facCode);
        loadFacilityData(facCode);
    });

    $(document).on('click', '.cott a, .room a, .Sroom a', function (event) {
        event.preventDefault();
        console.log(this)
		let reserveSeq = $(this).data('reserveSeq');
        console.log(reserveSeq)
        
        let data = {
        	"reserveSeq":reserveSeq
        }
            $.ajax({
		        url: "/reDetail",
		        contentType: "application/json;charset=utf-8",
		        data: JSON.stringify(data),
		        type: "post",
		        dataType: "json",
		        beforeSend: function (xhr) {
		            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		        },
		        success: function (result) {
			        console.log("detail >> ", result);
			        
			    	let memTel = result.memberVOList[0].memTelno.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})(\d+)(\d{4})$/, "$1-$2-$3").replace("--", "-");
					console.log("memTel: ", memTel);
			        
                    $("#modalTitle").html(result.reserveSeq);
                    $("#modalMemNm").html(result.memberVOList[0].memNm);
                    $("#modalMemTelNo").html(memTel);
                    $("#modalRoomCode").html(result.memberVOList[0].roomCode);
                    $("#modalNop").html(result.nop + "명");
                    $("#modalBeginTm").html(result.beginTm);
                    $("#modalEndTm").html(result.endTm);
		        }
        
		    });
        
        $('#modal1').modal('show');
    });

});


function loadFacilityData(facCode) {
    let data = { "facCode": facCode };

    $.ajax({
        url: "/public/admin/getInfo",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function (result) {
            console.log("result: ", result);

            if (result) {
                // 시설 정보 업데이트
                let infoHtml = "";
                infoHtml += "<div class='card ribbon-box border shadow-none material-shadow col-12' style='height: 446px;margin-top: -109px;'>";
                infoHtml += "<div class='card-body'>";
                infoHtml += "<div class='ribbon ribbon-info round-shape' style='font-size:18px;'>시설 정보</div>";
                infoHtml += '<div class="ribbon-content mt-4" style="font-size:16px;"><br>';
                infoHtml += '<p class="mb-0">'+ result.facLoc+ '</p><hr><br>';
                infoHtml += '<pre style="line-height: 35px;">'+ result.facCom+ '</pre><br>';
                infoHtml += '<p>관리자 &nbsp;:&nbsp;'+ result.facTelno+ '</p>';
                infoHtml += '</div></div></div>';
               

                $(".menu_bar").html(infoHtml);

                // 예약 정보 업데이트
                let reserveHtml = "";
                if (result.reserveVOList && result.reserveVOList.length > 0) {
                    result.reserveVOList.forEach(function (reserve) {
                        reserveHtml += "<tr>";
                        reserveHtml += "<td>" + reserve.memId + "</td>";
                        reserveHtml += "<td>" + reserve.reserveSeq + "</td>";
                        reserveHtml += "<td>" + reserve.regDt + "</td>";
                        reserveHtml += "<td>" + reserve.beginTm + " ~ " + reserve.endTm + " <b>(" + reserve.useTime + ")</b></td>";
                        reserveHtml += "<td>" + reserve.seat + "</td>";
                        reserveHtml += "<td>" + reserve.nop + "</td>";
                        reserveHtml += "<td>" + reserve.cancleYn + "</td>";
                        reserveHtml += "<td>" + (reserve.cancleDt ? reserve.cancleDt : "-") + "</td>";
                        reserveHtml += "</tr>";
                    });
                } else {
                    reserveHtml = "<tr><td colspan='10' style='vertical-align: middle; text-align: center;'>예약이 없습니다.</td></tr>";
                }
                $(".trShow").html(reserveHtml);
            }
        },
        error: function (err) {
            console.error("Error: ", err);
        }
    });
}

function liveRe(facCode) {
    let data = { "facCode": facCode };

    console.log("..?>>>>>>", data);

    $.ajax({
        url: "/public/tennis/liveReAjax",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {

            if (result[0].facCode === 'facility01') {
                console.log("1111111111111111");
                $(".cott").css("backgroundColor", "green");

                const now = new Date();
                result.forEach(reservation => {
                    const endTime = new Date(reservation.endTm);
                    $(".cott").each(function() {
                    	if ($(this).children("b").eq(0).html()  === reservation.seat && now < endTime) {
                            $(this).css("backgroundColor", "gray");
                            $(this).html("<b>"+$(this).children("b").eq(0).html()  + "</b><br><br><a class='memNmATag' href='#modal1' rel='modal:open' data-reserve-seq='" + reservation.reserveSeq + "'>" + reservation.memberVOList[0].memNm + "</a>");
 
                        }
                    });
                });
                // 실시간 예약 개수 업데이트
                $("#liveCount1").text(result.length);
                
            } else if (result[0].facCode === 'facility02') {
                console.log("22222222222222222");
                $(".room").css("backgroundColor", "rgb(81, 180, 89)");

                const now = new Date();
                result.forEach(reservation => {
                    const endTime = new Date(reservation.endTm);
                    $(".room").each(function() {
                    	if ($(this).children("b").eq(0).html()  === reservation.seat && now < endTime) {
                            $(this).css("backgroundColor", "gray");
                            $(this).html("<b>"+$(this).children("b").eq(0).html()  + "</b><br><br><a class='memNmATag' href='#modal1' rel='modal:open' data-reserve-seq='" + reservation.reserveSeq + "'>" + reservation.memberVOList[0].memNm + "</a>");
                        }
                    });
                });
                // 실시간 예약 개수 업데이트
                $("#liveCount2").text(result.length);
                
            } else if (result[0].facCode === 'facility03') {
                console.log("3333333333333333333");
                $(".Sroom").css("backgroundColor", "rgb(185, 198, 255)");

                const now = new Date();
                result.forEach(reservation => {
                    const endTime = new Date(reservation.endTm);
                    $(".Sroom").each(function() {
                    	console.log("독서실1 : " + $(this).children("b").eq(0).html() + " vs 독서실2 : " + reservation.seat);
                        if ($(this).children("b").eq(0).html()  === reservation.seat && now < endTime) {
                            $(this).css("backgroundColor", "gray");
                            $(this).html("<b>"+$(this).children("b").eq(0).html()  + "</b><br><br><a class='memNmATag' href='#modal1' rel='modal:open' data-reserve-seq='" + reservation.reserveSeq + "'>" + reservation.memberVOList[0].memNm + "</a>");
                        }
                    });
                });

                // 실시간 예약 개수 업데이트
                $("#liveCount3").text(result.length);
            }
            
        },
        error: function(err) {
            console.error("Error: ", err.status, "statusText: ", err.statusText, "responseText: ", err.responseText);
        }
    });
}
</script>



<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="las la-dove"></i><strong>실시간 사용현황</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">공동시설물</a></li>
						<li class="breadcrumb-item active">실시간 사용 현황</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>



<div class="col-12">
	<div class="card">

		<div class="col" style="font-size: 16px;">
			<div class="nav nav-pills flex-row nav-pills-tab custom-horiz-nav-pills justify-content-start text-center"
				role="tablist" aria-orientation="horizontal">
				
				<a class="nav-link show active" id="custom-h-pills-home-tab"
					data-bs-toggle="pill" href="#tennis" role="tab"
					aria-controls="custom-h-pills-home" aria-selected="true"> <i
					class="mdi mdi-tennis nav-icon nav-tab-position"></i> 테니스장
					 <input type="hidden" value="facility01">
				</a> 
				<a class="nav-link" id="custom-h-pills-profile-tab"
					data-bs-toggle="pill" href="#golf" role="tab"
					aria-controls="custom-h-pills-profile" aria-selected="false"
					tabindex="-1"> <i class="mdi mdi-golf nav-icon nav-tab-position"></i>
					스크린골프
					 <input type="hidden" value="facility02">
				</a> 
				<a class="nav-link" id="custom-h-pills-messages-tab"
					data-bs-toggle="pill"  href="#studyRoom" role="tab"
					aria-controls="custom-h-pills-messages" aria-selected="false"
					tabindex="-1" style="width: 120px;"> <i  class="mdi mdi-book-open-page-variant-outline nav-icon nav-tab-position"></i>
					독서실
					 <input type="hidden" value="facility03">
				</a>
			
			</div>
		</div>

<hr style="margin-top: 3px;color: #b9b9b9;">

		<div class="card-header ">


			<!-- 테니스  -------------------------------------------------------->
			<div class="tab-content">

				<div class="active tab-pane" id="tennis">
					<div class="col-12 bobb">
						<div class="flex-container">
							<div class="contt">
								<img id="tennisImg" src="/resources/images/테니.jpg">
								<div class="menu_bar">
										<!-- 아작스 -->
								</div>                                
							</div>
							<div id="con">
								<div class="oneset">
									<div class="cott"><b>1</b></div>
									<div class="cott"><b>2</b></div>
									<br> <br> <br> <br> <br>
									<div class="cott"><b>3</b></div>
								</div>
								<div class="oneset">
									<div class="cott"><b>4</b></div>
									<div class="cott"><b>5</b></div>
									<br> <br> <br> <br> <br>
									<div class="cott"><b>6</b></div>
								</div>
								<div class="oneset">
									<div class="cott"><b>7</b></div>
									<div class="cott"><b>8</b></div>
									<br> <br> <br> <br> <br>
									<div class="cott"><b>9</b></div>
								</div>
							</div>


						</div>

					</div>
					<br/><br/>

					<div class="card-body  table-responsive p-0">
						<div id="now" style="float: left;font-size: 17px;" class="col-12">
							실시간 이용현황&nbsp;(<span id="liveCount1"></span>팀)
						</div>
						<br>
						<br />
						<h5>&lt;오늘의 예약현황&gt;</h5>
						<table class="table table-hover text-nowrap">
							<thead>
								<tr>
									<th>회원ID</th>
									<th>예약일련번호</th>
									<th>신청일</th>
									<th>사용시간</th>
									<th>자리</th>
									<th>인원</th>
									<th>취소현황</th>
									<th>취소일시</th>
								</tr>
							</thead>
							<tbody class="trShow">

							</tbody>
						</table>
					</div>
				</div>


				<!-- 스크린골프  -------------------------------------------------------->

				<div class="tab-pane" id="golf">
					<div class="col-12 bobb">
						<div class="flex-container">
							<div class="contt">
								<img id="tennisImg" src="/resources/images/스크린골프.jpg">
								<div class="menu_bar">
			
								</div>
							</div>
							<div id="container">
								<c:forEach var="i" begin="1" end="10">
									<div class="room"><b>${i}</b></div>   
								</c:forEach>
							</div>

						</div>
					</div>
					<br/><br/>

					<div class="card-body  table-responsive p-0">
						<div id="now" style="float: left;font-size: 17px;" class="col-12">
							실시간 이용현황&nbsp;(<span id="liveCount2"></span>팀)
						</div>
						<br />
						<br />
						<h5>&lt;오늘의 예약현황&gt;</h5>
						<table class="table table-hover text-nowrap">
							<thead>
								<tr>
									<th>회원ID</th>
									<th>예약일련번호</th>
									<th>신청일</th>
									<th>사용시간</th>
									<th>자리</th>
									<th>인원</th>
									<th>취소현황</th>
									<th>취소일시</th>
								</tr>
							</thead>
							<tbody class="trShow">

							</tbody>
						</table>
					</div>

				</div>


				<!-- 독서실  -------------------------------------------------------->

				<div class="tab-pane" id="studyRoom">
					<div class="col-12 bobb">
						<div class="flex-container">
							<div class="contt">
								<img id="tennisImg" src="/resources/images/독서실.jpg">
								<div class="menu_bar">
						
								</div>
							</div>
							<div id="container2">
								<c:forEach var="i" begin="1" end="20">
									<div class="Sroom"><b>${i}</b></div>   
								</c:forEach>
							</div>
						</div>
					</div>
					<br />
					<br />
					<div class="card-body  table-responsive p-0">
						<div id="now" style="float: left;font-size: 17px;" class="col-12">
							실시간 이용현황&nbsp;(<span id="liveCount3">0</span>팀)
						</div>
						<br />
						<br />
						<h5>&lt;오늘의 예약현황&gt;</h5>
						<table class="table table-hover text-nowrap">
							<thead>
								<tr>
									<th>회원ID</th>
									<th>예약일련번호</th>
									<th>신청일</th>
									<th>사용시간</th>
									<th>자리</th>
									<th>인원</th>
									<th>취소현황</th>
									<th>취소일시</th>
								</tr>
							</thead>
							<tbody class="trShow">

							</tbody>
						</table>
					</div>
				</div>

		<div class="modal fade bd-example-modal-sm" id="modal1"
				tabindex="-1" aria-labelledby="detailModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-50size modal-center">
					<div class="modal-content">
						<div class="modal-header">
							<h3 class="modal-title" id="modalTitle"></h3>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body" style="font-size: 16px;">
							<div id="dd">
								<p>
									<strong>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름 </strong>&nbsp;:&nbsp; <span id="modalMemNm"></span>
								</p>
								<p>
									<strong>전화번호</strong>&nbsp;:&nbsp;  <span id="modalMemTelNo"></span>
								</p>
								<p>
									<strong>동_호수&nbsp;</strong>&nbsp;:&nbsp;  <span id="modalRoomCode"></span>
								</p>
								<p>
									<strong>인&nbsp;&nbsp;원&nbsp;&nbsp;수&nbsp;</strong>&nbsp;:&nbsp;  <span id="modalNop"></span>
								</p>
								<p>
									<strong>사용 시작</strong>&nbsp;:&nbsp;  <span id="modalBeginTm"></span>
								</p>
								<p>
									<strong>사용 종료</strong>&nbsp;:&nbsp;  <span id="modalEndTm"></span>
								</p>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
			</div>
		</div>

	</div>
</div>




