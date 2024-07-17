<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
.sticker {
	width: 470px;
	height: 470px;
	border: 35px solid #3E74D3;
	border-radius: 50%;
	position: relative;
	text-align: center;
	overflow: hidden;
}
.header, .footer {
	font-family: Helvetica Neue, sans-serif;
	font-size: 18px;
	font-weight: 300;
	text-transform: uppercase;
	letter-spacing: 2px;
	fill: rgb(243, 22, 22);
}

.sticker .content {
	font-size: 30px;
	margin-top: 20px;
	color: black;
	position: relative;
}

.sticker .content p {
	margin: 5px 0;
}

.sticker .content .bold2 {
	font-weight: bold;
}
.sticker .content .info {
	margin-top: 20px;
}

.bold1 {
	text-align: left;
	font-size: 22px;
	color:red;
}

.bold2 {
	font-size: 45px;
}
.p1{
	font-size: 25px;
}
#printBtn{
	width: 70px;
	height:30px;
	background-color: #a2a4a5;
	color:white;
	border: 1px solid #a2a4a5;
	border-radius:5px;
	float: right;
	cursor: pointer;
	
}
</style>
</head>
<body>
	<div class="row">
		<div>
			<input type="button" class="btn btn-primary waves-effect waves-light" id="printBtn" value="Print" /> 
		</div>
		<div class="sticker">
			
			<div class="content">
				<br>
	<%-- 			<p>${wasteVO}</p> --%>
				<p class="bold1" style="margin-left: 80px; margin-bottom:20px;">No. ${wasteVO.wasteSeq}</p>
				<p class="bold2" style="margin-bottom:30px;">대형폐기물</p>
			
				<div class="info">
				<p class="p1">
					폐기물품목: <span class="commDetCodeNm">${wasteVO.commDetailVO.commDetCodeNm}</span>
				</p>
				<p class="p1">
					 수수료: <span class="fee">${wasteVO.fee}</span>원
				</p>
				<p class="p1" style="margin-bottom:40px;">
					  배출일자: <span class="estDt">${wasteVO.estDt}</span>
				</p>
				</div>
					<p>
						<img src="/resources/images/daejeon.png" style="width:300px;"/>
					</p>
			</div>
		</div>
	</div>	
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script>
$(document).ready(function(){
	$("#printBtn").on("click", function(){
		console.log("print");
		window.print();
	});
	
	function priceToString(fee) {
		return fee.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}

	const feeSpan = document.querySelector('.fee'); 
	const feeValue = parseFloat(feeSpan.textContent); 

	if (!isNaN(feeValue)) {
		feeSpan.textContent = priceToString(feeValue);
	}
});
</script>	
</body>
</html>
