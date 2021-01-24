<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../inc/Top.jsp"/>
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-8" style="text-align:-webkit-center;">
              <h4 class="font-alt mb-0">어류 등록</h4>
                <hr class="divider-w mt-10 mb-20">
                <form class="form" role="form">
                  <div class="form-group">
                    <input class="form-control input-lg" type="text" placeholder="어종 이름"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-sm" type="text" placeholder="출몰지역"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-sm" type="text" placeholder="나무위키 주소"/>
                  </div>
                  <div class="form-group">
                  <textarea class="form-control" rows="7" placeholder="내용" style="resize: none;"></textarea>
               	  </div>
                  <div class="form-group">
                  	<div class="row multi-columns-row" style="margin-bottom: 15px;">
	                  <div class="col-sm-6 col-md-6 col-lg-6">
	                    <div class="alt-features-item">
	                      <h3 class="alt-features-title font-alt">이미지 등록</h3>
	                      <input class="form-control custom-file-input" type="file" placeholder="이미지 업로드"/>
	                    </div>
	                  </div>
                  	  <div class="col-sm-6 col-md-6 col-lg-6">
                        <div class="alt-features-item">
                          <h4 class="alt-features-title font-alt">미리보기</h4>
						  <img src="../assets/images/post-2.jpg" alt="Title 1">	                        
                        </div>
                      </div>
                    </div>
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