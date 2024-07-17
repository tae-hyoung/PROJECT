<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!--datatable css-->
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
<!--datatable responsive css-->
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">
<!--datatable js-->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<!-- SweetAlert2 CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
    div.dataTables_wrapper div.dataTables_paginate ul.pagination {
        margin: 2px 0;
        white-space: nowrap;
        justify-content: flex-start !important;
    }
    table.dataTable thead th,
    table.dataTable tbody td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
        vertical-align: middle;
    }

    table.dataTable thead th {
        background-color: #f2f2f2;
        cursor: pointer;
    }

    table.dataTable thead th.sorting,
    table.dataTable thead th.sorting_asc,
    table.dataTable thead th.sorting_desc {
        background-color: #66B2FF;
    }

    table.dataTable thead th.sorting:after,
    table.dataTable thead th.sorting_asc:after,
    table.dataTable thead th.sorting_desc:after {
        content: "";
        position: absolute;
        right: 10px;
        top: 50%;
        margin-top: -6px;
        border-width: 6px 6px 0 6px;
        border-style: solid;
        border-color: transparent transparent #333 transparent;
    }

    table.dataTable thead th.sorting_asc:after {
        border-width: 0 6px 6px 6px;
        border-color: #333 transparent transparent transparent;
    }

    table.dataTable thead th.sorting_desc:after {
        border-width: 6px 6px 0 6px;
        border-color: transparent transparent #333 transparent;
    }
    
    /* DataTables 기본 스타일 */
.dataTables_wrapper {
    font-family: "Poppins", sans-serif;  /* 원하는 글씨체로 설정 */
    font-size: 13px;  /* 글씨 크기 설정 */
}

#VisitCarVOList th, #VisitCarVOList td {
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
}
#VisitCarVOList th:nth-child(1), #VisitCarVOList td:nth-child(1) {
    width: 5%;
}
#VisitCarVOList th:nth-child(2), #VisitCarVOList td:nth-child(2) {
    width: 10%;
}
#VisitCarVOList th:nth-child(3), #VisitCarVOList td:nth-child(3) {
    width: 10%;
}
#VisitCarVOList th:nth-child(4), #VisitCarVOList td:nth-child(4) {
    width: 15%;
}
#VisitCarVOList th:nth-child(5), #VisitCarVOList td:nth-child(5) {
    width: 10%;
}
#VisitCarVOList th:nth-child(6), #VisitCarVOList td:nth-child(6) {
    width: 20%;
}
#VisitCarVOList th:nth-child(7), #VisitCarVOList td:nth-child(7) {
    width: 20%;
}
#VisitCarVOList th:nth-child(8), #VisitCarVOList td:nth-child(8) {
    width: 5%;
}
#VisitCarVOList th:nth-child(9), #VisitCarVOList td:nth-child(9) {
    width: 5%;
}
</style>   
    
    
<div style="display: none" id="memId"><sec:authentication property="principal.memberVO.memId" /></div>

