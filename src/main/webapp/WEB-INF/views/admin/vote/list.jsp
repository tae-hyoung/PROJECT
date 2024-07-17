<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%@ page import="java.util.List"%>
<%
   MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
   String memAuth = member != null ? member.getMemAuth() : null;
   @SuppressWarnings("unchecked")
   List<String> submitVote = (List<String>) request.getAttribute("submitVote");
%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<style>
.table thead th, .table tbody td {
    text-align: center; /* 텍스트를 중앙에 정렬 */
    vertical-align: middle; /* 수직 중앙 정렬 */
}

.tblRow.text-left {
    text-align: left; /* 투표 제목 열은 왼쪽 정렬 */
}

#adminBtn {
    position: absolute;
    bottom: 20px;
    right: 20px;
    display: flex;
    justify-content: flex-start;
}
#adminBtn .btn {
    margin-right: 10px; 
}
</style>

<script>
$(function(){

	//제출된 투표 리스트
    var submitVote = [];
    <% if (submitVote != null) { %>
        submitVote = [<%= String.join(",", submitVote.stream().map(s -> "\"" + s + "\"").toArray(String[]::new)) %>];
    <% } %>;
    
    
    // 이미 제출한 항목 비활성화 처리
    $("tbody tr").each(function(){
        let voteCode = $(this).children().eq(1).text().trim();
        if(submitVote.includes(voteCode)){
            $(this).addClass("disabled");
            $(this).find("input.voteCheckbox").prop("disabled", false); // 체크박스는 비활성화 하지 않음
            $(this).on("click", function(event){
            	if(!$(event.target).is(".voteCheckbox")){
            		event.stopPropagation();
            	}
            });
        }
    });

 	// 클릭 처리
    $(document).on('click', ".tblRow", function(event){
        // 체크박스를 클릭했을 때는 상세보기로 안넘어가기
		if($(event.target).is(".voteCheckbox")){
			return;
		}    	
    	
		//비활성 항목은 클릭 X
        if($(this).hasClass("disabled")){
        	return; 
        }
        
		// 해당 투표의 코드 가져오기        
        let voteCode = $(this).parent().children().eq(1).text().trim();
		
        location.href = "/vote/admin/detail?voteCode=" + voteCode;
    });
 	
    // 보기 버튼 클릭 시 결과 페이지로 이동
    $(document).on('click', ".btnShowResult", function(){
//     let voteCode = $(this).parent().parent().children().eq(1).text().trim();
    let voteCode = $(this).closest("tr").find("td:eq(1)").text().trim(); // 해당 투표의 코드 가져오기
    console.log("보기 버튼 클릭 - 투표 코드:", voteCode);

    // AJAX로 voteVO 데이터 가져와서 모달 영역에 넣어주기
    $.ajax({
        url: "/vote/showResult1",
        method: "post",
        contentType: "application/json",
        data: JSON.stringify({ voteCode: voteCode }), // voteCode를 JSON 형식으로 전송
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(voteVO) {
            // 받아오기 성공하면 두 번째 AJAX 요청으로 결과 데이터 가져오기
            $.ajax({
                url: "/vote/showResult2",
                method: "post",
                contentType: "application/json",
                data: JSON.stringify({ voteCode: voteCode }), // voteCode를 JSON 형식으로 전송
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(cnt) {
                    // 모달에 데이터 업데이트
                    updateModal(voteVO, cnt);
                },
                error: function(xhr, textStatus, errorThrown) {
                    console.log("데이터 가져오기 오류:", errorThrown);
                }
            });
        },
        error: function(xhr, textStatus, errorThrown) {
            console.log("투표 정보 가져오기 오류:", errorThrown);
        }
    });
});

    // 투표 등록 버튼 클릭 시
    $("#btnCreate").on("click", function(){
        window.location.href = "/vote/create";
    });

    // 설문 목록을 서버에서 받아와 출력하는 함수
	function getList(keyword, currentPage) {
	    let data = {
	        "keyword": keyword,
	        "currentPage": currentPage
	    };

        $.ajax({
            url: "/vote/listAjax",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
            	xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                let str = "";

                $.each(result.content, function(idx, voteVO) {
                    str += "<tr>";
                    str += "<td><input type='checkbox' class='voteCheckbox' value='" + voteVO.voteCode + "'></td>";
                    str += "<td style='display: none'>" + (voteVO.voteCode) + "</td>";
                    str += "<td class='tblRow text-left'>" + voteVO.voteTitle + "</td>";
                    str += "<td class='tblRow'>" + voteVO.count + "</td>";
                    str += "<td class='tblRow'>" + new Date(voteVO.beginTm).toLocaleString() + "</td>";
                    str += "<td class='tblRow'>" + new Date(voteVO.endTm).toLocaleString() + "</td>";
                    str += "<td class='tblRow'>" + (voteVO.endYn === 'N' ? '진행중' : '마감됨') + "</td>";
                    str += "<td><button type='button' class='btn btn-success btnShowResult'>보기</button></td>";
                    str += "</tr>";
                });

                $(".clsPagingArea").html(result.pagingArea);
                $("#trShow").html(str);
                
                //이미 제출한 목록인 경우 비활성화 처리
                $("tbody tr").each(function(){ 
                	let voteCode = $(this).children().eq(1).text().trim();
                	if(submitVote.includes(voteCode)){
                		$(this).addClass("disabled");
                	}
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("AJAX 오류 발생: " + textStatus, errorThrown);
            }            
        });
    }   
    
    
    // 설문 마감 처리 버튼 클릭 시
    $("#closeVoteBtn").on("click", function() {
        let selectedVotes = [];
        $(".voteCheckbox:checked").each(function() {
            selectedVotes.push($(this).val());
        });

        if (selectedVotes.length === 0) {
            Swal.fire({
            	icon: 'warning',
            	title: '선택된 투표',
            	text: '선택된 투표가 없습니다.'
            });
            return;
        }

        $.ajax({
            url: "/vote/closeVote",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(selectedVotes),
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(data) {
                $(".voteCheckbox:checked").each(function() {
                    $(this).closest("tr").find("td:eq(5)").text("마감됨");
                    $(this).prop('checked', false);  // 체크박스 체크 해제
                });
                Swal.fire({
                	icon: 'success',
                	title: '설문 마감',
                	text: '선택된 투표가 마감 처리되었습니다.'
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("AJAX 오류 발생: " + textStatus, errorThrown);
            }
        });
    });

    // 삭제 버튼 클릭 시
    $("#delBtn").on('click', function() {
        let selectedVotes = [];
        $(".voteCheckbox:checked").each(function() {
            selectedVotes.push($(this).val());
        });

        if (selectedVotes.length === 0) {
            Swal.fire({
            	icon: 'warning',
            	title: '선택된 투표',
            	text: '선택된 투표가 없습니다.'
            });
            return;
        }
        
        Swal.fire({
        	title: '투표를 삭제 하시겠습니까?',
        	icon: 'warning',
        	showCancelButton: true,
        	confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
        	cancelButtonClass: 'btn btn-danger w-xs mt-2',
        	confirmButtonText: '예',
        	cancelButtonText: '아니오',
	        buttonsStyling: false,
	        showCloseButton: true
		}).then(function (result) {
			if (result.isConfirmed) {  
	        	$.ajax({
	                url: "/vote/delete",
	                type: "POST",
	                contentType: "application/json",
	                data: JSON.stringify(selectedVotes),
	                beforeSend: function(xhr) {
	                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                },
	                success: function(data) {
	                    $(".voteCheckbox:checked").each(function() {
	                        $(this).closest("tr").remove();
	                    });
	                    Swal.fire({
	                    	icon: 'success',
	                    	title: '투표 삭제',
	                    	text: '선택된 투표가 삭제되었습니다.'
	                    });
	                },
	                error: function(jqXHR, textStatus, errorThrown) {
	                    console.log("AJAX 오류 발생: " + textStatus, errorThrown);
	                }
	        	});
	        }
		});
    });
    
 	// 모달 업데이트 함수
    function updateModal(voteVO, cnt) {
        console.log("voteVO:", voteVO); // voteVO 데이터 확인
        console.log("count:", cnt); // count 데이터 확인

        // 모달 제목 및 후보자 리스트 업데이트
        $("#voteTitle").text(voteVO.voteTitle);
        let candidatesHtml = "";
        voteVO.voteDetails.forEach(function(candidate) {
            candidatesHtml += `<tr><td>${candidate.vdItem}</td><td>${candidate.vdDetail}</td></tr>`;
        });
        $("#candidateList tbody").html(candidatesHtml);

        // 참여자 수 업데이트
        $("#participantCount").text(cnt.reduce((a, b) => a + b, 0));

        // 차트 업데이트
        let ctx = document.getElementById('doughnut').getContext('2d');
        
        // 기존에 있던 차트 인스턴스 삭제 (필요한 경우)
        if (window.myChart) {
            window.myChart.destroy();
        }

        window.myChart = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: voteVO.voteDetails.map(candidate => candidate.vdItem),
                datasets: [{
                    label: '투표 결과',
                    data: cnt,
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.5)',
                        'rgba(54, 162, 235, 0.5)',
                        'rgba(255, 206, 86, 0.5)',
                        'rgba(75, 192, 192, 0.5)',
                        'rgba(153, 102, 255, 0.5)',
                        'rgba(255, 159, 64, 0.5)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: '후보자 득표 수'
                    },
                    datalabels: {
                        color: 'black',
                        font: {
                            size: 20,
                            weight: 'bold'
                        },
                    }
                }
            },
            plugins: [ChartDataLabels]
        });

        // 모달 보이기
        $("#voteModal").modal("show");
        
        
        // 모달 내 테이블 그리기
        let strTbl = '';
        console.log(cnt);
        for(let i=0; i<voteVO.voteDetails.length; i++){
        	strTbl += '<tr>';
        	strTbl += '<td>';
        	strTbl += voteVO.voteDetails[i].vdItem;
        	strTbl += '</td>';
        	strTbl += '<td>';
        	strTbl += cnt[i];
        	strTbl += '</td>';
        	strTbl += '</tr>';
        }
        $('#testTbl').html(strTbl);
        
    }
});

