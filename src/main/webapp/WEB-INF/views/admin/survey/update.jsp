<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<style>
.form-control {
	width: 100%;
}

.form-group {
    margin-bottom: 20px;
}

.container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 20px;
}
.form-label{
	margin-top: 20px;
}

fieldset {
    display: flex;
    flex-direction: column;
}

legend {
    margin-bottom: 10px;
    font-weight: bold;
}
.question-input {
    height: 40px; 
}
.submit-reset{
    margin-top: 30px;
    justify-content: center;
}
</style>

<script>
	// 질문 추가 버튼
	let questionCount = ${surveyVO.surveyDetails.size()};	//기존 질문의 개수를 초기값으로 설정
	
	// 기존 설문 질문 목록에서 마지막 질문 코드 추출
    let lastSvdCode = "${surveyVO.surveyDetails[surveyVO.surveyDetails.size() - 1].svdCode}";
	
 	// 다음 질문 코드 생성 함수
	function getNextSvdCode(currentSvdCode){
		const prefix = currentSvdCode.match(/^\D+/)[0];
        const number = parseInt(currentSvdCode.match(/\d+$/)[0], 10) + 1;
        return prefix + number.toString().padStart(3, '0');
	}
	
	//질문 추가 함수
	function addQuestion(){
		questionCount++;
		
		const fieldset = document.createElement("fieldset");
		fieldset.setAttribute("name", "question");
	    fieldset.className = "form-group"; // 클래스 속성 추가
		
		const legend = document.createElement("legend");
		legend.textContent = questionCount + ". 질문을 입력해주세요.";
		fieldset.appendChild(legend);
		
		const input = document.createElement("input");
		input.type = "text";
		input.name = "surveyDetails[" + (questionCount - 1) + "].svdItem";
		input.placeholder = "질문을 입력해주세요";
		fieldset.appendChild(input);
		
		//다음 svd_code 생성
		lastSvdCode = getNextSvdCode(lastSvdCode);
		
        const hiddenInputSvdCode = document.createElement("input");
        hiddenInputSvdCode.type = "hidden";
        hiddenInputSvdCode.name = "surveyDetails[" + (questionCount - 1) + "].svdCode";
        hiddenInputSvdCode.value = lastSvdCode;
        fieldset.appendChild(hiddenInputSvdCode);

        const hiddenInputSvCode = document.createElement("input");
        hiddenInputSvCode.type = "hidden";
        hiddenInputSvCode.name = "surveyDetails[" + (questionCount - 1) + "].svCode";
        hiddenInputSvCode.value = "${surveyVO.svCode}";
        fieldset.appendChild(hiddenInputSvCode);
		
		
		document.getElementById("questions").appendChild(fieldset);
	}
	
    // 질문 삭제 버튼(-)
    function removeQuestion(){
    	const questionsDiv = document.getElementById("questions");
        if (questionsDiv.children.length > 1) {
            questionsDiv.removeChild(questionsDiv.lastElementChild);
            questionCount--;
        } else {
            swal.fire({
          	   icon: 'error',
          	   title: '최소 질문 갯수',
          	   text: '최소 한개 이상 질문이 필요합니다.'
             });
        }
	}    
	
	// 유효성 검사
	function validateForm() {
    	const beginTm = document.getElementById("beginTm").value;
    	const endTm = document.getElementById("endTm").value;
        const questions = document.querySelectorAll("[name^='surveyDetails']");
        	let isValid = true;
            let errorMsg = '';

            if (!beginTm) {
                isValid = false;
                errorMsg += "시작일을 입력해주세요.\n";
            }

            if (!endTm) {
                isValid = false;
                errorMsg += "마감일을 입력해주세요.\n";
            }

            if (beginTm && endTm && new Date(beginTm) > new Date(endTm)) {
                isValid = false;
                swal.fire({
                	icon: 'error',
                	title: '날짜 설정 오류',
                	text: '마감일은 시작일보다 이후의 날짜여야 합니다.'
                });
            }

            let hasQuestion = false;
            questions.forEach(question => {
                if (question.value.trim() !== '') {
                    hasQuestion = true;
                }
            });

            if (!hasQuestion) {
                isValid = false;
                errorMsg += "최소 한 개 이상의 질문을 등록해야 합니다.\n";
            }

//             if (!isValid) {
//                 alert(errorMsg);
//             }

            return isValid;
        }
	
    function goBack() {
        const prevURL = document.referrer;
        if (prevURL) {
            window.location.href = prevURL;
        } else {
            window.history.back();
        }
    }	
</script>
<div class="col-12">
	<div class="card">
		<div class="card-header">
			<h3 class="card-title" style="font-size: 40px;">수정 페이지</h3>
		</div>
	</div>

    <div class="card-body table-responsive" style="height: 600px;">
        <form:form action="/survey/updatePost" method="post" modelAttribute="surveyVO" onsubmit="return validateForm()">
            <input type="hidden" name="svCode" value="${svCode}" />
			
			<div class="row">
				<div class="col-md-5" style="margin-right: 30px;">
		            <div>
		                <label for="svTitle" class="form-label">설문 제목</label>
		                <input type="text" id="svTitle" name="svTitle" class="form-control" placeholder="제목을 입력해주세요" required="required" value="${surveyVO.svTitle}" />
		            </div>
		
		            <div>
		                <label for="beginTm" class="form-label">시작일</label>
		                <input type="datetime-local" id="beginTm" name="beginTm" class="form-control" onchange="formatDateTime(this, 'beginTmFormatted')" required="required" value="${surveyVO.beginTm}" />
		                <input type="hidden" id="beginTmFormatted" name="beginTmFormatted">
		            </div>
		
		            <div>
		                <label for="endTm" class="form-label">마감일</label>
		                <input type="datetime-local" id="endTm" name="endTm" class="form-control" onchange="formatDateTime(this, 'endTmFormatted')" required="required" value="${surveyVO.endTm}" />
		                <input type="hidden" id="endTmFormatted" name="endTmFormatted">
		            </div>
		            
					<div class="row mt-3">
						<div class="col-md-12 d-flex justify-content-center" style="margin-bottom: 20px;">
							<input type="submit" value="수정" class="btn btn-primary mx-2">
							<input type="button" value="취소" class="btn btn-secondary mx-2" onclick="goBack()">
						</div>
					</div>
				</div>
				
				<div class="col-md-5">
		            <div id="questions">
		                <c:forEach var="detail" items="${surveyVO.surveyDetails}" varStatus="loop">
		                    <fieldset  class="form-group">
		                        <legend>${loop.index + 1}. 질문을 입력해주세요.</legend>
		                        <input type="text" name="surveyDetails[${loop.index}].svdItem" value="${detail.svdItem}" class="form-control question-input" placeholder="질문을 입력해주세요" />
		                        <input type="hidden" name="surveyDetails[${loop.index}].svdCode" value="${detail.svdCode}" />
		                        <input type="hidden" name="surveyDetails[${loop.index}].svCode" value="${surveyVO.svCode}" />
		                    </fieldset>
		                </c:forEach>
		            </div>
				</div>
				
					<div class="col-md-1">
			            <div class="plus-minus">
			                <table>
			                    <tr>
			                        <td><input type="button" value="+" class="btn btn-primary" onclick="addQuestion()"></td>
			                        <td><input type="button" value="-" class="btn btn-secondary" onclick="removeQuestion()"></td>
			                    </tr>
			                </table>
			            </div>
					</div>			            
				</div>
        </form:form>
	</div>
	
</div>