<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
window.onload=function(){
		var img = document.createElement("img");
 		img.setAttribute("src","${contextPath}/resources/assets/images/scubaFlag.png");
		img.setAttribute("class","pointChecker");
		img.setAttribute("cursor","pointer");
 		img.style.position="absolute";
 		img.style.width="15px";
 		img.style.height="15px";
 		img.setAttribute("title",'${DivingName}'+"\n단계 :"+'${DivingRating}'+"\n수심 : "+'${DivingDepthMin}'+"m ~ "+'${DivingDepthMax}'+"m");
 		img.style.left = '${DivingXpoint}' * $('#preView>img').width()+8 + "px";
 		img.style.top = '${DivingYpoint}' * $('#preView>img').height()-7 + "px";
 		document.getElementById('preView').appendChild(img);
}
$(window).resize(function() {
	$('.pointChecker').remove();
	var img = document.createElement("img");
		img.setAttribute("src","${contextPath}/resources/assets/images/scubaFlag.png");
		img.setAttribute("class","pointChecker");
		img.setAttribute("cursor","pointer");
		img.style.position="absolute";
		img.style.width="15px";
		img.style.height="15px";
		img.setAttribute("title",'${DivingName}'+"\n단계 :"+'${DivingRating}'+"\n수심 : "+'${DivingDepthMin}'+"m ~ "+'${DivingDepthMax}'+"m");
		img.style.left = '${DivingXpoint}' * $('#preView>img').width()+8 + "px";
		img.style.top = '${DivingYpoint}' * $('#preView>img').height()-7 + "px";
		document.getElementById('preView').appendChild(img);
});
</script>
</head>
<body>
		<section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-md-8 col-lg-8" id="preView"><img src="${contextPath}/resources/upload/admin/information/City/${CityImage}" alt="Title of Image"/></div>
              <div class="col-sm-6 col-md-4 col-lg-4">
                <div class="work-details">
                  <h5 class="work-details-title font-alt">${CityName}</h5>
                  <p>${DivingExp}</p>
                  <ul>
                    <li><strong>단계: </strong><span class="font-serif"><a href="#" target="_blank">${DivingRating}</a></span>
                    </li>
                    <li><strong>수심: </strong><span class="font-serif"><a href="#" target="_blank">${DivingDepthMin}M ~ ${DivingDepthMax}M</a></span>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
                <div class="comment-form">
                  <h4 class="comment-form-title font-alt">댓글</h4>
                  <form method="post">
                    <div class="form-group">
                      <textarea class="form-control" id="comment" name="comment" rows="4" placeholder="Comment" style="resize: none;"></textarea>
                    </div>
                    <button class="btn btn-border-d btn-round" type="submit" style="float: right;">댓글쓰기</button>
                  </form>
                </div>
            <div class="comments">
                  <div class="comment clearfix">
                    <div class="comment-avatar"><img src="https://s3.amazonaws.com/uifaces/faces/twitter/ryanbattles/128.jpg" alt="avatar"/></div>
                    <div class="comment-content clearfix">
                      <div class="comment-author font-alt"><a href="#">John Doe</a></div>
                      <div class="comment-body">
                        <p>The European languages are members of the same family. Their separate existence is a myth. For science, music, sport, etc, Europe uses the same vocabulary. The European languages are members of the same family. Their separate existence is a myth.</p>
                      </div>
                      <div class="comment-meta font-alt">Today, 14:55 - <a href="#">Reply</a>
                      </div>
                    </div>
                    <div class="comment clearfix">
                      <div class="comment-avatar"><img src="https://s3.amazonaws.com/uifaces/faces/twitter/draganbabic/128.jpg" alt="avatar"/></div>
                      <div class="comment-content clearfix">
                        <div class="comment-author font-alt"><a href="#">Mark Stone</a></div>
                        <div class="comment-body">
                          <p>Europe uses the same vocabulary. The European languages are members of the same family. Their separate existence is a myth.</p>
                        </div>
                        <div class="comment-meta font-alt">Today, 15:34 - <a href="#">Reply</a>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="comment clearfix">
                    <div class="comment-avatar"><img src="https://s3.amazonaws.com/uifaces/faces/twitter/pixeliris/128.jpg" alt="avatar"/></div>
                    <div class="comment-content clearfix">
                      <div class="comment-author font-alt"><a href="#">Andy</a></div>
                      <div class="comment-body">
                        <p>The European languages are members of the same family. Their separate existence is a myth. For science, music, sport, etc, Europe uses the same vocabulary. The European languages are members of the same family. Their separate existence is a myth.</p>
                      </div>
                      <div class="comment-meta font-alt">Today, 14:59 - <a href="#">Reply</a>
                      </div>
                    </div>
                  </div>
                </div>
          </div>
        </section>
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>