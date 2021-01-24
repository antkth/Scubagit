<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
       	window.onload = function() {
       		if('${user_id}' == null||'${user_id}' == ""){
      		  $('#inquiry>div').empty();
      		  $('#inquiry>div').append("<h2>로그인 후 이용해 주세요.</h2>");
      	}else {
      	  var id = '${user_id}';	 
      	      $.ajax({
      	    	 url : '${contextPath}/Service/getinquirylist',
      	    	 type : 'POST',
      	    	 data : {id:id},
      	    	 success : function(data) {
      	    		var html = '<button class="btn btn-block btn-round btn-b" onclick="writeinquiry()">1대1 문의하기</button>';
      	    		for (var i = 0; i < data.length; i++) {
      			 	  html += '<div class="panel panel-default"><div class="panel-heading">';
      			  	  html += '<h4 class="panel-title font-alt"><a data-toggle="collapse" data-parent="#accordion" href="#inquiry'+data[i].Num+'">'+data[i].title;
      			  	  if(data[i].answerstatus==0){
      			  	  	  html += '<font color="red">대기중</font></a></h4></div>';
      			  	  }else{
      			  		  html += '<font color="blue">답변완료</font></a></h4></div>';
      			  	  }
      			  	  html += '<div class="panel-collapse collapse" id="inquiry'+data[i].Num+'">';
      			  	  html += '<div class="panel-body">'+data[i].contents;
      			  	  if(data[i].answerstatus!=0) html += '<hr><p>'+data[i].answer+'</p>';
      			  	  html += '</div></div></div>';
      	    		}
      	    		  $('#inquiry>div').empty();
      	    		  $('#inquiry>div').append(html);
      	    		}
      	      });
      	}
       		
	var List = ${CategoryList};
	for (var i = 0 ; i < List.length ; i++){
		var CategoryTag = List[i];
		var Category = CategoryTag.id;
		$.ajax({
			url : '${contextPath}/Service/getServiceList',
			type : 'POST',
			data : {Category : Category},
			success : function(data) {
				for(var j =1 ; j<data.length ; j++){
					var html = '<div class="panel panel-default">';
					html += '<div class="panel-heading">';
					html += '<h4 class="panel-title font-alt">';
					html += '<a data-toggle="collapse" data-parent="#accordion"';
					html += 'href="#'+data[0]+j+'">'+data[j].title+'</a></h4></div>';
					html += '<div class="panel-collapse collapse" id="'+data[0]+j+'">';
					html += '<div class="panel-body">'+data[j].contents+'</div></div></div>';
					$('#'+data[0]+'>div').append(html);
				}
			}
		});
	}
}
function writeinquiry() {
  var html = '<button class="btn btn-block btn-round btn-b" onclick="viewinquiry()">1대1 문의내역 보기</button>';
  html += '<form action="${contextPath}/Service/writeinquiry" method="post">';
  html += '<div class="panel panel-default">';
  html += '<div class="panel-heading">';
  html += '<h4 class="panel-title font-alt"><input class="form-control" type="text" name="title" placeholder="제목"></h4></div>';
  html += '<div class="panel-body"><textarea class="form-control" rows="6" name="contents" placeholder="내용" style="resize: none;"></textarea>';
  html += '<button class="btn btn-round btn-b" style="float: right;">글쓰기</button></div></div></form>';
  $('#inquiry>div').empty();
  $('#inquiry>div').append(html);
}
function viewinquiry() {
  var id = '${user_id}';	 
      $.ajax({
    	 url : '${contextPath}/Service/getinquirylist',
    	 type : 'POST',
    	 data : {id:id},
    	 success : function(data) {
    		var html = '<button class="btn btn-block btn-round btn-b" onclick="writeinquiry()">1대1 문의하기</button>';
    		for (var i = 0; i < data.length; i++) {
		 	  html += '<div class="panel panel-default"><div class="panel-heading">';
		  	  html += '<h4 class="panel-title font-alt"><a data-toggle="collapse" data-parent="#accordion" href="#inquiry'+data[i].Num+'">'+data[i].title;
		  	  if(data[i].answerstatus==0){
		  	  	  html += '<font color="red">대기중</font></a></h4></div>';
		  	  }else{
		  		  html += '<font color="blue">답변완료</font></a></h4></div>';
		  	  }
		  	  html += '<div class="panel-collapse collapse" id="inquiry'+data[i].Num+'">';
		  	  html += '<div class="panel-body">'+data[i].contents;
		  	  if(data[i].answerstatus!=0) html += '<hr><p>'+data[i].answer+'</p>';
		  	  html += '</div></div></div>';
    		}
    		  $('#inquiry>div').empty();
    		  $('#inquiry>div').append(html);
    		}
      });
}
</script>  
</head>
<body>
<!-- 질문 -->
        <section class="module" style="padding: 70px 0;">
          <div class="container">
            <div class="row mb-60" style="margin-bottom: 0% !important;">
              <div class="col-sm-8 col-sm-offset-2">
               <h4 class="font-alt mb-0">고객센터</h4>
                <hr class="divider-w mt-10 mb-20">
                <a href="${contextPath}/Service/MoveServiceList">이용안내 관리페이지</a>
                <a href="${contextPath}/Service/MoveInquiryList">1대1문의 관리페이지</a>
                <div class="row">
                    <div class="tab-pane" id="list">
                      <div class="panel-group" id="accordion" style="padding: 0 15px;">
                      <c:forEach items="${TopQuestionsList}" var="list" varStatus="i">
                        <div class="panel panel-default">
                          <div class="panel-heading">
                            <h4 class="panel-title font-alt"><a data-toggle="collapse" data-parent="#accordion" href="#list${i.count}">${list.title}</a></h4>
                          </div>
                          <div class="panel-collapse collapse" id="list${i.count}">
                            <div class="panel-body">${list.contents}</div>
                          </div>
                        </div>
                      </c:forEach>
                      </div>
                    </div>
                  </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <div role="tabpanel">
                  <ul class="nav nav-tabs font-alt" role="tablist">
<!--                   카테고리 -->
					<li class="active"><a href="#inquiry" data-toggle="tab">1대1문의</a></li>
                    <c:forEach items="${CategoryList}" var="Category">
                    	<li><a href="#${Category}" data-toggle="tab">${Category}</a></li>
                    </c:forEach>
<!--                     카테고리 -->
                  </ul>
                  <div class="tab-content">
<!--                   1대1문의 -->
                    <div class="tab-pane active" id="inquiry">
                      <div class="panel-group" id="accordion">
                      </div>
                    </div>
<!--                     1대1문의 -->
<!--                     질문리스트 -->
                        <c:forEach items="${CategoryList}" var="Category">
                        <div class="tab-pane" id="${Category}">
	                      <div class="panel-group" id="accordion">
	                      </div>
                   		</div>
                        </c:forEach>
<!--                     질문리스트 -->
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
<!-- 질문 -->
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>