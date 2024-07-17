<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%
   MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
   String memAuth = member != null ? member.getMemAuth() : null;
%>
<!-- 이것은 관리자 - 상세화면 -->
<style>
.candidate-list {
    margin-bottom: 20px;
}
.candidate-image {
    width: 300px; 
    height: 500px; 
}
.form-group {
    margin-bottom: 40px;
}
#adminBtn {
    position: absolute;
    bottom: 200px;
    right: 50%;
    transform: translateX(50%);
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: -150px;
}
#adminBtn .btn {
    margin-right: 10px;
}
</style>

<script>
// 전역 함수 정의
function updateReply(vdCode, vdItem) {
    console.log("Updating selected candidate name:", vdItem);
    document.getElementById('selectedCandidateName').value = vdItem; 
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

// jQuery를 사용한 DOM 로드 후 실행
$(function(){
    // 관리자 권한 버튼
    if('<%= memAuth%>' == 'ROLE_ADMIN'){
        let htmlStr = '';
        htmlStr += '<a href="/vote/update?voteCode=${voteVO.voteCode}" class="btn btn-primary">수정</a>';
        htmlStr += '<a href="/vote/admin/list" class="btn btn-success">목록</a>';
        
        $('#adminBtn').html(htmlStr);
    }
});
</script>

<div class="col-12">
	<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
	   <p class="mb-sm-0" style="font-size: 18px; color: #495057;">
	      <i class="las la-vote-yea"></i><strong> 투표 화면 </strong>
	   </p>
	   <div class="page-title-right">
	      <ol class="breadcrumb m-0">
	         <li class="breadcrumb-item"><a href="javascript: void(0);">투표</a></li>
	         <li class="breadcrumb-item active">투표 내용</li>
	      </ol>
	   </div>
	</div>
         
    <div class="card shadow p-3 rounded">
        <div class="card-header" style="display: flex; font-weight: bold;"></div>
        

        <div class="card-body table-responsive" style="height: 800px;">
            <form action="/vote/result" method="post" onsubmit="return validateForm()">
                
                <fieldset class="form-group">
                    <legend style="text-align: center; font-size: 30px; font-weight: bold;">${voteVO.voteTitle} 투표</legend>
                    <div class="row justify-content-center" style="margin-top: 150px;">
                        <c:forEach var="detail" items="${voteVO.voteDetails}">
                            <div class="col-md-3 mb-4 candidate-list text-center">
                                <div>
                                    <img src="/upload${detail.attach}" class="candidate-image"> <!-- 첨부파일 이미지 출력 -->
                                </div>
                                <p style="font-size: 18px; font-weight: bold; margin-top: 10px;">${detail.vdItem}</p>
                            </div>
                        </c:forEach>
                <div class="text-center" id="adminBtn"></div>
                        <input type="hidden" name="voteCode" value="${voteVO.voteCode}">
                        <input type="hidden" name="replyer" value="<sec:authentication property="principal.memberVO.memId" />">
                        <input type="hidden" name="selectedCandidateName" id="selectedCandidateName">
                    </div>
                </fieldset>

                <sec:csrfInput />
            </form>
        </div>
    </div>
</div>