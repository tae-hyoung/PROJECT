<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<input type="hidden" class="form-control" id="memId" name = "memId" value="<sec:authentication property='principal.memberVO.memId'/>">
<c:if test = "{nickname != null}">
    <input type="hidden" name="nickname" name="nickname" value = "${nickname}">
</c:if>
<c:if test = "{nickname == null}">
    <input type="hidden" name="nickname" name="nickname" value="<sec:authentication property='principal.memberVO.nickname'/>">
</c:if>
<div class="container-fluid">
    <div class="position-relative mx-n4 mt-n4">
        <div>
            <img src="/resources/images/BG.jpg" class="profile-wid-img" alt="" style="width: 100%;">
        </div>
    </div>
    <div class="row mt-4">
        <div class="col-xxl-center">
            <div class="card">
                <div class="card-header">
                    <ul class="nav nav-tabs-custom rounded card-header-tabs border-bottom-0" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link active" data-bs-toggle="tab" href="#personalDetails" role="tab" aria-selected="true">
                               <i class="fas fa-home"></i> 회원 정보
                            </a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link" data-bs-toggle="tab" href="#changePassword" role="tab" aria-selected="false" tabindex="-1">
                                <i class="far fa-user"></i> 비밀번호 변경
                            </a>
                        </li>
                    </ul>
                </div>
                <div class="card-body p-4">
                    <div class="tab-content">
                        <div class="tab-pane active" id="personalDetails" role="tabpanel">
						    <form action="javascript:void(0);">
						        <div class="row">
                                    <div class="alert alert-secondary material-shadow" role="alert" style="text-align: center;">
                                        <b> 프로필사진 </b>, <b>닉네임</b>, <b>연락처</b>, <b>전자주소(이메일)</b>는 수정이 가능합니다.  
                                    </div>
						        	<div class="col-lg-1">
						        	</div>
                                    <div class="col-lg-10">
                                        <div class="card mt-5">
                                            <div class="card-body p-4">
                                                <div class="row">
                                                    <div class="col-lg-4 text-center">
                                                        <div class="mb-4">
                                                            <img src="/resources/images/logo/logo3.png" alt="로고" style="width: 100%;">    
                                                        </div>
                                                        <div id="profileImageWrapper" class="profile-user position-relative d-inline-block mx-auto mb-4">
                                                            <c:if test="${mjSajin != null}">
                                                                <img src="/upload/profile/${mjSajin}" class="rounded-circle avatar-xl img-thumbnail user-profile-image material-shadow" alt="user-profile-image" id="residentImg">
                                                            </c:if>
                                                            <c:if test="${mjSajin == null}">
                                                                <img src="/upload/profile/<sec:authentication property='principal.memberVO.profImg'/>" class="rounded-circle avatar-xl img-thumbnail user-profile-image material-shadow" alt="user-profile-image" id="residentImg">
                                                            </c:if>
                                                        </div>
                                                        <h4 class="fs-16 mb-1">프로필 사진</h4>
                                                        <button type="button" id="resetPhoto" style="display: none;">기본 사진</button>
                                                    </div>
                                                    <div class="col-lg-8">
                                                        <div class="table-responsive">
                                                            <table class="table table-nowrap">
                                                                <tbody class="gridjs-tbody">
                                                                    <!-- 불러 올 데이터  -->
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                        <div class="hstack gap-2 justify-content-end">
                                                            <button id="editBtn" type="button" class="btn btn-primary">수정</button>
                                                            <a type="button" class="btn btn-soft-secondary" id="homeBtn" href="/home/adminHome">홈</a>
                                                            <button id="saveBtn" type="button" class="btn btn-primary" style="display:none;">저장</button>
                                                            <button id="cancelBtn" type="button" class="btn btn-soft-secondary" style="display:none;">취소</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-1">
						        	</div>
						        </div>
						    </form>
						</div>
                        <!--end tab-pane-->
                        <div class="tab-pane" id="changePassword" role="tabpanel">
                            <form action="javascript:void(0);">
                                <div class="row g-2">
                                	<div class="col-lg-1">
                                    </div>
                                    <div class="col-lg-3">
                                        <div>
                                            <label for="oldpasswordInput" class="form-label">현재 비밀번호*</label>
                                            <input type="password" class="form-control" id="memPw" placeholder="현재 비밀번호">
                                        </div>
                                    </div>
                                    <!--end col-->
                                    <div class="col-lg-3">
                                        <div>
                                            <label for="newpasswordInput" class="form-label">변경할 비밀번호*</label>
                                            <input type="password" class="form-control" id="newPw" name="newPw" placeholder="변경할 비밀번호">
                                        </div>
                                    </div>
                                    <!--end col-->
                                    <div class="col-lg-3">
                                        <div>
                                            <label for="confirmpasswordInput" class="form-label">비밀번호 확인*</label>
                                            <input type="password" class="form-control" id="newPwConfirm" placeholder="비밀번호 확인">
                                        </div>
                                    </div>
                                    <div class="col-lg-1">
                                    </div>
                                    <!--end col-->
                                    <div class="col-lg-10">
                                        <div class="text-end">
                                            <button type="button" id="passwordChange" class="btn btn-success">변경</button>
                                        </div>
                                    </div>
                                    <!--end col-->
                                </div>
                                <!--end row-->
                            </form>
                        </div>
                        <!--end tab-pane-->              
                    </div>
                </div>
            </div>
        </div>
        <!--end col-->
    </div>
    <!--end row-->
