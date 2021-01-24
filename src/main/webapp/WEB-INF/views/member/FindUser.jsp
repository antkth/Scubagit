<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<script type="text/javascript">
$(document).ready(function() {
	//비밀번호 찾기 클릭 시
	$(".te").click(function() {
		$(".idf").hide();
		$(".passf").show();
	});
	
	//ID찾기 클릭 시
	$(".te2").click(function() {
		$(".idf").show();
		$(".passf").hide();
	});
});
//아이디 찾기
function findId() {
	var email =$('#email_id').val();
	var emailCheck = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if(email == ""){
		alert('이메일을 입력해 주세요 ');
	}else if(!emailCheck.test(email)){
		alert("이메일 형식이 잘못 되었습니다 .")
	}else{
		$.ajax({
			url:'${contextPath}/member/findId',
			type:'POST',
			data:{email:email},
			success:function(data){
				if(data=="none"){
					alert("이 이메일을 사용하는 회원이 존재하지 않습니다 .");
				}else{
					$('#callid').val(data);
					$('#id').val(data);
					$('#email_pwd').val(email);
					$('#callid').css('display','block');
				}
			}
		});
	}
}
//비밀번호 찾기 인증번호 보내기
function sendEmailPwd() {
	var id = $('#id').val();
	var idCheck = /^[a-z]+[a-z0-9]{5,19}$/g;
	var email = $('#email_pwd').val();
	var emailCheck = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	if(id == ""){
		alert('아이디를 입력해 주세요 .');
	}else if(email == ""){
		alert('이메일을 입력해 주세요 .');
	}else if(!idCheck.test(id)){
		alert('아이디 형식이 잘못되었습니다 .')
	}else if(!emailCheck.test(email)){
		alert('이메일 형식이 잘못되었습니다 .')
	}else{
		$.ajax({
			url:'${contextPath}/member/sendEmailPwd',
			type:'POST',
			data:{id:id,email:email},
			success:function(data){
				if(data=="noneId"){
					alert("해당 회원이 존재하지 않습니다 .");
				}else if(data=="noneEmail"){
					alert("해당 회원의 이메일이 일치하지 않습니다 .");	
				}else{
					alert("인증 메일을 확인해 주세요 .");
					$('#emailCheck').css('display','block');
					$('#sendmail').css('display','none');
					$('#findpwd').css('display','block');
					document.getElementById('id').readOnly = true;
					document.getElementById('email_pwd').readOnly = true;
					$.ajax({
						url:'${contextPath}/member/sendEmailPwd2',
						type:'POST',
						data:{id:id,email:email},
						success:function(data){
							$('#emailnum').val(data);
						}
					});
				}
			}
		});
	}
}
//비밀번호 찾기
function PwdChange() {
	if($('#emailnum').val()==""){
		alert("잠시후 다시 시도해 주세요 .");
		return false;
	}else if($('#emailnum').val()!=$('#emailCheck').val()){
		alert("인증번호를 확인해 주세요 .");
		return false;
	}else{
		$('#PwdChange').submit();
	}
}
</script>
<jsp:include page="../inc/Top.jsp"/>
</head>
<body>
<!-- 인증번호 저장공간 -->
<input id="emailnum" style="display: none;" readonly="readonly">
<!-- 회원 정보 찾기 -->
        <section class="module" style="padding: 110px 0;">
          <div class="container" align="center">
            <div class="row">
              <div class="col-sm-4 col-sm-offset-4 idf" style="min-width: 397px;">
                <h4 class="font-alt">아이디 찾기</h4>
                <hr class="divider-w mb-10">
                <form class="form">
                  <div class="form-group" id="findid">
                    <input class="form-control" id="email_id" type="email" name="email" placeholder="email"/>
                  </div>                  
                  <div class="form-group">
                    <input class="form-control" id="callid" readonly="readonly"  style="display: none;"/>
                  </div>
                  <div class="form-group">
                    <button class="btn btn-block btn-round btn-b" type="button" onclick="findId()">아이디 찾기</button>
                    <a style="float: left;" class="te" href="javascript:;" title="비밀번호 찾기">비밀번호 잃어버리셨나요 ??</a>
                  </div>
                </form>
              </div>
              <div class="col-sm-4 col-sm-offset-4 passf" style="min-width: 397px; display: none;">
                <h4 class="font-alt">비밀번호 찾기</h4>
                <hr class="divider-w mb-10">
                <form class="form" id="PwdChange" method="post" action="${contextPath}/member/PwdChange">
                  <div class="form-group">
                    <input class="form-control" id="id" type="text" name="id" placeholder="id"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="email_pwd" type="email" name="email" placeholder="email"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control" id="emailCheck" placeholder="인증번호" style="display: none;"/>
                  </div>
                  <div class="form-group">
                    <button class="btn btn-block btn-round btn-b" id="sendmail" type="button" onclick="sendEmailPwd()" style="display: block;">인증 번호 보내기</button>
                    <button class="btn btn-block btn-round btn-b" id="findpwd" type="button" onclick="PwdChange()" style="display: none">비밀번호 찾기</button>
                    <a style="float: left;" class="te2" href="javascript:;" title="ID 찾기">아이디를 잃어버리셨나요 ??</a>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </section>
<!-- 회원 정보 찾기 -->
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>