<script type="text/javascript">
$(document).ready(function() {
    var table = $('#VisitCarVOList').DataTable({
        "paging": true,
        "ordering": true,
        "info": true,
        "lengthChange": false,
        "pageLength": 7,
        "order": [[0, "desc"]],  // 첫 번째 열(RNUM)을 내림차순으로 정렬
        "language": {
            "zeroRecords": "검색 결과가 없습니다.",
            "search": "",
            "paginate": {
                "next": "다음",
                "previous": "이전"
            },
            "info": "TOTAL :  _TOTAL_ 건<br>PAGE : _PAGE_ 페이지/ _PAGES_ 페이지 "
        }
    });
    
    // DataTable 초기화 후 검색 입력 필드의 placeholder 속성 설정
    $('.dataTables_filter input').attr('placeholder', '검색어를 입력해주세요');

    getVisitCarList();

    $('#btnSubmit').on('click', function(event) {
        event.preventDefault();

        var memId = $("#memId").text().trim();
        var carNo = $("#carNo").val().trim();
        var visitorName = $("#visitorName").val().trim();
        var visitorTelno = $("#visitorTelno").val().trim();
        var inTm = $("#inTm").val().trim();
        var outTm = $("#outTm").val().trim();
        var purpose = $("#purpose").val().trim();

        // 차량 번호 정규식 패턴
        var carNoPattern = /^\d{3}[가-힣]\d{4}$/;
        if (!carNoPattern.test(carNo)) {
            Swal.fire({
                icon: 'error',
                title: '차량 번호가 유효하지 않습니다',
                text: '형식은 숫자 3자리 + 한글 1자리 + 숫자 4자리여야 합니다.'
            });
            return;
        }

        // 필수 입력 필드 확인
        if (!visitorName) {
            Swal.fire({
                icon: 'error',
                title: '방문자 성명을 입력하세요'
            });
            return;
        }
        
        if (!visitorTelno) {
            Swal.fire({
                icon: 'error',
                title: '방문자 연락처를 입력하세요'
            });
            return;
        }
        
        if (!inTm) {
            Swal.fire({
                icon: 'error',
                title: '방문 예정일을 입력하세요'
            });
            return;
        }
        
        if (!outTm) {
            Swal.fire({
                icon: 'error',
                title: '출차 예정일을 입력하세요'
            });
            return;
        }
        
        if (!purpose) {
            Swal.fire({
                icon: 'error',
                title: '방문목적을 입력하세요'
            });
            return;
        }
        
        // 방문 예정일과 출차 예정일 비교
        if (new Date(outTm) < new Date(inTm)) {
            Swal.fire({
                icon: 'error',
                title: '날짜 오류',
                text: '출차 예정일이 방문 예정일보다 빠를 수 없습니다.'
            });
            return;
        }

        // 날짜 시간 포맷 변환
        function formatDateTime(datetime) {
            if (!datetime) return "";
            var dt = new Date(datetime);
            var year = dt.getFullYear();
            var month = ("0" + (dt.getMonth() + 1)).slice(-2);
            var day = ("0" + dt.getDate()).slice(-2);
            var hours = ("0" + dt.getHours()).slice(-2);
            var minutes = ("0" + dt.getMinutes()).slice(-2);
            var seconds = "00"; // datetime-local does not 제공 seconds
            return `\${year}-\${month}-\${day} \${hours}:\${minutes}:\${seconds}`;
        }

        var formattedInTm = formatDateTime(inTm);
        var formattedOutTm = formatDateTime(outTm);

        let data = {
            memId: memId,
            carNo: carNo,
            visitorName: visitorName,
            visitorTelno: visitorTelno,
            inTm: formattedInTm,
            outTm: formattedOutTm,
            purpose: purpose
        };

        $.ajax({
            url: "/visitcar/create",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data),
            type: "post",
            dataType: "text",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },

            success: function(result) {
                console.log("result : ", result);
                getVisitCarList();
                Swal.fire({
                    icon: 'success',
                    title: '성공',
                    text: '차량이 성공적으로 등록되었습니다.',
                });
                // 입력 필드 초기화
                $("#carNo").val("");
                $("#visitorName").val("");
                $("#visitorTelno").val("");
                $("#inTm").val("");
                $("#outTm").val("");
                $("#purpose").val("");
            },
            error: function(error) {
                Swal.fire({
                    icon: 'error',
                    title: '등록 실패',
                    text: '차량 등록에 실패했습니다. 다시 시도해주세요.',
                });
            }
        });
    });

    $(document).on('click', ".delete",  function(){
        let carNo = $(this).parent().parent().children().eq(1).text();

        Swal.fire({
            title: '차량을 삭제하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: '네, 삭제하겠습니다!',
            cancelButtonText: '취소'
        }).then((result) => {
            if (result.isConfirmed) {
                let data = {
                    "carNo": carNo
                };

                $.ajax({
                    url: "/visitcar/deleteAjax",
                    contentType: "application/json;charset=utf-8",
                    data: JSON.stringify(data),
                    type: "post",
                    dataType: "json",
                    beforeSend: function(xhr) {
                        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                    },
                    success: function(response) {
                        console.log("result : ", response);

                        if (result != null) {
                            getVisitCarList();
                            Swal.fire({
                                position: "center",
                                icon: "success",
                                title: "삭제가 완료 되었습니다.",
                                timer: 1000,
                                showConfirmButton: false
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: '삭제 실패',
                                text: '차량 삭제에 실패했습니다. 다시 시도해주세요.',
                            });
                        }
                    },
                    error: function(error) {
                        Swal.fire({
                            icon: 'error',
                            title: '삭제 실패',
                            text: '차량 삭제에 실패했습니다. 다시 시도해주세요.',
                        });
                    }
                });
            }
        });
    });

    function getVisitCarList() {
        let data2 = {
            memId: $('#memId').text()
        };

        $.ajax({
            url: "/visitcar/list",
            contentType: "application/json;charset=utf-8",
            data: JSON.stringify(data2),
            type: "post",
            dataType: "json",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                console.log("result:", result);

                let str = "";
                for (let i = 0; i < result.length; i++) {
                    str += "<tr>";
                    str += "<td style='text-align: center;'>" + result[i].rnum + "</td>"
                    str += "<td>" + result[i].carNo + "</td>";
                    str += "<td>" + result[i].visitorName + "</td>";
                    str += "<td>" + '010-' + result[i].visitorTelno.substr(3, 4) + '-' + result[i].visitorTelno.substr(7, 4) + "</td>";
                    str += "<td>" + result[i].purpose + "</td>";
                    str += "<td>" + result[i].regDt + "</td>";
                    str += "<td>" + result[i].inTm + "</td>";
                    if(result[i].status == "방문완료"){
                    	str += "<td><span style='font-size: 14px' class='badge bg-warning'>" + result[i].status + "</td>";
                    }
                   	else{
	                    str += "<td><span style='font-size: 14px' class='badge bg-success'>" + result[i].status + "</td>";
                   	}
                    str += "<td><button style='font-size: 14px' class='btn btn-danger btn-sm delete' data-car-no='" + result[i].carNo + "'>삭제</button></td>";
                    str += "</tr>";
                }

                console.log("str:", str);

                $("#VisitCarVOList tbody").html(str);
                table.clear().draw();
                table.rows.add($(str)).draw();
            }
        });
    }
});

