<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<div style="display: none" id="memId"><sec:authentication property="principal.memberVO.memId" /></div>

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

<style type="text/css">
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
.dd {
	width: 45%;
	float: right;
}
.tblRow {
	text-decoration: none;
	color: black;
}
.tblRow:hover {
	color: blue;
	text-decoration: underline;
}
.pagination {
	margin-left: 689px;
	margin-top: 15px;
}
#reBtn1 {
	margin-left: 720px;
}
.tt {
	width: 100%;
}
#reF {
	margin-left: 1195px;
}
#addBtn {
	width: 95px;
	margin-left: 1478px;
	margin-bottom: -50px;
}
.card-title {
	float: inline-start;
}
#modalBookImg {
	width: 50%;
	height: 60%;
	float: left;
	margin-left: 5px;
}
#modalBookImg2 {
	width: 50%;
	height: 60%;
	float: left;
	margin-left: 5px;
}
#modalIntro2 {
	resize: none;
}
.is-invalid {
	border-color: #dc3545;
	background-color: #f8d7da;
}
#DataTables_Table_1_filter{
	display : none;
}
#DataTables_Table_0_filter label {
    color: transparent;
    font-size: 0;
}
#DataTables_Table_0_filter label input {
    color: initial;
    font-size: initial;
}
#DataTables_Table_0_info{
	display: none;
}
#DataTables_Table_0_filter {
    margin-right: auto; 
}
#DataTables_Table_0_filter label {
    display: flex;
    align-items: center;
}
#DataTables_Table_0_filter input {
	margin-left: 481px;
    margin-top: 2px;
}
.badge {
	font-size: 18px;
}
#addBookAjax { 
	font-size: 15px;
}
#frm { 
	font-size: 15px;
}
#bookReDetailModal { 
	font-size: 15px;
}
#DataTables_Table_1 .sorting:before {
	display: none;
}
#DataTables_Table_1 .sorting:after {
	display: none;
}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
	let table = new DataTable('.tt', {
		 "searching": true
			,"paging" : false
			,"language": {
		            "zeroRecords": "내역이 없습니다.",
		            "paginate": {
		                "next": "다음",
		                "previous": "이전"
		            }
			  }
	});
	
});

//이미지 미리보기 함수
function handleImg(e) {
    // <p id="pImg"></p> 영역에 이미지 미리보기를 해보자
    // 이벤트가 발생된 타겟 안에 들어있는 이미지 파일들을 가져와보자
    let files = e.target.files;
    // 이미지가 여러 개가 있을 수 있으므로 이미지들을 각각 분리해서 배열로 만듦
    let fileArr = Array.prototype.slice.call(files);

    fileArr.forEach(function(f) {
        // 이미지 파일이 아닌 경우 이미지 미리보기 실패 처리(MIME 타입)
        if (!f.type.match("image.*")) {
            alert("이미지 확장자만 가능합니다.");
            // 함수 종료
            return;
        }
        // 이미지 객체를 읽을 자바스크립트의 reader 객체 생성
        let reader = new FileReader();

        $(".pImg").html("");

        // e : reader가 이미지 객체를 읽는 이벤트
        reader.onload = function(e) {
            // e.target : f(이미지 객체)
            // e.target.result : reader가 이미지를 다 읽은 결과
            let img_html = "<img src=\"" + e.target.result + "\" style='width:90%;' />";
            // p 사이에 이미지가 렌더링되어 화면에 보임
            // 객체.append : 누적, .html : 새로고침, .innerHTML : J/S
            $(".pImg").append(img_html);
        }
        // f : 이미지 파일 객체를 읽은 후 다음 이미지 파일(f)을 위해 초기화 함
        reader.readAsDataURL(f);
    }); // end forEach
}
	
