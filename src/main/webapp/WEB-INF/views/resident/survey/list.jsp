<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%@ page import="java.util.List"%>
<%
   MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
   String memAuth = member != null ? member.getMemAuth() : null;
   @SuppressWarnings("unchecked")
   List<String> submitSurvey = (List<String>) request.getAttribute("submitSurvey");
%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>

<style>
tbody tr:hover {
    background-color: #ccc;
}

#resultBtn {
    position: absolute;
    bottom: 20px;
    right: 20px;
    display: flex;
    justify-content: flex-start;
}

#resultBtn .btn {
    margin-right: 10px; 
}

.disabled {
    opacity: 0.5;
}

.table td.text-left {
    text-align: left;
}
</style>

<script>
$(document).ready(function() {
    // 서버에서 전달된 데이터를 직접 JavaScript 변수에 할당
    var submitSurvey = [<c:forEach var="sv" items="${submitSurvey}" varStatus="status">'${sv}'<c:if test="${!status.last}">, </c:if></c:forEach>];

    
    // 이미 제출한 항목 비활성화 처리 및 마감 여부에 따른 처리
    $("tbody tr").each(function() {
        var svCode = $(this).find("td:eq(1)").text().trim();
        var endYn = $(this).find("td:eq(5)").text().trim(); // '마감됨' 여부 확인
        
        if (submitSurvey.includes(svCode) || endYn === '마감됨') {
        	$(this).children().removeClass("tblRow");
            $(this).addClass("disabled");
            $(this).find("input.surveyCheckbox").prop("disabled", false);
        }
        
        // 클릭 시 상세보기로 이동 또는 설문 결과 보기 기능 추가
        $(this).on("click", ".tblRow", function(event) {
            // 클릭한 요소가 체크박스 또는 체크박스가 있는 td 내부이면 처리하지 않음
            if ($(event.target).is(".surveyCheckbox, .surveyCheckbox + td")) {
                return;
            }

            if ($(this).hasClass("disabled")) {
                event.stopPropagation(); // 비활성화된 항목은 클릭 이벤트 중단
            } else {
                var svCode = $(this).parent().find("td:eq(1)").text().trim();
                location.href = "/survey/detail?svCode=" + svCode; // 상세 페이지로 이동
            }
        });
    });

    // 설문 결과 보기 버튼 클릭 처리
    $("#btnShowResult").on("click", function() {
        var selectedSurveys = [];
        $(".surveyCheckbox:checked").each(function() {
            selectedSurveys.push($(this).val());
        });

        if (selectedSurveys.length === 0) {
            Swal.fire({
            	icon: 'warning',
            	title: '선택된 설문',
            	text: '선택된 설문이 없습니다.'
            });
            return;
        } else if (selectedSurveys.length > 1) {
            Swal.fire({
            	icon: 'error',
            	title: '설문 중복선택',
            	text: '중복 선택이 불가능합니다.'
            });
            return;
        }

        window.location.href = "/survey/showResult?svCode=" + selectedSurveys[0];
    });

    // 설문 목록을 서버에서 받아와 출력하는 함수
    function getList(keyword, currentPage) {
        var data = {
            "keyword": keyword,
            "currentPage": currentPage
        };

        $.ajax({
            url: "/survey/listAjax",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                var str = "";

                $.each(result.content, function(idx, surveyVO) {
                    str += "<tr>";
                    str += "<td><input type='checkbox' class='surveyCheckbox' value='" + surveyVO.svCode + "'></td>";
                    str += "<td style='display: none'>" + surveyVO.svCode + "</td>";
                    str += "<td class='tblRow text-left'>" + surveyVO.svTitle + "</td>";
                    str += "<td class='tblRow'>" + surveyVO.count + "</td>";
                    str += "<td class='tblRow'>" + new Date(surveyVO.beginTm).toLocaleString() + "</td>";
                    str += "<td class='tblRow'>" + new Date(surveyVO.endTm).toLocaleString() + "</td>";
                    str += "<td class='tblRow'>" + (surveyVO.endYn == 'N' ? '진행중' : '마감됨') + "</td>";
                    str += "</tr>";
                })

                $(".clsPagingArea").html(result.pagingArea);
                $("#trShow").html(str);

                // 이미 제출한 설문 비활성화 처리
                $("tbody#trShow tr").each(function() {
                    var svCode = $(this).find("td:eq(1)").text().trim();
                    if(submitSurvey.includes(svCode)) {
                        $(this).addClass("disabled");
                    }
                });
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log("AJAX 오류 발생: " + textStatus, errorThrown);
            }
        });
    }
});
</script>

<div class="container-fluid">
   <div class="row">
      <div class="col-12">
         <div
            class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
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
            	<img alt="설문" src="/resources/images/설문조사.png" style="width: 60px; margin-bottom: 10px; margin-right: 20px;">설문조사
            </p>
        </div>

        <div class="card-body table-responsive text-center" style="height: 600px;">
            <table class="table table-head-fixed text-nowrap" style="margin-top: -15px;">
                <thead style="font-size: 18px; bold;">
                    <tr>
                        <th></th>
                        <th>제목</th>
                        <th>참여자 수</th>
                        <th>설문 기간</th>
                        <th>마감여부</th>
                    </tr>
                </thead>
                <tbody id="trShow" style="font-size: 16px;">
                    <c:forEach var="surveyVO" items="${surveyVOList}" varStatus="stat">
                        <tr>
                            <td><input type="checkbox" class="surveyCheckbox" value="${surveyVO.svCode}" /></td>
                            <td class="tblRow" style="display: none">${surveyVO.svCode}</td>
                            <td class="tblRow text-left">${surveyVO.svTitle}</td>
                            <td class="tblRow">${surveyVO.count}</td>
                            <td class="tblRow">
    							${surveyVO.beginTm.substring(0, 10)}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
    							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${surveyVO.endTm.substring(0, 10)}
							</td>
                            <td class="tblRow">${surveyVO.endYn == 'N' ? '진행중' : '마감됨'}</td>
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

        <div class="text-center" id="resultBtn">
            <button type="button" id="btnShowResult" class="btn btn-danger">참여율</button>
        </div>
    </div>
</div>
