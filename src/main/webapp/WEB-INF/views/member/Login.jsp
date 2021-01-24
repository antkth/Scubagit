<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script type="text/javascript">
if('${msg}'!=""){
	window.alert('${msg}');
}
</script>
</head>
<body>
<!-- 로그인 -->
	<section class="module" style="padding: 110px 0;">
         <div class="container">
           <div class="row">
             <div class="col-sm-4 col-sm-offset-4" style="min-width: 399px;">
               <h4 class="font-alt">Login</h4>
               <hr class="divider-w mb-10">
               <form class="form" action="${contextPath}/member/userLogin" method="post">
                 <div class="form-group">
                   <input class="form-control" id="username" type="text" name="id" placeholder="ID"/>
                 </div>
                 <div class="form-group">
                   <input class="form-control" id="password" type="password" name="pwd" placeholder="Password"/>
                 </div>
                 <div class="form-group" style="float: right;">
                   <button class="btn btn-round btn-b" type="submit">Login</button>
                   <button type="button" class="btn btn-round btn-b" onclick="location.href='${contextPath}/member/signUp'">회원가입</button>
                 </div>
                 <div class="form-group" style="float: left;">
                 <a href="${contextPath}/member/findUser">아이디 비밀번호 찾기</a>&nbsp;&nbsp;&nbsp;
                 </div>
               </form>
             </div>
           </div>
         </div>
       </section>
<!-- 로그인 -->
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>