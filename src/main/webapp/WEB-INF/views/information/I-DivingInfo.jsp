<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
window.onload=function(){
	var CityName = '${nowCityName}';
	$.ajax({
		url : '${contextPath}/informations/getDivingList',
		type : 'POST',
		data : {CityName:CityName},
		success:function(data){
		 	for(var i = 0 ; i < data.length ; i++){
	 		var Xpoint =data[i].DivingXpoint;
	 		var Ypoint = data[i].DivingYpoint;
	 		var DivingName = data[i].DivingName;
	 		var DivingRating = data[i].DivingRating;
	 		var DivingDepthMin = data[i].DivingDepthMin;
	 		var DivingDepthMax = data[i].DivingDepthMax;

	 		var img = document.createElement("img");
	 		img.setAttribute("src","${contextPath}/resources/assets/images/scubaFlag.png");
			img.setAttribute("class","pointChecker");
			img.setAttribute("onclick","location.href='${contextPath}/informations/DivingSiteView?CityName=${nowCityName}&DivingName="+DivingName+"'");
			img.setAttribute("cursor","pointer");
			img.style.position="absolute";
	 		img.style.width="15px";
	 		img.style.height="15px";
	 		img.setAttribute("title",DivingName+"\n단계 :"+DivingRating+"\n수심 : "+DivingDepthMin+"m ~ "+DivingDepthMax+"m");
	 		img.style.left = Xpoint * $('#preView>img').width()+8 + "px";
	 		img.style.top = Ypoint * $('#preView>img').height()-7 + "px";
	 		document.getElementById('preView').appendChild(img);
	 		}
			$(window).resize(function() {
				$('.pointChecker').remove();
			 	for(var i = 0 ; i < data.length ; i++){
			 		var Xpoint =data[i].DivingXpoint;
			 		var Ypoint = data[i].DivingYpoint;
			 		var DivingName = data[i].DivingName;
			 		var DivingRating = data[i].DivingRating;
			 		var DivingDepthMin = data[i].DivingDepthMin;
			 		var DivingDepthMax = data[i].DivingDepthMax;

			 		var img = document.createElement("img");
			 		img.setAttribute("src","${contextPath}/resources/assets/images/scubaFlag.png");
					img.setAttribute("class","pointChecker");
					img.setAttribute("onclick","location.href='${contextPath}/informations/DivingSiteView?CityName=${nowCityName}&DivingName="+DivingName+"'");
					img.setAttribute("cursor","pointer");
					img.style.position="absolute";
			 		img.style.width="15px";
			 		img.style.height="15px";
			 		img.setAttribute("title",DivingName+"\n단계 :"+DivingRating+"\n수심 : "+DivingDepthMin+"m ~ "+DivingDepthMax+"m");
			 		img.style.left = Xpoint * $('#preView>img').width()+8 + "px";
			 		img.style.top = Ypoint * $('#preView>img').height()-7 + "px";
			 		document.getElementById('preView').appendChild(img);
			 		}
			});
		}
	});
}
function CountryChange() {
	var CountryName = $("#CountryNameCategory option:selected").val();
	location.href="${contextPath}/informations/DivingCountry?CountryName="+CountryName;
}
function CityChange() {
	var CityName = $("#CityNameCategory option:selected").val();
	location.href="${contextPath}/informations/DivingCity?CityName="+CityName;
}
</script>
</head>
<body>
	<jsp:include page="../inc/Top.jsp"/>
		<section class="module">
	      <div class="row">
            <div class="col-sm-6 col-sm-offset-3">
              <h2 class="module-title font-alt" style="margin-bottom: 20px">다이빙 정보</h2>
            </div>
          </div>
          <div class="container">
<!--           이미지 -->
            <div class="row">
              <div class="col-sm-3 mb-sm-20" style="margin-bottom: 15px; margin-right: 2%;">
                <select class="form-control" id="CountryNameCategory" onchange="CountryChange()" style="width: 100px; float: left;">
                  <c:forEach items="${CountryList}" var="CountryName">
                  	<c:choose>
                  		<c:when test="${CountryName eq nowCountryName}">
                  			<option value="${CountryName}" selected="selected">${CountryName}</option>
                  		</c:when>
                  		<c:otherwise>
                  			<option value="${CountryName}">${CountryName}</option>
                  		</c:otherwise>
                  	</c:choose>
                  </c:forEach>
                 
                </select>
                <select class="form-control" style="width: 100px;" id="CityNameCategory" onchange="CityChange()">
                  <c:forEach items="${CityList}" var="CityName">
                  	<c:choose>
                  		<c:when test="${CityName eq nowCityName}">
                  			<option value="${CityName}" selected="selected">${CityName}</option>
                  		</c:when>
                  		<c:otherwise>
                  			<option value="${CityName}">${CityName}</option>
                  		</c:otherwise>
                  	</c:choose>
                  </c:forEach>
                </select>
              </div>
              <div class="col-sm-12" id="preView"><img src="${contextPath}/resources/upload/admin/information/City/${CityImage}" alt="Title of Image"/></div>
            </div>
