<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<script type="text/javascript">
//미리보기
function preView(event) {
	var pathpoint = $('#image').val().lastIndexOf('.');
	var filepoint = $('#image').val().substring(pathpoint+1 , $('#image').val().length);
	var filetype = filepoint.toLowerCase();

	if(filetype=='jpg'||filetype=='png'||filetype=='jpeg'){
		var reader = new FileReader();
		reader.onload = function(event) {
			var img = document.createElement("img");
			img.setAttribute("src",event.target.result);
			img.setAttribute("onclick","getLocation()");
			img.setAttribute("style","cursor: pointer; width: 200px; border-radius: 100%;");
			img.setAttribute("onclick","$('#image').click()");
			document.querySelector("div#preView").appendChild(img);
		}
		$('#preView').empty();
		reader.readAsDataURL(event.target.files[0]);
	}else{
		alert('확장자 명이 jpg , png , jpeg 인 파일을 올려주세요');
		$('#image').val("");
	}
	
}
function check() {
	var id = $('#id').val();
	var pwd = $('#pwd').val();
	var nickname = $('#nickname').val();
	var nicknameCheck = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/;
	if(!nicknameCheck.test(nickname)){
		alert("닉네임은 2 ~ 20 글자로 입력해 주세요 .");
		$('#nickname').val("");
		$('#nickname').focus();
		return false;
	}else{
		$.ajax({
			url:'${contextPath}/member/userUpdatenicknameCheck',
			type:'POST',
			data:{nickname:nickname,id:id},
			success:function(data){
				if(data==1){
					alert("이미 존재하는 닉네임 입니다 .");
					$('#nickname').val("");
					$('#nickname').focus();
					return false;
				}
			}
		});
	}
	$.ajax({
		url : '${contextPath}/member/pwdcheck',
		type : 'POST',
		data : {id:id,pwd:pwd},
		success : function(data) {
			if(data == 1 ){
				alert("비밀번호가 틀렸습니다 .");
				return false;
			}
		}
	
	});
	$('#form').submit();
}
</script>
</head>
<body>
<!-- 회원정보 수정 폼 -->
	<section class="module">
         <div class="container" align="center">
           <div class="row">
             <div class="col-sm-6 col-sm-offset-3">
               <h4 class="font-alt">회원 정보 수정</h4>
               <hr class="divider-w mb-10">
               <form class="form" id="form" method="post" action="${contextPath}/member/memberChange" enctype="multipart/form-data">
               	  <div class="form-group" id="preView" style="margin: 25px 0 ;">
               		<img src="${contextPath}/resources/upload/member/${userinfo.image}" id="memberimage" alt="Post Thumbnail" onclick="$('#image').click()" style="cursor: pointer; width: 200px; border-radius: 100%;"/>
                  </div>
				  <div class="form-group">
                    <input class="form-control" id="id" type="text" name="id" value="${userinfo.id}" readonly="readonly"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="pwd" type="password" name="pwd" placeholder="Password"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="nickname" type="text" name="nickname" value="${userinfo.nickname}" placeholder="NickName"/>
                  </div>
                  <div class="form-group">
                    <div class="form-group">
                      <input class="form-control" readonly="readonly" type="email" id="email" name="email" value="${userinfo.email}" data-validation-required-message="Please enter your email address." required="required"/>
                    </div>    
                  </div> 
                   <input type="file" id="image" name="image" onchange="preView(event)" style="display: none;"  accept="image/*" onchange="preView(event)">
                   <input type="text" name="beforimage" value="${userinfo.image}" style="display: none">
                  <div class="form-group" style="float: right;">
                    <button class="btn btn-round btn-b" type="button" onclick="check()">정보 수정</button>
                    <button class="btn btn-round btn-b" type="button" onclick="location.href='history.back()'">취소</button>
                  </div>
               </form>
             </div>
           </div>
         </div>
       </section>
<!-- 회원정보 수정 폼 -->
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>