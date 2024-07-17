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
    margin-bottom: 10px;
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
    height: 30px; 
}

</style>

<script>
    // 질문 추가 버튼
    let questionCount = ${voteVO.voteDetails.size()};    //기존 질문의 개수를 초기값으로 설정
    
    // 기존 설문 질문 목록에서 마지막 질문 코드 추출
    let lastVdCode = "${voteVO.voteDetails[voteVO.voteDetails.size() - 1].vdCode}";
    
    // 다음 질문 코드 생성 함수
    function getNextVdCode(currentVdCode){
        const prefix = currentVdCode.match(/^\D+/)[0];
        const number = parseInt(currentVdCode.match(/\d+$/)[0], 10) + 1;
        return prefix + number.toString().padStart(3, '0');
    }

    //질문 추가 함수
    function addQuestion(){
        questionCount++;
        
        const fieldset = document.createElement("fieldset");
        fieldset.setAttribute("name", "question");
        fieldset.className = "form-group"; // 클래스 속성 추가
        
        const legend = document.createElement("legend");
        legend.textContent = questionCount + ". 내용을 입력 해주세요.";
        fieldset.appendChild(legend);
        
        const input = document.createElement("input");
        input.type = "text";
        input.name = "voteDetails[" + (questionCount - 1) + "].vdItem";
        input.placeholder = "내용을 입력해주세요";
        input.className = "form-control question-input";
        input.required = true;
        fieldset.appendChild(input);

        // 파일 입력 필드 추가
        const fileInput = document.createElement("input");
        fileInput.type = "file";
        fileInput.name = "voteDetails[" + (questionCount - 1) + "].uploadFiles";
        fileInput.id = "uploadFiles";
        fileInput.className = "form-control";
        fileInput.multiple = true;
        fieldset.appendChild(fileInput);
        
        //다음 svd_code 생성
        lastVdCode = getNextVdCode(lastVdCode);
        
        const hiddenInputVdCode = document.createElement("input");
        hiddenInputVdCode.type = "hidden";
        hiddenInputVdCode.name = "voteDetails[" + (questionCount - 1) + "].vdCode";
        hiddenInputVdCode.value = lastVdCode;
        fieldset.appendChild(hiddenInputVdCode);
    
        const hiddenInputVoteCode = document.createElement("input");
        hiddenInputVoteCode.type = "hidden";
        hiddenInputVoteCode.name = "voteDetails[" + (questionCount - 1) + "].voteCode";
        hiddenInputVoteCode.value = "${voteVO.voteCode}";
        fieldset.appendChild(hiddenInputVoteCode);
        
        
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
        const questions = document.querySelectorAll("[name^='voteDetails']");
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
                errorMsg += "최소 한 명 이상의 후보자를 등록해야 합니다.\n";
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
            <h3 class="card-title" style="font-size: 40px;">투표 수정</h3>
        </div>
        
        <div class="card-body table-responsive" style="height: 700px;">
            <form:form action="/vote/updatePost" method="post" modelAttribute="voteVO" enctype="multipart/form-data" onsubmit="return validateForm()">
                <input type="hidden" name="voteCode" value="${voteCode}" />
                
                <div class="row">
                    <div class="col-md-5" style="margin-right: 30px;">
                        <div>
                            <label for="voteTitle" class="form-label">투표제목</label>
                            <form:input path="voteTitle" id="voteTitle" class="form-control" placeholder="제목을 입력해주세요" required="required"/>
                        </div>
                        <div>
                            <label for="beginTm" class="form-label">시작일</label>
                            <input type="datetime-local" id="beginTm" name="beginTm" class="form-control" onchange="formatDateTime(this, 'beginTmFormatted')" required="required" value="${voteVO.beginTm}" />
                            <input type="hidden" id="beginTmFormatted" name="beginTmFormatted">
                        </div>
                        
                        <div>
                            <label for="endTm" class="form-label">마감일</label>
                            <input type="datetime-local" id="endTm" name="endTm" class="form-control" onchange="formatDateTime(this, 'endTmFormatted')" required="required" value="${voteVO.endTm}" />
                            <input type="hidden" id="endTmFormatted" name="endTmFormatted">
                        </div>
                        
                        <div class="row mt-3">
                        	<div class="col-md-12 d-flex justify-content-center" style="margin-bottom: 20px;">
		                        <input type="submit" value="수정 " class="btn btn-primary mx-2">
		                        <input type="button" value="취소" class="btn btn-secondary mx-2" onclick="goBack()">
                        	</div>
                        </div>
                    </div>
                    
                    <div class="col-md-5">
                        <div id="questions">
                            <c:forEach var="detail" items="${voteVO.voteDetails}" varStatus="loop">
                                <fieldset class="form-group">
                                    <legend>${loop.index + 1}. 내용을 입력 해주세요.</legend>
                                    <input type="text" name="voteDetails[${loop.index}].vdItem" value="${detail.vdItem}" class="form-control question-input" placeholder="내용을 입력해주세요" required="required"/>
                                    <input class="form-control" type="file" id="uploadFiles" name="voteDetails[${loop.index}].uploadFiles" multiple>
                                    <c:if test="${detail.attach != null}">
                                        <p>이미 등록된 파일: ${detail.attach}</p>
                                    </c:if>
                                    <input type="hidden" name="voteDetails[${loop.index}].vdCode" value="${detail.vdCode}" />
                                    <input type="hidden" name="voteDetails[${loop.index}].voteCode" value="${voteVO.voteCode}" />
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
</div>
