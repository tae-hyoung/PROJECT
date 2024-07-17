<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
                    <p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="ri-file-edit-line"></i><strong>의무공개 계약서</strong></p>
                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">서비스</a></li>
                            <li class="breadcrumb-item active">의무공개 계약서</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-12">
        <div class="card shadow p-3 rounded">
            <div class="card-header" style="display: flex;">
                <p class="card-title" style="font-size: 25px;">
                    <img alt="하자보수" src="/resources/images/doc.png" style="width: 40px; margin-right: 10px;">의무공개 계약서
                </p>
            </div>
            <div class="card-body table-responsive p-0" style="font-size: 16px;">
                <table class="table table-hover text-nowrap">
                    <thead>
                        <tr class="tblRow" align="center" data-waste-seq="">
                            <th>순번</th>
                            <th>구분</th>
                            <th>제목</th>
                            <th>등록일</th>
                            <th>첨부파일</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="contractVO" items="${contractVOList}" varStatus="stat">
                            <tr class="tblRow">
                                <td style="text-align: center;" width="10%">${contractVO.rnum}</td>
                                <td style="text-align: center;" width="10%">${contractVO.ctCt}</td>
                                <td width="40%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${contractVO.ctTitle}</td>
                                <td style="text-align: center;" width="25%">${contractVO.ctRegDt}</td>
                                <td style="text-align: center;" width="15%"><a href="/upload${contractVO.ctAttach}" download="${fn:split(contractVO.ctAttach, '_')[1]}"><img alt="" src="/resources/images/download.png"></a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="text-end">
                    <button type="button" style="display : none;" class="btn btn-primary waves-effect waves-light" data-bs-toggle="modal" data-bs-target="#exampleModalgrid">
                        등록
                    </button>
                </div>          

                <div class="modal fade" id="exampleModalgrid" tabindex="-1" aria-labelledby="exampleModalgridLabel" aria-modal="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div style="margin-bottom: 10px" class="modal-header">
                                <h5 class="modal-title" id="exampleModalgridLabel">의무공개 계약서 등록</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <form id="frm" name="frm" action="/contract/createAjax?${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
                                    <div class="row g-3">
                                        <div class="col-xxl-12">
                                            <div>
                                                <label for="ctSeq" class="form-label"><strong>등록번호</strong></label>
                                                <input type="text" class="form-control" id="ctSeq" name="ctSeq" placeholder="">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <label for="ctCt" class="form-label"><strong>구분</strong></label>
                                            <div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="ctCt" id="ctCt1" value="규약">
                                                    <label class="form-check-label" for="ctCt1">규약</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="ctCt" id="ctCt2" value="공고문">
                                                    <label class="form-check-label" for="ctCt2">공고문</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="ctCt" id="ctCt3" value="계약서">
                                                    <label class="form-check-label" for="ctCt3">계약서</label>
                                                </div>
                                                <div class="form-check form-check-inline">
                                                    <input class="form-check-input" type="radio" name="ctCt" id="ctCt4" value="기타">
                                                    <label class="form-check-label" for="ctCt4">기타</label>
                                                </div>
                                            </div>
                                        </div><!--end col-->
                                        <div class="col-xxl-12">
                                            <div>
                                                <label for="ctTitle" class="form-label"><strong>제목</strong></label>
                                                <input type="text" class="form-control" id="ctTitle" name="ctTitle" placeholder="제목을 입력하세요">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-xxl-12">
                                            <div>
                                                <label for="ctAttach" class="form-label"><strong>첨부파일</strong></label>
                                                <input type="file" class="form-control" id="ctAttach" name="myFiles">
                                            </div>
                                        </div><!--end col-->

                                        <div class="col-lg-12">
                                            <div class="hstack gap-2 justify-content-end">
                                                <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
                                                <button type="button" class="btn btn-primary" id="submitBtn">등록</button>
                                            </div>
                                        </div><!--end col-->
                                    </div><!--end row-->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            $('#submitBtn').click(function(event) {
                event.preventDefault(); // 기본 폼 제출 방지

                var formData = new FormData($('#frm')[0]);
                console.log("formData", formData)

                $.ajax({
                    url: '/contract/createAjax',
                    type: 'POST',
                    data: formData,
                    contentType: false,
                    processData: false,
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function(response) {
                        Swal.fire({
                            icon: 'success',
                            title: '등록 성공',
                            text: '계약서가 성공적으로 등록되었습니다.'
                        }).then(function() {
                            $('#exampleModalgrid').modal('hide'); // 모달 창 닫기
                            window.location.href = '/contract/list';
                        });
                    },
                    error: function(error) {
                        Swal.fire({
                            icon: 'error',
                            title: '등록 실패',
                            text: '계약서 등록에 실패했습니다. 다시 시도해주세요.'
                        });
                    }
                });
            });
        });
    </script>
	
	
	
