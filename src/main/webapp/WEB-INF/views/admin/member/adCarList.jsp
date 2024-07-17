<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<link rel="stylesheet"
	href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
<!--datatable responsive css-->
<link rel="stylesheet" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.bootstrap.min.css" />
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.2/css/buttons.dataTables.min.css">
<!-- datatable js -->
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.datatables.net/responsive/2.2.9/js/dataTables.responsive.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<style>
div.dataTables_wrapper div.dataTables_paginate ul.pagination {
	margin: 2px 0;
	white-space: nowrap;
	justify-content: flex-start !important;
}

table.dataTable thead th, table.dataTable tbody td {
	border: 1px solid #ddd;
	padding: 8px;
	vertical-align: middle;
}

table.dataTable thead th {
	background-color: #f2f2f2;
	cursor: pointer;
}

table.dataTable thead th.sorting, table.dataTable thead th.sorting_asc,
	table.dataTable thead th.sorting_desc {
	background-color: #66B2FF;
}

table.dataTable thead th.sorting:after, table.dataTable thead th.sorting_asc:after,
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

.select-wrapper {
	display: flex;
	justify-content: center;
	align-items: center;
}

/* DataTables 기본 스타일 */
.dataTables_wrapper {
    font-family: "Poppins", sans-serif;  /* 원하는 글씨체로 설정 */
    font-size: 16px;  /* 글씨 크기 설정 */
}

