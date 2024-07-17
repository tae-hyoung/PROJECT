<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    table.dataTable thead th,
    table.dataTable tbody td {
        border: 1px solid #ddd;
        padding: 8px;
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
</style>
<div class="container-fluid">
    <div class="row">
        <div class="col-12">
            <div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
                <p class="mb-sm-0" style="font-size: 18px; color: #495057;">
                    <i class="ri-car-line"></i><strong> 방문차량 현황</strong>
                </p>
                <div class="page-title-right">
                    <ol class="breadcrumb m-0">
                        <li class="breadcrumb-item"><a href="">입주민 관리</a></li>
                        <li class="breadcrumb-item active">방문차량 현황</li>
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
                <img alt="차량신청" src="/resources/images/차량등록.png"
                    style="width: 40px; margin-right: 10px;">방문차량 신청 현황
            </p>
        </div>
        <div class="card-body " style="font-size: 16px;">
            <div class="row">
                <div class="col-md-6">
                    <canvas id="visitChart" height="150px"></canvas>
                </div>
                <div class="col-md-6">
                    <canvas id="monthlyVisitChart" height="150px"></canvas>
                </div>
            </div>
            <table class="table table-hover table-striped align-middle table-nowrap mb-0 adVisitCarList">
                <thead>
                    <tr style="text-align: center;" >
                        <th scope="col">순번</th>
                        <th scope="col">차량번호</th>
                        <th scope="col">방문자 이름</th>
                        <th scope="col">방문자 연락처</th>
                        <th scope="col">방문목적</th>
                        <th scope="col">방문 예정일</th>
                        <th scope="col">출차 예정일</th>
                        <th style="text-align: center;" scope="col">동</th>
                        <th style="text-align: center;" scope="col">호수</th>
                        <th scope="col">세대주</th>
                        <th scope="col">연락처</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="visitCarVO" items="${adVisitCarVOList}" varStatus="stat">
                        <tr class="tblRow">
                            <td style="text-align: center;">${visitCarVO.rnum}</td>
                            <td>${visitCarVO.carNo}</td>
                            <td>${visitCarVO.visitorName}</td>
                            <td>${visitCarVO.visitorTelno}</td>
                            <td>${visitCarVO.purpose}</td>
                            <td>${visitCarVO.inTm}</td>
                            <td>${visitCarVO.outTm}</td>
                            <td style="text-align: center;">${visitCarVO.memberVO.dongCode}</td>
                            <td style="text-align: center;">${visitCarVO.memberVO.roomCode}</td>
                            <td>${visitCarVO.memberVO.memNm}</td>
                            <td>${visitCarVO.memberVO.memTelno}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    var table = $('.adVisitCarList').DataTable({
        "paging": true,
        "ordering": true,
        "info": true,
        "lengthChange": false,
        "pageLength": 10,
        "order": [[0, "desc"]],  
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

    // Prepare the data for the daily chart
    var visitData = {};
    <c:forEach var="visitCarVO" items="${adVisitCarVOList}">
        var visitDate = '${visitCarVO.inTm}'.split(' ')[0]; // Extract the date part
        if (visitData[visitDate]) {
            visitData[visitDate]++;
        } else {
            visitData[visitDate] = 1;
        }
    </c:forEach>

    var visitArray = Object.keys(visitData).map(function(key) {
        return { date: key, count: visitData[key] };
    });

    visitArray.sort(function(a, b) {
        return new Date(a.date) - new Date(b.date);
    });

    var labels = visitArray.map(function(item) {
        var dateParts = item.date.split('/');
        return dateParts[1] + '/' + dateParts[2]; // Extract month and day
    });
    var data = visitArray.map(function(item) {
        return item.count;
    });

    var ctx = document.getElementById('visitChart').getContext('2d');
    var visitChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                label: '일별 방문차량 수',
                data: data,
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderWidth: 4
            }]
        },
        options: {
            scales: {
                x: {
                    beginAtZero: true,
                    title: {
                        display: false,
                        text: '날짜'
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: false,
                        text: '방문차량 수',
                        position: 'top',
                        rotation: 0
                    },
                    ticks: {
                        stepSize: 1 // Ensure y-axis increments by 1
                    }
                }
            }
        }
    });

    // Prepare the data for the monthly chart
    var monthlyData = {
        0: 0,
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0,
        7: 0,
        8: 0,
        9: 0,
        10: 0,
        11: 0
    };

    <c:forEach var="visitCarVO" items="${adVisitCarVOList}">
        var visitDate = '${visitCarVO.inTm}'.split(' ')[0]; 
        var visitMonth = parseInt(visitDate.split('/')[1], 10) - 1; 
        if (monthlyData[visitMonth]) {
            monthlyData[visitMonth]++;
        } else {
            monthlyData[visitMonth] = 1;
        }
    </c:forEach>

    var monthLabels = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"];
    var monthData = Object.values(monthlyData);

    var ctxMonthly = document.getElementById('monthlyVisitChart').getContext('2d');
    var monthlyVisitChart = new Chart(ctxMonthly, {
        type: 'bar',
        data: {
            labels: monthLabels,
            datasets: [{
                label: '월별 방문차량 수',
                data: monthData,
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                x: {
                    title: {
                        display: false,
                        text: '월'
                    }
                },
                y: {
                    beginAtZero: true,
                    title: {
                        display: false,
                        text: '방문차량 수',
                        position: 'top',
                        rotation: 0
                    },
                    ticks: {
                        stepSize: 1 
                    }
                }
            }
        }
    });
});
</script>
