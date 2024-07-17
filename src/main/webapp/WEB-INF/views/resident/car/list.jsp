<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>

<div style="display: none" id="memId"><sec:authentication property="principal.memberVO.memId" /></div>



<script type="text/javascript">
	
$(function(){
	
	getCarList();
	
	$('#btnSubmit').on("click",function(){
		var carNo = $("#carNo").val();
		var memId = $("#memId").text();
		var carModel = $("#carModel").val();
		
		// 정규 표현식 패턴
        var carNoPattern = /^\d{3}[가-힣]\d{4}$/;
        
        // 차량 번호 입력 여부 확인
        if (carNo.trim() === "") {
            Swal.fire({
                icon: 'error',
                title: '입력 오류',
                text: '차량 번호를 입력해주세요.',
            });
            return false;
        }

        // 차량 번호 형식 확인
        if (!carNoPattern.test(carNo)) {
            Swal.fire({
                icon: 'error',
                title: '유효성 검사 실패',
                text: '차량 번호는 숫자 3자리 + 한글 1자리 + 숫자 4자리 형식이어야 합니다.',
            });
            return false;
        }

        // 차량 모델 입력 여부 확인
        if (carModel.trim() === "") {
            Swal.fire({
                icon: 'error',
                title: '입력 오류',
                text: '차량 모델을 입력해주세요.',
            });
            return false;
        }
        
		console.log(carNo, memId, carModel);
		
		let data = {
				'carNo':carNo,
				'memId':memId,
				'carModel':carModel
		};
		
		$.ajax({
			url	:"/car/create",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
            success: function(result) {
                console.log("result : ", result);
                getCarList();
                Swal.fire({
                    icon: 'success',
                    title: '성공',
                    text: '차량이 성공적으로 등록되었습니다.',
                });
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
		
		if (confirm("차량을 삭제하시겠습니까?")) {
// 			let carNo = $("input[name='carNo']").val();

			let data = {
				"carNo" : carNo
			};
			console.log("data : " + data);

			$.ajax({
				url : "/car/deleteAjax",
				contentType : "application/json;charset=utf-8",
				data : JSON.stringify(data),
				type : "post",
				dataType : "text",
				beforeSend : function(xhr) {
					xhr.setRequestHeader("${_csrf.headerName}",
							"${_csrf.token}");
				},
				success : function(result) {
					console.log("result : ", result);

					if (result != null) {
						
						getCarList();
						
						Swal.fire({
								position: "center",
								icon: "success",
								title: "삭제가 완료 되었습니다.",
								timer: 1000,
								showConfirmButton: false // 확인 버튼을 숨깁니다.
							}).then(() => {
								// Swal.fire의 타이머가 끝난 후 호출됩니다.
								console.log("result>>>", result);
								
								
						});
					}
				}
			});
		}
	});
	
	
	
	
	
	
	
});

function getCarList(){
	let data = {
			'memId':$("#memId").text()
	};
	
	$.ajax({
		url: "/car/list",
		contentType: "application/json;charset=utf-8",
		data:JSON.stringify(data),
		type: "post",
		dataType: "json",
		beforeSend:function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
		},
		success: function(result) {
			
			console.log("result : ", result);
			
			let str = "";
			for(let i=0; i<result.length; i++){

				str += "<tr>";
				str += "<td>"+result[i].memId+"</td>";
				str += "<td>"+result[i].carNo+"</td>";
				str += "<td>"+result[i].carModel+"</td>";
				str += "<td>"+result[i].regDt+"</td>";
				str += "<td style='text-align: center;'>";
			    switch (result[i].status) {
			        case '승인대기':
			            str += "<span class='badge bg-warning'>" + result[i].status + "</span>";
			            break;
			        case '승인완료':
			            str += "<span class='badge bg-success'>" + result[i].status + "</span>";
			            break;
			        case '승인거절':
			            str += "<span class='badge bg-danger'>" + result[i].status + "</span>";
			            break;
			        default:
			            str += "<span class='badge bg-danger'>" + result[i].status + "</span>";
			    }
				str += "<td><input type='button' style='margin-left: 38px;' class='btn btn-danger btn-sm delete' value='삭제'></input></td>";
				str += "</tr>";
			}
			console.log("str : ", str);
			
// 			$(".clsPagingArea").html(result.pagingArea);
			$("#carList").html(str);
			
			$("#carNo").val("");
			$("#carModel").val("");
			
// 			location.reload();      //(일단 이렇게)
		}
	});
}

</script>



<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="ri-car-line"></i><strong> 보유차량 신청</strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="/car/list">차량등록</a></li>
						<li class="breadcrumb-item active">보유차량 신청</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="row">
	<div class="col-6">
		<div style="height: 374px;" class="card shadow p-3 rounded">
			<div class="card-header align-items-center d-flex">
				<p class="card-title mb-0 flex-grow-1" style="font-size: 25px;">
					<img alt="보유차량" src="/resources/images/차량등록.png" style="width: 35px; margin-right: 10px;">보유차량 신청
				</p>
			</div>
			<div class="card-body" style="font-size: 15px;">
				<div class="live-preview">
					<form id="frm" name="frm" action="" method="post" style="font-size: 15px;">
						<div class="mb-3">
							<label for="carNo" class="form-label">차량 번호</label> 
							<input type="button" class="btn btn-secondary waves-effect waves-light end" id="btnSubmit" value="신청" style="float: right; margin-bottom:10px;">
							<input type="text" class="form-control" id="carNo" name="carNo" value="" pattern="\d{3}[가-힣]\d{4}" title="형식: 숫자 4자리 + 한글 1자리 + 숫자 4자리" required>

						</div>
						<div class="mb-3">
							<label for="carModel" class="form-label">차량 종류</label> 
							<input type="text" class="form-control" id="carModel" value="" required="required">
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
<div class="col-6">
	<div class="card shadow p-3 rounded">
		<div class="card-header align-items-center d-flex">
			<p class="card-title mb-0 flex-grow-1" style="font-size: 25px;">
				<img alt="보유차량" src="/resources/images/차량등록.png" style="width: 35px; margin-right: 10px;">보유차량 목록
			</p>
		</div>
		<div class="card-body">
			<table id="carTbl"
						class="display table table-bordered dt-responsive"
						style="width: 100%;">
	        	<thead>
	            <tr>
	                <th style="text-align: center;">회원아이디</th>
	                <th style="text-align: center;">차량번호</th>
	                <th style="text-align: center;">차량 종류</th>
	                <th style="text-align: center;">등록일</th>
	                <th style="text-align: center;">상태</th>
	                <th style="text-align: center;">삭제</th>
	            </tr>
	       		</thead>
	       		<tbody style=" font-size: 15px;" id="carList">
	       		
	        	</tbody>
	    	</table>
	    </div>
	  </div>
	</div>
</div>





