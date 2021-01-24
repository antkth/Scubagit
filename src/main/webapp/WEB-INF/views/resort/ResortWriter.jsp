<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리조트 등록</title>
<script src="${contextPath}/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<script type="text/javascript">
//에디터 관련
$(document).ready(function(){
CKEDITOR.on('dialogDefinition', function (ev) {
    var dialogName = ev.data.name;
    var dialog = ev.data.definition.dialog;
    var dialogDefinition = ev.data.definition;
    if (dialogName == 'image') {
        dialog.on('show', function (obj) {
            this.selectPage('Upload'); //업로드텝으로 시작
        });
        dialogDefinition.removeContents('advanced'); // 자세히탭 제거
        dialogDefinition.removeContents('Link'); // 링크탭 제거
    }
});
	CKEDITOR.replace('contents', {
		height : 500,
		width : 750,
		filebrowserUploadUrl: "${contextPath}/Common/imgupload",
		enterMode:'2'
	});
//에디터 관련

//지역 가져오기
$.ajax({
	url:'${contextPath}/informations/getCountryNameList',
	type:'POST',
	success : function(data) {
		for (var i = 0; i < data.length; i++) {
			var tag = '<option value="'+data[i]+'">'+data[i]+'</option>';
			$('#Country').append(tag);
		}
		//처음 지역 설정
		var CountryName = data[0];
		$.ajax({
			url:'${contextPath}/informations/getCityList',
			type:'POST',
			data : {CountryName : CountryName},
			success : function (data) {
				$('#City').empty();
				for(var i = 0 ; i < data.length ; i ++){
					var tag = '<option value="'+data[i]+'">'+data[i]+'</option>';
					$('#City').append(tag);
				}
				$('<option selected="selected" disabled="disabled">지역선택</option>').prependTo('#City');
			}
		});
	}
});
});
//국가 카테고리 변경
function CountryChange() {
	var CountryName = $("#Country option:selected").val();
	//City카테고리 변경
	$.ajax({
		url:'${contextPath}/informations/getCityList',
		type:'POST',
		data : {CountryName : CountryName},
		success : function (data) {
			$('#City').empty();
			for(var i = 0 ; i < data.length ; i ++){
				var tag = '<option value="'+data[i]+'">'+data[i]+'</option>';
				$('#City').append(tag);
			}
			$('<option selected="selected" disabled="disabled" value="지역선택">지역선택</option>').prependTo('#City');
		}
	});
}
//썸네일 이미지 유효성 체크
$(document).ready(function() {
$("#image1").on("change", function(event) {
	var formData = new FormData();
	var inputFile = this.files;
	console.log(1);
	for(var i=0; i<inputFile.length; i++) {
		formData.append("imgfile", inputFile[i]);
	}
	//썸네일 이미지 유효성 체크
	$.ajax({
		contentType : false,
		processData : false,
		url : "${contextPath}/Common/imgCheck",
		data : formData,
		type : "post",
		success : function (data) {
			var check = data;
			if(check == 1 ) {
				alert("파일 형식을 확인해주세요");
				$("#image1").val("");
				$("#preView").empty();
			} else if(check == 2) {
				alert("파일 크기를 확인해주세요");
				$("#image1").val("");
				$("#preView").empty();
			} else if(check == 3) {
				
			}
		},
		error : function(data) {
			alert("통신 실패");
		}
	});
	readURL(this);
});
$("#image2").on("change", function(event) {
	var formData = new FormData();
	var inputFile = this.files;
	console.log(1);
	for(var i=0; i<inputFile.length; i++) {
		formData.append("imgfile", inputFile[i]);
	}
	//썸네일 이미지 유효성 체크
	$.ajax({
		contentType : false,
		processData : false,
		url : "${contextPath}/Common/imgCheck",
		data : formData,
		type : "post",
		success : function (data) {
			var check = data;
			if(check == 1 ) {
				alert("파일 형식을 확인해주세요");
				$("#image2").val("");
				$("#preView").empty();
			} else if(check == 2) {
				alert("파일 크기를 확인해주세요");
				$("#image2").val("");
				$("#preView").empty();
			} else if(check == 3) {
				
			}
		},
		error : function(data) {
			alert("통신 실패");
		}
	});
	readURL(this);
});
$("#image3").on("change", function(event) {
	var formData = new FormData();
	var inputFile = this.files;
	console.log(1);
	for(var i=0; i<inputFile.length; i++) {
		formData.append("imgfile", inputFile[i]);
	}
	//썸네일 이미지 유효성 체크
	$.ajax({
		contentType : false,
		processData : false,
		url : "${contextPath}/Common/imgCheck",
		data : formData,
		type : "post",
		success : function (data) {
			var check = data;
			if(check == 1 ) {
				alert("파일 형식을 확인해주세요");
				$("#image3").val("");
				$("#preView").empty();
			} else if(check == 2) {
				alert("파일 크기를 확인해주세요");
				$("#image3").val("");
				$("#preView").empty();
			} else if(check == 3) {
				
			}
		},
		error : function(data) {
			alert("통신 실패");
		}
	});
	readURL(this);
});
});
//미리보기
function preView(event) {
	var reader = new FileReader();
	reader.onload = function(event) {
		var img = document.createElement("img");
		img.setAttribute("src",event.target.result);
		img.setAttribute("onclick","getLocation()");
		document.querySelector("div#preView").appendChild(img);
	}
	$('#preView').empty();
	reader.readAsDataURL(event.target.files[0]);
}
//유효성 검사
	function contentsCheck() {
	var resortName = $('#resortName').val();
	var phoneNumber = $('#phoneNumber').val();
	var cacaoId = $('#cacaoId').val();
	var City = $("#City option:selected").val();
	var address = $('#address').val();
	var simpleIntroduce = $('#simpleIntroduce').val();
	var contents = CKEDITOR.instances.contents.getData();
	var tag = $('#tag').val();
	var image1 = $('#image1').val();
	var image2 = $('#image2').val();
	var image3 = $('#image3').val();
	if(resortName==""){
		alert("리조트 이름을 입력해 주세요. ");
		$('#resortName').focus();
	}else if(phoneNumber == "" && cacaoId == ""){
			alert("연락처중 하나는 필수로 입력해야 합니다 . ");
			$('#phoneNumber').focus();
			return false;
	}else if(City=="지역선택"){
		alert("지역을 선택해 주세요 .");
		return false;
	}else if(address==""){
		alert("리조트의 주소를 입력해 주세요");
		$('#address').focus();
		return false;
	}else if(simpleIntroduce==""){
		alert("간단한 리조트 소개를 입력해 주세요 ");
		$('#simpleIntroduce').focus();
		return false;
	}else if(contents==""){
		alert("내용을 입력해 주세요");
		$('#contents').focus();
		return false;
	}else if (tag == ""){
		alert("하나 이상의 태그를 입력해 주세요");
		$('#tag').focus();
		return false;
	}else if(image1==""&&image2==""&&image3==""){
		alert("하나 이상의 이미지를 등록해 주세요.");
		$('#image1').focus();
		return false;
	}else{
		$('#form').submit();
	}
	}
