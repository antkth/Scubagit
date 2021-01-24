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
    		location.href="${contextPath}/underWaterBoard/underWaterBoardList";
		});
    	
    	//글 삭제 버튼
    	$(".delete_btn").click(function() {
    		if (confirm("글을 삭제 하시겠습니까?") == true) {
    		var num = $(this).data("num");
    		location.href="${contextPath}/underWaterBoard/underWaterBoardDelete?num="+num;
    		} else {
    			return;
    		}
		});
    	
    	//글 수정 버튼
    	$(".Modify_btn").click(function() {
    		var num = $(this).data("num");
    		var cate = $(this).data("cate");
    		location.href="${contextPath}/underWaterBoard/underWaterBoardModify?num="+num+"&communityname="+cate;
		});
    	
    	//댓글
    	<%@ include file="../reply/reply.jsp" %>
    	
    });
    
    
    </script>
    
    
  </head>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
      <div class="main">
        <section class="module-small">
          <div class="container">
            <div class="row">
              <div class="col-sm-8">
                <div class="post">
                  <div class="post-header font-alt">
                    <h1 class="post-title">${viewList.title}</h1>
                    <fmt:formatDate var="writeDate" pattern="yyyy-MM-dd" value="${viewList.writedate}"/>
                    <div class="post-meta"> ${viewList.nickname}  | ${writeDate} | ${viewList.likecount}
                   	</div>
                  </div>
                  <div class="post-entry">
                    <p>${viewList.content}</p>
                    </div>
                </div>
                <div class="row" style="padding: 0 15px;">
                <script type="text/javascript">
                 	console.log("${viewList.communityname}");
                </script>
                
               	  <button class="btn btn-border-d btn-round list_btn" type="submit" style="float: right; margin: 5px;">목록보기</button>
                   <c:if test="${viewList.nickname == user_nickname}">
                  <button class="btn btn-border-d btn-round delete_btn" type="button" style="float: right; margin: 5px;" data-num="${viewList.num}" data-cate="${viewList.communityname}">글 삭제</button>
                  <button class="btn btn-border-d btn-round Modify_btn" type="button" style="float: right; margin: 5px;" data-num="${viewList.num}" data-cate="${viewList.communityname}">글 수정</button>
                  </c:if>
                </div>
                
                <!-- 댓글 입력창 -->
                <div class="comment-form" style="margin-top: 0px;">
                  <h6 class="comment-form-title font-alt">댓글</h6>
                  <form id="replyform" method="post">
                    <div class="form-group">
                      <textarea class="form-control" id="replycontent" name="content" rows="4" placeholder="댓글을 입력하세요" style="resize: none;"></textarea>
                    </div>
                    <button class="btn btn-border-d btn-round reply_btn" type="button" style="float: right;">댓글 등록</button>
                  </form>
                </div>
                <!-- 댓글 입력창 -->
                
                <!-- 댓글 리스트 -->
                <div id="repList" class="comments">
                  <div class="comment clearfix">
                  <c:forEach var="reply_list" items="${replyList}" varStatus="status">
                  <c:if test="${reply_list.status != 1}">
                  <fmt:formatDate var="wrtDate" pattern="yyyy-MM-dd" value="${reply_list.writedate}"/>
                    <div class="comment-avatar">
                    <img src="${contextPath}/resources/upload/member/${reply_list.image}" alt="avatar"/>
                    </div>
                    <div class="comment-content clearfix">
                      <div class="comment-author font-alt"><a href="javascript:;">${reply_list.nickname}</a></div>
                     <div id="replymodform${reply_list.num}">
                      <div class="comment-body">
                        <p id="repconarea${reply_list.num}">${reply_list.replycontent}</p>
                      </div>
                   	  <div id="replyform${reply_list.num}" class="comment-meta font-alt">${wrtDate} - 
                   	  <c:if test="${user_nickname == reply_list.nickname}">
                   	  	<a class="replymodify" href="javascript:;" data-sort="0" data-groupnum="${reply_list.num}" data-num="${reply_list.num}">수정</a> ㅣ <a class="replydelete_btn" href="javascript:;"  data-sort="0" data-groupnum="${reply_list.num}" data-num="${reply_list.num}">삭제</a> ㅣ
                   	  </c:if>
                   	  <a class="reply" href="javascript:;" data-wrdate="${wrtDate}" data-groupnum="${reply_list.num}" data-sort='0' data-num="${reply_list.num}">
                   	  	   댓글
                   	  </a>
                      </div>
                     </div>
                     
                     <!-- 대댓글 리스트 보기 -->
                      <c:forEach var="reList" items="${rereplyList}">
                       <c:if test="${reList.status != 1}">
                      	<c:if test="${reply_list.num == reList.replygroup_num}">
                      		<c:set var="thereis" value="1"/>
                      	</c:if>
                       </c:if>
                      </c:forEach>
                      <c:if test="${thereis >= 1}">
                      	<a href="javascript:;" class="listshow" id="listshow${reply_list.num}" data-repnum="${reply_list.num}">
                      		댓글 보기
                      	</a>
                      	<c:set var="thereis" value="0"/>
                      </c:if>
                      <!-- 대댓글 리스트 보기 -->
                    </div>
                   <c:forEach var="rereplyList_list2" items="${rereplyList}">
                   <fmt:formatDate var="wrtDate2" pattern="yyyy-MM-dd" value="${rereplyList_list2.writedate}"/>
                   <c:if test="${rereplyList_list2.status != 1}">
                   <c:if test="${reply_list.num == rereplyList_list2.replygroup_num}">
                    <div class="comment clearfix rep2${reply_list.num}" style="display: none;">
                      <div class="comment-avatar">
                      <img src="${contextPath}/resources/upload/member/${rereplyList_list2.image}" alt="avatar"/>
                      </div>
                      <div class="comment-content clearfix">
                        <div class="comment-author font-alt"><a href="javascript:;">${rereplyList_list2.nickname}</a></div>
                       <div id="replymodform${rereplyList_list2.num}">
                        <div class="comment-body">
                          <p id="repconarea${rereplyList_list2.num}">${rereplyList_list2.replycontent}</p>
                        </div>
                        <div id="rereplyform${rereplyList_list2.num}" class="comment-meta font-alt">${wrtDate2} - 
                        <c:if test="${user_nickname == reply_list.nickname}">
                   	  		<a class="replymodify" href="javascript:;" data-sort="1" data-groupnum="${reply_list.num}" data-num="${rereplyList_list2.num}">수정</a> ㅣ <a class="replydelete_btn" href="javascript:;"  data-sort="1" data-groupnum="${reply_list.num}" data-num="${rereplyList_list2.num}">삭제</a> ㅣ
                   	    </c:if>
                   	  	<a class="reply" href="javascript:;" data-nname="${rereplyList_list2.nickname}"  data-groupnum="${reply_list.num}" data-sort='1' data-num="${rereplyList_list2.num}">
                   	  	 	댓글 <!-- 대댓글 -->
                   	    </a>
                        </div>
                       </div>
                      </div>
                    </div>
                    </c:if>
                   </c:if>
                   </c:forEach>
                   </c:if>
                   </c:forEach>
               </div>
              </div>
              <!-- 댓글 리스트 -->
              
              </div>
              <div class="col-sm-4 col-md-3 col-md-offset-1 sidebar">
                <div class="widget">
                  <h5 class="widget-title font-alt">해당 스쿠버의 다른글</h5>
                  <ul class="widget-posts">
                    <li class="clearfix">
                      <div class="widget-posts-image"><a href="#"><img src="${contextPath}/resources/assets/images/rp-1.jpg" alt="Post Thumbnail"/></a></div>
                      <div class="widget-posts-body">
                        <div class="widget-posts-title"><a href="#">Designer Desk Essentials</a></div>
                        <div class="widget-posts-meta">23 january</div>
                      </div>
                    </li>
                    <li class="clearfix">
                      <div class="widget-posts-image"><a href="#"><img src="${contextPath}/resources/assets/images/rp-2.jpg" alt="Post Thumbnail"/></a></div>
                      <div class="widget-posts-body">
                        <div class="widget-posts-title"><a href="#">Realistic Business Card Mockup</a></div>
                        <div class="widget-posts-meta">15 February</div>
                      </div>
                    </li>
                    <li class="clearfix">
                      <div class="widget-posts-image"><a href="#"><img src="${contextPath}/resources/assets/images/rp-3.jpg" alt="Post Thumbnail"/></a></div>
                      <div class="widget-posts-body">
                        <div class="widget-posts-title"><a href="#">Eco bag Mockup</a></div>
                        <div class="widget-posts-meta">21 February</div>
                      </div>
                    </li>
                    <li class="clearfix">
                      <div class="widget-posts-image"><a href="#"><img src="${contextPath}/resources/assets/images/rp-4.jpg" alt="Post Thumbnail"/></a></div>
                      <div class="widget-posts-body">
                        <div class="widget-posts-title"><a href="#">Bottle Mockup</a></div>
                        <div class="widget-posts-meta">2 March</div>
                      </div>
                    </li>
                  </ul>
                </div>
                <div class="widget">
                  <h5 class="widget-title font-alt">해쉬 태그(검색 용도)</h5>
                  <div class="tags font-serif"><a href="#" rel="tag">Blog</a><a href="#" rel="tag">Photo</a><a href="#" rel="tag">Video</a><a href="#" rel="tag">Image</a><a href="#" rel="tag">Minimal</a><a href="#" rel="tag">Post</a><a href="#" rel="tag">Theme</a><a href="#" rel="tag">Ideas</a><a href="#" rel="tag">Tags</a><a href="#" rel="tag">Bootstrap</a><a href="#" rel="tag">Popular</a><a href="#" rel="tag">English</a>
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