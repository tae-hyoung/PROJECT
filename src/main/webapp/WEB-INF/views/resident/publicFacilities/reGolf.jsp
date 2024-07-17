<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
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

<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="/resources/js/calll.js"></script>
<script src="/resources/js/jquery.min.js"></script>
	

<style>
#todayBtn, #prevWeek, #nextWeek {
	background-color: #add8e6;
}
#DataTables_Table_0_paginate {
    margin: 13px 197px;
    white-space: nowrap;
    width: 20px;
}
#tennisImg {
	width: 50%;
	height: 100%;
}
#contt {
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

#mBtn {
    width: 99px;
    height: 40px;
    font-weight: bold;
    margin-left: 1487px;
    margin-bottom: 5px;
    font-size: 16px;
}
p{
	margin-top: -6px;
}
#timetable {
	border: 2px solid #d2d2d2;
	border-collapse: collapse;
	font-size: 0.9em;
    width: 476px;
    margin-top: -3px;
    margin-left: -6px;
    margin-bottom: -2px;
    position: absolute;
}
.past {
  background-color: #fff5ea;
  pointer-events: none;
  cursor: not-allowed;
}

#timetable th, #timetable td {
	border: 1px solid #d2d2d2;
	border-collapse: collapse;
}

#timetable th {
	height: 5px;
	padding: 3px;
}

#timetable td {
	width: 75px;
	padding: 3px;
}
.gray {
	background-color: gray;
}
.ligthgray {
	background-color: #bebebe;
	pointer-events: none
}
.lightblue {
	background-color: #ADD8E6;
}
/* 예약하기 버튼 스타일 */
pre {
	white-space: pre-wrap;
}
/* 설명 */
.menu_bar {
	background-color: white;
    border: 0px solid white;
    width: 50%;
    float: inline-end;
    margin-top: 1px;
    margin-left: -12px;
    height: 437px;
}

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
/* 스크린골프 */
#container {
    border: 1px solid #aaaaaa;
    border-radius: 5px;
	width: 48%;
	flex: 1;
	height: 450px;
	margin-left: 10px;
}
.nav {
    border-radius: 5px;
    justify-content: center;
    width: 182px;
}
.go-today {
    width: 75px;
    border-left: 1px solid #333333;
    border-right: 1px solid #333333;
}
.nav-btn {
	ont-family: 'Poppins';
    width: 56px;
    height: 30px;
    border: none;
    font-size: 14px;
    line-height: 29px;
}
#ym {
    float: left;
    margin-left: 19px;
    font-size: 26px;
    margin-right: -78px;
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

.flex-container {
	display: flex;
	justify-content: space-between;
}
#reAbl{
	border: 1px solid;
	width: 13px;
	height: 13px;
    margin-top: 7px;
}
#reAbl1{
	border: 1px solid;
	width: 20px;
	height: 20px;
	background-color:  gray
}
#reunAbl{
	border: 1px solid;
	width: 13px;
	height: 13px;
	background-color:  #bebebe
}
#DataTables_Table_0_length {
	display: none;
}
#DataTables_Table_0_info {
	display: none;
}
#timetableModal {
	padding-right:  221px !important;
}
#seat {
	margin-left: -3px;
    width: 129px;
    height: 29px;
}
#todayBtn, #prevWeek, #nextWeek{
	background-color: #dff3ff;
	border: 1px solid #add8e6;
	font-weight: bold;
}
.btn-jelly:hover {
  animation: jelly 0.5s;
}
@keyframes jelly {
  25% {
    transform: scale(0.9, 1.1);
  }
  50% {
    transform: scale(1.1, 0.9);
  }
  75% {
    transform: scale(0.95, 1.05);
  }
}
</style>

<script>
document.addEventListener('DOMContentLoaded', function() {
	let table = new DataTable('.tt', {
		"searching" : false,
		"paging" : true,
		"ordering" : false,
		 "language": {
	            "zeroRecords": "예약 내역이 없습니다.",
	            "paginate": {
	                "next": "다음",
	                "previous": "이전"
	            },
		  }
	});

});

