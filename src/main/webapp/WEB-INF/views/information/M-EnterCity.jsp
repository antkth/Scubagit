<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
//이미지 X,Y 좌표 구하기 
function getLocation() {
	$('#pointChecker').remove();
	var Xpoint = event.offsetX / $('#preView>img').width();
	var Ypoint = event.offsetY / $('#preView>img').height();
	
	var img = document.createElement("img");
	img.setAttribute("src","${contextPath}/resources/assets/images/scubaFlag.png");
	img.setAttribute("id","pointChecker");
	img.style.position="absolute";
	img.style.width="15px";
	img.style.height="15px";
	img.style.left = Xpoint * $('#preView>img').width()+8 + "px";
	img.style.top = Ypoint * $('#preView>img').height()-7 + "px";
	document.getElementById('preView').appendChild(img);
	
	$('#Xpoint').val(Xpoint);
	$('#Ypoint').val(Ypoint);
	
	$(window).resize(function(){
		$('#pointChecker').remove();
	});
}
//미리보기
function preView(event) {
	var reader = new FileReader();
	reader.onload = function(event) {
		var img = document.createElement("img");
		img.setAttribute("src",event.target.result);
		img.setAttribute("onclick","getLocation()");
		document.querySelector("div#preView").appendChild(img);
	}
	$('#preView').empty();
	reader.readAsDataURL(event.target.files[0]);
}
//국가 카테고리 변경
function CountryChange() {
	var CountryName = $("#CountryNameCategory option:selected").val();
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
			$('<option selected="selected" disabled="disabled">도시 명</option>').prependTo('#CityNameCategory');
			$('#CountryNameup').empty();
			var tag = '<input class="form-control input-sm" type="text" value="'+CountryName+'" name="CountryName" id="CountryName" readonly="readonly">';
			$('#CountryNameup').append(tag);
		}
	});
}
//도시 카테고리 변경
function CityChange() {
	var CityName = $("#CityNameCategory option:selected").val();
	$.ajax({
		url:'${contextPath}/informations/getCityinfo',
		type:'POST',
		data:{CityName:CityName},
		success : function(data) {
			//도시이름
			$('#CityName').val(data.CityName);
			document.getElementById('CityName').readOnly = true;
			//이미지
			$('#preView').empty();
			var img = document.createElement("img");
			img.setAttribute("src",data.url+data.CityImage);
			img.setAttribute("onclick","getLocation()");
			document.querySelector("div#preView").appendChild(img);
			//이미지 파일쪽
			$('#CityImageUp').empty();
			var input = document.createElement("input");
			input.setAttribute("class","form-control input-sm");
			input.setAttribute("type","text");
			input.setAttribute("id","CityImage");
			input.setAttribute("name","CityImageAlread");
			document.querySelector("div#CityImageUp").appendChild(input);
			$('#CityImage').val(data.CityImage);
			document.getElementById('CityImage').readOnly = true;
			
		}
	});
}
</script>
</head>
<body>
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-8" style="text-align:-webkit-center;">
              <!--           이미지 -->
	            <div class="row">
	            <div class="col-sm-4 mb-sm-20">
		            <select class="form-control" id="CountryNameCategory" onchange="CountryChange()" style="margin-bottom: 10px;">
	                  <option selected="selected" disabled="disabled">국가 명</option>
	                  <c:forEach var="CountryName" items="${CountryList}">
	                  <option value="${CountryName}">${CountryName}</option>
	                  </c:forEach>
	                </select>
                </div>
                <div class="col-sm-4 mb-sm-20">
		            <select class="form-control" id="CityNameCategory" onchange="CityChange()" style="margin-bottom: 10px;">
	                  <option selected="selected" disabled="disabled">도시 명</option>
	                </select>
                </div>
	              <div class="col-sm-12" id="preView">
	              	<h2> 1680 * 945 이미지를 등록해 주세요.</h2>
	              </div>
	            </div>
