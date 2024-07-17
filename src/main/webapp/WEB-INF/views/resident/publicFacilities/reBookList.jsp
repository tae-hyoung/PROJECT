<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<!-- 슬라이드 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<!-- 차트 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>

<!-- 스위트 알러트 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<!--datatable css-->
<link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
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

<script src="/resources/js/jquery.min.js"></script>


<title>도서관</title>
<style type="text/css">
#modalBookImg {
   width: 50%;
   height: 400px;
   float: left;
   margin-left: 5px;
}
#dd {
   width: 45%;
   float: right;
   font-size: large;
}
.tblRow {
   text-decoration: none;
   color: black;
}
.tblRow:hover {
   color: blue;
   text-decoration: underline;
}
.pagination{
	    padding-left: 647px;
}
#reBtn1{
	position: absolute;
    right: 32px;
}
.swiper-container {
	height:420px;
	border-bottom: 1px solid #e5e5e5;
}
.swiper-slide {
	text-align:center;
	align-items:center; /* 위아래 기준 중앙정렬 */
	justify-content:center; /* 좌우 기준 중앙정렬 */
}
.fon {
	font-size: 14px;
	font-weight: bold;
}
.fon:first-of-type {
	font-size: 20px;
	margin-bottom: 0px;   
}
.swiper-slide img {
	box-shadow:0 0 5px #555;
	width:65%; 
	height: 326px;
	margin-top: 10px;
    margin-left: -50px;
}
table, td, th {
  border-bottom : 1px solid black;
  border-collapse : collapse;
}
th, td {
  text-align: center;
  font-size: 16px;
  font-family:"trana";
  font-weight: 400;
  font-style: normal;
}
thead{
 background-color:  #e9f7ff;
}
th{
  font-weight: bold;
}
table {
    border: 1px solid gray;
}
#searchh {
    width: 199px;
    height: 35px;
}
#btnSearch {
    height: 36px;
    width: 75px;
}
#btnSearchAll {
    height: 36px;
    width: 87px;
}
#ser {
    margin-left: 1150px;
    margin-bottom: 10px;
	display:flex; 
}
/* 대여목록 바로가기 */
#myRentalList{
  margin-left: 1200px; 
  text-decoration: none;
  font-family: "Malgun Gothic", "맑은 고딕", dotum, "돋움", sans-serif;
  font-weight: 300;
  font-size: 16px;
  letter-spacing: -0.03em;
  width: 150px;
}
.arrow-right {
  position: absolute;
  display: inline-block;
  width: 0;
  height: 0;
  border-top: 8px solid transparent;
  border-right: 8px solid transparent;
  border-bottom: 8px solid transparent;
  border-left: 14px solid white;
  margin-top: 4px;
  margin-left: 9px;
  animation: horizontal 0.7s ease-in-out infinite;
}
@keyframes horizontal {
  0% {
    margin-left: 9px;
  }
  50% {
    margin-left: 11px;
  }
  100% {
    margin-left: 9px;
  }
}
</style>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	let table = new DataTable('.tt', {
		"searching" : false,
		"paging" : false,
		"ordering" : false
	});

});