</style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
                    <p class="mb-sm-0" style="font-size:18px; color: #495057;">
                        <i class="ri-car-line"></i><strong>  입주자 차량신청 내역</strong>
                    </p>
                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">입주민</a></li>
                            <li class="breadcrumb-item active">입주자 차량신청 내역</li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-12">
        <div class="card shadow p-3 rounded">
            <div class="card-header d-flex" style="display: flex;">
                <p class="card-title" style="font-size: 25px;">
                    <img alt="차량신청" src="/resources/images/차량등록.png" style="width: 40px; margin-right: 10px;">입주자 차량신청 내역
                </p>
            </div>
            <div class="card-body " style="font-size: 15px;">
            <canvas id="dongChart" height="70px"></canvas>
	                <table class="table table-hover table-striped align-middle table-nowrap mb-0 adCarList">
	                    <thead>
	                        <tr style="text-align: center;" >
	                            <th scope="col">순번</th>
	                            <th scope="col">동</th>
	                            <th scope="col">호수</th>
	                            <th scope="col">회원ID</th>
	                            <th scope="col">이름</th>
	                            <th scope="col">전화번호</th>
	                            <th scope="col">차량번호</th>
	                            <th scope="col">모델명</th>
	                            <th scope="col">신청일</th>
	                            <th scope="col">상태</th>
	                            <th scope="col">변경</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach var="carVO" items="${adCarVOList}" varStatus="stat">
	                            <tr class="tblRow" id="row-${carVO.carNo}">
	                                <td align="center">${carVO.rnum}</td>
	                                <td align="center">${carVO.memberVO.dongCode}</td>
	                                <td align="center">${carVO.memberVO.roomCode}</td>
	                                <td>${carVO.memId}</td>
	                                <td>${carVO.memberVO.memNm}</td>
	                                <td>${carVO.memberVO.memTelno}</td>
	                                <td>${carVO.carNo}</td>
	                                <td>${carVO.carModel}</td>
	                                <td>${carVO.regDt}</td>
	                                <td style="text-align: center;">
	                                    <span style="font-size: 15px" id="status-badge-${carVO.carNo}" class="badge ${carVO.status == '승인대기' ? 'bg-warning text-white' : carVO.status == '승인완료' ? 'bg-success text-white' : 'bg-danger text-white'}">${carVO.status}</span>
	                                </td>
	                                <td>
		                                <div class="select-wrapper">
		                                    <select class="status-selector" data-carno="${carVO.carNo}">
		                                        <option value="승인대기" ${carVO.status == '승인대기' ? 'selected' : ''}>승인대기</option>
		                                        <option value="승인완료" ${carVO.status == '승인완료' ? 'selected' : ''}>승인완료</option>
		                                        <option value="승인거절" ${carVO.status == '승인거절' ? 'selected' : ''}>승인거절</option>
		                                    </select>
		                                </div>
	                                </td>
	                            </tr>
	                        </c:forEach>
	                    </tbody>
	                </table>
                </div>
            </div>
        </div>

    <script>
        function updateStatus(carNo, status) {
            var data = {
                carNo: carNo,
                status: status
            };

            $.ajax({
                url: "/car/admin/updateAjax",
                contentType: "application/json;charset=utf-8",
                data: JSON.stringify(data),
                type: "post",
                beforeSend: function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(response) {
                    Swal.fire({
                        position: "center",
                        icon: "success",
                        title: "변경이 완료 되었습니다.",
                        timer: 1000,
                        showConfirmButton: false
                    }).then(() => {
                        // 상태 배지 업데이트
                        var badge = $('#status-badge-' + carNo);
                        badge.text(status);
                        badge.removeClass('bg-warning text-white bg-success text-white bg-danger text-white');
                        if (status === '승인대기') {
                            badge.addClass('bg-warning text-white');
                        } else if (status === '승인완료') {
                            badge.addClass('bg-success text-white');
                        } else if (status === '승인거절') {
                            badge.addClass('bg-danger text-white');
                        }
                    });
                },
                error: function(error) {
                    console.error('Error updating status:', error);
                    Swal.fire({
                        icon: 'error',
                        title: '변경에 실패했습니다.',
                        text: '다시 시도해주세요.',
                    });
                }
            });
        }

        $(document).ready(function() {
            var table = $('.adCarList').DataTable({
                "paging": true,
                "ordering": true,
                "info": true,
                "lengthChange": false,
                "pageLength": 10,
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

            $('.dataTables_filter input').attr('placeholder', '검색어를 입력해주세요');
            
            $(document).on('change', '.status-selector', function() {
                var carNo = $(this).data('carno');
                var status = $(this).val();
                updateStatus(carNo, status);
            });
            
         // Prepare the data for the chart
            var dongData = {
                "101동": 60, "102동": 60, "103동": 90, "104동": 90, "105동": 90,
                "106동": 90, "107동": 90, "108동": 90, "109동": 90, "110동": 90,
                "111동": 90, "112동": 90, "113동": 90, "114동": 90, "115동": 90,
                "116동": 90, "117동": 90, "118동": 90, "119동": 90
            };
            var registrationData = {
                "101동": 0, "102동": 0, "103동": 0, "104동": 0, "105동": 0,
                "106동": 0, "107동": 0, "108동": 0, "109동": 0, "110동": 0,
                "111동": 0, "112동": 0, "113동": 0, "114동": 0, "115동": 0,
                "116동": 0, "117동": 0, "118동": 0, "119동": 0
            };

            <c:forEach var="carVO" items="${adCarVOList}">
                var dong = '${carVO.memberVO.dongCode}동';
                if (registrationData[dong] !== undefined) {
                    registrationData[dong]++;
                }
            </c:forEach>

            var labels = Object.keys(dongData);
            var data = Object.values(dongData);
            var regData = Object.values(registrationData);

            var ctx = document.getElementById('dongChart').getContext('2d');
            var dongChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: '주차 가능 대수',
                        data: data,
                        borderColor: 'rgba(75, 192, 192, 1)',
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderWidth: 1
                    }, {
                        label: '등록된 차량 수',
                        data: regData,
                        borderColor: 'rgba(255, 99, 132, 1)',
                        backgroundColor: 'rgba(255, 99, 132, 0.2)',
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        x: {
                            title: {
                                display: false,
                                text: '동'
                            }
                        },
                        y: {
                            beginAtZero: true,
                            title: {
                                display: false,
                                text: '대수'
                            },
                            ticks: {
                                stepSize: 10
                            }
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>