<!--             이미지 -->
<!-- 			메인 설명 -->
            <div class="row multi-columns-row" style="margin-top: 20px;">
              <div class="col-sm-6 col-md-4 col-lg-4">
                <div class="work-details" style="margin-top: 2%;">
                  <h5 class="work-details-title font-alt">Project Details</h5>
                  <p></p>
                  <ul>
                    <li><strong>지역 명: </strong><span class="font-serif"><a href="#" target="_blank">${nowCityName}</a></span>
                    </li>
                    <li><strong>평균 수온: </strong><span class="font-serif"><a href="#" target="_blank">${AveTemper} 도</a></span>
                    </li>
                    <li><strong>다이빙 적정기간: </strong><span class="font-serif"><a href="#" target="_blank">${Season}</a></span>
                    </li>
                  </ul>
                </div>
              </div>
              <div class="col-sm-6 col-md-4 col-lg-4">
				<p>${CityExp}</p>
              </div>
            </div>
<!--             메인 설명 -->
<!-- 어류 정보 -->
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="owl-carousel text-center" data-items="5" data-pagination="false" data-navigation="false">
                <c:forEach items="${FishList}" var="Fish">
	                <div class="owl-item">
	                  <div class="col-sm-12" title="${Fish.FishExp}">
	                    <div class="ex-product"><a href="#"><img src="${contextPath}/resources/upload/admin/information/Fish/${Fish.FishImage}"/></a>
	                      <h4 class="shop-item-title font-alt"><a href="#">${Fish.FishName}</a></h4>
	                    </div>
	                  </div>
	                </div>
                </c:forEach>
              </div>
            </div>
          </div>
        </section>
<!-- 어류정보 -->
<!-- 			그외 정보 -->
			<div role="tabpanel">
              <ul class="nav nav-tabs font-alt" role="tablist">
                <li class="active"><a href="#review" data-toggle="tab">
                	<i class="fa fa-fw">&#xf044;</i>후기</a>
                </li>
                <li><a href="#resort" data-toggle="tab"><span class="icon-map-pin">
                	</span>&nbsp;주변 리조트</a>
                </li>
              </ul>
              <div class="tab-content">
                <div class="tab-pane active" id="review">
<!-- 1번 카테고리 -->
	                <table class="table table-striped table-border checkout-table">
	                  <tbody>
	                    <tr>
	                      <th class="hidden-xs" width="7%">글번호</th>
	                      <th width="7%">이미지</th>
	                      <th width="50%">제목</th>
	                      <th class="hidden-xs" width="12%">작성자</th>
	                      <th class="hidden-xs" width="12%">등록일자</th>
	                      <th width="12%">좋아요</th>
	                    </tr>
	                    <tr>
	                      <td class="hidden-xs">1</td>
	                      <td><a href="#"><img src="${contextPath}/resources/assets/images/shop/product-14.jpg" alt="Accessories Pack"/></a></td>
	                      <td>
	                        <h5 class="product-title font-alt">Accessories Pack</h5>
	                      </td>
	                      <td class="hidden-xs">
	                        <h5 class="product-title font-alt">우리</h5>
	                      </td>
	                      <td class="hidden-xs">
	                        <h5 class="product-title font-alt">1994/02/02</h5>
	                      </td>
	                      <td class="pr-remove"><a href="#" title="Remove"><i class="fa fa-times"></i></a></td>
	                    </tr>
	                    <tr>
	                      <td class="hidden-xs">2</td>
	                      <td><a href="#"><img src="${contextPath}/resources/assets/images/shop/product-14.jpg" alt="Accessories Pack"/></a></td>
	                      <td>
	                        <h5 class="product-title font-alt">Accessories Pack</h5>
	                      </td>
	                      <td class="hidden-xs">
	                        <h5 class="product-title font-alt">우리</h5>
	                      </td>
	                      <td class="hidden-xs">
	                        <h5 class="product-title font-alt">1994/02/02</h5>
	                      </td>
	                      <td class="pr-remove"><a href="#" title="Remove"><i class="fa fa-times"></i></a></td>
	                    </tr>
	                  </tbody>
	                </table>
<!-- 1번 카테고리 -->
                </div>
                <div class="tab-pane" id="resort">
<!-- 2번 카테고리 -->
	                <table class="table table-striped table-border checkout-table">
	                  <tbody>
	                    <tr>
	                      <th class="hidden-xs" width="7%">이미지</th>
	                      <th width="20%">리조트명</th>
	                      <th class="hidden-xs" width="13%">홈페이지주소</th>
	                      <th width="10%">연락처</th>
	                      <th width="50%">인사말</th>
	                    </tr>
	                    <c:forEach items="${resortList}" var="resortVO">
		                    <tr>
		                      <td class="hidden-xs"><a href="#"><img src="${contextPath}/resources/images/Resort/thumbnail/${resortVO.num}/${resortVO.image1}"/></a></td>
		                      <td>
		                        <h5 class="font-alt"><a href="${contextPath}/Resort/moveViewResort?num=${resortVO.num}">${resortVO.resortName}</a></h5>
		                      </td>
		                      <td class="hidden-xs">
		                        <h5 class="font-alt">${resortVO.homepageAddress}</h5>
		                      </td>
		                      <td>
		                        <h5 class="font-alt">${resortVO.phoneNumber}</h5>
		                        <h5 class="font-alt"><img src="${contextPath}/resources/assets/images/kakaoIcon.png" alt="kakaologo" width="13px">&nbsp;${resortVO.cacaoId}</h5>
		                      </td>
		                      <td>
		                        <h5 class="font-alt">${resortVO.simpleIntroduce}</h5>
		                      </td>
		                    </tr>
	                    </c:forEach>
	                  </tbody>
	                </table>
<!-- 2번 카테고리 -->
                </div>
              </div>
            </div>
<!-- 			그외 정보 -->
          </div>
        </section>
	<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>