$(function() {
		
	let memId = $("#memId").text();
	
	let data = {
			"memId": memId
	}
	
	
    $.ajax({
        url: "/cntDanger",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
            console.log("result>>", result);
			if(result>0) {
	           Swal.fire({
	               title: "연체된 대여내역이 " + result + "건 있습니다.",
	               html: "※도서관의 책은 공공 물품입니다.<br>속히 반납 부탁드립니다.※ <br><br><a href= 'http://localhost/public/book/myRentalList'>👉🏼대여현황 바로가기</a>  ",
	               icon: "warning"
	           });
			}
        }
    });

	  
	$("#myRentalList").on("click", function(){
		location.href = "/public/book/myRentalList";
	});
	
	
	
    // 검색 버튼 클릭 시 실행되는 함수
    $('#btnSearch').on('click', function() {
        let keyword = $("#searchh").val();
        getList(keyword, 1);
    });

    // 전체 검색 버튼 클릭 시 실행되는 함수
    $("#btnSearchAll").on('click', function() {
        getList("", 1);
    });

    // 테이블 행 클릭 시 모달 창에 도서 정보 표시
	$(document).on("click", ".tblRow", function(event) {
	    event.preventDefault();
	
	    var row = $(this).closest('tr');
	    var rnum = row.children().eq(1).text();
	    var title = row.children().eq(2).text();
	    var bookCat = row.children().eq(3).text();
	    var writer = row.children().eq(4).text();
	    var intro = row.find('input[type="hidden"]').val();
	    var publisher = row.children().eq(6).text();
	    var status = row.children().eq(7).text().trim(); 
	    var status1 = row.children().eq(7).html(); 
	    var bookCode = $(this).data('bookcode');
	    var attach = $(this).data('attach') || ''; // attach가 정의되지 않았을 때 빈 문자열로 설정
	
	    // 디버깅: attach 경로 확인
	    console.log("첨부 파일 경로: ", attach);
	
	    // 경로를 상대 경로로 변환
	    var relativeAttach = attach;
	    if (!attach.includes("/upload")) {
	        relativeAttach = "/upload" + attach;
	    }
	
	    // 디버깅: 변환된 attach 경로 확인
	    console.log("변환된 첨부 파일 경로: ", relativeAttach);
	
	    $("#modalRnum").html(rnum);
	    $("#modalTitle").html(title);
	    $("#modalBookCat").html(bookCat);
	    $("#modalWriter").html(writer);
	    $("#modalIntro").html(intro);
	    $("#modalPublisher").html(publisher);
	    $("#modalStatus").html(status1);
	    $("#modalBookCode").val(bookCode);
	
	    console.log("상태다! : ", status);
	    // 모달의 이미지 src 속성 설정 및 이미지 표시
	    $("#modalBookImg").attr('src', relativeAttach);
	
	    // 디버깅: 이미지 src 속성 확인
	    console.log("이미지 src: ", $("#modalBookImg").attr('src'));
	
	    // Hide or show the button based on the status
	    if (status === "대출중") {
	        $("#reBtn2").css("display", "none");
	    } else {
	        $("#reBtn2").css("display", "block");
	    }
	
	    var myModal = new bootstrap.Modal(document.getElementById('bookDetailModal'));
	    myModal.show();
	});



    // 회원 대출 상태 확인 함수
    function checkmem(callback) {
        $.ajax({
            url: "/public/book/checkmem",
            type: "post",
            dataType: "text",
            beforeSend: function(xhr) {
                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
            },
            success: function(result) {
                console.log("checkmem->result : ", result);
                callback(result);
            },
            error: function(error) {
                console.error("Error:", error);
            }
        });
    }

    // 대출 버튼 클릭 시 실행되는 함수
    $(document).on("click", "#reBtn1, #reBtn2", function() {
        var self = this;
        var selectedBooks = [];
        var unavailableBooks = [];
        
        // 대출할 책 선택 로직
        if (self.id === "reBtn1") {
            $(".chk:checked").each(function() {
                var row = $(this).closest('tr');
                var status = row.children().eq(7).text().trim(); 
                var bookCode = row.find('.tblRow').data('bookcode');

                if (status === "대출가능") {
                    selectedBooks.push(bookCode);
                } else {
                    unavailableBooks.push(bookCode);
                }
            });
        } else if (self.id === "reBtn2") {
            var bookCode = $("#modalBookCode").val();
            var status = $("#modalStatus").text().trim(); 
            if (status === "대출가능") {
                selectedBooks.push(bookCode);
            } else {
                unavailableBooks.push(bookCode);
            }
        }

        // 회원 대출 상태 확인
        checkmem(function(result) {
            if (result == -1) {
                Swal.fire({
                 position: "center",
                 icon: "error",
                 title: "대출 중이거나 연체된 책이 3권 이상입니다. 반납 후 대여해 주세요.",
                 timer: 1800,
                 showConfirmButton: false // 확인 버튼을 숨깁니다.
             })
                return;
            } else if (result == -2) {
                if(selectedBooks.length > 1) {
                    Swal.fire({
	                    position: "center",
	                    icon: "error",
	                    title: "이미 2권을 대여중이어서 추가로 1권만 대여 가능합니다.",
	                    timer: 1800,
	                    showConfirmButton: false // 확인 버튼을 숨깁니다.
	                })
                    return;
                }
            } else if (result == -3) {
                if(selectedBooks.length > 2) {
                    Swal.fire({
	                    position: "center",
	                    icon: "error",
	                    title: "이미 1권을 대여중이어서 추가로 2권만 대여 가능합니다.",
	                    timer: 1800,
	                    showConfirmButton: false // 확인 버튼을 숨깁니다.
	                })
                    return;
                }
            }

            // 대출 가능 여부 확인 및 대출 처리
            if (unavailableBooks.length > 0) {
                Swal.fire({
                 position: "center",
                 icon: "error",
                 title: "대출할 수 없는 책이 포함되어 있습니다.",
                 timer: 1800,
                 showConfirmButton: false // 확인 버튼을 숨깁니다.
             })
            } else if (selectedBooks.length > 0) {
                if (confirm("대출하시겠습니까?")) {
                    console.log("대출할 책들:", selectedBooks);
                    selectedBooks.forEach(function(selectedBook) {
                        let data = { "bookCode": selectedBook };
                        $.ajax({
                            url: "/public/book/rentalAjax",
                            contentType: "application/json;charset=utf-8",
                            data: JSON.stringify(data),
                            type: "post",
                            dataType: "json",
                            beforeSend: function(xhr){
                                xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                            },
                            success: function(result) {
                                console.log("result>>", result);
                                Swal.fire({
            	                    position: "center",
            	                    icon: "success",
            	                    title: "대출이 완료되었습니다.",
            	                    html: "대여기간은 일주일입니다.<br>반납일을 지켜주세요.",
            	                    timer: 1800,
            	                    showConfirmButton: false // 확인 버튼을 숨깁니다.
            	                }).then(() => {
        		                    location.replace(location.href);
        		                });
                            },
                            error: function(error) {
                                console.error("Error:", error);
                            }
                        });

                    });
             
                }
            } else {
                Swal.fire({
                    position: "center",
                    icon: "error",
                    title: "대출할 책을 선택하세요.",
                    timer: 1800,
                    showConfirmButton: false // 확인 버튼을 숨깁니다.
                })
            }
        });
    });


 	// 카테고리 검색 시		
    $("#selectCa").on("change", function() {
        let status = $("#selectCa").val();
        console.log("선택된 카테고리:", status);

        if (status === "all") {
            getList("", 1); 
        } else {
            getList(status, 1);
        }
    });



});
    
    
    