<!--             이미지 -->
                <hr class="divider-w mt-10 mb-20">
                <form class="form" role="form" id="form" method="post" action="${contextPath}/informations/sendCity" enctype="multipart/form-data">
                  <div class="form-group">
                    <input class="form-control input-sm" id="CityName" name="CityName" type="text" placeholder="도시명" required/>
                  </div>
                  <div class="form-group" id="CityImageUp">
                    <input class="form-control input-sm" id="CityImage" name="CityImage" type="file" accept="image/*" onchange="preView(event)" placeholder="지도 이미지" required/>
                  </div>
                  <div class="form-group" id="CountryNameup">
		            <select class="form-control" id="CountryName" name="CountryName">
	                  <option selected="selected" disabled="disabled">국가 명</option>
	                  <c:forEach var="CountryName" items="${CountryList}">
	                  <option value="${CountryName}">${CountryName}</option>
	                  </c:forEach>
	                </select>                  
	                </div>
                  <div class="form-group">
                    <input class="form-control input-sm" name="DivingXpoint" id="Xpoint" type="text" placeholder="x축 좌표" readonly="readonly"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-sm" name="DivingYpoint" id="Ypoint" type="text" placeholder="y축 좌표" readonly="readonly"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-lg" id="DivingName" name="DivingName" type="text" placeholder="다이빙사이트 명" required/>
                  </div>
                  <div class="form-group">
                  <textarea class="form-control" rows="7" id="DivingExp" name="DivingExp" placeholder="다이빙사이트 설명" style="resize: none;" required></textarea>
               	  </div>
               	  <div class="form-group">
		            <select class="form-control" id="DivingRating" name="DivingRating" style="margin-bottom: 10px;">
		            	<option selected="selected" disabled="disabled">단계</option>
		            	<option value="Easy">Easy</option>	
		            	<option value="Intermediate">Intermediate</option>	
		            	<option value="Hard">Hard</option>
		            	<option value="Advanced">Advanced</option>	
		            </select>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-lg" id="DivingDepthMin" name="DivingDepthMin" type="text" placeholder="최저수심" required style="margin-left: 28% ; float: left; margin-right: 5% ; width: 20%;"/>
                    <input class="form-control input-lg" id="DivingDepthMax" name="DivingDepthMax" type="text" placeholder="최고수심" required style="width: 20%; float: left;"/>
                  </div>
                  <div class="row" style="text-align: center; clear: both; padding-top: 15px;">
                  <button class="btn btn-border-d btn-round" type="button" onclick="checkform()">등록하기</button>&nbsp;
                  <button class="btn btn-border-d btn-round">취소하기</button>
                  </div>
                </form>
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
        <script type="text/javascript">
        function checkform() {
			var CityName = $('#CityName').val();
			var CountryName = $('#CountryName option:selected').val();
			if(CountryName == null){
				CountryName = $('#CountryName').val();
			}
			var CityCheck = 0;
        	$.ajax({
        		url:'${contextPath}/informations/CityCheck',
        		type:'POST',
        		data:{CityName : CityName , CountryName : CountryName},
        		success: function (data) {
					CityCheck = data;
		        	if($('#CityName').val()==""){
		        		alert("도시명을 입력해 주세요");
		        	}else if($('#CountryName option:selected').val()=="국가 명"){
		        		alert("국가명을 선택해 주세요 .");
		        	}else if($('#DivingName').val()==""){
		        		alert("다이빙 사이트 명을 입력해 주세요 .");
		        	}else if($('#DivingExp').val()==""){
		        		alert("다이빙사이트 설명을 입력해 주세요 . ");
		        	}else if($('#DivingRating option:selected').val()=="단계"){ 
		        		alert("다이빙사이트 단계를 입력해 주세요 .");
		        	}else if($('#Xpoint').val()==""){
		        		alert("이미지의 좌표를 지정해 주세요 .");
		        	}else if(CityCheck == 1){
						alert("등록된 도시가 아님니다 .");
		        	}else{
		        		$('#form').submit();
		        	}
				}
        	});
        }
        </script>
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>