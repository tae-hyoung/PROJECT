<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.homecat.sweethome.vo.member.MemberVO"%>
<%
        MemberVO member = session.getAttribute("loginMember") != null ? (MemberVO) session.getAttribute("loginMember") : null;
        String memAuth = member != null ? member.getMemAuth() : null;
%>


<style>
.dImg {
    width:430px;
    height:300px;
}


</style>

<script type="text/javascript">


$(document).on('click', ".tblRow", function(){
	location.href = "/site/danji/detail?danjiCode="+$(this).children().eq(0).children().eq(0).html();
})


function getList(){
	
	
	$.ajax({
		url:"/site/danji/list",
		contentType:"application/json;charset=utf-8",
		type:"post",
		dataType:"json",
		beforeSend: function(xhr){
			xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
		},
		success:function(result){
			console.log("result : ", result);
			
			let str = "";

	         for(let i=0; i<result.length/3; i++){
	            str += "<tr>";
	            for(let j=0; j<3; j++){
	               if(i*3+j == result.length){
	                  break;
	               }
	               str += "  <td class='tblRow'>"
	               str += "    <div>"
	               str += "      <p style='display: none' >"+(result[i*3+j].danjiCode)+"</p>"
	               str += "    </div>"
	               str += "    <div>"
	               str += "      <image class='dImg'  src='/upload"+result[i*3+j].danjiPicture+"'>";
	               str += "    </div>"
	               str += "    <div>"
	               str +=        result[i*3+j].danjiName
	               str += "    </div>"
	               str += "  </td>";
	            }
	            
	            str += "</tr>";
	         };
			
			
			console.log("str : ", str);
			
			$("#trShow").html(str);
		}
	});
}

$(document).ready(function(){
	
	getList();
	
    if('<%= memAuth%>' == 'ROLE_MASTER'){
        let htmlStr = '';
        htmlStr += '<a href="/site/danji/create" class="btn btn-primary"> 단지 등록 </a>';
        $('#create').html(htmlStr);
}
	
	
});
</script>
<div class="main-content">
            <div class="page-content">
                <div class="container-fluid">

                    <div class="row" style="margin-top: 50px;">
                        <div class="col-lg-12">
                            <div class="card rounded-0 bg-success-subtle mx-n4 mt-n4 border-top">
                                <div class="px-4">
                                    <div class="row" style="width: 3500px;">
                                        <div class="col-xxl-5 align-self-center">
                                            <div class="row">
                                            	<div class="col-3" style="margin-top: 30px;">
                                                	<h5 style="color:#222; font-size: 2rem; font-weight: 800" class="display-6 coming-soon-text">
                                                	| 단지 소개</h5>
                                                </div>
                                    		</div>
                                		</div>
                                <!-- end card body -->
                            </div>
                            <!-- end card -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
 </div> 

<div class="col-12">
	<div class="card row">
			<h3 class="card-title">${danjiName}</h3>
			<div class="card-tools"></div>

		<div class="card-body table-responsive" >
			<div id="create"class="col-1" style="float: right; margin-bottom: 10px" >
			
			</div>
			<table class="table table-head-fixed text-nowrap">
				<tbody id="trShow">
				</tbody>
			</table>

		</div>
	</div>
</div>