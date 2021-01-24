<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <title>Titan | Multipurpose HTML5 Template</title>
    
   <script type="text/javascript">
    $(document).ready(function(){
    	//목록 버튼
    	$(".list_btn").click(function() {
    		location.href="${contextPath}/Event/moveEventList?nowpage=${nowpage}";
		});
    	//글 삭제 버튼
    	$(".delete_btn").click(function() {
    		if (confirm("글을 삭제 하시겠습니까?") == true) {
    		var num = $(this).data("num");
    		location.href="${contextPath}/Event/EventBoardDelete?num="+num;
    		} else {
    			return;
    		}
		});
    	//글 수정 버튼
    	$(".Modify_btn").click(function() {
    		var num = $(this).data("num");
    		var cate = $(this).data("cate");
    		location.href="${contextPath}/Event/EventBoardModify?num="+num+"&communityname="+cate;
		});
    	
    });    
    </script>
  </head>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
      <div class="main">
        <section class="module-small">
          <div class="container">
            <div class="row">
              <div class="col-sm-12">
                <div class="post">
                  <div class="post-header font-alt">
                    <h1 class="post-title">${viewList.title}</h1>
                    <div class="post-meta">${viewList.nickname} | ${viewList.writeDate}
                   </div>
                  </div>
                  <div class="post-entry">
                    <p>${viewList.content}</p>
                    </div>
                </div>
                <div class="row" style="padding: 0 15px;"> 
                  <button class="btn btn-border-d btn-round list_btn" type="submit" style="float: right; margin: 5px;">목록보기</button>
                  <button class="btn btn-border-d btn-round delete_btn" type="submit" style="float: right; margin: 5px;" data-num="${viewList.num}">글 삭제</button>
                  <button class="btn btn-border-d btn-round Modify_btn" type="submit" style="float: right; margin: 5px;" data-num="${viewList.num}" data-cate="${viewList.communityname}">글 수정</button>
                </div>
                                <!-- 댓글 입력창 -->
                <div class="comment-form" style="margin-top: 0px;">
                  <h6 class="comment-form-title font-alt">댓글</h6>
                  <form method="post">
                    <div class="form-group">
                      <textarea class="form-control" id="comment" name="comment" rows="4" placeholder="댓글을 입력하세요" style="resize: none;"></textarea>
                    </div>
                    <button class="btn btn-border-d btn-round" type="submit" style="float: right;">댓글 등록</button>
                  </form>
                </div>
                <!-- 댓글 입력창 -->
                <div class="comments">
                  <div class="comment clearfix">
                    <div class="comment-avatar"><img src="https://s3.amazonaws.com/uifaces/faces/twitter/ryanbattles/128.jpg" alt="avatar"/></div>
                    <div class="comment-content clearfix">
                      <div class="comment-author font-alt"><a href="#">John Doe</a></div>
                      <div class="comment-body">
                        <p style="margin-bottom: 5px;">The European languages are members of the same family. Their separate existence is a myth. For science, music, sport, etc, Europe uses the same vocabulary. The European languages are members of the same family. Their separate existence is a myth.</p>
                      </div>
                      <div class="comment-meta font-alt">Today, 14:55 - <a href="#">Reply</a>
                      </div>
                    </div>
                   
                  </div>
                  <div class="comment clearfix">
                    <div class="comment-avatar"><img src="https://s3.amazonaws.com/uifaces/faces/twitter/pixeliris/128.jpg" alt="avatar"/></div>
                    <div class="comment-content clearfix">
                      <div class="comment-author font-alt"><a href="#">Andy</a></div>
                      <div class="comment-body">
                        <p style="margin-bottom: 5px;">The European languages are members of the same family. Their separate existence is a myth. For science, music, sport, etc, Europe uses the same vocabulary. The European languages are members of the same family. Their separate existence is a myth.</p>
                      </div>
                      <div class="comment-meta font-alt">Today, 14:59 - <a href="#">Reply</a>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
        </div>
       <jsp:include page="../inc/Footer.jsp"/>
  </body>
</html>