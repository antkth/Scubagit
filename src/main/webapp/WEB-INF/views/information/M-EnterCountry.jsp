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
//나라 카테고리 변경
function CountryChage() {
	var CountryName = $("#CountryNameCategory option:selected").val();
	$.ajax({
		url:'${contextPath}/informations/getCountryinfo',
		type:'POST',
		data : {CountryName : CountryName},
		success : function(data){
			//나라이름
			$('#CountryName').val(data.CountryName);
			document.getElementById('CountryName').readOnly = true;
			//이미지
			$('#preView').empty();
			var img = document.createElement("img");
			img.setAttribute("src",data.url+data.CountryImage);
			img.setAttribute("onclick","getLocation()");
			document.querySelector("div#preView").appendChild(img);
			//이미지 파일쪽
			$('#CountryImageUp').empty();
			var input = document.createElement("input");
			input.setAttribute("class","form-control input-sm");
			input.setAttribute("type","text");
			input.setAttribute("id","CountryImage");
			input.setAttribute("name","CountryImageAlread");
			document.querySelector("div#CountryImageUp").appendChild(input);
			$('#CountryImage').val(data.CountryImage);
			document.getElementById('CountryImage').readOnly = true;
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
	            <select class="form-control" id="CountryNameCategory" onchange="CountryChage()" style="margin-bottom: 10px;">
                  <option selected="selected" disabled="disabled">국가 명</option>
                  <c:forEach var="CountryName" items="${CountryList}">
                  <option value="${CountryName}">${CountryName}</option>
                  </c:forEach>
                </select>
                </div>
	              <div class="col-sm-12" id="preView">
	              	<h2> 1680 * 945 이미지를 등록해 주세요.</h2>
	              </div>
	            </div>
<!--             이미지 -->
                <hr class="divider-w mt-10 mb-20">
                <form class="form" role="form" id="form" method="post" action="${contextPath}/informations/sendCountry" enctype="multipart/form-data">
                  <div class="form-group">
                    <input class="form-control input-sm" id="CountryName" name="CountryName" type="text" placeholder="국가명" required/>
                  </div>
                  <div class="form-group" id="CountryImageUp">
                    <input class="form-control input-sm" id="CountryImage" name="CountryImage" type="file" accept="image/*" onchange="preView(event)" placeholder="지도 이미지" required/>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-sm" name="CityXpoint" id="Xpoint" type="text" placeholder="x축 좌표" readonly="readonly"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-sm" name="CityYpoint" id="Ypoint" type="text" placeholder="y축 좌표" readonly="readonly"/>
                  </div>
                  <div class="form-group">
                    <input class="form-control input-lg" name="CityName" type="text" placeholder="도시 명" required/>
                  </div>
                  <div class="form-group">
                  <textarea class="form-control" rows="7" name="CityExp" placeholder="도시 설명" style="resize: none;" required></textarea>
               	  </div>
               	  <div class="form-group">
                    <input class="form-control input-lg" name="AveTemper" type="text" placeholder="도시 평균 수온" required/>
                  </div>
                  <div class="form-group">
                    <table style="width: 300px;">
	                    <tr>
	                    	<td colspan="4">(도시)다이빙 적정 기간</td>
	                    </tr>
	                    <tr>
		                    <td><input type="checkbox" class="Season" name="Season0" value="1">&nbsp;1월</td>
		                    <td><input type="checkbox" class="Season" name="Season1" value="2">&nbsp;2월</td>
		                    <td><input type="checkbox" class="Season" name="Season2" value="3">&nbsp;3월</td>
		                    <td><input type="checkbox" class="Season" name="Season3" value="4">&nbsp;4월</td>
	                    </tr>
	                    <tr>
		                   	<td><input type="checkbox" class="Season" name="Season4" value="5">&nbsp;5월</td>
		                    <td><input type="checkbox" class="Season" name="Season5" value="6">&nbsp;6월</td>
		                    <td><input type="checkbox" class="Season" name="Season6" value="7">&nbsp;7월</td>
		                    <td><input type="checkbox" class="Season" name="Season7" value="8">&nbsp;8월</td>
	                    </tr>
		                <tr>
		                   	<td><input type="checkbox" class="Season" name="Season8" value="9">&nbsp;9월</td>
		                    <td><input type="checkbox" class="Season" name="Season9" value="10">&nbsp;10월</td>
		                    <td><input type="checkbox" class="Season" name="Season10" value="11">&nbsp;11월</td>
		                    <td><input type="checkbox" class="Season" name="Season11" value="12">&nbsp;12월</td>
	                    </tr>
                    </table>
                  </div>
                  <div class="row" style="text-align: center;">
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
        	var season = document.getElementsByClassName("Season");
        	var seasonCheck = false;
        	for(var i = 0 ; i <season.length ; i++){
        		if(season[i].checked==true) seasonCheck = true;
        	}
        	if($('#Xpoint').val()==""){
        		alert("이미지의 좌표를 지정해 주세요 .");
        	}else if(seasonCheck == false){
        		alert("다이빙 적정 기간을 선택해 주세요 .");
        	}else{
        		$('#form').submit();
        	}
        }
        </script>
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>