</script>



<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
                <p class="mb-sm-0" style="font-size: 18px; color: #495057;">
                    <i class="ri-car-line"></i><strong> 방문차량 등록</strong>
                </p>
                <div class="page-title-right">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="">차량등록</a></li>
                        <li class="breadcrumb-item active">방문차량 등록</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-4">
        <div class="card shadow p-3 rounded" style="height:710px; min-height: 710px;">
            <div class="card-header align-items-center d-flex">
                <p class="card-title mb-0 flex-grow-1" style="font-size: 25px;">
                    <img alt="방문차량" src="/resources/images/차량등록.png" style="width: 35px; margin-right: 10px;">방문차량 등록
                    <button style="margin-left:155px;" class="btn btn-primary auto" id="auto">자동입력</button>
                </p>
            </div>
            <div class="card-body" style="font-size: 15px;">
                <div class="live-preview">
                    <form id="frm" name="frm" action="/visitcar/updatePost" method="post" enctype="multipart/form-data" style="font-size: 15px;">
                        <div class="mb-3">
                            <label for="carNo" class="form-label">차량 번호</label> 
                            <input type="button" class="btn btn-secondary waves-effect waves-light end" id="btnSubmit" value="등록" style="float: right; margin-bottom:10px;">
                            <input type="text" class="form-control" id="carNo" name="carNo" value="">
                        </div>
                        <div class="mb-3">
                            <label for="visitorName" class="form-label">방문자 성명</label> 
                            <input type="text" class="form-control" id="visitorName" value="" required="required">
                        </div>
                        <div class="mb-3">
                            <label for="visitorTelno" class="form-label">방문자 연락처</label> 
                            <input type="text" class="form-control" id="visitorTelno" value="" required="required">
                        </div>
                        <div class="mb-3">
                            <label for="inTm" class="form-label">방문 예정일</label> 
                            <input type="datetime-local" class="form-control" id="inTm" value="" required="required">
                        </div>
                        <div class="mb-3">
                            <label for="outTm" class="form-label">출차 예정일</label> 
                            <input type="datetime-local" id="outTm" class="form-control" value="" required="required">
                        </div>
                        <div class="mb-3">
                            <label for="purpose" class="form-label">방문목적</label> 
                            <input type="text" class="form-control" id="purpose" value="" required="required">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-8">
        <div class="card shadow p-3 rounded" style="min-height: 710px;">
            <div class="card-header align-items-center d-flex">
                <p class="card-title mb-0 flex-grow-1" style="font-size: 25px;">
                    <img alt="하자보수" src="/resources/images/차량등록.png" style="width: 35px; margin-right: 10px;">방문차량 목록
                </p>
            </div>
            <div class="card-body">
                <table id="VisitCarVOList" class="display table table-bordered dt-responsive" style="width: 100%; font-size: 15px">
                    <thead>
                        <tr>
                        	<th style="text-align: center;">순번</th>
                            <th style="text-align: center;">차량번호</th>
                            <th style="text-align: center;">방문자 이름</th>
                            <th style="text-align: center;">방문자 연락처</th>
                            <th style="text-align: center;">방문 목적</th>
                            <th style="text-align: center;">신청일시</th>
                            <th style="text-align: center;">방문일시</th>
                            <th style="text-align: center;">상태</th>
                            <th style="text-align: center;">삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="VisitCarVOList" items="${visitcarVOList}" varStatus="stat">
                            <tr>
                                <td>${VisitCarVOList.rnum}</td>
                                <td>${VisitCarVOList.carNo}</td>
                                <td>${VisitCarVOList.visitorName}</td>
                                <td>${VisitCarVOList.visitorTelno}</td>
                                <td>${VisitCarVOList.purpose}</td>
                                <td>${VisitCarVOList.regDt}</td>
                                <td>${VisitCarVOList.inTm}</td>
                                <td><span class="badge bg-success" class="status">${VisitCarVOList.status}</span></td>
                                <td><button class="btn btn-danger btn-sm delete" data-car-no="${VisitCarVOList.carNo}">삭제</button></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>


<script>
$('#auto').on('click', function(){
   $('#carNo').val('223너7864');
   $('#visitorName').val('이철희');
   $('#visitorTelno').val('01047364364');
   $('#inTm').val('2024-07-16 11:00');
   $('#outTm').val('2024-07-17 11:00');
   $('#purpose').val('코딩과외');
})

</script>