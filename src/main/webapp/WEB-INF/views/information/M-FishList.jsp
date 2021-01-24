<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function setCity() {
	$('#setCity').css("display","inline");
}
function addCity(fishName) {
	if($('#setCity').val()!=""){
		var CityName = $('#setCity').val();
		var msg = fishName + "의 서식지에 " +CityName+" 을 추가하시겠습니까 ?";
		if(confirm(msg)){
			$.ajax({
				url:'${contextPath}/informations/addHauntingCity',
				type:'POST',
				data :{FishName : fishName , CityName : CityName},
				success : function() {
					$('#'+fishName+'>p').html('<font style="color : red;">변경되었습니다 .</font>');
				}
			});
		}
	}
}
$(document).ready(function() {
	$('#setCity').on('keyup',function() {
		if($('#setCity').val()==""){
			window.location.reload();
		}
	});
});
</script>
</head>
<body>
<!-- 리스트 -->
<section class="module">
  <div class="container">
<!--   검색 -->
    <div class="row mb-40">
      <div class="col-sm-6 col-sm-offset-3">
      </div>
    </div>
    <div class="row mb-40">
        <div class="col-sm-12">
	        <div style="float: right;">
	        	<a href="${contextPath}/informations/EnterFish">어류 등록</a>
	        </div>
	        <div>
	        	<button class="btn btn-border-d btn-round" type="button" onclick="setCity()" style="padding: 5px;">지역 추가</button>
         		<input type="text" id="setCity" placeholder="지역명 입력" style="display: none;">
	        </div>
    	</div>
	</div>
<!--     검색 -->
    <div class="row multi-columns-row post-columns">
    
    <c:forEach items="${FishList}" var="informationVO">
      <div class="col-sm-6 col-md-3 col-lg-3">
        <div class="post">
          <div class="post-thumbnail"><a href="#"><img src="${contextPath}/resources/upload/admin/information/Fish/${informationVO.getFishImage()}"/></a></div>
          <div class="post-header font-alt">
            <h2 class="post-title"><a onclick="addCity('${informationVO.getFishName()}')" style="cursor: pointer;">${informationVO.getFishName()}</a></h2>
          </div>
          <div class="post-entry" id="${informationVO.getFishName()}">
            <p>${informationVO.getFishExp()}<br><b>출몰지역</b><br>${informationVO.getHauntingCity()}</p>
          </div>
        </div>
      </div>
    </c:forEach>
    </div>
  </div>
</section>
<!--         리스트 -->
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>