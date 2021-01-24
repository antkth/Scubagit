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
                <form role="form" style="width: 300px; margin-bottom: 20px;">
                  <div class="search-box">
                    <input class="form-control" type="text" placeholder="Search..."/>
                    <button class="search-btn" type="submit"><i class="fa fa-search"></i></button>
                  </div>
                </form>
                <div class="row">
                <select class="form-control" style="float: right; width: 13%; min-width: 102px;">
                  <option selected="selected">활성화</option>
                  <option>비 활성화</option>
                </select>
              </div>
            	<div class="row">
              <table class="table table-striped table-border checkout-table" style="text-align-last: center; vertical-align: bottom; margin-top: 1%;">
                  <tbody>
                    <tr style="text-align: center;">
                      <th class="hidden-xs" width="10%" height="" >번호</th>
                      <th class="hidden-xs" width="10%">아이디</th>
                      <th width="40%">리조트 이름</th>
                      <th width="10%">연락처</th>
                      <th width="15%">카카오</th>
                      <th width="15%">상태</th>
                    </tr>
                    <tr style="text-align: center;">
                      <td class="hidden-xs"><h6 class="product-title font-alt">1</h6></td>
                      <td class="hidden-xs">
                        <h6 class="product-title font-alt">ID</h6>
                      </td>
                      <td>
                        <h6 class="product-title font-alt">리조트 이름</h6>
                      </td>
                      <td>
                        <h6 class="product-title font-alt">01012341234</h6>
                      </td>
                      <td>
                        <p><img src="../assets/images/kakaoIcon.png" alt="kakaologo" width="13px">&nbsp;abc123z</p>
                      </td>
                      <td>
                        <h6 class="product-title font-alt"><font color="blue">활성</font></h6>
                      </td>
                    </tr>
                    <tr>
                      <td class="hidden-xs"><h6 class="product-title font-alt">1</h6></td>
                      <td class="hidden-xs">
                        <h6 class="product-title font-alt">ID</h6>
                      </td>
                      <td>
                        <h6 class="product-title font-alt">리조트 이름</h6>
                      </td>
                      <td>
                        <h6 class="product-title font-alt">01012341234</h6>
                      </td>
                      <td>
                        <p><img src="../assets/images/kakaoIcon.png" alt="kakaologo" width="13px">&nbsp;abc123z</p>
                      </td>
                      <td>
                        <h6 class="product-title font-alt"><font color="red">비활성</font></h6>
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