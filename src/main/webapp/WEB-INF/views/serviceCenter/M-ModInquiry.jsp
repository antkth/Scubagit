<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-8" style="text-align:-webkit-center;">
              <h4 class="font-alt mb-0">1대1 문의 수정</h4>
                <hr class="divider-w mt-10 mb-20">
                <form class="form" role="form" action="${contextPath}/Service/ModInquiry" method="post">
                	<input type="hidden" name="Num" value="${info.num}">
                  <div class="form-group">
                    <input class="form-control input-lg" type="text" value="${info.id}" readonly="readonly"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-sm" type="text" value="${info.writedate}" readonly="readonly"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-sm" type="text" value="${info.title}" readonly="readonly"/>
                  </div>
                  <div class="form-group">
                  	<textarea class="form-control" rows="7" style="resize: none;" readonly="readonly">${info.contents}</textarea>
               	  </div>
               	  <div class="form-group">
                  	<textarea class="form-control" rows="7" style="resize: none;" name="answer" placeholder="답변" required></textarea>
               	  </div>
                  <div class="row" style="text-align: center;">
                  <button class="btn btn-border-d btn-round" >수정하기</button>&nbsp;
                  <button class="btn btn-border-d btn-round" type="button" onclick="location.href='${contextPath}/Service/MoveInquiryList';">리스트가기</button>
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