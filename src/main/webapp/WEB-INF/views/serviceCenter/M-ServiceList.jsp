<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
window.onload = function() {
	var TopQuestions = $('#TopQuestions option:selected').val();
	$.ajax({
		url:'${contextPath}/Service/getList',
		type:'POST',
		data: {TopQuestions : TopQuestions},
		success : function(data) {
			$('#List').empty();
			for(var i = 0 ; i < data.length ; i++){
				var html = '<tr><td class="hidden-xs">'+data[i].Num+'</td>';
	                html += '<td>'+data[i].Category+'</td>'
	                html += '<td class="hidden-xs">'+data[i].Title+'</td>';
	                html += '<td>'+data[i].Contents+'</td>';
	                if(data[i].TopQuestions==1){
	                	html += '<td id="'+data[i].Num+'"><a style="cursor: pointer;" onclick="changeQuestions('+data[i].Num+')">등록상태</a></td>';	
	                }else{
	                	html += '<td id="'+data[i].Num+'"><a style="cursor: pointer;" onclick="changeQuestions('+data[i].Num+')">비등록상태</a></td>';
	                }
	                html += '<td><a style="cursor: pointer;" onclick="delQuestions('+data[i].Num+')">삭제</a></td></tr>';
	          $('#List').append(html);
			}
		}
	});
}
function ChangeTopQuestions() {
	var TopQuestions = $('#TopQuestions option:selected').val();
	$.ajax({
		url:'${contextPath}/Service/getList',
		type:'POST',
		data: {TopQuestions : TopQuestions},
		success : function(data) {
			$('#List').empty();
			for(var i = 0 ; i < data.length ; i++){
				var html = '<tr><td class="hidden-xs">'+data[i].Num+'</td>';
	                html += '<td>'+data[i].Category+'</td>'
	                html += '<td class="hidden-xs">'+data[i].Title+'</td>';
	                html += '<td>'+data[i].Contents+'</td>';
	                if(data[i].TopQuestions==1){
	                	html += '<td id="'+data[i].Num+'"><a style="cursor: pointer;" onclick="changeQuestions('+data[i].Num+')">등록상태</a></td>';	
	                }else{
	                	html += '<td id="'+data[i].Num+'"><a style="cursor: pointer;" onclick="changeQuestions('+data[i].Num+')">비등록상태</a></td>';
	                }
	                html += '<td><a style="cursor: pointer;" onclick="delQuestions('+data[i].Num+')">삭제</a></td></tr>';
	          $('#List').append(html);
			}
		}
	});
}
function changeQuestions(id) {
	var TopQuestions = $('#TopQuestions option:selected').val();
	$.ajax({
		url:'${contextPath}/Service/changeQuestions',
		type:'POST',
		data:{TopQuestions:TopQuestions , Num : id},
		success: function() {
			document.getElementById(id).innerText = '변경되었습니다.';
		}
	});
}
function delQuestions(id) {
	console.log(id);
	var msg = "번호 "+ id + " 를 삭제하시겠습니까 ?";
	if(confirm(msg)){
		$.ajax({
			url : '${contextPath}/Service/delQuestions',
			type : 'POST',
			data : { Num : id },
			success : function () {
				alert('삭제되었습니다 .');
				window.location.reload();
			}
		});
	}
}
</script>
</head>
<body>
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-8" style="text-align:-webkit-center;">
                    <a href="${contextPath}/Service/MoveServiceWrite">이용안내 글쓰기</a>
              <div class="row">
                <select class="form-control" id="TopQuestions" onchange="ChangeTopQuestions()" style="float: right; width:15%; margin-right: 7%">
                  <option selected="selected" value="1">등록중</option>
                  <option value="0">비등록중</option>
                </select>
              </div>
            	<div class="row">
              <table class="table table-striped table-border checkout-table">
                  <thead>
                    <tr>
                      <th class="hidden-xs" width="8%">번호</th>
                      <th width="15%">카테고리</th>
                      <th class="hidden-xs" width="15%">제목</th>
                      <th width="40%">내용</th>
                      <th width="15%">자주묻는질문</th>
                      <th width="7%">삭제</th>
                    </tr>
                    </thead>
                    <tbody id="List">
                    <tr>
                      <td class="hidden-xs">번호</td>
                      <td>카테고리
                      </td>
                      <td class="hidden-xs">제목
                      </td>
                      <td>내용
                      </td>
                      <td>자주묻는질문
                      </td>
                    </tr>
                  </tbody>
                  </table>
                  </div>
                <div class="pagination font-alt"><a href="#"><i class="fa fa-angle-left"></i></a><a class="active" href="#">1</a><a href="#">2</a><a href="#">3</a><a href="#">4</a><a href="#"><i class="fa fa-angle-right"></i></a></div>
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
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>