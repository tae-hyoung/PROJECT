<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
tbody tr:hover{
	background-color: lightgrey;
}

</style>
<br>
<div class="col-12 row" style="margin-left: 0px;">
	<div class="col-5">
		<div class="card" style="background-color: white;">
			<div class="card-header" style="background-color: white;">
				<div class="row">
					<div class="col-11">
						<h3>공지사항</h3>
					</div>
					<div class="col-1">
						<h3><a href="/site/notice?boardCat=board_site" style="font: 2em;text-decoration-line: none;">+</a></h3>
					</div>
				</div>
			</div>
			<div class="card-body" style="height: 200px;">
				<table>
					<thead>
						<tr>
							<th width="40%" style="text-align: center;">제목</th>
							<th width="25%" style="text-align: center;">등록일</th>
							<th width="10%" style="text-align: center;">조회수</th>
							<th width="10%" style="text-align: center;">추천수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="boardVO" items="${boardVOList}" varStatus="stat">
							<tr class="tblRow boardRow">
								<td style="display: none">${boardVO.brdSeq}</td>
								<td width="40%">${boardVO.title}</td>
								<td width="25%" style="text-align: center;">${fn:substring(boardVO.regDt, 0, 10)}</td>
								<td width="10%" style="text-align: center;">${boardVO.viewCnt}</td>
								<td width="10%" style="text-align: center;">${boardVO.likeCnt}</td>
							</tr>
							<tr><td colspan="3" style="padding: 3px 0;"></td></tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="col-5">
		<div class="card" style="background-color: white;">
			<div class="card-header" style="background-color: white;">
				<div class="row">
					<div class="col-11">
						<h3>입찰공고</h3>
					</div>
					<div class="col-1">
						<h3><a href="/site/bidList" style="font: 2em;text-decoration-line: none;">+</a></h3>
					</div>
				</div>
			</div>
			<div class="card-body" style="height: 200px;">
				<table>
					<thead>
						<tr>
							<th width="20%" style="text-align: center;">단지명</th>
							<th width="45%" style="text-align: center;">입찰공고명</th>
							<th width="17%" style="text-align: center;">입찰방법</th>
							<th width="18%" style="text-align: center;">입찰마감일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="bidnoticeVO" items="${bidnoticeVOList}" varStatus="stat">
							<tr class="tblRow bidRow">
								<td style="display: none">${bidnoticeVO.bidSeq}</td>
								<td width="20%">${bidnoticeVO.danjiName}</td>
								<td width="45%">${bidnoticeVO.bidTitle}</td>
								<td width="17%" style="text-align: center;">${bidnoticeVO.bidHow}</td>
								<td width="18%" style="text-align: center;">${fn:substring(bidnoticeVO.bidOutDt, 0, 10)}</td>
							</tr>
							<tr><td colspan="3" style="padding: 3px 0;"></td></tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<c:if test="${login ne 'ok'}">
		<div class="col-2" >
			<div class="card">
				<div class="card-header" style="background-color: white;">
					<h3>방문자 수</h3>
				</div>
				<div class="card-body" style="height: 200px;">
					<br>
					<table>
						<tr>
							<td width="100px">TOTAL: </td>
							<td style="text-align: right"><span style="font-size: 1.5em;"><fmt:formatNumber value="${visitTotal}" pattern="#,###" />명</span></td>
						</tr>
						<tr>
							<td width="100px">TODAY: </td>
							<td style="text-align: right"><span style="font-size: 1.5em;"><fmt:formatNumber value="${visitToday}" pattern="#,###" />명</span></td>
						</tr>
					</table>
				</div>
			</div>
		</div>
	</c:if>
</div>
<br>

<!-- Include Swiper CSS -->
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">

<!-- Include Swiper JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>