function liveRe() {
    let facCode = $("#inputFC").val();
    console.log("Facility Code:", facCode);

    let data = {
        "facCode": facCode
    };
    
    console.log("Sending data:", data);
    
    $.ajax({
        url: "/public/tennis/liveReAjax",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        dataType: "json",
        beforeSend: function (xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function (result) {
            console.log("Success - result: ", result);

            // 모든 좌석을 초록색으로 초기화
            $(".room").css("backgroundColor", "rgb(81, 180, 89)");

            // 예약된 좌석을 회색으로 설정
            const now = new Date();
            result.forEach(reservation => {
                const endTime = new Date(reservation.endTm);
                const beginTime = new Date(reservation.beginTm);
                $(".room").each(function () {
                    if ($(this).text().trim() === reservation.seat && now < endTime ) {
                        $(this).css("backgroundColor", "gray");
                    }
                });
            });

            // 실시간 예약 개수 업데이트
            $("#liveCount").text(result.length);
        },
        error: function (err) {
            console.error("Error: ", err.status, "statusText: ", err.statusText, "responseText: ", err.responseText);
        }
    });
}

function updateButtonStates() {
    const now = new Date();
    console.log(now);

    $("#trShow tr").each(function() {
        const beginTm = new Date($(this).find(".beginTm").text().trim().substr(0,16));
        console.log("어디야 : " , beginTm);

        if (beginTm < now) {
            $(this).find(".cancle").removeClass("btn btn-primary").addClass("btn btn-dark waves-effect").text("사용 완료").prop("disabled", true);
        }
    });
}

$(document).ready(function () {
    liveRe();
    
    setInterval(liveRe, 5000); 

    updateButtonStates();

    let selectedSeat = ""; // 선택한 좌석을 저장할 변수

    // 선택한 좌석이 변경될 때마다 호출될 함수
  function updateTimetable() {
        let facCode = $("#inputFC").val();
        console.log("Selected Seat:", selectedSeat);

        if (selectedSeat === "") {
            $("#timetable td").prop("disabled", true);
            return;
        }

        let data = {
            "seat": selectedSeat,
            "facCode": facCode
        };

        $.ajax({
            url: "/public/tennis/blockReAjax",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                $("#timetable td").removeClass("ligthgray");

                result.forEach(function(item) {
                    let day = item.beginTm.substr(0, 10);
                    let beTime = item.beginTm.substr(11, 5);
                    let endTime = item.endTm.substr(11, 5);

                    console.log("예약 : ", item.beginTm, day, beTime, endTime);

                    $(".dayy").each(function(index) {
                        let dayy = $(this).text().trim();

                        $("#timetable tbody tr").each(function() {
                            let time = $(this).find(".time").text().trim();
                            let cell = $(this).find("td").eq(index);

                            if (day === dayy && time >= beTime && time < endTime && !cell.hasClass("past")) {
                                cell.addClass("ligthgray");
                            }
                        });
                    });
                });

                $("#timetable td").prop("disabled", false);
            },
            error: function(err) {
                console.log("Error : ", err);
            }
        });
    }

    // 좌석 선택이 변경될 때의 이벤트 처리
    $('#seat').on('change', function () {
        selectedSeat = $(this).val(); // 선택한 좌석 값 업데이트
        console.log("선택한 좌석:", selectedSeat);

        // 좌석 선택 후 바로 시간표 업데이트
        updateTimetable();
    });
    
    $("#timetable td").prop("disabled", true);


    // 주간 변경 버튼 클릭 이벤트 처리
    $("#nextWeek, #prevWeek").on("click", function () {
        // 주간 변경 시 시간표 업데이트
        updateTimetable();
    });

    // 예약 버튼 클릭 이벤트 처리
	$("#reserveFrm").submit(function(e) {
		e.preventDefault();	 
        console.log(">>>>>>>>>2", data);

        let facCode = $("#inputFC").val();
        console.log(">>>>", facCode);
        let memId = $("#memId").text();
        console.log(">>>>", memId);

        data.facCode = facCode;
        data.memId = memId;
        console.log(">>>>>>>>>>>>>>>>>", data);

        
        var reservationMessage = "예약일 : " + data.regDt + "<br>시작 시간 : " + data.beginTm + 
						        "<br>종료 시간 : " + data.endTm + "<br>선택한 자리 : " + data.seat + "번 코트" +
						        "<br>인원수 : " + data.nop + "명<br>예약을 진행하시겠습니까?";

		Swal.fire({
			title: "예약 정보를 확인해주세요!",
			icon: "info",
			html : reservationMessage,
			showCancelButton: true,
			confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
			cancelButtonClass: 'btn btn-danger w-xs mt-2',
			confirmButtonText: "예",
			cancelButtonText: "아니오",
			buttonsStyling: false,
			showCloseButton: true
		}).then(function (result) {
			if (result.value) {
	            $.ajax({
	                url: "/public/tennis/reservationAjax",
	                contentType: "application/json;charset=utf-8",
	                data: JSON.stringify(data),
	                type: "post",
	                dataType: "json",
	                beforeSend: function (xhr) {
	                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                },
	                success: function (result) {
	                    console.log("result :", result);
	
	                    Swal.fire({
	                          title: "예약이 정상적으로 완료되었습니다!",
	                          text: "※사용시간 꼭 지켜주시고 깨끗하게 이용 부탁드립니다.※",
	                          icon: "success",
	                          timer: 1500,
	                          showConfirmButton: false // 확인 버튼을 숨깁니다.
	                        }).then(() => {
			                    location.replace(location.href);
			                });
	                },
	                error: function (err) {
	                    console.log("result :", err);
	                }
				});
			}
			return false;
	   });
	});

    // 모달이 닫힐 때 초기화
    $('#timetableModal').on('hidden.bs.modal', function () {
        // 입력 필드 초기화
        $('#seat').val('');
        $('#nop').val('');
        $('#timetable td').removeClass('gray');
        $('#timetable td').removeClass('ligthgray');
    });

    // 신청 취소하기
    $(".cancle").on("click", function(){
        console.log("취송");

        let reserveSeq = $(this).closest('tr').find('td:first').text().trim();
        console.log("취송 reserveSeq : ", reserveSeq);

        let data = {
            "reserveSeq": reserveSeq    
        };

        console.log("취송 btn", $("#btn" + reserveSeq));

        Swal.fire({
	        title: "신청을 취소 하시겠습니까??",
	        icon: "question",
	        showCancelButton: true,
	        confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
	        cancelButtonClass: 'btn btn-danger w-xs mt-2',
	        confirmButtonText: "예",
	        cancelButtonText: "아니오",
	        buttonsStyling: false,
	        showCloseButton: true
	    }).then(function (result) {
	        if (result.value) {
            $.ajax({
                url: "/public/tennis/cancleReAjax",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(data),
                type: "post",
                dataType: "json",
                beforeSend: function (xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function (result) {
                    console.log("result :", result);

                    if (result > 0) {
                        Swal.fire({
                              title: "취소가 정상적으로 완료되었습니다!",
                              icon: "warning"
                            });
                      $("#can" + reserveSeq).html("취소완료").removeClass("btn btn-primary").addClass("btn btn-light waves-effect");
                      $("#can" + reserveSeq).attr("disabled", true);
                    }
                },
                error: function (err) {
                    console.log("result :", err);
                }
            });
        }
     });
	});
    
    
    
    //날짜 옮기면서 보기
    //날짜 옮기면서 보기
    $(document).on("click", "#pM, #to, #nM", function () {
        updateButtonStates(); // 버튼 상태 업데이트 함수 호출
        console.log("날짜");

        // 날짜 문자열 생성 (예: "202406")
        let date = $("#ym").text().substr(0, 4) + $("#ym").text().substr(6, 2);
        console.log("클릭 날짜 :", date);

        // 시설 코드 가져오기
        let facCode = $("#inputFC").val();
        console.log("시설 코드 :", facCode);

        // 회원 ID 가져오기
        let memId = $("#memId").text();
        console.log("회원 ID :", memId);

        let data = {
            "facCode": facCode,
            "memId": memId
        };
        console.log("AJAX 요청 데이터 :", data);

        $.ajax({
            url: "/public/tennis/reserveListAjax",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            beforeSend: function (xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function (result) {
                console.log("AJAX 응답 데이터 :", result);
                const now = new Date();

                // 이전 예약 목록 삭제
                $("#trShow").empty();

                // 예약 내역이 없을 경우
                if (result.length === 0) {
                    console.log("예약 내역 없음");
                    $("#trShow").html("<tr class='odd'><td valign='top' colspan='6' class='dataTables_empty'>예약 내역이 없습니다.</td></tr>");
                    return;
                }

                let hasReservations = false; // 예약 여부 플래그

                result.forEach(reserveVO => {
                    // 예약 시작 날짜 문자열 생성 (예: "202406")
                    let beginDate = reserveVO.beginTm.substr(0, 4) + reserveVO.beginTm.substr(5, 2);
                    console.log("예약 시작 날짜 :", beginDate);

                    // 예약 시작 날짜가 현재 날짜와 같을 경우
                    if (beginDate === date) {
                        hasReservations = true;
                        const beginTm = new Date(reserveVO.beginTm.replace(' ', 'T'));
                        console.log("예약 시작 시간 :", beginTm);

                        let row = "<tr>";
                        row += "<td style='vertical-align: middle;'>" + reserveVO.reserveSeq + "</td>";
                        row += "<td style='vertical-align: middle;'>" + reserveVO.regDt + "</td>";
                        row += "<td style='vertical-align: middle;' class='beginTm'>" + reserveVO.beginTm + " ~ " + reserveVO.endTm + " <b>(" + reserveVO.useTime + ")</b></td>";
                        row += "<td style='vertical-align: middle;'>" + reserveVO.seat + " 코트</td>";
                        row += "<td style='vertical-align: middle;'>" + reserveVO.nop + " 명</td>";

                        if (beginTm < now) {
                            row += "<td class='dd'><button class='btn btn-dark waves-effect' id='can" + reserveVO.reserveSeq + "' disabled>사용 완료</button></td>";
                        } else if (reserveVO.cancleYn === 'N') {
                            row += "<td class='dd'><button style='width: 87px;' class='btn btn-primary cancle' id='can" + reserveVO.reserveSeq + "'>취소</button></td>";
                        } else {
                            row += "<td class='dd'><button class='btn btn-light waves-effect' id='can" + reserveVO.reserveSeq + "' disabled>취소 완료</button></td>";
                        }

                        row += "</tr>";

                        $("#trShow").append(row);
                    }
                });

                // 해당 날짜에 예약이 없을 경우
                if (!hasReservations) {
                    console.log("해당 날짜에 예약 없음");
                    $("#trShow").html("<tr class='odd'><td valign='top' colspan='6' class='dataTables_empty'>예약 내역이 없습니다.</td></tr>");
                }

                // 예약 목록을 업데이트한 후 버튼 상태를 다시 확인하여 업데이트
                updateButtonStates();
            }
        });
    });

  
});
</script>



<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><img alt="" src="/resources/images/골.png" style="width: 20px;">&nbsp;<strong>스크린 골프</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">공동시설물</a></li>
						<li class="breadcrumb-item active">스크린 골프</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>


<div class="col-12">
	<div class="card">
		<div class="card-header" >
			<div style="margin-left: 1430px;">
				<div id="reAbl1" ></div>
				<p style="margin: -21px 0px 9px 23px;">&nbsp;:&nbsp;사용중&nbsp; </p>
			</div>
			<div class="col-12 bobb">
				<div class="flex-container">
					<div id="contt">
						<img id="tennisImg" src="/resources/images/스크린골프.jpg">
							<div class="menu_bar">
								<c:forEach var="facilityVO" items="${facilityVOList}" varStatus="stat">
								
									<input id="inputFC" type="hidden" value="${facilityVO.facCode}">
									<br><br><br><br>
									<div class="card ribbon-box border shadow-none material-shadow col-12"style="height: 446px;margin-top:-79px;">
										<div class="card-body">
											<div class="ribbon ribbon-info round-shape" style="font-size:18px;">시설 정보</div>
												<div class="ribbon-content mt-4" style="font-size:16px;"><br>
													<p class="mb-0" >${facilityVO.facLoc}</p><hr><br>
													<pre style="line-height: 35px;">${facilityVO.facCom}</pre><br>
													<p>☎&nbsp;관리자 &nbsp;:&nbsp; ${facilityVO.facTelno}</p>
												</div>
										</div>
									</div>
									
								</c:forEach>
							</div>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
					</div>
					
					<div id="container">
						<div class="room">1</div>
						<div class="room">6</div>
						<div class="room">2</div>
						<div class="room">7</div>
						<div class="room">3</div>
						<div class="room">8</div>
						<div class="room">4</div>
						<div class="room">9</div>
						<div class="room">5</div>
						<div class="room">10</div>
					</div>

				</div>
			</div>
		</div>
		<br>

		<button type="button" id="mBtn" class="btn btn-secondary btn-jelly"
				data-toggle="modal" data-target="#timetableModal">예약&nbsp;하기</button>
		<div id="now" style="float: left;">실시간 이용현황&nbsp;(<span id="liveCount"></span>팀)</div>
		<br>

		<div style="display: flex;">
			<div class="year-mon" id="ym"></div>
			<div class="nav" style="margin-left: 100px;border: 1px solid;">
				<button class="nav-btn go-prev" id="pM" onclick="prevMonth()">&lt;</button>
				<button class="nav-btn go-today" id="to" onclick="goToday()" >Today</button>
				<button class="nav-btn go-next" id="nM" onclick="nextMonth()">&gt;</button>
			</div>
		</div>
		<div class="card-body">
			<table class="table table-hover text-nowrap tt" style="width: 100%">
				<thead>
					<tr>
						<th class="col-md-3">예약일련번호</th>
						<th>신청일</th>
						<th>사용시간</th>
						<th>자리</th>
						<th>인원</th>
						<th style="width: 5%;"></th>
					</tr>
				</thead>
				<tbody id="trShow">
					<c:forEach var="reserveVO" items="${reserveVOList}" varStatus="stat">
					
						<c:if test="${fn:substring(reserveVO.beginTm, 0, 7) eq '2024/07'}">
							<tr>
								<td style="vertical-align: middle;">${reserveVO.reserveSeq}</td>
								<td style="vertical-align: middle;">${reserveVO.regDt}</td>
								<td class="beginTm" style="vertical-align: middle;">
									 ${reserveVO.beginTm}<span> ~ </span>  ${reserveVO.endTm} <b> ( ${reserveVO.useTime} )</b>
								</td>
								<td style="vertical-align: middle;">${reserveVO.seat}번 코트</td>
								<td style="vertical-align: middle;">${reserveVO.nop}명</td>
								<c:choose>
									<c:when test="${reserveVO.cancleYn == 'N'}">
										<td class="dd"><button style="width: 87px;" class="btn btn-primary cancle"
												id="can${reserveVO.reserveSeq}">취소</button></td>
									</c:when>
									<c:when test="${reserveVO.cancleYn == 'Y'}">
										<td class="dd"><button class="btn btn-light waves-effect"
												id="can${reserveVO.reserveSeq}" disabled>취소 완료</button></td>
									</c:when>
								</c:choose>
							</tr>
						</c:if>
						
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>


<!-- 모달 구조 -->
<form id="reserveFrm" >
	<div class="modal fade" id="timetableModal" tabindex="-1" role="dialog"
		aria-labelledby="timetableModalLabel" aria-hidden="true" >
		<div class="modal-dialog" role="document">
			<div class="modal-content" style="width: 749px;height: 740px;">
				<div class="modal-header" style="border-bottom: 1px solid gray;">
					<h5 class="modal-title" id="timetableModalLabel" style="margin-bottom: 10px;">예약</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close" style="background-color: white; border: 0px solid;font-size: 33px;margin-top: -15px;color: #979797;">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- 주간 스케줄러 -->
					<div class="d-flex justify-content-between align-items-center mb-3" style="margin-left: 14px;margin-right: 18px;">
						<button type="button" id="todayBtn" class="btn btn">TODAY</button>
						<button type="button" id="prevWeek" class="btn btn">&lt;</button>
						<div id="weekDates" style="font-size: 22px; font-weight: 600; "></div>
						<button type="button" id="nextWeek" class="btn btn">&gt;</button>
					</div>
	
					<div  style="float: left; width: 84%; margin:0px -10px -4px 13px;">
						<p>
							위&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;치&nbsp;&nbsp;&nbsp;
							<select name="seat" id="seat" required="required">
								<option value="">위치 선택</option>
								<option value="1" id="seat1">1코트</option>
								<option value="2" id="seat2">2코트</option>
								<option value="3" id="seat3">3코트</option>
								<option value="4" id="seat4">4코트</option>
								<option value="5" id="seat5">5코트</option>
								<option value="6" id="seat6">6코트</option>
								<option value="7" id="seat7">7코트</option>
								<option value="8" id="seat8">8코트</option>
								<option value="9" id="seat9">9코트</option>
								<option value="10" id="seat10">10코트</option>
							</select>
							<span class="text-danger" style="font-size: 14px;">&nbsp;&nbsp;※위치 선택을 먼저 해주세요※</span>
						</p>
							<p>
								<span style="letter-spacing:4px">인원수</span>&nbsp;<input type="number" name="nop" id="nop"
									style="width: 130px;" required />&nbsp;명
							</p>
					</div>
						<div style="margin-top: 33px;">
							<div id="reAbl" style="float: left;"></div><p >&nbsp; : 예약가능&nbsp; </p>
							<div id="reunAbl"  style="float: left;"></div><p>&nbsp; : 예약불가</p>
						</div>
	
					<!-- 시간표 테이블 -->
					<table id="timetable" style="color: #121212;">
						<thead>
							<tr>
								<th></th>
								<th id="day0" class="dayy"></th>
								<th id="day1" class="dayy"></th>
								<th id="day2" class="dayy"></th>
								<th id="day3" class="dayy"></th>
								<th id="day4" class="dayy"></th>
								<th id="day5" class="dayy"></th>
								<th id="day6" class="dayy"></th>
							</tr>
						</thead>
						<tbody>
							<!-- 동적으로 행이 추가될 부분 -->
						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="submit" id="reBtn" class="btn btn-secondary">예약</button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</form>
<script src="/resources/js/calender copy.js"></script>