<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>

<style>
.chart-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    width: 100%;
}
.chart {
    width: 40%;
    height: 40%;
}
</style>

<div class="col-12">
    <div class="card">
        <div class="card-header text-center">
            <h3 style="font-size: 40px;">${surveyVO.svTitle}&nbsp;&nbsp;&nbsp; 참여율</h3>
            <p style="font-weight: bold;">참여자 수 : &nbsp;<span id="participantCount"></span>명</p>
        </div>
        
        <div class="card-body table-responsive" style="height: 600px;">
            <div class="chart-container">
                <canvas id="doughnut" class="chart"></canvas>
            </div>
        </div>
        <div class="text-center mt-3" style="margin-bottom: 10px;">
            <a href="/survey/admin/list" class="btn btn-success">목록</a>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const doughnut = document.getElementById('doughnut');

    // 참여자 수를 계산하는 함수
    function countParticipants() {
        const uniqueParticipants = new Set();
        <c:forEach var="surveyResultVO" items="${surveyResultVOList}">
            uniqueParticipants.add("${surveyResultVO.replyer}");
        </c:forEach>
        return uniqueParticipants.size;
    }

    // JSP 값을 자바스크립트 변수로 할당
    const participantCount = countParticipants();
    const getMember = ${getMember};  // 단지 인원수
    const danjiCode = "${danjiCode}";

    const labels = [
        '참여',
        '미참여'
    ];

    const data = [
        participantCount,
        getMember - participantCount,
    ];

    const percentage = (participantCount / getMember * 100).toFixed(2) + '%';

    // 커스텀 플러그인 정의
    const centerTextPlugin = {
        id: 'centerText',
        beforeDraw: function(chart) {
            if (chart.config.type === 'doughnut') {
                var width = chart.width,
                    height = chart.height,
                    ctx = chart.ctx;

                ctx.restore();
                
                var fontSize1 = (height / 200).toFixed(2);  // 폰트 크기 조정 (첫 번째 줄)
                var fontSize2 = (height / 100).toFixed(2);  // 폰트 크기 조정 (두 번째 줄)
                
                ctx.textBaseline = "middle";

                var text1 = "참여율";
                var text2 = percentage;

                ctx.font = fontSize1 + "em sans-serif";
                var text1X = Math.round((width - ctx.measureText(text1).width) / 2) + 19;
                var text1Y = height / 2 - 40;  // 상단 텍스트 위치
                
                ctx.fillText(text1, text1X, text1Y);
                
                ctx.font = fontSize2 + "em sans-serif";
                var text2X = Math.round((width - ctx.measureText(text2).width) / 2) + 20;
                var text2Y = height / 2 + 30;  // 하단 텍스트 위치
                
                ctx.fillText(text2, text2X, text2Y);

                ctx.save();
            }
        }
    };
    
    new Chart(doughnut, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                backgroundColor: ['#36A2EB', '#FF6384'],  // 색상을 필요에 따라 변경
                data: data
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true,
                    position: 'left',
                    labels: {
                        font: {
                            size: 20
                        }
                    }
                },
                tooltip: {
                    enabled: true
                }
            },
            layout: {
                padding: {
                    left: 0,
                    right: 100,
                    top: 0,
                    bottom: 0
                }
            },
            borderWidth: 1,
        },
        plugins: [centerTextPlugin]  // 플러그인을 차트에 추가
    });

    // HTML의 참여자 수를 동적으로 채우는 부분
    const participantCountElement = document.getElementById('participantCount');
    participantCountElement.textContent = participantCount;
});
</script>
