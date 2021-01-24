<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리조트 리스트</title>
<style type="text/css">
	.list{margin-bottom: 15px;}
</style>
<script type="text/javascript">
window.onload=function(){
	$.ajax({
		url:'${contextPath}/informations/getAllCityList',
		type:'POST',
		success : function (data) {
			$('#CityNameCategory').empty();
			var tag = "";
			if("${map.city}"==""){
				tag += '<option selected="selected" disabled="disabled">지역 선택</option>';
			}else{
				tag += '<option disabled="disabled">지역 선택</option>'
			}
			for(var i = 0 ; i < data.length ; i ++){
				if("${map.city}"==data[i]){
					tag += '<option selected="selected" value="'+data[i]+'">'+data[i]+'</option>';
				}else{
					tag += '<option value="'+data[i]+'">'+data[i]+'</option>';
				}
			}
			$('#CityNameCategory').append(tag);
		}
	});
}
function orderChange() {
	var order = $('#order option:selected').val();
	location.href="${contextPath}/Resort/moveResortList?search=${map.search}&city=${map.city}&order="+order	;
}
function cityChange() {
	var city = $('#CityNameCategory option:selected').val();
	location.href="${contextPath}/Resort/moveResortList?search=${map.search}&order=${map.order}&city="+city;
}
</script>
</head>
<body>
	
<!-- 	검색 정렬순서 -->
        <section class="module-small" style="padding-top: 50px; padding-bottom: 30px;">
          <div class="container">
          <h4 class="font-alt" align="center">리조트 게시판</h4>
            <form role="form" action="${contextPath}/Resort/moveResortList" style="text-align:-webkit-center;">
                  <div class="search-box" style="width: 40%; margin-bottom: 10px;">
                    <input class="form-control" name="search" value="${map.search}" type="text" placeholder="Search..."/>
                    <button class="search-btn" type="submit"><i class="fa fa-search"></i></button>
                  </div>
            </form>
            <div class="row" style="margin: 0;">
            <select class="form-control" id="CityNameCategory" onchange="cityChange()" style="width: 120px; float: left;">
            </select>
            <select class="form-control" id="order" onchange="orderChange()" style="width: 120px; float: left; margin-left: 1%">
              <c:choose>
              	<c:when test="${map.order == 'enterDate'}">
              	    <option selected="selected" value="enterDate">최신순</option>
              		<option value="viewCount">조회순</option>
              	</c:when>
              	<c:when test="${map.order == 'viewCount'}">
              	    <option value="enterDate">최신순</option>
              		<option selected="selected" value="viewCount">조회순</option>
              	</c:when>
              </c:choose>
            </select>
            <a href='${contextPath}/Resort/moveResortAdmin'>리조트 관리 페이지</a>
            </div>
<!-- 	검색 정렬순서 -->
<!-- 	리스트 -->
          	<div class="col-sm-10" style="margin-top: 2%;">
            <c:forEach items="${map.resortList}" var="resortVO">
	            <div class="row list">
	              <div class="col-sm-6 col-md-8 col-lg-8" style="padding-left: 0%;"><img src="${contextPath}/resources/images/Resort/thumbnail/${resortVO.num}/${resortVO.image1}"/></div>
	              <div class="col-sm-6 col-md-4 col-lg-4">
	                <div class="work-details">
	                  <h4 class="work-details-title font-alt"><a href="${contextPath}/Resort/moveViewResort?num=${resortVO.num}">${resortVO.resortName}</a></h4>
	                  <p>${resortVO.simpleIntroduce}</p>
	                  <ul>
	                    <li><strong>조회수 :</strong><span class="font-serif"><a href="#" target="_blank">${resortVO.viewCount}</a></span>
	                    </li>
	                    <li><strong>홈페이지 주소 : </strong><span class="font-serif"><a href="#" target="_blank">${resortVO.homepageAddress}</a></span>
	                    </li>
	                  </ul>
	                </div>
	              </div>
	            </div>
            </c:forEach>
           </div>
            <!-- 우측 네비바 -->
			<div class="col-sm-2 col-md-2 sidebar" style="margin-top:2%;">
					<div class="widget">
						<h5 class="widget-title font-alt" style="font-size: 12px"><mark>인기 리조트</mark></h5>
						<ul class="icon-list">
							<li><a href="#">Photography - 7</a></li>
							<li><a href="#">Web Design - 3</a></li>
							<li><a href="#">Illustration - 12</a></li>
							<li><a href="#">Marketing - 1</a></li>
							<li><a href="#">Wordpress - 16</a></li>
						</ul>
					</div>
					<div class="widget">
						<h5 class="widget-title font-alt" style="font-size: 12px"><mark>최근 본 리조트</mark></h5>
						<ul class="widget-posts">
							<li class="clearfix">
								<div class="widget-posts-image">
									<a href="#"><img src="${contextPath}/resources/assets/images/rp-3.jpg"
										alt="Post Thumbnail" /></a>
								</div>
								<div class="widget-posts-body">
									<div class="widget-posts-title">
										<a href="#">Designer Desk Essentials</a>
									</div>
									<div class="widget-posts-meta">23 january</div>
								</div>
							</li>
							<li class="clearfix">
								<div class="widget-posts-image">
									<a href="#"><img src="${contextPath}/resources/assets/images/rp-4.jpg"
										alt="Post Thumbnail" /></a>
								</div>
								<div class="widget-posts-body">
									<div class="widget-posts-title">
										<a href="#">Realistic Business Card Mockup</a>
									</div>
									<div class="widget-posts-meta">15 February</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<!-- 우측 네비바 -->
			  <div class="col-sm-12" style="text-align: center;">
                <div class="pagination font-alt">
			        <c:if test="${map.blockfirst!=1}">
			        	<a href="${contextPath}/Resort/moveResortList?nowpage=${map.blockfirst-1}&city=${map.city}&search=${map.search}&order=${map.order}"><i class="fa fa-angle-left"></i></a>
			        </c:if>
			        <c:forEach begin="${map.blockfirst}" end="${map.blocklast}" var="i">
			        	<c:choose>
			        		<c:when test="${map.nowpage == i}">
			        			<a href="${contextPath}/Resort/moveResortList?nowpage=${i}&city=${map.city}&search=${map.search}&order=${map.order}" style="background-color: #cdebfa;">${i}</a>
			        		</c:when>
			        		<c:otherwise>
			        			<a href="${contextPath}/Resort/moveResortList?nowpage=${i}&city=${map.city}&search=${map.search}&order=${map.order}">${i}</a>
			        		</c:otherwise>
			        	</c:choose>
			        </c:forEach>
			        <c:if test="${map.totalpage != map.blocklast }">
			        	<a href="${contextPath}/Resort/moveResortList?nowpage=${map.blocklast+1}&city=${map.city}&search=${map.search}&order=${map.order}"><i class="fa fa-angle-right"></i></a>
			        </c:if>
                </div>
              </div>
 			</div>
                 </section>
<!-- 	리스트 -->
	<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>