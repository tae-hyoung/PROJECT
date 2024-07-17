<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%@ page import="java.util.List"%>

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

.disabled {
    opacity: 0.5;
}

.table td.text-left {
    text-align: left;
}

.no-pointer-events {
    pointer-events: none;
}

.surveyCheckbox {
    pointer-events: auto;
}
</style>
<script>
$(document).ready(function() {
    var submitSurvey = [<c:forEach var="sv" items="${submitSurvey}" varStatus="status">'${sv}'<c:if test="${!status.last}">, </c:if></c:forEach>];

    
    $("tbody#trShow tr").each(function() {
        var svCode = $(this).find("td:eq(1)").text().trim();
       
        if(submitSurvey.includes(svCode)) {
            $(this).addClass("disabled");
            $(this).find("input.surveyCheckbox").prop("disabled", false);
            $(this).on("click", function(event){
                if(!$(event.target).is(".surveyCheckbox")){
                    event.stopPropagation();
                }
            });
        }
    });

    $(document).on('click', ".tblRow", function(event) {
        if($(event.target).is(".surveyCheckbox")){
            return;
        }
        if($(this).hasClass("disabled")) {
            return; 
        }
        var svCode = $(this).find("td:eq(1)").text().trim();
        location.href = "/survey/admin/detail?svCode=" + svCode;
    });

    $("#btnShowResult").on("click", function() {
        var selectedSurveys = [];
        $(".surveyCheckbox:checked").each(function() {
            selectedSurveys.push($(this).val());
        });
        if (selectedSurveys.length === 0) {
            Swal.fire({
            	icon: 'warning',
            	title: '선택된 투표',
            	text: '선택된 투표가 없습니다.'
            });
            return;
        } else if (selectedSurveys.length > 1) {
            Swal.fire({
            	icon: 'error',
            	title: '투표 중복선택',
            	text: '중복 선택이 불가능합니다.'
            });
            return;
        }
        window.location.href = "/survey/admin/showResult?svCode=" + selectedSurveys[0];
    });

    $("#btnSearch").on("click", function() {
        var keyword = $("#search").val();
        getList(keyword, 1);
    });

    $("#btnSearchAll").on("click", function() {
        getList("", 1);
    });

    $("#btnCreate").on("click", function() {
        window.location.href = "/survey/create";
    });

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
                    str += "<tr class='tblRow'>";
                    str += "<td class='no-pointer-events'><input type='checkbox' class='surveyCheckbox' value='" + surveyVO.svCode + "'></td>";
                    str += "<td style='display: none'>" + surveyVO.svCode + "</td>";
                    str += "<td>" + surveyVO.svTitle + "</td>";
                    str += "<td>" + surveyVO.count + "</td>";
                    str += "<td>" + new Date(surveyVO.beginTm).toLocaleString() + "</td>";
                    str += "<td>" + new Date(surveyVO.endTm).toLocaleString() + "</td>";
                    str += "<td>" + (surveyVO.endYn == 'N' ? '진행중' : '마감됨') + "</td>";
                    str += "</tr>";
                });
                $(".clsPagingArea").html(result.pagingArea);
                $("#trShow").html(str);
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

    $("#closeSurveyBtn").on("click", function() {
        var selectedSurveys = [];
        $(".surveyCheckbox:checked").each(function() {
            selectedSurveys.push($(this).val());
        });
        if (selectedSurveys.length === 0) {
            Swal.fire({
            	icon: 'warning',
            	title: '선택된 투표',
            	text: '선택된 투표가 없습니다.'
            });
            return;
        }
        $.ajax({
            url: "/survey/closeSurveys",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(selectedSurveys),
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(data) {
                $(".surveyCheckbox:checked").each(function() {
                    $(this).closest("tr").find("td:last").text("마감됨");
                    $(this).prop('checked', false);  
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

    $("#delBtn").on('click', function() {
        var selectedSurveys = [];
        $(".surveyCheckbox:checked").each(function() {
            selectedSurveys.push($(this).val());
        });
        if (selectedSurveys.length === 0) {
            Swal.fire({
            	icon: 'warning',
            	title: '선택된 투표',
            	text: '선택된 투표가 없습니다.'
            });
            return;
        }
        Swal.fire({
        	title: '설문을 삭제하시겠습니까?',
        	icon: 'warning',
        	showCancelButton: true,
        	confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
        	cancelButtonClass: 'btn btn-danger w-xs mt-2',
        	confirmButtonText: '예',
        	cancelButtonText: '아니오',
	        buttonsStyling: false,
	        showCloseButton: true
        }).then(function(result){
	        if (result.isConfirmed) {
	            $.ajax({
	                url: "/survey/delete",
	                type: "POST",
	                contentType: "application/json",
	                data: JSON.stringify(selectedSurveys),
	                beforeSend: function(xhr) {
	                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	                },
	                success: function(data) {
	                    $(".surveyCheckbox:checked").each(function() {
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
});
</script>

<div class="container-fluid">
   <div class="row">
      <div class="col-12">
         <div
            class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
            <p class="mb-sm-0" style="font-size: 18px; color: #495057;">
               <i class="las la-vote-yea"></i><strong> 설문목록 화면 </strong>
            </p>
            <div class="page-title-right">
               <ol class="breadcrumb m-0">
                  <li class="breadcrumb-item"><a href="javascript: void(0);">설문</a></li>
                  <li class="breadcrumb-item active">설문목록</li>
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
                        <tr class="tblRow">
                            <td class="no-pointer-events"><input type="checkbox" class="surveyCheckbox" value="${surveyVO.svCode}" /></td>
                            <td style="display: none">${surveyVO.svCode}</td>
                            <td class="text-left">${surveyVO.svTitle}</td>
                            <td>${surveyVO.count}</td>
                            <td>
    							${surveyVO.beginTm.substring(0, 10)}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-
    							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${surveyVO.endTm.substring(0, 10)}
							</td>
                            <td>${surveyVO.endYn == 'N' ? '진행중' : '마감됨'}</td>
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

        <div class="text-center" id="adminBtn">
            <a href="/survey/create" class="btn btn-primary">설문 등록</a>
            <button type="button" id="closeSurveyBtn" class="btn btn-success">마감 처리</button>
            <button type="button" id="delBtn" class="btn btn-secondary">삭제</button>
            <button type="button" id="btnShowResult" class="btn btn-danger">참여율</button>
        </div>
    </div>
</div>