$(function() {
	
	
	// 연체 된 도서가 있는 지 체크 후 알럿창 띄워지기
	let memId = 'admin';
	
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
	               html: "확인 후 조치를 취하세요.",
	               icon: "warning"
	           });
			}
        }
    });
	
	
	getList("", 1);
	
	$("#uploadFile").on("change" , handleImg);
	$("#fileAdd").on("change" , handleImg);
	
	
	// 책 등록 버튼 클릭 시 처리
	$(document).on("click", "#addBtn", function() {
	    // 책 코드 가져오기
	    getBookCode();
	    
	    // 등록 모달 보이기
	    var myModal = new bootstrap.Modal(document.getElementById('addBookModal'));
	    myModal.show();
	});
	
	 /**
	 * 등록 버튼 클릭 시 등록 처리
	 */ 
	 $("#addBookAjax").submit(function(e) {
	    e.preventDefault();
	
	    let title = $("#title").val();
	    let bookCode = $("#mbc").val();
	    let bookCat = $("#modalBookCat2").val();
	    let writer = $("#modalWriter2").val();
	    let intro = $("#modalIntro2").val();
	    let publisher = $("#modalPublisher2").val();
	    let totalPage = $("#modalTotalPage2").val();
	    console.log("ck", title);
	
	    let formData = new FormData();
	    formData.append("title", title);
	    formData.append("bookCode", bookCode);
	    formData.append("bookCat", bookCat);
	    formData.append("writer", writer);
	    formData.append("intro", intro);
	    formData.append("publisher", publisher);
	    formData.append("totalPage", totalPage);
	    console.log("ck", formData);
	
	    let inputFile = $("#uploadFile")[0]; // jQuery 객체에서 DOM 객체로 변환
	    console.log("inputFile : ", inputFile);
	
	    let files = inputFile.files;
	    console.log("files>>>", files);
	
	    for (let i = 0; i < files.length; i++) {
	        formData.append("uploadFile", files[i]);
	    }
	
	    console.log("formData: ", formData);
	
	    // AJAX를 이용해 폼 데이터 전송
	    $.ajax({
	        url: "/public/admin/createAjax",
	        processData: false,
	        contentType: false,
	        data: formData,
	        type: "POST",
	        dataType: "text",
	        beforeSend: function(xhr) {
	            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
	        },
	        success: function(result) {
	            console.log("결과: ", result);
	            if(result > 0 ) {
	                Swal.fire({
	                    position: "center",
	                    icon: "success",
	                    title: "등록완료 되었습니다.",
	                    timer: 1800,
	                    showConfirmButton: false // 확인 버튼을 숨깁니다.
	                }).then(() => {
	                    location.replace(location.href);
	                });
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error("AJAX 오류: ", error);
	            // 오류 처리
	        }
	    });
   	return false;
   });

	
  // 모달이 닫힐 때 초기화
  $('#addBookModal').on('hidden.bs.modal', function () {
	    $("#title").val('').removeClass("is-invalid");
	    $("#mbc").val('').removeClass("is-invalid");
	    $("#modalBookCat2").val('').removeClass("is-invalid");
	    $("#modalWriter2").val('').removeClass("is-invalid");
	    $("#modalIntro2").val('').removeClass("is-invalid");
	    $("#modalPublisher2").val('').removeClass("is-invalid");
	    $("#modalTotalPage2").val('').removeClass("is-invalid");
	    $("#uploadFile").val('').removeClass("is-invalid");
	    $(".pImg").html('').removeClass("is-invalid");
	    $("#fileAdd").val('').removeClass("is-invalid");
  });
	
	
	// 깜빡임 없이 반납일 넣어 주기 위해
	let today = new Date(); 
	let year = today.getFullYear(); // 년도
	let month = ('0' + (today.getMonth() +1)).slice(-2);  // 월
	let date = ('0' + (today.getDate() +1)).slice(-2) // 날짜
	let hours = today.getHours(); // 시
	let minutes = ('0' + (today.getMinutes()+1)).slice(-2);  // 분
	console.log(year + '-' + month + '-' + date +' ' + hours + ":" +minutes);
   
	
	/**
	* 반납 버튼을 눌렀을 때 반납 처리
	*/
	$(document).on("click",".retBook", function(){
	     console.log("반납버튼 클릭 : " , $(this));
	     
	     var bookCode =  $(this).closest('tr').find('td:first').text().trim();
	     console.log("반납버튼 클릭 :  bookCode : " , bookCode);
	
	      Swal.fire({
		       title: "반납처리하시겠습니까?",
		       icon: "question",
		       showCancelButton: true,
		       confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
		       cancelButtonClass: 'btn btn-danger w-xs mt-2',
		       confirmButtonText: "예",
		       cancelButtonText: "아니오",
		       buttonsStyling: false,
		       showCloseButton: true
		   }).then(function (result) {
		      if (result.value) {
		         let data = {
		             "bookCode": bookCode,
		         };
		         console.log("bookCode : " , data);
		
		         
		         $.ajax({
		             url: "/public/admin/retUpdate",
		             contentType: "application/json;charset=utf-8",
		             data: JSON.stringify(data),
		             type: "post",
		             dataType: "json",
		             beforeSend: function(xhr) {
		                 xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		             },
		             success: function(result) {
		                    
		             	 if (result > 0) {
		                      console.log("성공", $("#span" + bookCode));
		                      Swal.fire({
			                    position: "center",
			                    icon: "success",
			                    title: "정상적으로 반납처리 되었습니다.",
			                    timer: 1800,
			                    showConfirmButton: false // 확인 버튼을 숨깁니다.
		             		   });
		                      $("#span" + bookCode).html("반납완료")
		                                           .removeClass("badge bg-warning badge")
		                                           .addClass("badge bg-success")
		                      $("#btn" + bookCode).attr("disabled", true);
		                      $("#rD" +bookCode).html(year + '-' + month + '-' + date +' ' + hours + ":" +minutes);
		                  }
		             },
		             error: function(error) {
		                 console.log("Error:", error);
		             }
		         });
			}
		});
	});
	
	
	// 검색 버튼
    $('.btnSearch').on('click', function() {
        let keyword = $("#searchh").val();
        console.log(">>>>>>>>>>", keyword)
        getList(keyword, 1);
    });

    // 전체 검색 버튼 클릭 시 실행되는 함수
    $(".btnSearchAll").on('click', function() {
        getList("", 1);
    });
    
    // 원래 정보 담을 박스
	let originalValues = {};

    // 수정버튼
	$('#edit').on('click', function() {
		$('#p1').css("display", "none");
		$('#p2').css("display", "block");
		$('#fileAdd').css("display", "block");
		$('.formdata').removeAttr("readonly");
	});

    // 수정 붕 취소 버튼 누르면 원래 정보로 불러오기
	$("#cancle").on('click', function() {
	    $('#p1').css("display", "block");
	    $('#p2').css("display", "none");
	    $('#fileAdd').css("display", "none");
	    $('.formdata').attr("readonly", true);
	    $("#fileAdd").val('').removeClass("is-invalid");
	
	    $("#modalTitle").val(originalValues.title);
	    $("#modalBookCat").val(originalValues.bookCat);
	    $("#modalWriter").val(originalValues.writer);
	    $("#modalIntro").val(originalValues.intro);
	    $("#modalTotalPage").val(originalValues.totalPage);
	    $("#modalPublisher").val(originalValues.publisher);
	    $("#modalBookImg").attr('src', "/upload" + originalValues.attach);
	    
	    $(".pImg").html("<img src=\"/upload" + originalValues.attach + "\" style='width:90%;' />");
	    console.log(">>여기 : ", "/upload" + originalValues.attach);
	});

    
    // 수정 시  확인 버튼 눌렀을 때 정보 저장하기
	$("#confirm").on("click",function() {
		
		let dataArr = $("#frm").serializeArray();
		console.log("dataArr>>>", dataArr);
		let bookCode = $("#modalBookCode").val();
		console.log("bookCode>>>", bookCode);

		let data = {
			"bookCode" : bookCode
		};

		dataArr.map(function(row, idx) {
			//  key  value
			data[row.name] = row.value;
		});

		console.log("data>>>", data);

		let formData = new FormData();
		  formData.append("bookCode", bookCode);
		  formData.append("title", data.title);
		  formData.append("bookCat", data.bookCat);
		  formData.append("writer", data.writer);
		  formData.append("intro", data.intro);
		  formData.append("publisher", data.publisher);
		  formData.append("totalPage", data.totalPage);
		  console.log("ck", formData);

		let inputFile = $("#fileAdd")[0]; // jQuery 객체에서 DOM 객체로 변환
		console.log("inputFile : ", inputFile);
		
		let files = inputFile.files;
		console.log("files>>>", files);
		
		for (let i = 0; i < files.length; i++) {
		    formData.append("uploadFile", files[i]);
		}
		console.log("formData: ", formData);


	
	    Swal.fire({
		    title: "수정 하시겠습니까?",
		    icon: "question",
		    showCancelButton: true,
		    confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
		    cancelButtonClass: 'btn btn-danger w-xs mt-2',
		    confirmButtonText: "예",
		    cancelButtonText: "아니오",
		    buttonsStyling: false,
		    showCloseButton: true
		}).then(function (result) {
	       if (result.value) {
			$.ajax({
				url : "/public/admin/bookUp",
			    processData: false,
		        contentType: false,
		        data: formData,
		        type: "POST",
		        dataType: "text",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
				},
				success : function(result) {
					console.log("result: ", result);
	
					$('#p1').css("display", "block");
					$('#p2').css("display", "none");
					$('#fileAdd').css("display", "none");
					$('.formdata').attr("readonly", true);
					
					 if(result > 0 ) {
		            	 Swal.fire({
		                     position: "center",
		                     icon: "success",
		                     title: "수정 완료 되었습니다.",
		                     timer: 1800,
		                     showConfirmButton: false // 확인 버튼을 숨깁니다.
		                   }).then(() => {
		           			location.replace(location.href);
		                 });
		             }
				},
		        error: function(xhr, status, error) {
		            console.error("AJAX 오류: ", error);
		        }
				});
			}
		});
	});

    
    
    /**
    * 삭제 버튼 눌렀을 때 도서 삭제 하기
    */
	$(document).on('click','.delBtn',function() {
			
		var self = this;
		var selectedBooks = [];
		console.log(selectedBooks)
		var row = $(this).closest('tr');
		var bookCode = row.find('.tblRow').data('bookcode');
		console.log(bookCode)
		selectedBooks.push(bookCode);
		console.log(selectedBooks)

		
		
		Swal.fire({
		    title: "삭제하시겠습니까??",
		    icon: "question",
		    showCancelButton: true,
		    confirmButtonClass: 'btn btn-primary w-xs me-2 mt-2',
		    cancelButtonClass: 'btn btn-danger w-xs mt-2',
		    confirmButtonText: "예",
		    cancelButtonText: "아니오",
		    buttonsStyling: false,
		    showCloseButton: true
		}).then(function (result) {
	        if (result.value) {
				selectedBooks.forEach(function(selectedBook) {
					let data = {
						"bookCode" : selectedBook
					};
					$.ajax({
						url : "/public/admin/bookDel",
						contentType : "application/json;charset=utf-8",
						data : JSON.stringify(data),
						type : "post",
						dataType : "json",
						beforeSend : function(xhr) {
							xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
						},
						success : function(result) {
							if(result > 0) {
								 Swal.fire({
					                    position: "center",
					                    icon: "success",
					                    title: "삭제 완료 되었습니다.",
					                    timer: 1800,
					                    showConfirmButton: false // 확인 버튼을 숨깁니다.
					                }).then(() => {
					                    location.replace(location.href);
					                });
							}
						}
					});
				});
			}
		});
	});



	/**
	* 도서 상세 정보 모달 띄우기
	*/
	$(document).on('click','.tblRow',function(event) {
		event.preventDefault();
		var row = $(this).closest('tr');
		var rnum = row.children().eq(1).text();
		var title = row.children().eq(2).text();
		var bookCat = row.children().eq(3).text();
		var writer = row.children().eq(4).text();
		var intro = row.children().eq(0).children().val().trim();
		var publisher = row.children().eq(6).text();
		var status = row.children().eq(7).html();
		var totalPage = row.children().eq(9).text();
		var bookCode = $(this).data('bookcode');
		var attach = $(this).data('attach'); // 데이터 속성에서 이미지 경로 가져오기
		
		console.log("??? ",attach)
		 
		originalValues = {
			title : title,
			bookCat : bookCat,
			writer : writer,
			intro : intro,
			publisher : publisher,
			totalPage : totalPage,
			attach : attach
		};
		console.log("originalValues??? ",originalValues)
	
		$("#modalRnum").text(rnum);
		$("#modalTitle").val(title);
		$("#modalBookCat").val(bookCat);
		$("#modalWriter").val(writer);
		$("#modalIntro").val(intro);
		$("#modalPublisher").val(publisher);
		$("#modalStatus").html(status);
		$("#modalBookCode").val(bookCode);
		$("#modalTotalPage").val(totalPage);
		$("#modalBookImg").attr('src',"/upload" + attach); // 모달의 이미지 src 속성 설정
	
		var myModal = new bootstrap.Modal(document.getElementById('bookDetailModal'));
		myModal.show();
	});

	
	
	/**
	* 대여 현황 상세 모달
	*/
	$(document).on('click','.reView',function(event) {
		event.preventDefault();
		
		var row = $(this).closest('tr');
		var loanSeq = row.children().eq(2).text().trim();
		
		let data = {
				"loanSeq" : loanSeq
		}
		console.log(data);
		
		$.ajax({
			url : "/public/admin/reDetail",
			contentType : "application/json;charset=utf-8",
			data : JSON.stringify(data),
			type : "post",
			dataType : "json",
			beforeSend : function(xhr) {
				xhr.setRequestHeader("${_csrf.headerName}",
						"${_csrf.token}");
			},
			success : function(result) {
				console.log(">>",$("#modalBookCode").html(result.bookCode));
				
				let memTel = result.memList[0].memTelno.replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})(\d+)(\d{4})$/, "$1-$2-$3").replace("--", "-");
				console.log("memTel: ", memTel);
				
				$("#modalLoanSeq").html(result.loanSeq);
				$("#modalBookCode2").html(result.bookCode);
				$("#modalTitle2").html(result.bookList[0].title);
				$("#modalMemId").html(result.memId);
				$("#modalMemNm").html(result.memList[0].memNm);
				$("#modalMemTelno").html(memTel);
				$("#modalRoomCode1").html(result.roomList[0].dongCode);
				$("#modalRoomCode2").html(result.roomList[0].roomCode);
				$("#modalLoanDt").html(result.loanDt);
				$("#modalReturnStatus").html(result.returnStatus);
				$("#modalBookImg2").attr('src' ,"/upload"+ result.bookList[0].attach ); 
				
			}
		});
		
		var myModal = new bootstrap.Modal(document.getElementById('bookReDetailModal'));
		myModal.show();
	});

	

}); // 함수 끝


