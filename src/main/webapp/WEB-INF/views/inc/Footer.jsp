<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="module-small bg-dark"
		style="padding: 20px 0; background-color: #333;">
		<div class="container">
			<div class="row">
				<div class="col-sm-3">
					<div class="widget">
						<h5 class="widget-title font-alt">회사 정보</h5>
						<p>The languages only differ in their grammar, their
							pronunciation and their most common words.</p>
						<p>Phone: +1 234 567 89 10</p>
						Fax: +1 234 567 89 10
						<p>
							Email:<a href="#">somecompany@example.com</a>
						</p>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="widget">
						<h5 class="widget-title font-alt">정보 소개</h5>
						<ul class="icon-list">
							<li><a href="#">지도 사진</a></li>
							<li><a href="#">어류 리스트</a></li>
							<li><a href="#">다이빙 포인트 리스트</a></li>
						</ul>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="widget">
						<h5 class="widget-title font-alt">커뮤니티</h5>
						<ul class="icon-list">
							<li><a href="#">자유게시판</a></li>
							<li><a href="#">구인 구직</a></li>
							<li><a href="#">동료 모집</a></li>
							<li><a href="#">후기 게시판</a></li>
							<li><a href="#">중고장터</a></li>
						</ul>
					</div>
				</div>
				<div class="col-sm-3">
					<div class="widget">
						<h5 class="widget-title font-alt">샾 소개</h5>
						<ul class="widget-posts">
							<li class="clearfix">
								<div class="widget-posts-image">
									<a href="#"><img
										src="${contextPath}/resources/assets/images/rp-1.jpg"
										alt="Post Thumbnail" /></a>
								</div>
								<div class="widget-posts-body">
									<div class="widget-posts-title">
										<a href="#">샾 이름</a>
									</div>
								</div>
							</li>
							<li class="clearfix">
								<div class="widget-posts-image">
									<a href="#"><img
										src="${contextPath}/resources/assets/images/rp-2.jpg"
										alt="Post Thumbnail" /></a>
								</div>
								<div class="widget-posts-body">
									<div class="widget-posts-title">
										<a href="#">샾 이름</a>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<hr class="divider-d">
	<footer class="footer bg-dark" style="background-color: #252525;">
		<div class="container">
			<div class="row">
				<div class="col-sm-6">
					<p class="copyright font-alt">
						&copy; 2020&nbsp;<a href="index.html">Time To will Be Star</a>,
						MoonyHoony
					</p>
				</div>
				<div class="col-sm-6">
					<div class="footer-social-links">
						<a href="#"><i class="fa fa-facebook"></i></a><a href="#"><i
							class="fa fa-twitter"></i></a><a href="#"><i
							class="fa fa-dribbble"></i></a><a href="#"><i class="fa fa-skype"></i></a>
					</div>
				</div>
			</div>
		</div>
	</footer>
	<div class="scroll-up">
		<a href="#totop"><i class="fa fa-angle-double-up"></i></a>
	</div>
</body>
</html>