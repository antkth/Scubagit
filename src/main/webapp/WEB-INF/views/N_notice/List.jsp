<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <title>Titan | Multipurpose HTML5 Template</title>
  </head>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
      <div class="main">
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <h1 class="module-title font-alt" style="margin-bottom: 5%">공지사항</h1>
                <form role="form" action="${contextPath}/Notice/moveNoticeList" style="text-align:-webkit-center;">
                  <div class="search-box" style="width: 60%;">
                    <input class="form-control" type="text" value="${map.search}" placeholder="Search..."/>
                    <button class="search-btn" type="submit"><i class="fa fa-search"></i></button>
                  </div>
                </form>
              </div>
            </div>
            <div class="row" style="margin: 10px 0;">
              <button class="btn btn-border-d btn-round" onclick="location.href='${contextPath}/Notice/moveWrite'" style="float: right;">글쓰기</button>
            </div>
            <hr class="divider-w pt-20">
            <div class="row">
              <div class="col-sm-12">
                <table class="table table-striped table-border checkout-table">
                  <thead>
                    <tr>
                      <th class="hidden-xs" width="15%">글번호</th>
                      <th width="45%">제목</th>
                      <th width="25%">작성일</th>
                      <th class="hidden-xs" width="15%">조회</th>
                    </tr>
                  </thead>
                  <tbody>
                  <c:forEach items="${map.noticeList}" var="noticeVO">
                    <tr>
                      <td class="hidden-xs">${noticeVO.num}</td>
                      <td>
                        <h5 class="product-title font-alt"><a href="${contextPath}/Notice/moveNoticeView?num=${noticeVO.num}">${noticeVO.title}</a></h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${noticeVO.writedate}</h5>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt">${noticeVO.viewcount}</h5>
                      </td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
            </div>
              <div class="col-sm-12" style="text-align: center;">
                <div class="pagination font-alt">
			        <c:if test="${map.blockfirst!=1}">
			        	<a href="${contextPath}/Notice/moveNoticeList?nowpage=${map.blockfirst-1}&search=${map.search}"><i class="fa fa-angle-left"></i></a>
			        </c:if>
			        <c:forEach begin="${map.blockfirst}" end="${map.blocklast}" var="i">
			        	<c:choose>
			        		<c:when test="${map.nowpage == i}">
			        			<a href="${contextPath}/Notice/moveNoticeList?nowpage=${i}&city=${map.city}&search=${map.search}" style="background-color: #cdebfa;">${i}</a>
			        		</c:when>
			        		<c:otherwise>
			        			<a href="${contextPath}/Notice/moveNoticeList?nowpage=${i}&city=${map.city}&search=${map.search}">${i}</a>
			        		</c:otherwise>
			        	</c:choose>
			        </c:forEach>
			        <c:if test="${map.totalpage != map.blocklast }">
			        	<a href="${contextPath}/Notice/moveNoticeList?nowpage=${map.blocklast+1}&search=${map.search}"><i class="fa fa-angle-right"></i></a>
			        </c:if>
                </div>
              </div>
          </div>
        </section>
      </div>
   <jsp:include page="../inc/Footer.jsp"/>
  </body>
</html>