<input type="hidden" id="originalProfileImg" value="<sec:authentication property='principal.memberVO.profImg'/>">
</div>
<script> 
    const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";

    let memId = $("#memId").val();
    console.log(memId);
    
    let img = "";
    let email = $("#emailInput")
    let defaultImgSrc = '/resources/images/profile/basic.png';
    let nickname = $("#nickname").val();
    let memTelno = $("#memTelno").val();
    let memEmail = $("#memEmail").val();

    /* 마이페이지 호출 */
    getProfile();

    function formatTelno(memTelno){
        if (memTelno.length === 11) {
			return memTelno.replace(/(\d{3})(\d{4})(\d{4})/, '$1-$2-$3');
		} else if (memTelno.length === 10) {
			if (memTelno.startsWith("02")) {
				return memTelno.replace(/(02)(\d{4})(\d{4})/, '$1-$2-$3');
			} else {
				return memTelno.replace(/(\d{3})(\d{3})(\d{4})/, '$1-$2-$3');
			}
		} else if (memTelno.length === 9 && memTelno.startsWith("02")) {
			return memTelno.replace(/(02)(\d{3})(\d{4})/, '$1-$2-$3');
		} else if (memTelno.length === 8) {
			return memTelno.replace(/(\d{4})(\d{4})/, '$1-$2');
		}
		return memTelno;
    }

    function getProfile(){
        $.ajax({
            url: "/resident/getProfile",
            type: "GET",
            data: {
                "memId": memId
            },
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(data){
                let tbody = $('.gridjs-tbody')
                tbody.empty();
                $.each(data, function(index, memberVO) {
                    
                    let memTelno = formatTelno(memberVO.memTelno);
                    let roomCode = roomDecode(memberVO.roomCode);

                    // HTML 템플릿에 맞게 행(tr) 추가
                    let trId = $('<tr>').addClass('table-info');
                    trId.append('<td style="text-align: center; vertical-align: middle;"><label for="memId" class="form-label"><b>ID</b></label></td>');
                    trId.append('<td style="padding-left : 50px"><input type="text" id="memId" class="form-control" style="padding-left : 20px; padding-right : 20px;" value = "' + memberVO.memId + '" readonly></td>');

                    let memNm = $('<tr>').addClass('table-info');
                    memNm.append('<td style="text-align: center; vertical-align: middle;"><label for="memNm" class="form-label"><b>이름</b></label></td>');
                    memNm.append('<td style="padding-left : 50px"><input type="text" id="memNm" class="form-control" style="padding-left : 20px; padding-right : 20px;" value = "' + memberVO.memNm + '" readonly></td>');
                    
                    let nickname = $('<tr>').addClass('table-info');
                    nickname.append('<td style="text-align: center; vertical-align: middle;"><label for="nickname" class="form-label"><b>닉네임</b></label></td>');
                    nickname.append('<td id="nicknameTd" style="padding-left : 50px"><input type="text" id="nickname" class="form-control" style="padding-left : 20px; padding-right : 20px;" value = "' + memberVO.nickname + '" readonly></td>');

                    let trTelno = $('<tr>').addClass('table-info');
                    trTelno.append('<td style="text-align: center; vertical-align: middle;"><label for="memTelno" class="form-label"><b>연락처</b></label></td>');
                    trTelno.append('<td id="memTelnoTd" style="padding-left : 50px"><input type="text" id="memTelno" class="form-control" style="padding-left : 20px; padding-right : 20px;" value = "' + memTelno + '" readonly></td>');

                    let trEmail = $('<tr>').addClass('table-info');
                    trEmail.append('<td style="text-align: center; vertical-align: middle;"><label for="emailInput" class="form-label"><b>전자우편</b></label></td>');
                    trEmail.append('<td id="memEmailTd" style="padding-left : 50px"><input type="text" id="memEmail" class="form-control" style="padding-left : 20px; padding-right : 20px;" value = "'+memberVO.memEmail+'" readonly></td>');

                    let trDanji = $('<tr>').addClass('table-info');
                    trDanji.append('<td style="text-align: center; vertical-align: middle;"><label for="danji" class="form-label"><b>거주 단지</b></label></td>');
                    trDanji.append('<td style="padding-left : 50px"><input type="text" id="memRoom" class="form-control" style="padding-left : 20px" value = "'+ memberVO.danjiName +' '+ roomCode +'" readonly></td>');

                    // 테이블에 추가
                    tbody.append(trId);
                    tbody.append(memNm);
                    tbody.append(nickname);
                    tbody.append(trTelno);
                    tbody.append(trEmail);
                    tbody.append(trDanji);
                        
                });
            },

            error: function(error){
                console.error("에러난다 쌤? -> ", error);
            }
        })
    }

    function roomDecode(roomCode){
        const parts = roomCode.split('_');

        const danNum = parts[1]+'동';
        const danRoom = parts[2]+'호';

        return danNum + ' ' + danRoom;
    }

    $("#editBtn").click(function(){
        //수정 버튼을 누르면 먼저 비밀번호를 입력 요구
        Swal.fire({
            title: '비밀번호를 입력하세요',
            input: 'password',
            inputAttributes:{
                autocapitalize: 'off',
                autocorrect: 'off',
            },
            showCancelButton: true,
            confirmButtonText: '확인',
            cancelButtonText: '취소',
            showLoaderOnConfirm: true,
            preConfirm: (password) => {
                if(!password){
                    Swal.fire("비밀번호를 입력하세요!", "비밀번호 입력 후 프로필 수정이 가능합니다", "warning");
                }
                //입력된 비밀번호 리턴
                return password;
            },
            allowOutsideClick: () => !Swal.isLoading
        }).then((result) => {
            if(result.isConfirmed){
                $.ajax({
                    url: "/pwMatch",
                    type: "POST",
                    data: result.value,
                    dataType: 'json',
                    contentType: "application/json;charset=utf-8",
                    beforeSend: function(xhr){
                        xhr.setRequestHeader(csrfHeader, csrfToken);
                    },
                    success: function(check){
                        if(check.result === "ok"){
                            console.log("비번 일치");
                            updateProfile()
                        }else{
                            Swal.fire("비밀번호 불일치!", "올바른 비밀번호를 입력하세요", "error");
                        }
                    },error: function(error){
                        console.log("에러났다 ㅠㅠ ", error);
                    }
                });
            }
        });          
    });

    function updateProfile(){
        let memTelno = $('#memTelno').val();
        let memEmail = $('#memEmail').val();
        let nickname = $('#nickname').val();
       
        /* 사진 부분이다 */
        $("#profileImageWrapper").html(`
            <c:if test="${mjSajin != null }">
                <img src="/upload/profile/${mjSajin}" class="rounded-circle avatar-xl img-thumbnail user-profile-image material-shadow" alt="user-profile-image" id="residentImg">
            </c:if>
            <c:if test="${mjSajin == null }">
                <img src="/upload/profile/<sec:authentication property='principal.memberVO.profImg'/>" class="rounded-circle avatar-xl img-thumbnail user-profile-image material-shadow" alt="user-profile-image" id="residentImg">
            </c:if>		
            <div class="avatar-xs p-0 rounded-circle profile-photo-edit">
                <input id="profImg-Resident" name="profImg-Resident" type="file" class="profile-img-file-input">
                <label for="profImg-Resident" class="profile-photo-edit avatar-xs">
                    <span class="avatar-title rounded-circle bg-light text-body material-shadow">
                        <i class="ri-camera-fill"></i>
                    </span>
                </label>
            </div>
        `);

        upImg("#profImg-Resident", "#residentImg");
        $("#resetPhoto").show();

        let telRgx = memTelno.replace(/-/g, "");
        $("#nicknameTd").html('<input type="text" class="form-control" id="nickname" value="' + nickname + '">')
        $("#nickname").on('input', rgxNickname);

        $("#memTelnoTd").html('<input type="text" class="form-control" id="memTelno" value="' + telRgx + '">');
        $("#memTelno").on('input', rgxTelno);

        $("#memEmailTd").html('<input type="text" class="form-control" id="memEmail" value="' + memEmail + '">');                                                                  
        $("#memEmail").on('input', rgxEmail);

        //버튼 변경
        $("#editBtn, #homeBtn").hide();
        $("#saveBtn, #cancelBtn").show();
    }


    $("#saveBtn").click(function(){
        let memTelno = $('#memTelno').val();
        let memEmail  = $('#memEmail').val()
        let nickname = $('#nickname').val();
        
        let validNick = 0;

        let profileImg = $('#profImg-Resident')[0].files[0]; // 파일객체 가져오기
        let profImgExt = ''; // 확장자겠지?
        let originalProfileImg = $('#originalProfileImg').val(); // 원래사진
        
        let formData = new FormData();

        if(profileImg){
            img = memId + 'Photo.'+profileImg.name.split('.').pop();
            formData.append('profImg', img);
            formData.append('file', profileImg);
        }else if ($("#residentImg").attr("src") === defaultImgSrc) {
            // 기본 이미지가 설정된 경우
            img = "basic.png";
            formData.append('file', img)
        } else{
            img = originalProfileImg;
            formData.append('profImg', img);
        }

        if(nickname === ''){
            Swal.fire("", "수정할 닉네임을 입력하세요.", "warning");
            return;
        }

        if(memTelno === ''){
            Swal.fire("", "수정할 연락처를 입력하세요", "warning");
            return;
        }

        if(memEmail === ''){
            Swal.fire("", "수정할 전자주소를 입력하세요", "warning");
            return;
        }

        let memberVO = {
            "memId" : memId,
            "nickname": nickname,
            "memTelno": memTelno,
            "memEmail" : memEmail,
            "profImg" : img
        }

        formData.append('memberVO', new Blob([JSON.stringify(memberVO)], {type: "application/json;charset=utf-8"}));

        $.ajax({
            url: "/resident/changeNick.do",
            type: "POST",
            data: JSON.stringify(memberVO),
            dataType: "json",
            contentType: "application/json;charset=utf-8",
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeader, csrfToken)
            },
            success: function(result){
                console.log(result.cnt);
                console.log(nickname);
                if(result.cnt > 0){
                    Swal.fire("수정 실패!", "이미 사용중인 닉네임 입니다.", "error");
                    return;                   
                }else{
                    Swal.fire({
                        title: "",
                        text: "회원 정보를 수정하시겠습니까?",
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: '확인',
                        cancelButtonText: '취소',
                        icon: "question"
                    }).then((result)=>{
                        if(result.isConfirmed){
                            $.ajax({
                                url: "/resident/update.do",
                                data: formData,
                                type: 'POST',
                                processData: false,
                                contentType: false,
                                beforeSend: function(xhr){
                                    xhr.setRequestHeader(csrfHeader, csrfToken);
                                },
                                success: function(data){
                                    Swal.fire("수정 완료!", "회원정보가 수정되었습니다.", "success").then(() => {
                                        location.reload();
                                    });
                                },
                                error: function(error){
                                    console.log(error+ "난다 쌤?");
                                }
                            });
                        }
                    });                 
                }
            },error: function(error){
                console.log("에러난다 쌤?" + error);
            }
        });    
    });

    $("#cancelBtn").click(function(){
        location.href = "/resident/profile";
    })

    /* 사진 미리보기 함수 */
    function upImg(imgInput, imgPrev){
        $(imgInput).on("change", function(e){
            let files = e.target.files;
            let file = files[0];

            let reg = /(.?)\/(jpg|jpeg|png|bmp)$/;

            if (!file.type.match(reg)) {
                Swal.fire("등록 실패!", "지원하지 않는 파일 형식입니다. (.jpg, .jpeg, .png, .bmp 사용 가능)", "error");
                return;
            }

            let reader = new FileReader();
            reader.onload = function(e){
                $(imgPrev).attr("src", e.target.result);
            }

            reader.readAsDataURL(file);
        });
    }

    /* 기본사진 변경 */
    $("#resetPhoto").click(function(){
        $("#residentImg").attr("src", defaultImgSrc);
        img = "basic.png";
    })

    /* 숫자만 입력되는 전화번호 */
    function rgxTelno(tel){
        const input = tel.target;
        const value = input.value;

        if(value !== undefined){
            const filteredValue = value.replace(/[^0-9]/g, '');
            input.value = filteredValue;
        }
    }

    function rgxNickname(nickname){
        const input = nickname.target;
        const value = input.value;

        if(value !== undefined){
            const filteredValue = value.replace( /[''""\s~`!@#$%^&*()_\-+={}[\]|\\:;<>,.?/]/g, '');
            input.value = filteredValue;
        }
    }

    function rgxEmail(email){
        const input = email.target;
        const value = input.value;

        if(value !== undefined){
            const filteredValue = value.replace('^[a-zA-Z0-9]*$', '');
            input.value = filteredValue;
        }
    }
    
    /* 비밀번호 변경 관련  */
    $('#passwordChange').click(function(){  

        let curPw = $('#memPw').val();
        
        if(curPw.length === 0 ){
            Swal.fire("", "현재 비밀번호를 입력 하세요.", "warning");
            return;
        }

        $.ajax({
            url: "/pwMatch",
            type: "POST",
            data: curPw,
            dataType: 'json',
            contentType: "application/json;charset=utf-8",
            beforeSend: function(xhr){
                xhr.setRequestHeader(csrfHeader, csrfToken);
            },
            success: function(check){

         
                let newPw = $('#newPw').val();
                let newPwConfirm = $('#newPwConfirm').val(); 

                if(check.result === "ok"){
                    const pattern = /^(?=.*\d)(?=.*[a-z])(?=.*[!@#$%^&*]).{8,}$/;   

                    if (newPw.trim().length < 8 || newPw.trim().length > 20) {
                        Swal.fire("", "설정 할 비밀번호를 입력하세요( 8 ~ 20자)", "warning");
                        return;
                    }

                    if (!pattern.test(newPw.trim())) {
                        Swal.fire("", "영문, 숫자, 특수문자(!@#$%^&*) 는 반드시 1개이상 포함해야 합니다.", "warning");
						return;
					}
                
                    if(newPw.trim() != newPwConfirm.trim()){
                        Swal.fire("변경 실패", "비밀번호를 확인하세요!", "error");
                        return;
                    }
                    
                Swal.fire({
                        title: "",
                        text: "비밀번호를 수정하시겠습니까?",
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: '확인',
                        cancelButtonText: '취소',
                        icon: "question"
                    }).then((result)=>{
                        if(result.isConfirmed){
                            $.ajax({
                                url: "/passwordChange",
                                type: "POST",
                                data: newPw,
                                dataType: "JSON",
                                contentType: "application/json;charset=utf-8",
                                beforeSend: function(xhr){
                                    xhr.setRequestHeader(csrfHeader, csrfToken);
                                },
                                success: function(){
                                    Swal.fire("변경 성공", "비밀번호가 변경 되었습니다.", "success").then(() => {
                                        location.reload();
                                    });
                                },error: function(error){
                                    console.log("다시 해...ㅎㅎ", error);
                                }
                            })
                        }
                    });
                }else{
                    Swal.fire("비밀번호 불일치!", "올바른 비밀번호를 입력하세요", "error");
                }
            },error: function(error){
                console.log("에러났다 ㅠㅠ ", error);
            }
        });

    })


</script>