<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/Top.jsp"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <title>Titan | Multipurpose HTML5 Template</title>
    
    <script type="text/javascript">
    $(document).ready(function(){
    	//목록 버튼
    	$(".list_btn").click(function() {
    		location.href="${contextPath}/jobSearchBoard/jobSearchBoardList";
		});
    	//글 삭제 버튼
    	$(".delete_btn").click(function() {
    		
    		if (confirm("글을 삭제 하시겠습니까?") == true) {
    		var num = $(this).data("num");
    		location.href="${contextPath}/jobSearchBoard/jobSearchBoardDelete?num="+num;
    		} else {
    			return;
    		}
		});
    	
    	//글 수정 버튼
    	$(".Modify_btn").click(function() {
    		var num = $(this).data("num");
    		var cate = $(this).data("cate");
    		location.href="${contextPath}/jobSearchBoard/jobSearchBoardModify?num="+num+"&communityname="+cate;
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
              <div class="col-sm-8 col-sm-offset-2">
                <div class="post">
                  <div class="post-header font-alt">
                    <h1 class="post-title">${viewList.title}</h1>
                    <div class="post-meta"> ${viewList.nickname}  | ${viewList.writedate} | ${viewList.likecount}
                    </div>
                  </div>
                  <div class="post-entry">
                    <p>${viewList.content}</p>
                    </div>
                </div>
                <div class="row">
               	  <button class="btn btn-border-d btn-round list_btn" type="submit" style="float: right; margin: 5px;">목록보기</button>
               	  <c:if test="${viewList.nickname == user_nickname}">
                  <button class="btn btn-border-d btn-round delete_btn" type="submit" style="float: right; margin: 5px;" data-num="${viewList.num}">글 삭제</button>
                  <button class="btn btn-border-d btn-round Modify_btn" type="submit" style="float: right; margin: 5px;" data-num="${viewList.num}" data-cate="${viewList.communityname}">글 수정</button>
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
            </div>
          </div>
        </section>
        </div>
       <jsp:include page="../inc/Footer.jsp"/>
  </body>
</html>