// 도서 목록 가져오기 함수
function getList(keyword, currentPage ) {
    let data = {
        "keyword": keyword,
        "currentPage": currentPage
    };
    console.log("data>>", data);

    $.ajax({
        url: "/public/book/listAjax",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        dataType: "json",
        beforeSend: function(xhr) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
            console.log("result>>", result);
			let statusClass ="";
            let str = "";
            $.each(result.content, function(idx, bookVO) {
                str += "<tr>";
                str += '<td><input type="checkbox" name="chk" class="chk" onclick="chkClicked(this)" value=""><input id="introHi" type="hidden" value="'+bookVO.intro+'"></td>';
                str += "<td>"+(idx+1)+"</td>";
                str += '<td style="text-align: left;"><a class="tblRow" data-bookcode="'+bookVO.bookCode+'" data-attach="'+bookVO.attach+'">'+bookVO.title+'</a></td>';
                str += "<td>"+bookVO.bookCat+"</td>";
                str += "<td>"+bookVO.writer+"</td>";
                str += "<td>" + (bookVO.intro.length > 20 ? (bookVO.intro).substr(0, 20) + "..." : bookVO.intro) + "</td>";
                str += "<td>"+bookVO.publisher+"</td>";
                if (bookVO.status == "대출중") {
	                 statusClass = "badge bg-warning";
	             } else if (bookVO.status == "대출가능") {
	                 statusClass = "badge bg-secondary";
	             } 
	                 
	            str += "<td style='font-size: 18px;'><span style='width: 73px;'  class='" + statusClass +"'>" + bookVO.status+ "</span></td>";
                str += "</tr>";
            });

            $(".clsPagingArea").html(result.pagingArea);
            $("#trShow").html(str);
        }
    });
}

    
    
