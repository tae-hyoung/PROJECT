<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- 스윗 알럿 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<style>
.form-control {
	width: 100%;
}

.form-group {
    margin-bottom: 20px;
    width: 100%;
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

</style>

<script>
    function validateForm() {
        var beginTm = new Date(document.getElementById("beginTm").value);
        var endTm = new Date(document.getElementById("endTm").value);

        if (endTm <= beginTm) {
            swal.fire({
            	icon: 'error',
            	title: '날짜 설정 오류',
            	text: '마감일은 시작일보다 이후의 날짜여야 합니다.'
            });
            return false;
        }

        return true;
    }

    let questionCount = 1;

    function addQuestion() {
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
        input.placeholder = "질문을 입력해주세요";
        input.className = "form-control"; // 클래스 속성 추가
        fieldset.appendChild(input);

        const inputFiles = document.createElement("input");
        inputFiles.type = "file";
        inputFiles.name = "voteDetails[" + (questionCount - 1) + "].uploadFiles";
        inputFiles.className = "form-control"; // 클래스 속성 추가
        fieldset.appendChild(inputFiles);
        
        document.getElementById("questions").appendChild(fieldset);
    }

    function removeQuestion() {
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
    
    function formatDateTime(input, hiddenFieldId) {
        const date = new Date(input.value);
        const formattedDate = date.toISOString().slice(0, 16).replace("T", " ");
        document.getElementById(hiddenFieldId).value = formattedDate;
    }

    function goBack() {
        window.history.back();
    }
</script>

<div class="col-12">
    <div class="card">
        <div class="card-header">
            <h3 class="card-title" style="font-size: 40px;">투표 제작 페이지</h3>
        </div>

        <div class="card-body table-responsive" style="height: 900px;">
            <form:form action="/vote/createPost" method="post" modelAttribute="voteVO" enctype="multipart/form-data" onsubmit="return validateForm()">
                
                <div class="row">
                    <div class="col-md-5" style="margin-right: 30px;">
                        <div>
                            <label for="voteTitle" class="form-label">투표제목</label>
                            <form:input path="voteTitle" id="voteTitle" class="form-control" placeholder="제목을 입력해주세요" required="required"/>
                        </div>
                        <div>
                            <label for="beginTm" class="form-label">시작일</label>
                            <input type="datetime-local" id="beginTm" name="beginTm" class="form-control" onchange="formatDateTime(this, 'beginTmFormatted')" required="required" />
                            <input type="hidden" id="beginTmFormatted" name="beginTmFormatted">
                        </div>
                        <div>
                            <label for="endTm" class="form-label">마감일</label>
                            <input type="datetime-local" id="endTm" name="endTm" class="form-control" onchange="formatDateTime(this, 'endTmFormatted')" required="required" />
                            <input type="hidden" id="endTmFormatted" name="endTmFormatted">
                        </div>
                        
					<div class="row mt-3">
	                    <div class="col-md-12 d-flex justify-content-center">
	                        <input type="submit" value="등록" class="btn btn-primary mx-2">
	                        <input type="reset" value="취소" class="btn btn-secondary mx-2" onclick="goBack()">
	                    </div>
                	</div>
                        
                    </div>

                    <div class="col-md-5">
                        <div id="questions">
                            <fieldset name="question" class="form-group">
                                <legend>1. 내용을 입력 해주세요.</legend>
                                <form:input path="voteDetails[0].vdItem" placeholder="내용을 입력해주세요" class="form-control" required="required" />
                                <input class="form-control" type="file" id="uploadFiles" name="voteDetails[0].uploadFiles" multiple>
                            </fieldset>
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