<div class="row" style="background-color: white;">
	<div class="container" style="background-color: white;">
		<div
			class="footbanner swiper swiper-initialized swiper-horizontal swiper-pointer-events" id="scroll-area" style="overflow-x: scroll; -ms-overflow-style: none; scrollbar-width: none; scroll-behavior: smooth;">

			<ul class="list swiper-wrapper" id="swiper-wrapper-17591db211624351" aria-live="off" style="transition-duration: 0ms; transform: translate3d(-3329.17px, 0px, 0px);">
				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="6" role="group" aria-label="7 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://www.nhis.or.kr" target="_blank" title="새창"rel="noopener"> 
						<img src="/resources/images/20240126112553986.png" alt="h-well 국민건강보험"> 
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="7" role="group" aria-label="8 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://www.alio.go.kr/home.do" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231214153710062.jpg" alt="ALIO 공공기관 경영정보 공개시스템">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="8" role="group" aria-label="9 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://president.globalwindow.org" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112530569.png" alt="글로벌 비즈니스를 위한 세일즈 정상외교 활용포털">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-prev" data-swiper-slide-index="9" role="group" aria-label="10 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://irts.molit.go.kr" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112743377.png" alt="국토교통부 부동산거래 전자계약시스템">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-active" data-swiper-slide-index="10" role="group" aria-label="11 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="https://www.khug.or.kr/hug/web/ig/dl/igdl000001.jsp" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231214154622390.jpg" alt="HUG 주택도시보증공사">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate swiper-slide-duplicate-next" data-swiper-slide-index="11" role="group" aria-label="12 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://nhuf.molit.go.kr/" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231214154738902.jpg" alt="국토교통부 주택도시기금">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="12" role="group" aria-label="13 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="https://www.safetyreport.go.kr/api?apiKey=B55255500RIT6SJUZ0TTF3T2FD9" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231214155349997.jpg" alt="안전신문고">
					</a>
				</li>
				
				<li class="swiper-slide" data-swiper-slide-index="0" role="group" aria-label="1 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="https://kras.go.kr:444/cmmmain/goMainPage.do" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112656133.png" alt="국토교통부 부동산종합증명서 일사편리">
					</a>
				</li>
				
				<li class="swiper-slide" data-swiper-slide-index="1" role="group" aria-label="2 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://www.gov.kr" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231214155548099.jpg" alt="정부의 모든 서비스를 정부24에서 누려보세요!">
					</a>
				</li>
				
				<li class="swiper-slide" data-swiper-slide-index="2" role="group" aria-label="3 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://myapt.molit.go.kr" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112637340.png" alt="중앙공동주택관리지원센터">
					</a>
				</li>

				<li class="swiper-slide" data-swiper-slide-index="3" role="group" aria-label="4 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://namc.molit.go.kr" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112616712.png" alt="중앙공동주택관리 분쟁조정위원회">
					</a>
				</li>

				<li class="swiper-slide" data-swiper-slide-index="4" role="group" aria-label="5 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://www.epeople.go.kr" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231207172259188.jpg" alt="예산낭비 신고하세요">
					</a>
				</li>

				<li class="swiper-slide" data-swiper-slide-index="5" role="group" aria-label="6 / 13" style="width: 150.833px; margin-right: 45px;">
						<a href="http://jeonse.lh.or.kr/" target="_blank" title="새창" rel="noopener"> 
					<img src="/resources/images/20231214153220362.jpg" alt="언제 어디서나 누구나 쉽고 빠르게 전세임대포털">
					</a>
				</li>

				<li class="swiper-slide" data-swiper-slide-index="6" role="group" aria-label="7 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://www.nhis.or.kr" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112553986.png" alt="h-well 국민건강보험">
					</a>
				</li>

				<li class="swiper-slide" data-swiper-slide-index="7" role="group" aria-label="8 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://www.alio.go.kr/home.do" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231214153710062.jpg" alt="ALIO 공공기관 경영정보 공개시스템">
					</a>
				</li>

				<li class="swiper-slide" data-swiper-slide-index="8" role="group" aria-label="9 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://president.globalwindow.org" target="_blank" title="새창" rel="noopener">
						<img src="/resources/images/20240126112530569.png" alt="글로벌 비즈니스를 위한 세일즈 정상외교 활용포털">
					</a>
				</li>

				<li class="swiper-slide swiper-slide-prev" data-swiper-slide-index="9" role="group" aria-label="10 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://irts.molit.go.kr" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112743377.png" alt="국토교통부 부동산거래 전자계약시스템">
					</a>
				</li>

				<li class="swiper-slide swiper-slide-active" data-swiper-slide-index="10" role="group" aria-label="11 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="https://www.khug.or.kr/hug/web/ig/dl/igdl000001.jsp" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231214154622390.jpg" alt="HUG 주택도시보증공사">
					</a>
				</li>

				<li class="swiper-slide swiper-slide-next" data-swiper-slide-index="11" role="group" aria-label="12 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://nhuf.molit.go.kr/" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231214154738902.jpg" alt="국토교통부 주택도시기금">
					</a>
				</li>

				<li class="swiper-slide" data-swiper-slide-index="12" role="group" aria-label="13 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="https://www.safetyreport.go.kr/api?apiKey=B55255500RIT6SJUZ0TTF3T2FD9" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231214155349997.jpg" alt="안전신문고">
					</a>
				</li>

				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="0" role="group" aria-label="1 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="https://kras.go.kr:444/cmmmain/goMainPage.do" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112656133.png" alt="국토교통부 부동산종합증명서 일사편리">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="1" role="group" aria-label="2 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://www.gov.kr" target="_blank" title="새창" rel="noopener">
						<img src="/resources/images/20231214155548099.jpg" alt="정부의 모든 서비스를 정부24에서 누려보세요!">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="2" role="group" aria-label="3 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://myapt.molit.go.kr" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112637340.png" alt="중앙공동주택관리지원센터">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="3" role="group" aria-label="4 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://namc.molit.go.kr" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112616712.png" alt="중앙공동주택관리 분쟁조정위원회">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="4" role="group" aria-label="5 / 13" style="width: 150.833px; margin-right: 45px;">
				<a href="http://www.epeople.go.kr" target="_blank" title="새창" rel="noopener"> 
					<img src="/resources/images/20231207172259188.jpg" alt="예산낭비 신고하세요">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="5" role="group" aria-label="6 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://jeonse.lh.or.kr/" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20231214153220362.jpg" alt="언제 어디서나 누구나 쉽고 빠르게 전세임대포털">
					</a>
				</li>
				
				<li class="swiper-slide swiper-slide-duplicate" data-swiper-slide-index="6" role="group" aria-label="7 / 13" style="width: 150.833px; margin-right: 45px;">
					<a href="http://www.nhis.or.kr" target="_blank" title="새창" rel="noopener"> 
						<img src="/resources/images/20240126112553986.png" alt="h-well 국민건강보험">
					</a>
				</li>
			</ul>
			<span class="swiper-notification" aria-live="assertive"
				aria-atomic="true"></span>
		</div>
	</div>
</div>



<script>
$(document).on('click', ".boardRow", function(){
// 	console.log($(this).children().eq(0).html());
	location.href = "/site/notice/detail?brdNo="+$(this).children().eq(0).html();
})

$(document).on('click', ".bidRow", function(){
	console.log($(this).children().eq(0).html());
	location.href = "/site/bidDetail?bidSeq=?"+$(this).children().eq(0).html();
})

function autoScroll() {
	const scrollArea = $("#scroll-area");
// 	console.log(">>>", scrollArea.scrollLeft());  
	
	let scroll = scrollArea.scrollLeft();
	
	scrollArea.scrollLeft(scroll + 10);
	
	if(scrollArea.scrollLeft() > 820){
		clearInterval(interval);
		scrollArea.scrollLeft(0);
		let sleep = setTimeout(function(){
			interval = setInterval(autoScroll, 100);
		}, 500)
	}
};

let interval = setInterval(autoScroll, 100);



</script>