// 체크박스 클릭 시 최대 선택 가능 수 제한
var maxChk = 3;
var count = 0;

function chkClicked(obj) {
    if (obj.checked) {
        count += 1;
    } else {
        count -= 1;
    }

    if (count > maxChk) {
        Swal.fire({
            position: "center",
            icon: "error",
            title: "한번에 최대 3권까지만 대여 가능합니다!",
            timer: 1800,
            showConfirmButton: false // 확인 버튼을 숨깁니다.
        })
        obj.checked = false;
        count -= 1;
    }
}
</script>



<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><img alt="" src="/resources/images/도.png" style="width: 20px;">&nbsp;<strong>도서관</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">공동시설물</a></li>
						<li class="breadcrumb-item active">도서목록</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>





<div class="col-12">
	<div class="card">
		<div class="card-header" style="display: flex;">
			 <i class="ri-vip-crown-2-fill" style="font-size: 24px; margin-right: 10px;"></i> <h2 style="margin-top: 5px;">이달의 인기도서</h2>
			<button class="btn btn-primary waves-effect waves-light" id="myRentalList" type="button">
				<span style="margin-left: -11px;">대여목록</span>
				<span class="arrow-right"></span>
			</button>
		</div>
		
		<div class="col-12" id="sliView" >
			<div class="swiper-container" style="background: linear-gradient(-225deg, #FFFEFF 0%, #f1ffff 100%);">
				<div class="swiper-wrapper">

					<c:forEach var="bookLoanVO" items="${bookLoanList}"
						varStatus="stat">

						<div class="swiper-slide">
							<h3 style="margin-right: -6px; margin-left: 42px; float: left;margin-top: 4px; ">${bookLoanVO.rnum}</h3>
							<img
								src="/upload${bookLoanVO.bookList[0].attach}"><br>
							<br>
							<p class="fon">&lt;${bookLoanVO.bookList[0].title}&gt;</p>
							<p class="fon">대여 횟수 : ${bookLoanVO.loanCount}건</p>
						</div>
					</c:forEach>
				</div>

				<div class="swiper-pagination"></div>
				
			</div>
			<br><br>
		</div>


		<form id="ser">
			<select  id="selectCa">
				<option value="all">전체보기</option>
				<option value="대출가능">대출가능</option>
				<option value="대출중">대출중</option>
			</select>
			<input type="text" id="searchh" name="table_search"
				class="form-control float-right" placeholder="Search">
			<button type="button"
				class="btn btn-soft-dark waves-effect waves-light material-shadow-none"
				id="btnSearch">검색</button>
			<button type="button" class="btn btn-light waves-effect"
				id="btnSearchAll">전체보기</button>
		</form>
		
		<div class="card-body table-responsive"  style="margin-left: auto; margin-right: auto;">
			<table class="table table-hover text-nowrap tt" style="width: 1572px;">
				<thead>
					<tr>
						<th></th>
						<th>순번</th>
						<th>책제목</th>
						<th>도서구분</th>
						<th>저자</th>
						<th>책소개</th>
						<th>출판사</th>
						<th>대출상태</th>
					</tr>
				</thead>
				<tbody id="trShow">
					<c:forEach var="bookVO" items="${bookList}" varStatus="stat">
						<tr>
							<td><input type="checkbox" name="chk" class="chk"
								onclick="chkClicked(this)" value="">
								<input id="introHi" type="hidden" value="${bookVO.intro}">
							</td>
							<td>${bookVO.rnum}</td>
							<td style="text-align: left;" ><a class="tblRow" data-bookcode="${bookVO.bookCode}"
								data-attach="/upload${bookVO.attach}">${bookVO.title}</a></td>
							<td>${bookVO.bookCat}</td>
							<td>${bookVO.writer}</td>
							<td>
							<c:if test="${bookVO.intro.length() > 20}">
							    ${bookVO.intro.substring(0, 20)}...
							</c:if>
							</td>
							<td>${bookVO.publisher}</td>
							<td style="font-size: 18px;">
								 <c:choose>
									<c:when test="${bookVO.status == '대출중'}">
										<span class="badge bg-warning"  style="width: 73px;">${bookVO.status}</span>
									</c:when>
									<c:when test="${bookVO.status == '대출가능'}">
										<span class="badge bg-secondary"  >${bookVO.status}</span>
									</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>



			<!-- Modal -->
			<div class="modal fade bd-example-modal-lg" id="bookDetailModal"
				tabindex="-1" aria-labelledby="bookDetailModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h2 class="modal-title" id="modalTitle"></h2>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<img id="modalBookImg" name="attach" src="/upload" />
							<div id="dd">
								<p>
									<strong>도서구분:</strong> <span id="modalBookCat"></span>
								</p>
								<p>
									<strong>저자:</strong> <span id="modalWriter"></span>
								</p>
								<p>
									<strong>책소개:</strong><br /> <span id="modalIntro"></span>
								</p>
								<p>
									<strong>출판사:</strong> <span id="modalPublisher"></span>
								</p>
								<p>
									<strong>대출상태:</strong> <span id="modalStatus"></span>
								</p>
								<input type="hidden" id="modalBookCode" />
							</div>
						</div>
						<div class="modal-footer">
						
							<button type="button" class="btn btn-primary reBtn" id="reBtn2" style="display: block;">대출하기</button>
							<button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
							
						</div>
					</div>
				</div>
			</div>

			<div>
				<div class="row clsPagingArea" style="float: left">
					${articlePage.pagingArea}</div>
			</div>
				<button type="button" class="btn btn-primary" id="reBtn1">대출하기</button>
		</div>
	</div>
</div>

<script>
/**
 * 인기차트 슬라이드 쇼 Swiper 
 */
new Swiper('.swiper-container', {
	slidesPerView : 4, // 동시에 보여줄 슬라이드 갯수
	spaceBetween : 10, // 슬라이드간 간격
	slidesPerGroup : 2,

	// 그룹수가 맞지 않을 경우 빈칸으로 메우기
	// 3개가 나와야 되는데 1개만 있다면 2개는 빈칸으로 채워서 3개를 만듬
	loopFillGroupWithBlank : true,

	loop : true, // 무한 반복
  autoplay: {
          delay: 2000, // 3초마다 자동 재생
          dynamicBullets: true,
          disableOnInteraction: false // 사용자 상호 작용 후에도 자동 재생 유지
        },  
	pagination : { // 페이징
		el : '.swiper-pagination',
		clickable : true, // 페이징을 클릭하면 해당 영역으로 이동, 필요시 지정해 줘야 기능 작동
	},
	navigation : { // 네비게이션
		nextEl : '.swiper-button-next', // 다음 버튼 클래스명
		prevEl : '.swiper-button-prev', // 이번 버튼 클래스명
	},
  mousewheel: true, // 마우스 휠로 슬라이드 이동 가능
});

</script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
