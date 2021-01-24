<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function changeCategory() {
	var Category = $('#CategoryList option:selected').val();
	$('#Category').val(Category);
	document.getElementById('Category').readOnly = true;
	
}
</script>
</head>
<body>
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-8" style="text-align:-webkit-center;">
              <h4 class="font-alt mb-0">서비스센터 질문 등록</h4>
                <hr class="divider-w mt-10 mb-20">
                <form class="form" role="form" action="${contextPath}/Service/EnterService" method="post">
                  <div class="form-group">
                  	<select class="form-control" id="CategoryList" onchange="changeCategory()" style="width: 25%; float: left; margin-bottom: 15px;">
                  	<option selected="selected" disabled="disabled">카테고리</option>
                  	<c:forEach items="${CategoryList}" var="Category">
                  	<option value="${Category}">${Category}</option>
                  	</c:forEach>
                  	</select>
                  	<input class="form-control" id="Category" name="category" type="text" placeholder="카테고리" style="width: 75%; float: left;"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-sm" name="title" type="text" placeholder="제목"/>
                  </div>
                  <div class="form-group">
                  <textarea class="form-control" rows="7" name="contents" placeholder="내용" style="resize: none;"></textarea>
               	  </div>
                  <div class="row" style="text-align: center;">
                  <button class="btn btn-border-d btn-round">등록하기</button>&nbsp;
                  <button class="btn btn-border-d btn-round">취소하기</button>
                  </div>
                </form>
              </div>
              <div class="col-sm-4 col-md-3 col-md-offset-1 sidebar">
                <div class="widget">
                  <h5 class="widget-title font-alt">관리자 페이지</h5>
                  <ul class="icon-list">
                    <li><a href="#">회원정보 확인</a></li>
                    <li><a href="#">1대1문의 내역</a></li>
                    <li><a href="#">신고 리스트</a></li>
                    <li><a href="#">다이빙샵 등록 확인</a></li>
                    <li><a href="#">어류 등록</a></li>
                    <li><a href="#">다이빙 포인트 등록</a></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>