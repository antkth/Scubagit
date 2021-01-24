<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 게시판 이미지 글 출력 -->
	<section class="module">
		<div class="container">
		<!-- 리스트 -->
			<div class="row multi-columns-row post-columns">
				<div class="col-sm-10 col-sm-offset-1">
				<h1 class="module-title font-alt" style="margin-bottom: 30px;">이벤트 게시판</h1>
                <div class="row" style="margin: 15px;">
              <button class="btn btn-border-d btn-round" type="button" onclick="location.href='${contextPath}/Event/moveWrite'" style="float: right;">글쓰기</button>
                </div>
                <c:forEach items="${map.eventList}" var="list">
                	<div class="col-sm-6 col-md-4 col-lg-4">
						<div class="post">
							<div class="post-thumbnail">
								<a href="${contextPath}/Event/eventView?num=${list.num}&nowpage=${map.nowpage}"><img src="${contextPath}/resources/images/${list.communityname}/Thumbnail/${list.num}/${list.thumbnail}"
									alt="Blog-post Thumbnail" /></a>
							</div>
							<div class="post-header font-alt">
								<h2 class="post-title">
									<a href="${contextPath}/Event/eventView?num=${list.num}&nowpage=${map.nowpage}">${list.title}</a>
								</h2>
								<div class="post-meta">
									${list.startdate} ~ ${list.enddate} | ${list.writeDate}
								</div>
							</div>
							<div class="post-entry">
								<p>${list.introduction}</p>
							</div>
						</div>
					</div>
                </c:forEach>
				</div>
				<!-- 리스트 -->
			<!-- 페이징 -->
			</div>
              <div class="col-sm-12" style="text-align: center;">
                <div class="pagination font-alt" id="pagelist">
                <c:if test="${map.blockfirst!=1}">
                <a href="${contextPath}/Event/moveEventList?nowpage=${map.blockfirst-1}"><i class="fa fa-angle-left page" data-num="${map.blockfirst-1}"></i></a>
                </c:if>
                <c:forEach begin="${map.blockfirst}" end="${map.blocklast}" var="i">
                <c:if test="${map.nowpage == i }">
                <a class="active page pagenum" style="background: #cdebfa;" href="${contextPath}/Event/moveEventList?nowpage=${i}" data-now="${map.nowpage}" data-num="${i}">${i}</a>
                </c:if>
                <c:if test="${map.nowpage != i }">
                <a class="active page pagenum" href="${contextPath}/Event/moveEventList?nowpage=${i}" data-now="${map.nowpage}" data-num="${i}">${i}</a>
                </c:if>
                </c:forEach>
                <c:if test="${map.blocklast != map.totalpage}">
                <a href="${contextPath}/Event/moveEventList?nowpage=${map.blocklast+1}"><i class="fa fa-angle-right page" data-num="${map.blocklast+1}"></i></a>
                </c:if>
                </div>
              </div>
			<!-- 페이징 -->
		</div>
	</section>
	<!-- 푸터 -->
	<jsp:include page="../inc/Footer.jsp" />
	<!-- 푸터 -->
</body>
</html>