</script>

<div class="container-fluid">
   <div class="row">
      <div class="col-12">
         <div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
            <p class="mb-sm-0" style="font-size: 18px; color: #495057;">
               <i class="las la-vote-yea"></i><strong> 투표목록 화면 </strong>
            </p>
            <div class="page-title-right">
               <ol class="breadcrumb m-0">
                  <li class="breadcrumb-item"><a href="javascript: void(0);">투표</a></li>
                  <li class="breadcrumb-item active">투표목록</li>
               </ol>
            </div>
         </div>
      </div>
   </div>
</div>

<div class="col-12">
    <div class="card">
        <div class="card-header">
            <p class="card-title" style="font-size: 30px; float: left; margin-right: 20px;" >
            	<img alt="투표" src="/resources/images/투표.png" style="width: 60px; margin-bottom: 10px; margin-right: 20px;">투표
            </p>
        </div>

        <div class="card-body table-responsive text-center" style="height: 600px;">
            <table class="table table-head-fixed text-nowrap" style="margin-top: -15px;">
                <thead style="font-size: 18px; bold;">
                    <tr>
                        <th></th>
                        <th style="display: none">투표 코드</th>
                        <th>투표 제목</th>
                        <th>투표 인원</th>
                        <th>투표 기간</th>
                        <th>마감여부</th>
                        <th>결과</th>
                    </tr>
                </thead>
                <tbody id="trShow" style="font-size: 16px;">
                    <c:forEach var="voteVO" items="${voteVOList}" varStatus="stat">
                        <tr>
                            <td><input type="checkbox" class="voteCheckbox" value="${voteVO.voteCode}" /></td>
                            <td class="tblRow" style="display: none">${voteVO.voteCode}</td>
                            <td class="tblRow text-left">${voteVO.voteTitle}</td>
                            <td class="tblRow">${voteVO.count}</td>
                            <td class="tblRow">
    							${voteVO.beginTm.substring(0, 10)}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
    							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${voteVO.endTm.substring(0, 10)}
							</td>
                            <td class="tblRow">${voteVO.endYn == 'N' ? '진행중' : '마감됨'}</td> 
                        	<td><button type="button" id="btnShowResult" class="btn btn-success btnShowResult" data-bs-toggle="modal" data-bs-target="#voteModal">보기</button></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div class="row">
            <div class="col-5"></div>
            <div class="col-6 clsPagingArea" style="float: left">
                ${articlePage.pagingArea}
            </div>
        </div>

				<!-- 상세 모달 시작 -->
				<div id="voteModal" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
				    <div class="modal-dialog modal-xl">
				        <div class="modal-content">
				        	<div class="modal-body">
							    <div class="card">
							        <div class="card-header text-center">
							            <h3 style="font-size: 40px;" id="voteTitle"></h3> <!-- 같은 줄 오른쪽 상단에 x 표시 누르면 모달 창 닫기 -->
							            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" 
							            	style="border: none; background-color: transparent; font-size: 1.5em; position: absolute; top: 10px; right: 10px;">
							            </button>
							            <p><strong>참여자 수 : &nbsp;<span id="participantCount"></span>명</strong></p>
							        </div>
							
							        <div class="card-body table-responsive" style="height: 600px;">
							            <div class="row">
								            <div class="col-6">
								            	<canvas id="doughnut" style="width: 500px; height: 600px; position: relative; margin-top: 20px;"></canvas>
								            </div>
								            
								            <div class="col-6"> 
									            <table class="table table-bordered" style="margin-top: 200px;">
									                <thead>
									                    <tr>
									                        <th>후보자 명</th>
									                        <th>득표 수</th>
									                    </tr>
									                </thead>
									                <tbody id="testTbl">
									                </tbody>
									            </table>
											</div>
										</div>					            
							        </div>
							    </div>
				        	</div>
						</div>
					</div>
				</div>
				<!-- 상세 모달 끝 -->
				
        <div class="text-center" id="adminBtn">
        	<a href="/vote/create" class="btn btn-primary">투표 등록</a>                    
			<button type="button" id="closeVoteBtn" class="btn btn-success">마감 처리</button>
			<button type="button" id="delBtn" class="btn btn-danger">삭제</button>           
        </div>
    </div>
</div>
