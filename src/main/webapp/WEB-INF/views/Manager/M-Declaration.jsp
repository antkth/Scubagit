<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 카테고리 선정후 제작 -->
</head>
<body>
<jsp:include page="../inc/Top.jsp"/>
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-8" style="text-align:-webkit-center;">
                <form role="form" style="width: 300px; margin-bottom: 20px;">
                  <div class="search-box">
                    <input class="form-control" type="text" placeholder="Search..."/>
                    <button class="search-btn" type="submit"><i class="fa fa-search"></i></button>
                  </div>
                </form>
            	<div class="row">
              <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr>
                      <th width="10%">신고자</th>
                      <th width="10%">피신고자</th>
                      <th width="15%">게시판이름</th>
                      <th width="10%">글번호</th>
                      <th width="45%">글제목</th>
                      <th width="10%">신고당한 횟수</th>
                    </tr>
                    <tr>
                      <td>
                        <h5 class="product-title font-alt">ID</h5>
                      </td>                      
                      <td>
                        <h5 class="product-title font-alt">제목</h5>
                      </td>
                      <td>
                        <p>내용</p>
                      </td>
                      <td>
                        <h5 class="product-title font-alt"><font color="blue">해결완료</font></h5>
                      </td>
                    </tr>
                    <tr>
                      <td>
                        <h5 class="product-title font-alt">ID</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">제목</h5>
                      </td>
                      <td>
						<p>내용</p>
                      </td>
                      <td>
                        <h5 class="product-title font-alt"><font color="red">해결중</font></h5>
                      </td>
                    </tr>
                  </tbody>
                  </table>
                  </div>
                <div class="pagination font-alt"><a href="#"><i class="fa fa-angle-left"></i></a><a class="active" href="#">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#"><i class="fa fa-angle-right"></i></a></div>
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