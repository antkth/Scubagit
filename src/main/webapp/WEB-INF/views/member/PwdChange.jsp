<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
    
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<jsp:include page="../inc/Top.jsp"/>
<script type="text/javascript">
function pwdCheck() {
	var pwd = $('pwd').val();
	var pwd_c = $('pwd_c').val();
	var pwdCheck = /^[A-Za-z0-9]{8,20}$/;
	if(pwd == ""){
		alert("비밀번호를 입력해 주세요 . ");
		$('#pwd').focus();
	}else if(!pwdCheck.test(pwd)){
		alert("비밀번호는 최소 8 자 최대 20 자 이며 ,최소 하나의 문자 및 하나의 숫자 를 포함해야 합니다");
		$('#pwd').val("");
		$('#pwd').focus();
	}else if(pwd!=pwd_c){
		alert("비밀번호가 일치하지 않습니다 . ");
		$('#pwd_c').val("");
		$('#pwd_c').focus();
	}else{
		$('#findPwdChage').submit();
	}
}
</script>
</head>
<body>
<!-- 회원 정보 찾기 -->
        <section class="module" style="padding: 110px 0;">
          <div class="container" align="center">
            <div class="row">
              <div class="col-sm-4 col-sm-offset-4 idf" style="min-width: 397px;">
                <h4 class="font-alt">비밀번호 변경</h4>
                <hr class="divider-w mb-10">
                <form class="form" method="post" id="findPwdChage" action="${contextPath}/member/findPwdChage">
                  <div class="form-group">
                    <input class="form-control" id="id" type="text" name="id" value="${id}" readonly="readonly"/>
                  </div> 
                  <div class="form-group">
                    <input class="form-control" id="pwd" type="password" name="pwd" placeholder="password"/>
                  </div> 
                   <div class="form-group">
                    <input class="form-control" id="pwd_c" type="password" name="pwd_c" placeholder="password_c"/>
                  </div>                  
                  <div class="form-group">
                    <button class="btn btn-block btn-round btn-b" type="button" onclick="pwdCheck()">비밀번호 변경</button>
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