</script>
<!-- 주소 위치 추가할것 -->
</head>
<body>

        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <h4 class="font-alt mb-0">리조트 등록</h4>
                <hr class="divider-w mt-10 mb-20">
                <form class="form" role="form" id="form" action="${contextPath}/Resort/EnterResort" method="post" enctype="multipart/form-data">
                  <div class="form-group">
                  	<h5><b>리조트 이름</b></h5>
                    <input class="form-control input-lg" id="resortName" name="resortName" type="text" placeholder="리조트 이름" required/>
                  </div>
                  <div class="form-group">
                  	<h5><b>연락처 등록</b></h5>
                    <input class="form-control" type="text" id="phoneNumber" name="phoneNumber" placeholder="연락처" style="float: left; width: 49%; margin-right: 1%;"/>
                    <input class="form-control" type="text" id="cacaoId" name="cacaoId" placeholder="카카오톡아이디" style="width: 50%;"/>
                  </div>
                  <div class="form-group">
                  	<h5><b>지역 선택</b></h5>
                    <select id="Country" name="country" onchange="CountryChange()" style="float: left; width: 29%; margin-right: 1%; height: 30px;">
                    </select>
                    <select id="City" name="city" style="width: 30%; height: 30px;">
                    </select>
                  </div>
                  <div class="form-group">
                  	<h5><b>홈페이지 주소</b></h5>
                    <input class="form-control input-sm" id="homepageAddress" name="homepageAddress" type="text" placeholder="홈페이지 주소"/>
                  </div>
                  <div class="form-group">
                  	<h5><b>주소</b></h5>
                    <input class="form-control input-sm" id="address" name="address" type="text" placeholder="주소" required/>
                  </div>
                  <div class="form-group">
                  <h5><b>한줄소개</b></h5>
                  <textarea class="form-control" rows="3" id="simpleIntroduce" name="simpleIntroduce" placeholder="한줄소개" style="resize: none;" required></textarea>
                  </div>
                  <div class="form-group">
                  <h5><b>내용</b></h5>
                  <textarea class="form-control" rows="10" name="contents" id="contents"></textarea>
               	  </div>
               	  <div class="form-group">
               	  <h5><b>태그</b></h5>
                  <textarea class="form-control" rows="2" id="tag" name="tag" placeholder="태그" style="resize: none;"></textarea>
                  </div>
                  <div class="form-group">
                  	<div class="row multi-columns-row" style="margin-bottom: 15px;">
	                  <div class="col-sm-6 col-md-6 col-lg-6">
	                    <div class="form-group">
	                      <h3 class="alt-features-title font-alt">이미지 등록</h3>
	                      <input class="form-control custom-file-input file" id="image1" name="image1" type="file" accept="image/*" onchange="preView(event)"/>
	                      <input class="form-control custom-file-input file" id="image2" name="image2" type="file" accept="image/*" onchange="preView(event)"/>
	                      <input class="form-control custom-file-input file" id="image3" name="image3" type="file" accept="image/*" onchange="preView(event)"/>
	                    </div>
	                  </div>
                  	  <div class="col-sm-6 col-md-6 col-lg-6">
                        <div class="form-group">
                          <h4 class="alt-features-title font-alt">미리보기</h4>
                          <div id="preView"></div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="row" style="text-align: center;">
                  <button class="btn btn-border-d btn-round" type="button" onclick="contentsCheck()">등록하기</button>&nbsp;
                  <button class="btn btn-border-d btn-round" type="button" onclick="history.back()">취소하기</button>&nbsp;
                  <button class="btn btn-border-d btn-round">목록으로</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </section>
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>