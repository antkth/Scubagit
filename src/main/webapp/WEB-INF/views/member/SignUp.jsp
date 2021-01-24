<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<jsp:include page="../inc/Top.jsp"/>
<script type="text/javascript">
//이메일 인증 
function emailSend() {
	var email = $('#email').val();
	if(email==""){
		window.alert("이메일을 입력해 주세요 .");
		$('#email').focus();
	}else{
		$.ajax({
			url:'${contextPath}/member/emailSend',
			type : 'POST',
			data : {email:email},
			success: function(data) {
				$('#emailcheck_c').val(data);
			},
			error: function(){
				alert("실패");
			}
		});
		window.alert('인증 메일이 발송되었습니다 .');
		$('#emailcheck').css('display','block');
	}
}
//회원가입시 공백 체크
function userjoin() {
	if($('#id').val()==""){
		alert("아이디를 입력해 주세요 .");
		$('#id').focus
		return false;
	}else if($('#pwd').val()==""){
		alert("비밀번호를 입력해 주세요");
		$('#pwd').focus
		return false;
	}else if($('#pwd_c').val()==""){
		alert("비밀번호를 확인해 주세요");
		$('#pwd_c').focus
		return false;
	}else if($('#nickname').val()==""){
		alert("닉네임를 입력해 주세요");
		$('#nickname').focus
		return false;
	}else if($('#email').val()==""){
		alert("이메일을 입력해 주세요");
		$('#email').focus
		return false;
	}else if($('#emailcheck_c').val()==""){
		alert("이메일 인증을 진행해 주세요");
		return false;
	}else if($('#emailcheck').val()==""){
		alert("인증번호를 입력해 주세요");
		$('#emailcheck').focus
		return false;
	}else{
		$('#joinform').submit();
	}
}
</script>
</head>
<body>
<!-- 이메일 인증시 인증 숫자 저장 폼 -->
<input id="emailcheck_c" style="display: none;">
<!-- 회원가입 폼 -->
	<section class="module" >
         <div class="container" align="center">
           <div class="row">
            <div class="col-sm-4 col-sm-offset-4" >
               <h4 class="font-alt">회원 가입</h4>
               <hr class="divider-w mb-10">
               <form class="form" id="joinform" action="${contextPath}/member/userjoin" method="post" style="min-width: 245px;">
				  <div class="form-group">
                    <input class="form-control" id="id" type="text" name="id" placeholder="id"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="pwd" type="password" name="pwd" placeholder="password"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="pwd_c" type="password" name="pwd_c" placeholder="password_c"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="nickname" type="text" name="nickname" placeholder="NickName"/>
                  </div>
                  <div class="form-group">
                    <div class="input-group">
                      <input class="form-control" type="text" id="email" name="email" placeholder="Your Email"/><span class="input-group-btn">
                        <button class="btn btn-g btn-round" id="subscription-form-submit" type="button" onclick="emailSend()">Submit</button></span>
                    </div>    
                  </div> 
                  <div class="form-group">
                    <input class="form-control" id="emailcheck" style="display: none;" type="text" name="emailcheck" placeholder="인증번호" required="required"/>
                  </div>    
                  <div class="form-group" style="float: right;">
                    <button class="btn btn-round btn-b" type="button" onclick="userjoin()">회원 가입</button>
                    <button class="btn btn-round btn-b" type="button" onclick="history.back()">취소</button>
                  </div>
               </form>
             </div>
           </div>
         </div>
       </section>
<!-- 회원가입 폼 -->
<script type="text/javascript">
//아이디 유효성 & 중복 검사
$('#id').on("blur",function(){
	if($('#id').val()!=""){
	var id = $('#id').val();
	var idCheck = /^[a-z]+[a-z0-9]{5,19}$/g;
	if(!idCheck.test(id)){
		alert("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
		$('#id').val("");
		$('#id').focus();
	}else{
		$.ajax({
			url:'${contextPath}/member/idCheck',
			type:'POST',
			data:{id:id},
			success:function(data){
				if(data==1){
					alert("이미 존재하는 아이디 입니다 .");
					$('#id').val("");
					$('#id').focus();
				}
			},
			error:function(){
				window.alert("실패");
			}
		});
	}
	}
	});
//비밀번호 정규식
$('#pwd').on('blur',function(){
	if($('#pwd').val()!=""){
	var pwd = $('#pwd').val();
	var pwdCheck = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
	if(!pwdCheck.test(pwd)){
		alert("비밀번호는 최소 8 자 이며 ,최소 하나의 문자 , 하나의 숫자 및 최소 하나의 특수문자를 포함해야 합니다")
		$('#pwd').val("");
		$('#pwd_c').val("");
		$('#pwd').focus();
	}
	}
});
//비밀번호 확인 비교
$('#pwd_c').on('blur',function(){
	if($('#pwd_c').val()!=""){
	var pwd = $('#pwd').val();
	var pwd_c = $('#pwd_c').val();
	if(pwd!=pwd_c){
		alert("비밀번호가 일치하지 않습니다 .");
		$('#pwd_c').val("");
		$('#pwd_c').focus();
	}
	}
});
//닉네임 정규식
$('#nickname').on('blur',function(){
	if($('#nickname').val()!=""){
	var nickname = $('#nickname').val();
	var nicknameCheck = /^[\w\Wㄱ-ㅎㅏ-ㅣ가-힣]{2,20}$/;
	if(!nicknameCheck.test(nickname)){
		alert("닉네임은 2 ~ 20 글자로 입력해 주세요 .");
		$('#nickname').val("");
		$('#nickname').focus();
	}else{
		$.ajax({
			url:'${contextPath}/member/nicknameCheck',
			type:'POST',
			data:{nickname:nickname},
			success:function(data){
				if(data==1){
					alert("이미 존재하는 닉네임 입니다 .");
					$('#nickname').val("");
					$('#nickname').focus();
				}
			},
			error:function(){
				window.alert("실패");
			}
		});
	}
	}
});
//이메일 정규식
$('#email').on('blur',function(){
	if($('#email').val()!=""){
	var email = $('#email').val();
	var emailCheck = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if(!emailCheck.test(email)){
		alert("이메일 형식이 잘못 되었습니다 .");
		$('#email').val("");
		$('#email').focus();
	}else{
		$.ajax({
			url:'${contextPath}/member/emailCheck',
			type:'POST',
			data:{email:email},
			success:function(data){
				if(data==1){
					alert("이미 존재하는 이메일 입니다 .");
					$('#email').val("");
					$('#email').focus();
				}
			},
			error:function(){
				window.alert("실패");
			}
		});
	}
	}
});
//인증번호 비교 
$('#emailcheck').on('blur',function(){
	if($('#emailcheck').val()!=""){
	var emailcheck = $('#emailcheck').val();
	var emailcheck_c = $('#emailcheck_c').val();
	if(emailcheck != emailcheck_c){
		alert("인증번호를 확인해 주세요 .");
		$('#emailcheck').val("");
		$('#emailcheck').focus();
	}
	}
});
</script>
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>