<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.portone.io/v2/browser-sdk.js"></script>

<div class="col-12">
    <div class="card">
        <div class="card-header">
            <h3>${voteVO.voteTitle}&nbsp;&nbsp;&nbsp;투표 결과</h3>
            <p><strong>참여자 수 : &nbsp;<span id="participantCount"></span>명</strong></p>
        </div>

        <div class="card-body table-responsive" style="height: 600px; right: 10px;">
            <div class="row">
	            <div class="col-6">
	            	<canvas id="doughnut" style="width: 500px; height: 600px; position: relative; left: 100px;"></canvas>
	            </div>
	            
	            <div class="col-6"> 
		            <table class="table table-bordered" style="margin-top: 200px;">
		                <thead>
		                    <tr>
		                        <th>후보자 명</th>
		                        <th>득표 수</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <c:forEach var="detail" items="${voteVO.voteDetails}" varStatus="stat">
		                        <tr>
		                            <td>${detail.vdItem}</td>
		                            <td>${cnt[stat.index]}</td>
		                        </tr>
		                    </c:forEach>
		                </tbody>
		            </table>
				</div>
			</div>					            
        </div>

        <div class="text-center mt-3" style="margin-bottom : 30px;">
            <a href="/vote/list" class="btn btn-primary">목록</a>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const doughnut = document.getElementById('doughnut');
    
    const labels = [
        <c:forEach var="detail" items="${voteVO.voteDetails}">
            '${detail.vdItem}',
        </c:forEach>
    ];

    const data = [
        <c:forEach var="detail" items="${voteVO.voteDetails}" varStatus="stat">
            ${cnt[stat.index]},
        </c:forEach>
    ];

    new Chart(doughnut, {
        type: 'doughnut',
        data: {
            labels: labels,
            datasets: [{
                backgroundColor: getDoughnutColor(),
                data: data
            }]
        },
        options: {
            responsive: false,
            plugins: {
                legend: {
                    display: true,
                },
                tooltip: {
                    enabled: true
                }
            },
            borderWidth: 1,
        }
    });

    // 참여자 수를 계산하는 함수
    function countParticipants() {
        let totalVotes = 0;
        const voteCounts = [<c:forEach var="detail" items="${voteVO.voteDetails}" varStatus="stat">${cnt[stat.index]},</c:forEach>];
        for (let i = 0; i < voteCounts.length; i++) {
            totalVotes += voteCounts[i];
        }
        return totalVotes;
    }

    // HTML의 참여자 수를 동적으로 채우는 부분
    const participantCountElement = document.getElementById('participantCount');
    participantCountElement.textContent = countParticipants();
});

// 이 함수는 고정된 색상 배열을 반환합니다. 필요시 수정 가능
function getDoughnutColor() {
    return [
        '#FF6384',
        '#36A2EB',
        '#FFCE56',
        '#4BC0C0',
        '#9966FF',
        '#FF9F40'
    ];
}
</script>
