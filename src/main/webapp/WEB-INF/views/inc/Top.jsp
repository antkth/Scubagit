<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<!-- CSS or JS -->
    <link rel="apple-touch-icon" sizes="57x57" href="${contextPath}/resources/assets/images/favicons/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="${contextPath}/resources/assets/images/favicons/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="${contextPath}/resources/assets/images/favicons/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="${contextPath}/resources/assets/images/favicons/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="${contextPath}/resources/assets/images/favicons/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="${contextPath}/resources/assets/images/favicons/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="${contextPath}/resources/assets/images/favicons/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="${contextPath}/resources/assets/images/favicons/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="${contextPath}/resources/assets/images/favicons/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192" href="${contextPath}/resources/assets/images/favicons/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="${contextPath}/resources/assets/images/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="${contextPath}/resources/assets/images/favicons/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="${contextPath}/resources/assets/images/favicons/favicon-16x16.png">
    <link rel="manifest" href="${contextPath}/resources/assets/images/favicons/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="${contextPath}/resources/assets/images/favicons/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">
    <link href="${contextPath}/resources/assets/lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Volkhov:400i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
    <link href="${contextPath}/resources/assets/lib/animate.css/animate.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/lib/components-font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/lib/et-line-font/et-line-font.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/lib/flexslider/flexslider.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/lib/owl.carousel/dist/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/lib/owl.carousel/dist/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/lib/magnific-popup/dist/magnific-popup.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/lib/simple-text-rotator/simpletextrotator.css" rel="stylesheet">
    <link href="${contextPath}/resources/assets/css/style.css" rel="stylesheet">
    <link id="color-scheme" href="${contextPath}/resources/assets/css/colors/default.css" rel="stylesheet">
    <script src="${contextPath}/resources/assets/lib/jquery/dist/jquery.js"></script>
    <script src="${contextPath}/resources/assets/lib/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="${contextPath}/resources/assets/lib/wow/dist/wow.js"></script>
    <script src="${contextPath}/resources/assets/lib/jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js"></script>
    <script src="${contextPath}/resources/assets/lib/isotope/dist/isotope.pkgd.js"></script>
    <script src="${contextPath}/resources/assets/lib/imagesloaded/imagesloaded.pkgd.js"></script>
    <script src="${contextPath}/resources/assets/lib/flexslider/jquery.flexslider.js"></script>
    <script src="${contextPath}/resources/assets/lib/owl.carousel/dist/owl.carousel.min.js"></script>
    <script src="${contextPath}/resources/assets/lib/magnific-popup/dist/jquery.magnific-popup.js"></script>
    <script src="${contextPath}/resources/assets/lib/simple-text-rotator/jquery.simple-text-rotator.min.js"></script>
    <script src="${contextPath}/resources/assets/js/plugins.js"></script>
    <script src="${contextPath}/resources/assets/js/main.js"></script>
    <style type="text/css">
    .topMenu{width: 80%; text-align: center;}
    .topMenu>li{width: 20%;}
    .navbar-custom .nav li > a{color: black;}
    </style>
    <!-- CSS or JS -->
  </head>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
      <div class="page-loader">
        <div class="loader">Loading...</div>
      </div>
      <nav class="navbar navbar-custom navbar-fixed-top" role="navigation" style="background-color: #e0efff;">
        <div class="container">
          <div class="navbar-header">
            <button class="navbar-toggle" type="button" data-toggle="collapse" data-target="#custom-collapse"><span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button><a class="navbar-brand" href="${contextPath}/index/main" style="color: black;">Scuba</a>
          </div>
          <div class="collapse navbar-collapse" id="custom-collapse">
            <ul class="nav navbar-nav navbar-right topMenu">
              <li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown">리조트</a>
                <ul class="dropdown-menu" style="background-color: #c4dffb;">
                  <li><a href="${contextPath}/Resort/moveResortList">리조트 리스트</a></li>
                  <c:if test="${user_id != null}">
                    <li><a href="${contextPath}/Resort/moveResortWriter">리조트 등록하기</a></li>
                  </c:if>
                </ul>
              </li>
              <li><a href="${contextPath}/informations/DivingCountry">다이빙지도</a>
              </li>
              <li class="dropdown"><a class="dropdown-toggle" href="#" data-toggle="dropdown">커뮤니티</a>
                <ul class="dropdown-menu" style="background-color: #c4dffb;">
                  <li><a href="${contextPath}/freeBoard/freeBoardList">자유 게시판</a></li>
                  <li><a href="${contextPath}/jobSearchBoard/jobSearchBoardList">구인 구직</a></li>
                  <li><a href="${contextPath}/friendsBoard/friendsBoardList">동료 모집</a></li>
                  <li><a href="${contextPath}/reviewBoard/reviewBoardList">후기 게시판</a></li>
                  <li><a href="${contextPath}/underWaterBoard/underWaterBoardList">수중 사진</a></li>
                  <li><a href="${contextPath}/marketBoard/marketBoardList">중고 장터</a></li>
                </ul>
              </li>
              <li class="dropdown" >
              	<a class="dropdown-toggle" href="#" data-toggle="dropdown">고객센터</a>
                <ul class="dropdown-menu" style="background-color: #c4dffb;">
                  <li><a href="${contextPath}/Notice/moveNoticeList">공지사항</a></li>
                  <li><a href="${contextPath}/Event/moveEventList">이벤트</a></li>
                  <li><a href="${contextPath}/Service/moveServiceCenter">이용안내</a></li>
                </ul>
               </li>
				<c:choose>
					<c:when test="${user_id == null}">
						<li>
					    <a href="${contextPath}/member/login" style="display: inline-block;">로그인</a>
						</li>
					</c:when>
					<c:otherwise>
					<li class="dropdown" >
					    <a class="dropdown-toggle" href="#" data-toggle="dropdown" style="display: inline-block;">마이페이지</a>
							<ul class="dropdown-menu" style="background-color: #c4dffb;">
			                  <li><a href="${contextPath}/member/MoveuserUpdate">회원정보 수정</a></li>
			                  <li><a href="${contextPath}/member/logout">로그아웃</a></li>
			                </ul>
			        </li>
					</c:otherwise>
				</c:choose>
            </ul>
          </div>
        </div>
      </nav>
      	<!-- 	상단 배너 -->
<!--       	배경 이미지 1 ~ 6  -->
<%int random = (int)(Math.random()*10000)%6+1; %>
	<section class="module bg-dark-30 about-page-header" data-background="${contextPath}/resources/assets/images/TopBanner<%=random%>.jpg" style="padding: 200px 0;">
	</section>
	<!-- 	상단 배너 -->
  </body>
</html>