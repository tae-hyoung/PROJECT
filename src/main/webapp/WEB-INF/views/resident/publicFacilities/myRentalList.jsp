<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<div style="display: none" id="memId"><sec:authentication property="principal.memberVO.memId" /></div>


<!-- 스위트 알러트 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

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

<script src="/resources/js/jquery.min.js"></script>

<title>도서관</title>
<style type="text/css">
.badge {
	font-size: 18px;
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

#DataTables_Table_0 {
	padding: 5px;
}

#modalBookImg {
   width: 50%;
   height: 400px;
   float: left;
   margin-left: 5px;
}
#dd {
   width: 45%;
   float: right;
}
.pagination{
   padding-left: 706px;
   display: inline-flex;
}
#DataTables_Table_0_length{
	display: none;
}
#aTag{
    margin-left: 1510px;
    border: 1px solid;
    background-color: #405189;
    padding: 4px;
    color: white;
}
#DataTables_Table_0_paginate {
    margin: 22px -651px;
    white-space: nowrap;
    justify-content: right;
    width: 20px;
}
#DataTables_Table_0_info {
	display: none;
}
/* 대여목록 바로가기 */
#myRentalList{
  margin-left: 1162px; 
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
<script>

document.addEventListener('DOMContentLoaded', function() {
	let table = new DataTable('.tt', {
		 "search": false
			,"paging" : true
			,"language": {
	            "zeroRecords": "대여 내역이 없습니다.",
	            "paginate": {
	                "next": "다음",
	                "previous": "이전"
	            }

		  }
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
	               html: "※도서관의 책은 공공 물품입니다.<br>속히 반납 부탁드립니다.※",
	               icon: "warning"
	           });
			}
        }
    });
	
	
	$("#myRentalList").on("click", function(){
		location.href = "/public/book/list";
	});
	
});

</script>

<div class="container-fluid">
<div class="row">
      <div class="col-12">
         <div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
            <p class="mb-sm-0" style="font-size:18px; color: #495057;"><i class="lab las la-cat"></i><strong>나의 대여 목록</strong></p>
            <div class="page-title-right">
               <ol class="breadcrumb m-0">
                  <li class="breadcrumb-item">도서관</li>
                  <li class="breadcrumb-item active">나의 대여목록</li>
               </ol>
            </div>
         </div>
      </div>
   </div>
</div>

<%-- ${bookLoanList} --%>
<div class="col-12">
	<div class="card">
		<div class="card-header">
			<img alt="" src="/resources/images/books.png" style="width: 40px; float: left;margin-right: 5px;">
			<h3 class="card-title" style="font-size: 30px; float: left;">나의 대여 목록</h3>
			<button class="btn btn-primary waves-effect waves-light" id="myRentalList" type="button">
				<span style="margin-left: -11px;">도서목록</span>
				<span class="arrow-right"></span>
			</button>
		</div>

		<div class="card-body table-responsive p-0" style="min-height: 600px;">
			<table class="table table-hover text-nowrap tt">
				<thead>
					<tr>
						<th>대여 일련 번호</th>
						<th>책제목</th>
						<th>책소개</th>
						<th>구분</th>
						<th>저자</th>
						<th>대여일</th>
						<th>반납일</th>
						<th>반납상태</th>
					</tr>
				</thead>
				<tbody id="trShow">
					<c:forEach var="bookLoanVO" items="${bookLoanList}" varStatus="stat">
						<tr>
							<td>${bookLoanVO.loanSeq}</td>
							<td style="text-align: left;" >${bookLoanVO.bookList[0].title}</td>
							<td>
								<c:if test="${bookLoanVO.bookList[0].intro.length() > 20}">
								    ${bookLoanVO.bookList[0].intro.substring(0, 20)}...
								</c:if>
							</td>
							<td>${bookLoanVO.bookList[0].bookCat}</td>
							<td>${bookLoanVO.bookList[0].writer}</td>
							<td>${bookLoanVO.loanDt}</td>
							<td>${bookLoanVO.returnDt}</td>
							<td>
			                     <c:choose>
			                        <c:when test="${bookLoanVO.returnStatus == '대출중'}">
			                           <span class="badge bg-warning" style="width: 95px;">${bookLoanVO.returnStatus}</span>
			                        </c:when>
			                        <c:when test="${bookLoanVO.returnStatus == '반납완료'}">
			                           <span class="badge bg-success" >${bookLoanVO.returnStatus}</span>
			                        </c:when>
			                        <c:when test="${bookLoanVO.returnStatus == '연체'}">
			                           <span class="badge bg-danger" style="width: 95px;">${bookLoanVO.returnStatus}</span>
			                        </c:when>
			                     </c:choose>
                           </td>
						
						</tr>
					</c:forEach>
				</tbody>
			</table>


	
		</div>


	</div>
</div>