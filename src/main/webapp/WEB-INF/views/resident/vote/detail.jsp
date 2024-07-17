<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%
   MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
   String memAuth = member != null ? member.getMemAuth() : null;
%>
<!-- 이것은 입주민 - 상세화면 -->
<style>
/* .candidate-list { */
/* 	margin-bottom: 20px; */
/* } */
.candidate-image {
width: 300px; /* 원하는 너비로 설정 */
height: 500px; /* 너비에 따라 자동으로 높이 조정 */
}
/* .form-group { */
/* 	margin-bottom: 10px; */
/* } */
/* #adminBtn { */
/* 	position: absolute; */
/* /* 	bottom: 200px; */ */
/* 	right: 50%; */
/* 	transform: translateX(50%); */
/* 	display: flex; */
/* 	justify-content: center; */
/* 	align-items: center; */
/* 	margin-bottom: -150px; */
/* } */
/* #adminBtn{ */
/* 	margin-bottom: 10px; */ */
/* } */
legend{
	font-size: 30px;
	font-weight: bold;
}
.card{
	min-height: 750px;
}
.custom-radio {
	display: none; 
}

.custom-radio + label {
	display: inline-block;
	width: 35px; 
	height: 35px; 
	background-image: url('/resources/images/stamp2.png');
	background-size: cover;
	cursor: pointer;
	transition: filter 0.3s ease;
	margin-left: 10px;
	filter: grayscale(100%);
}

.custom-radio:checked + label {
	filter: none;
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
//     // 관리자 권한 버튼
<%--     if('<%= memAuth%>' == 'ROLE_ADMIN'){ --%>
//         let htmlStr = '';
//         htmlStr += '<a href="/vote/list" class="btn btn-primary">목록</a>';
//         htmlStr += '<a href="/vote/update?voteCode=${voteVO.voteCode}" class="btn btn-primary">투표 수정하기</a>';
        
//         $('#adminBtn').html(htmlStr);
//     }
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
		<div class="card-header" style="text-align: center;">
        <div style="display: flex; align-items: center; justify-content: center;">
            <img alt="스탬프" src="/resources/images/stamp2.png" style="width: 35px; height:35px; margin-right:15px;">
            <p style="font-size: 28px; margin: 0;"><strong>${voteVO.voteTitle}</strong></p>
        </div>
        <div>
            <p style="margin: 5px 0 0 0; font-size:15px;">투표기간 : ${voteVO.beginTm.substring(0,10)} ~ ${voteVO.endTm.substring(0,10)}</p>
        </div>
    </div>
		
		<div class="card-body table-responsive">
			<form action="/vote/result" method="post" onsubmit="return validateForm()">
		
				<fieldset class="form-group">
					<div class="row justify-content-center">
						<c:forEach var="detail" items="${voteVO.voteDetails}">
							<div class="col-md-3 mb-4 candidate-list text-center">
								<div>
									<img src="/upload${detail.attach}" class="candidate-image" style="margin-top: 30px;"> <!-- 첨부파일 이미지 출력 -->
								</div>
								<div style="margin-top: 15px;">
									<div class="d-flex align-items-center justify-content-center">
										<p style="font-size: 20px; font-weight: bold; margin-top: 10px;">${detail.vdItem}</p>
										<input class="custom-radio" type="radio" name="selectedCandidate" value="${detail.vdCode}" id="radio-${detail.vdCode}" onclick="updateReply('${detail.vdCode}', '${detail.vdItem}')">
										<label for="radio-${detail.vdCode}"></label>
									</div>	
								</div>
							</div>
						</c:forEach>
							<input type="hidden" name="voteCode" value="${voteVO.voteCode}">
							<input type="hidden" name="replyer" value="<sec:authentication property="principal.memberVO.memId" />">	
							<input type="hidden" name="selectedCandidateName" id="selectedCandidateName">
					</div>
				</fieldset>
		
				<div class="text-center" id="adminBtn" >
					<button type="submit" class="btn btn-primary mx-2">제출</button>
					<a href="/vote/list" class="btn btn-success">목록</a>
				</div>
				<sec:csrfInput />
			</form>
		</div>
	</div>
</div>