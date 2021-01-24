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
	var status = $('#status option:selected').val();
	$.ajax({
		url : '${contextPath}/Service/getAllinquiryList',
		type : 'POST',
		data : {answerstatus:status},
		success : function(data) {
			var html ="";
			for (var i = 0; i < data.length; i++) {
			html += "<tr><td>"+data[i].id+"</td>";
			html += "<td><a href='${contextPath}/Service/MoveModInquiry?Num="+data[i].Num+"'>"+data[i].title+"</a></td>";
			html += "<td>"+data[i].contents+"</td>";
			html += "<td>"+data[i].writedate+"</td>";
			if(data[i].answerstatus==0){
				html += "<td>대기중</td></tr>";	
			}else{
				html += "<td>해결 완료</td></tr>";	
			}
			}
			$('#tbody').empty();
			$('#tbody').append(html);
		}
	});
}
function statusChange() {
	var status = $('#status option:selected').val();
	$.ajax({
		url : '${contextPath}/Service/getAllinquiryList',
		type : 'POST',
		data : {answerstatus:status},
		success : function(data) {
			var html ="";
			for (var i = 0; i < data.length; i++) {
			html += "<tr><td>"+data[i].id+"</td>";
			html += "<td><a href='${contextPath}/Service/MoveModInquiry?Num="+data[i].Num+"'>"+data[i].title+"</a></td>";
			html += "<td>"+data[i].contents+"</td>";
			html += "<td>"+data[i].writedate+"</td>";
			if(data[i].answerstatus==0){
				html += "<td>대기중</td></tr>";	
			}else{
				html += "<td>해결 완료</td></tr>";	
			}
			}
			$('#tbody').empty();
			$('#tbody').append(html);
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
       	<div class="row">
       	<select class="form-control" id="status" onchange="statusChange()" style="float: right; width: 15%;">
             <option selected="selected" value="0">대기중</option>
             <option value="1">해결</option>
           </select>
         <table class="table table-striped table-border checkout-table" style="text-align-last: center; vertical-align: bottom; margin-top: 1%;">
             <thead>
             	<tr style="text-align: center;">
                 <th width="10%">아이디</th>
                 <th width="15%">제목</th>
                 <th width="50%">내용</th>
                 <th width="10%">작성일</th>
                 <th width="15%">상태</th>
               </tr>
             </thead>
             <tbody id="tbody">
             </tbody>
             </table>
             </div>
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