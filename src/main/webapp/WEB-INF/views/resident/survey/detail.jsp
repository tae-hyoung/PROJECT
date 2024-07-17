<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%
   MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
   String memAuth = member != null ? member.getMemAuth() : null;
%>

<style>
tbody tr:hover {
    background-color: lightgrey;
}
.options label {
    margin-right: 10px;
}
.form-group {
    margin-bottom: 40px;
}
#adminBtn {
    position: absolute;
    bottom: 50px;
    right: 50%; 
    transform: translateX(50%); 
    display: flex;
    justify-content: center; 
    align-items: center; 
}

#adminBtn .btn {
    margin-right: 10px;
}

</style>
<script>
$(function(){

	function goBack() {
	    const prevURL = document.referrer;
	    if (prevURL) {
	        window.location.href = prevURL;
	    } else {
	        window.history.back();
	    }
	}
	
	function validateForm() {
	    const checkboxes = document.querySelectorAll('input[type="radio"]');
	    let allChecked = true;
	
	    checkboxes.forEach(function (checkbox) {
	        const name = checkbox.getAttribute('name');
	        if (!document.querySelector('input[name="' + name + '"]:checked')) {
	            allChecked = false;
	        }
	    });
	
	    if (!allChecked) {
	        alert('모든 질문에 답변을 선택해주세요.');
	        return false; // 제출을 막음
	    }
	
	    return true; // 제출 허용
	}
});	
</script>

<div class="col-12">
	<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
	   <p class="mb-sm-0" style="font-size: 18px; color: #495057;">
	      <i class="las la-vote-yea"></i><strong> 설문 화면 </strong>
	   </p>
	   <div class="page-title-right">
	      <ol class="breadcrumb m-0">
	         <li class="breadcrumb-item"><a href="javascript: void(0);">설문</a></li>
	         <li class="breadcrumb-item active">설문 내용</li>
	      </ol>
	   </div>
	</div>
	
    <div class="card shadow p-3 rounded">
        <div class="card-header" style="display: flex;">
            <p style="font-size: 25px;"><strong>${surveyVO.svTitle}</strong></p>
        </div>
		
		<!-- 리본뭐시기 -->
		<div class="card ribbon-box border shadow-none bl-lg-0 material-shadow">
        	<div class="card-body">
        		<div class="ribbon ribbon-info round-shape">Notice</div>
        		<div class="ribbon-content mt-4">
        			<p class="mb-0" style="font-size: 18px; color: red; font-weight: bold;">* 제출 주의사항</p>
        			<p style="font-size: 13px; margin-top: 10px;">제출은 한번만 가능합니다.<br>제출시 수정이 불가하오니 신중히 답변해주시기를 바랍니다.</p>
        		</div>
        	</div>
        </div>
		
        <div class="card-body table-responsive" style="height: 750px;">
            <form action="/survey/result" method="post" onsubmit="return validateForm()">
            	<input type="hidden" name="svCode" value="${surveyVO.svCode}">
            	<div class="row">
            		<!-- 왼쪽 영역: 1번부터 5번 설문 항목 -->
            		<div class="col-md-6">
		                <c:forEach var="detail" items="${surveyVO.surveyDetails}" varStatus="loop">
		                    <c:if test="${loop.index < 5}">
		                        <fieldset class="form-group">
		                            <legend style="font-size: 15px;">Q${loop.index + 1} . ${detail.svdItem}</legend>
		                            <div class="options">
		                                <input type="hidden" name="surveyResultVOList[${loop.index}].svdCode" value="${detail.svdCode}">
		                                <input type="hidden" name="surveyResultVOList[${loop.index}].svCode" value="${surveyVO.svCode}">
		                                <label><input type="text" name="surveyResultVOList[${loop.index}].reply" style="width: 350%;" class="form-control" required></label>
		                                <input type="hidden" name="surveyResultVOList[${loop.index}].replyer" value="<sec:authentication property="principal.memberVO.memId" />">
		                            </div>
		                        </fieldset>
		                    </c:if>
		                </c:forEach>
            		</div>
            		
            		<!-- 오른쪽 영역: 6번부터 10번 설문 항목 -->
            		<div class="col-md-6">
		                <c:forEach var="detail" items="${surveyVO.surveyDetails}" varStatus="loop">
		                    <c:if test="${loop.index >= 5 && loop.index < 10}">
		                        <fieldset class="form-group">
		                            <legend style="font-size: 15px;">Q${loop.index + 1} . ${detail.svdItem}</legend>
		                            <div class="options">
		                                <input type="hidden" name="surveyResultVOList[${loop.index}].svdCode" value="${detail.svdCode}">
		                                <input type="hidden" name="surveyResultVOList[${loop.index}].svCode" value="${surveyVO.svCode}">
		                                <label><input type="text" name="surveyResultVOList[${loop.index}].reply" style="width: 350%;" class="form-control" required></label>
		                                <input type="hidden" name="surveyResultVOList[${loop.index}].replyer" value="<sec:authentication property="principal.memberVO.memId" />">
		                            </div>
		                        </fieldset>
		                    </c:if>
		                </c:forEach>
            		</div>
            	</div>
	                
                <div class="text-center" id="adminBtn">
                    <button type="submit" class="btn btn-primary mx-2">제출</button>
                    <a href="/survey/list" class="btn btn-success">목록</a>
                </div>
                <sec:csrfInput/>
            </form>
        </div>
    </div>
</div>
