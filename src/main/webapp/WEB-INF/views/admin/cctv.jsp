<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#cctv  {
	    margin:  0px auto;
	    width:  500px;
	    height:  375px;
	    border:  10px  #333 solid;
}

#videoElement  {
	    width:  500px;
	    height:  375px;
	    background-color:   #666;
}
</style>

<div class="container-fluid">
	<div class="row">
		<div class="col-12">
			<div
				class="page-title-box d-sm-flex align-items-center justify-content-between bg-galaxy-transparent">
				<p class="mb-sm-0" style="font-size: 18px; color: #495057;">
					<i class="las la-video"></i><strong> CCTV </strong>
				</p>
				<div class="page-title-right">
					<ol class="breadcrumb m-0">
						<li class="breadcrumb-item"><a href="javascript: void(0);">CCTV</a></li>
						<li class="breadcrumb-item active">조회</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</div>

<div>
	<div id="cctv" style="display: flex; justify-content: center">
		<img alt="cctv" src="/resources/images/cctv.gif" width="1500px" height="700px">
	</div>
</div>

 

<script>
var streamVideo
console.log(navigator);

if(!navigator.mediaDevices || !navigator.mediaDevices.getUserMedia ) {
	alert("Media Device not supported")
} else {
	open()
}

function open() {
	navigator.mediaDevices.getUserMedia({video:true}).then(stream => {
		streamVideo = stream
		var cameraView = document.getElementById("cameraview");
		cameraView.srcObject = stream;
		cameraView.play()
	})
}
</script>