/**
 * 대여현황리스트 : 비동기로 작업
 */
function getList(keyword, currentPage) {
    let data = {
        "keyword": keyword,
        "currentPage": currentPage
    };
    console.log("data>>", data);

    $.ajax({
        url: "/public/admin/rentalListAjax",
        contentType: "application/json;charset=utf-8",
        data: JSON.stringify(data),
        type: "post",
        dataType: "json",
        beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success: function(result) {
            console.log("result>>", result);

            let str = "";
            $.each(result.content, function(idx, bookLoanVO) {
                let bookList = bookLoanVO.bookList;
                let memList = bookLoanVO.memList;
                let statusClass = "";
                
                str += "<tr>";
                str += "<td style='display: none;'>" + bookLoanVO.bookCode + "</td>";
                str += "<td>" + bookLoanVO.rnum + "</td>";
                
                for (let i = 0; i < bookList.length; i++) {
                    for (let j = 0; j < memList.length; j++) {
                        str += "<td><a class='reView' data-bookcode=" + bookLoanVO.bookCode + ">" + bookLoanVO.loanSeq + "</a></td>";
                        str += "<td style='text-align: left;'>" + bookList[i].title + "</td>";
                        str += "<td>" + bookLoanVO.memId + "</td>";
                        str += "<td>" + memList[j].memNm + "</td>";
                        str += "<td>" + bookLoanVO.loanDt + "</td>";
                        
                        if (bookLoanVO.returnDt == null) {
                            str += "<td id='rD" + bookLoanVO.bookCode + "'>-</td>";
                        } else {
                            str += "<td id='rD" + bookLoanVO.bookCode + "'>" + bookLoanVO.returnDt + "</td>";
                        }

                        if (bookLoanVO.returnStatus == "대출중") {
                            statusClass = "badge bg-warning";
                        } else if (bookLoanVO.returnStatus == "반납완료") {
                            statusClass = "badge bg-success";
                        } else if (bookLoanVO.returnStatus == "연체") {
                            statusClass = "badge bg-danger";
                        }

                        str += "<td><span style='width: 95px;' id='span" + bookLoanVO.bookCode + "' class='" + statusClass + "'>" + bookLoanVO.returnStatus + "</span></td>";
                        str += '<td><button type="button" id="btn' + bookLoanVO.bookCode + '" class="btn btn-soft-secondary waves-effect material-shadow-none retBook"';
                        if (bookLoanVO.returnStatus == "반납완료") {
                            str += ' disabled';
                        }
                        str += ' style="width: 95px;">반납</button></td>';
                        str += "</tr>";
                    }
                }
            });
            $("#pa2").html(result.pagingArea);
            $("#trRentalList").html(str);
        },
        error: function(error){
            console.log(error);
        }
    });
}

