<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function CountryChange() {
	var CountryName = $("#CountryNameCategory option:selected").val();
	//City카테고리 변경
	$.ajax({
		url:'${contextPath}/informations/getCityList',
		type:'POST',
		data : {CountryName : CountryName},
		success : function (data) {
			$('#CityNameCategory').empty();
			for(var i = 0 ; i < data.length ; i ++){
				var tag = '<option value="'+data[i]+'">'+data[i]+'</option>';
				$('#CityNameCategory').append(tag);
			}
			$('<option selected="selected" disabled="disabled">지역선택</option>').prependTo('#CityNameCategory');
			$('#CountryNameup').empty();
			var tag = '<input class="form-control input-sm" type="text" value="'+CountryName+'" name="CountryName" id="CountryName" readonly="readonly">'
			$('#CountryNameup').append(tag);
		}
	});
	//국가 선택시 도시 이미지 바꿔주기
	$.ajax({
		url : '${contextPath}/informations/antherCityArea',
		type : 'POST',
		data : {CountryName:CountryName},
		success : function(data) {
			$('#antherCityArea').html("");
			for(var i = 0 ; i < data.length ; i++){
				var html = '<div class="col-sm-6 col-md-4 col-lg-4">';
				html += '<div class="post">';
				html += '<div class="post-thumbnail"><a href="${contextPath}/informations/DivingCity?CityName='+data[i].CityName+'"><img src="${contextPath}/resources/upload/admin/information/City/'+data[i].CityImage+'" alt="Blog-post Thumbnail"/></a></div>';
				html += '<div class="post-header font-alt">';
				html += '<h2 class="post-title"><a href="${contextPath}/informations/DivingCity?CityName='+data[i].CityName+'">'+data[i].CityName+'</a></h2>';
				html += '</div></div></div>';
				$('#antherCityArea').append(html);
			}
			
		}
	});
	//나라 이미지 변경시 도시 위치 체크
	$.ajax({
		url:'${contextPath}/informations/getCountryPointinfo',
		type:'POST',
		data:{CountryName:CountryName},
		success : function(data) {
			$('#preView').empty();
			var img = document.createElement("img");
			img.setAttribute("src",data[0].url+data[1].CountryImage);
			document.querySelector("div#preView").appendChild(img);
			$('#CountryName').empty();
			$('#CountryName').append(data[1].CountryName);
			setTimeout(function () {
				var widthsize = $('#preView>img').width();
				var heightsize = $('#preView>img').height();
				for(var i = 1 ; i < data.length ; i++){
					var Xpoint = data[i].CityXpoint * widthsize;
					var Ypoint = data[i].CityYpoint * heightsize;
					var img = document.createElement("img");
					img.setAttribute("src","${contextPath}/resources/assets/images/scubaFlag.png");
					img.setAttribute("class","pointChecker");
					img.setAttribute("cursor","pointer");
					img.setAttribute("title",data[i].CityName+"\n수온 :"+data[i].AveTemper+"\n시즌 : "+data[i].Season);
					img.setAttribute("onclick","location.href='${contextPath}/informations/DivingCity?CityName="+data[i].CityName+"'");
					img.style.position="absolute";
					img.style.width="15px";
					img.style.height="15px";
					img.style.left = Xpoint+8 + "px";
					img.style.top = Ypoint-7 + "px";
					document.getElementById('preView').appendChild(img);
				}
			},100);
			//사이즈 조절시 도시 이미지 변경
			$(window).resize(function() {
			$('.pointChecker').remove();
			var widthsize = $('#preView>img').width();
			var heightsize = $('#preView>img').height();
			for(var i = 1 ; i < data.length ; i++){
				var Xpoint = data[i].CityXpoint * widthsize;
				var Ypoint = data[i].CityYpoint * heightsize;
				var img = document.createElement("img");
				img.setAttribute("src","${contextPath}/resources/assets/images/scubaFlag.png");
				img.setAttribute("class","pointChecker");
				img.setAttribute("cursor","pointer");
				img.setAttribute("title",data[i].CityName+"\n수온 :"+data[i].AveTemper+"\n시즌 : "+data[i].Season);
				img.setAttribute("onclick","location.href='${contextPath}/informations/DivingCity?CityName="+data[i].CityName+"'");
				img.style.position="absolute";
				img.style.width="15px";
				img.style.height="15px";
				img.style.left = Xpoint+8 + "px";
				img.style.top = Ypoint-7 + "px";
				document.getElementById('preView').appendChild(img);
			}
			});
		}
	});
}
function CityChange() {
	var CityName = $("#CityNameCategory option:selected").val();
	location.href="${contextPath}/informations/DivingCity?CityName="+CityName;
}
</script>
</head>
<body>
		<section class="module">
	      <div class="row">
            <div class="col-sm-6 col-sm-offset-3">
              <h2 class="module-title font-alt" style="margin-bottom: 20px" id="CountryName">국가를 선택해 주세요</h2>
            </div>
          </div>
          <div class="container">
<!--           이미지 -->
            <div class="row">
            <div class="col-sm-3 mb-sm-20" style="margin-bottom: 15px;">
                <select class="form-control" id="CountryNameCategory" onchange="CountryChange()" style="width: 100px; float: left;">
                  <option selected="selected" disabled="disabled">국가선택</option>
				  <c:forEach items="${CountryList}" var="CountryName">
				  <c:choose>
				  <c:when test="${nowCountryName eq CountryName}">
				  <option value="${CountryName}" selected="selected">${CountryName}</option>
				  <script type="text/javascript">
				  CountryChange();
				  </script>
				  </c:when>
				  <c:otherwise>
				  <option value="${CountryName}">${CountryName}</option>
				  </c:otherwise>
				  </c:choose>	
				  </c:forEach>
                </select>
                <select class="form-control" id="CityNameCategory" style="width: 100px;" onchange="CityChange()">
                  <option selected="selected" disabled="disabled">지역선택</option>
                </select>
                <a href="${contextPath}/informations/EnterCountry">나라 등록 o</a>
                <a href="${contextPath}/informations/EnterCity">지역 등록 o</a>
                <a href="${contextPath}/informations/FishList">어류 리스트</a>
              </div>
              <div class="col-sm-12" id="preView">
				<h2>카테고리를 선택해 주세요</h2>
              </div>
            </div>
<!--             이미지 -->
<!-- 추천지역 -->
            <div class="row multi-columns-row post-columns" id="antherCityArea" style="margin-top: 25px;">
            </div>
<!-- 추천지역 -->
<!-- 			메인 설명 -->
            <div class="row multi-columns-row" style="margin-top: 20px;">
              <div class="col-sm-18 col-md-12 col-lg-12">
              </div>
            </div>
<!--             메인 설명 -->
          </div>
        </section>
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>