/**
* 책 추가 할 때 북 코드 자동 작성
*/
function getBookCode(){
	
	$.ajax({
		url:"/public/admin/getBookCode",
		type:"post",
		dataType:"text",
	    beforeSend: function(xhr){
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
		success:function(result){
			console.log("getBookCode -> result : ", result);
			
			$("#mbc").val(result);
			
		}
	});
}
</script>


<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="mdi mdi-library-shelves"></i><strong>도서관</strong></p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">공동시설물</a></li>
						<li class="breadcrumb-item active">도서목록 & 대여현황</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>



<div class="col-12">



	<div class="col" style="font-size: 16px;background-color: rgb(229, 238, 255);">
			<div class="nav nav-pills flex-row nav-pills-tab custom-horiz-nav-pills justify-content-start text-center"
				role="tablist" aria-orientation="horizontal">
				
				<a class="nav-link show active" id="custom-h-pills-home-tab"
					data-bs-toggle="pill" href="#bookList" role="tab"
					aria-controls="custom-h-pills-home" aria-selected="true"> <i
					class="ri-book-2-line nav-icon nav-tab-position"></i> 도서목록
				</a> 
				<a class="nav-link" id="custom-h-pills-profile-tab"
					data-bs-toggle="pill" href="#rentalList" role="tab"
					aria-controls="custom-h-pills-profile" aria-selected="false"
					tabindex="-1"> <i class="ri-user-fill nav-icon nav-tab-position"></i>
					대여현황
				</a> 
			
			</div>
		</div>

	<div class="card">
		<div class="card-body table-responsive">
			<div class="tab-content">
				<div class="card-header">
					<button type="button" class="btn btn-outline-secondary" id="addBtn">
						<span class="icon-on"><i
							class="ri-add-line align-bottom me-1"></i> 책 등록</span>
					</button><br><br><br>
				</div>
				<div class="active tab-pane" id="bookList">
					
<!-- 차트------------------------------------------------------------------------------------------------->
					<div class="col-xl-6" style="float: left; position: relative; z-index: 2;" >
						<div class="card">
							<div class="card-header">
								<h3 class="card-title mb-0">보유 도서 구분 별 통계</h3>
							</div>
							<div class="card-body">
								<canvas id="pieChart1" class="chartjs-chart"
									data-colors="[&quot;--vz-success&quot;, &quot;--vz-light&quot;]"
									width="758" height="320"
									style="display: block; box-sizing: border-box; height: 320px; width: 758px;"></canvas>
							</div>
						</div>
					</div>
					
					<div class="col-xl-6" style="float: left; position: relative; z-index: 2;">
						<div class="card">
							<div class="card-header">
								<h3 class="card-title mb-0">대출 도서 구분 별 통계</h3>
							</div>
							<div class="card-body"  style="overflow-x: hidden">
								<canvas id="pieChart2" class="chartjs-chart"
									data-colors="[&quot;--vz-success&quot;, &quot;--vz-light&quot;]"
									width="758" height="320"
									style="display: block; box-sizing: border-box; height: 320px; width: 758px;"></canvas>
							</div>
						</div>
					</div>


<!-- bookCat=에세이, totalbook=11, -->
<c:forEach var="total1" items="${catCnt}" varStatus="stat">
   <input type="hidden" class="cnt${stat.index+1} cnt" data-book-cat="${total1.bookCat}" data-totalbook="${total1.totalbook}" />
</c:forEach>

<!-- totalReBook=10,bookList= bookCat=에세이,  -->
<c:forEach var="total2" items="${reCatCnt}" varStatus="stat">
  <input type="hidden" class="reCnt${stat.index+1} reCnt" data-total-re-book="${total2.totalReBook}" data-book-cat="${total2.bookList[0].bookCat}"  />
</c:forEach>

<script>
$(document).ready(function() {
    function getRandomColor(existingColors) {
        let color;
        do {
            color = 'rgba(' + Math.floor(Math.random() * 256) + ',' + Math.floor(Math.random() * 256) + ',' + Math.floor(Math.random() * 256) + ', 0.6)';
        } while (existingColors.includes(color));
        return color;
    }

    function getRandomBorderColor(color) {
        return color.replace(', 0.6)', ', 1)');
    }

    let cntList = [];
    $(".cnt").each(function(index) {
        let bookCat = $(this).data("bookCat");
        let totalbook = $(this).data("totalbook");
        cntList.push({
            bookCat: bookCat,
            totalbook: totalbook
        });
    });

    let category = cntList.map(item => item.bookCat);

    let existingColors = [];
    let backgroundColors = cntList.map(() => {
        let color = getRandomColor(existingColors);
        existingColors.push(color);
        return color;
    });

    let borderColors = backgroundColors.map(color => getRandomBorderColor(color));
    let hoverBackgroundColors = backgroundColors.map(color => getRandomBorderColor(color));

    const pieExample1 = document.querySelector('#pieChart1').getContext('2d');
    const pieExampleChart1 = new Chart(pieExample1, {
        type: 'pie',
        data: {
            labels: category,
            datasets: [{
                data: cntList.map(item => item.totalbook),
                backgroundColor: backgroundColors,
                borderColor: borderColors,
                borderWidth: 2,
                hoverBackgroundColor: hoverBackgroundColors
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: true,
                    position: 'right'
                }, 
                datalabels: {
                    color: 'black',
                    font: {
                        size: 16,
                        weight: 'bold'
                    },
                    formatter: (value) => {
                        return value;
                    }
                }
            }
        },
        plugins: [ChartDataLabels]
    });

    let reCntList = [];
    $(".reCnt").each(function(index) {
        let bookCat = $(this).data("bookCat");
        let totalReBook = $(this).data("totalReBook");
        reCntList.push({
            bookCat: bookCat,
            totalReBook: totalReBook
        });
    });

    let reCategory = reCntList.map(item => item.bookCat);

    existingColors = [];
    backgroundColors = reCntList.map(() => {
        let color = getRandomColor(existingColors);
        existingColors.push(color);
        return color;
    });

    borderColors = backgroundColors.map(color => getRandomBorderColor(color));
    hoverBackgroundColors = backgroundColors.map(color => getRandomBorderColor(color));

    const pieExample2 = document.querySelector('#pieChart2').getContext('2d');
    const pieExampleChart2 = new Chart(pieExample2, {
        type: 'pie',
        data: {
            labels: reCategory,
            datasets: [{
                data: reCntList.map(item => item.totalReBook),
                backgroundColor: backgroundColors,
                borderColor: borderColors,
                borderWidth: 2,
                hoverBackgroundColor: hoverBackgroundColors
            }]
        },
        options: {
            plugins: {
                legend: {
                    display: true,
                    position: 'right'
                },
                datalabels: {
                    color: 'black',
                    font: {
                        size: 16,
                        weight: 'bold'
                    },
                    formatter: (value) => {
                        return value;
                    }
                }
            }
        },
        plugins: [ChartDataLabels]
    });
});
</script>

<!-- 차트------------------------------------------------------------------------------------------------->


        <button type="button" class="btn btn-light waves-effect float-end btnSearchAll">전체보기</button>
        <button type="button" class="btn btn-soft-dark waves-effect waves-light material-shadow-none float-end btnSearch">검색</button>
        
					<table class="table table-hover text-nowrap tt" style="width: 100%;" >
						<thead>
							<tr>
								<th></th>
								<th>책코드</th>
								<th>책제목</th>
								<th>도서구분</th>
								<th>저자</th>
								<th>책소개</th>
								<th>출판사</th>
								<th>대출상태</th>
								<th>삭제여부</th>
								<th></th>
								<th style="display: none;"></th>
							</tr>
						</thead>
						<tbody id="trShow">
							<c:forEach var="bookVO" items="${bookList}" varStatus="stat">
								<tr>
									<td><input type="hidden" value="${bookVO.intro}"></td>
									<td>${bookVO.bookCode}</td>
									<td style="text-align: left;" ><a class="tblRow" data-bookcode="${bookVO.bookCode}"
										data-attach="${bookVO.attach}">${bookVO.title}</a></td>
									<td>${bookVO.bookCat}</td>
									<td>${bookVO.writer}</td>
									<td>
										<c:if test="${bookVO.intro.length() > 20}">
									    	${bookVO.intro.substring(0, 20)}...
										</c:if>
									</td>
									<td>${bookVO.publisher}</td>
									<td style="font-size: 16px;">
										 <c:choose>
											<c:when test="${bookVO.status == '대출중'}">
												<span class="badge bg-warning"  style="width: 96px;">${bookVO.status}</span>
											</c:when>
											<c:when test="${bookVO.status == '대출가능'}">
												<span class="badge bg-secondary"  >${bookVO.status}</span>
											</c:when>
										</c:choose>
									</td>
									<td>${bookVO.delyn}</td>
									<td style="display: none;">${bookVO.totalPage}</td>
									<td><button type="button"
											class="btn btn-soft-secondary waves-effect material-shadow-none delBtn">삭제</button></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="row clsPagingArea" id="pa1" style="float: left">
						${articlePage.pagingArea}</div>
				</div>

				<!-- ---=========================-----대여현황======================== -->
				<div class="tab-pane col-12" id="rentalList">

					<div class="card-body table-responsive p-0">
						<form id="reF">
							<input type="text" id="searchh" name="table_search"
								class="form-control float-right" 
								style="width: 230px;float: left;">
							<button type="button"
								class="btn btn-soft-dark waves-effect waves-light material-shadow-none btnSearch">검색</button>
							<button type="button" class="btn btn-light waves-effect btnSearchAll">전체보기</button>
						</form>
						<table class="table table-hover text-nowrap tt"
							style="width: 100%;padding: 5px;">
							<thead>
								<tr>
									<th>순번</th>
									<th>일련번호</th>
									<th>책 제목</th>
									<th>대여자 아이디</th>
									<th>대여자 명</th>
									<th>대여일</th>
									<th>반납일</th>
									<th>상태</th>
									<th>반납여부</th>
								</tr>
							</thead>
							<tbody id="trRentalList">

							</tbody>
						</table>
						<div class="row clsPagingArea" id="pa2" style="float: left">
							${articlePage2.pagingArea}</div>

					</div>

				</div>
			</div>


			<!-- ---=========================상세&수정 모달======================== -->
			<form action="/admin/bookUp" id="frm">
				<div class="modal fade bd-example-modal-lg" id="bookDetailModal"
					tabindex="-1" aria-labelledby="bookDetailModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<strong>제목 : &nbsp;&nbsp;</strong> <input type="text" value=""
									class="modal-title formdata" id="modalTitle" name="title"
									readonly style="width: 355px;" />
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="pImg" style="width: 50%; float: left;">
										<img style="width: 100%;" id="modalBookImg" name="attach" src="" />								
								</div>
								<div class="dd">
									<p>
										<strong>도서구분 :</strong><br /> <input type="text"
											class="formdata" id="modalBookCat" name="bookCat" readonly />
									</p>
									<p>
										<strong>저자 :</strong><br /> <input type="text"
											id="modalWriter" class="formdata" name="writer" readonly />
									</p>
									<p>
										<strong>책소개 :</strong><br />
										<textarea style="width: 240px;min-height: 100px;resize: none;" id="modalIntro"
											class="formdata" name="intro" readonly></textarea>
									</p>
									<p>
										<strong>출판사 :</strong><br /> <input type="text"
											id="modalPublisher" class="formdata" name="publisher"
											readonly />
									</p>
									<p>
										<strong>총 페이지 :</strong><br /> <input type="number"
											id="modalTotalPage" class="formdata" name="totalPage"
											readonly />
									</p>
									<p>
										<strong>대출상태 :</strong> <span id="modalStatus"></span>
									</p>
									<input type="hidden" id="modalBookCode" />
									<p>
										<input type="file" id="fileAdd" name="uploadFile" style="display: none;" />
									</p>
								</div>
		
							</div>
							<div class="modal-footer">
								<p id="p1">
									<button type="button" class="btn btn-secondary" id="edit">수정</button>
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal">닫기</button>
								</p>
								<p id="p2" style="display: none;">
									<input type="button" class="btn btn-secondary" id="confirm"
										value="확인"> <input type="button"
										class="btn btn-secondary" id="cancle" value="취소">
								</p>
							</div>
						</div>
					</div>
				</div>
			</form>



			<!-- 대여현황 상세 -->
			<div class="modal fade bd-example-modal-lg" id="bookReDetailModal"
				tabindex="-1" aria-labelledby="bookReDetailModalLabel"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="modalLoanSeq"></h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body">
							<img id="modalBookImg2" name="attach" src="" />
							<div class="dd">
								<p>
									<strong>책 ID :&nbsp; </strong> <span id="modalBookCode2"></span>
								</p>
								<p>
									<strong>책 제목 :&nbsp; </strong><br> <span id="modalTitle2"></span>
								</p>
								<hr>
								<p>
								<h5>대여자 정보</h5>
								<hr>
								<p>
									ㄴ<strong>ID :&nbsp; </strong><span id="modalMemId"></span>
								</p>
								<p>
									ㄴ<strong>이름 :&nbsp; </strong> <span id="modalMemNm"></span>
								</p>
								<p>
									ㄴ<strong>전화번호 :&nbsp; </strong> <span id="modalMemTelno"></span>
								</p>
								<p>
									ㄴ<strong>동호수 :&nbsp; </strong> <span id="modalRoomCode1"></span><span>동&nbsp;</span><span
										id="modalRoomCode2"></span><span>호</span>
								</p>
								<p>
									ㄴ<strong>대여일시 :&nbsp; </strong> <span id="modalLoanDt"></span>
								</p>
								<p>
									ㄴ<strong>반납상태 :&nbsp; </strong> <span id="modalReturnStatus"></span>
								</p>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>







			<!-- 책 추가 -->
			<form action="/admin/createAjax" id="addBookAjax" method="post" enctype="multipart/form-data">
				<div class="modal fade bd-example-modal-lg" id="addBookModal"
					tabindex="-1" aria-labelledby="addBookModalLabel"
					aria-hidden="true">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<strong>제목 : &nbsp;&nbsp;</strong> <input type="text"
									class="modal-title" id="title" name="title" required />
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="pImg" style="width: 50%; float: left;"></div>
								<div class="dd" style="width: 50%; float: right;">
									<p>
										<strong>도서 ID :</strong><br /> <input type="text" id="mbc"
											name="bookCode" required />
									</p>
									<p>
										<strong>도서구분 :</strong><br /> <input type="text"
											id="modalBookCat2" name="bookCat" required />
									</p>
									<p>
										<strong>저자 :</strong><br /> <input type="text"
											id="modalWriter2" name="writer" required />
									</p>
									<p>
										<strong>책소개 :</strong><br />
										<textarea style="width: 240px" id="modalIntro2" name="intro"
											required></textarea>
									</p>
									<p>
										<strong>출판사 :</strong><br /> <input type="text"
											id="modalPublisher2" name="publisher" required />
									</p>
									<p>
										<strong>총 페이지 :</strong><br /> <input type="number"
											id="modalTotalPage2" name="totalPage" required />
									</p>
									<p>
										<strong>도서 이미지:</strong><br /> <input type="file"
											id="uploadFile" name="uploadFile" />
									</p>
								</div>
							</div>
							<div class="modal-footer">
								<button type="submit" class="btn btn-primary" id="subb">등록</button>
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
							</div>
						</div>
					</div>
				</div>
				<sec:csrfInput/>
			</form>

		</div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>