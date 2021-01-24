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
    		location.href="${contextPath}/marketBoard/marketBoardList";
		});
    	//글 삭제 버튼
    	$(".delete_btn").click(function() {
    		if (confirm("글을 삭제 하시겠습니까?") == true) {
    		var num = $(this).data("num");
    		location.href="${contextPath}/marketBoard/marketBoardDelete?num="+num;
    		} else {
    			return;
    		}
		});
    	//글 수정 버튼
    	$(".Modify_btn").click(function() {
    		var num = $(this).data("num");
    		var cate = $(this).data("cate");
    		location.href="${contextPath}/marketBoard/marketBoardModify?num="+num+"&communityname="+cate;
		});
    	
    	//댓글
    	<%@ include file="../reply/reply.jsp" %>
    	
    	//판매 상태 수정 버튼
    	$(document).on("click", ".state_btn", function() {
    		var checkresult = 0;
    		var sort = $(this).data("sort");
    		var sortnotice = "";
    		if(sort == "sell") {
    			sortnotice = "판매";
    		} else {
    			sortnotice = "구매";
    		}
    		var state = $(this).data("state");
    		var num = $(this).data("num");
    		if(state == 1) {
    			if(confirm(sortnotice+"상태를 "+sortnotice+"완료로 변경하시겠습니까?") == true) {
    				checkresult = 1;
    			} else {
    				return;
    			}
    		} else{
    			if(confirm(sortnotice+"상태를 "+sortnotice+"중으로 변경하시겠습니까?") == true) {
    				checkresult = 1;
    			} else {
    				return;
    			}
    		}
    		
    		//판매상태변경 Ajax
    		if(checkresult == 1) {
    			$.ajax({
    				url : "${contextPath}/marketBoard/dealstate",
    				type : "post",
    				data : {"state" : state,
    						"num" : num},
    				success : function(data) {
    					if(state == 1) {
    						$("#stateS").hide();
    						$("#stateI").show();
    						$(".dealshow").css("color", "red");
    						$(".dealshow").html("<b>"+sortnotice+" 완료</b>");
    					} else if(state == 0) {
    						$("#stateS").show();
    						$("#stateI").hide();
    						$(".dealshow").css("color", "blue");
    						$(".dealshow").html("<b>"+sortnotice+"중</b>");
    					}
    					
    				},
    				error : function() {
    					alert("상태변경 에러 다시 시도해주세요");
    				}
    			});
    		}
    			
		});
    	
    });    
    </script>
  </head>
  
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
    
      <div class="main">
        <section class="module-small">
          <div class="container">
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <div class="post" style="margin-bottom: 15px;">
                  <div class="post-header font-alt">
                    <h1 class="post-title">${viewList.title}</h1>
                    <div class="post-meta"> ${viewList.nickname}   | ${viewList.writedate}
                    </div>
                  </div>
                  <div class="post-entry">
                    <p>${viewList.content}</p>
                  </div>
                   <div class="row multi-columns-row">
              <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="features-item">
                  <div class="features-icon"><i class="fa fa-fw">&#xf155;</i></div>
                  <h3 class="features-title font-alt">희망가격</h3>
                  <p><b>${viewList.price}</b></p>
                </div>
              </div>
              <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="features-item">
                  <div class="features-icon"><span class="icon-phone"></span></div>
                  <h3 class="features-title font-alt">연락처</h3>
                  <c:if test="${viewList.phone ne '' || viewList.phone ne null}">
                  <p><b>${viewList.phone}</b></p>
                  </c:if>
                  <c:if test="${viewList.phone eq '' || viewList.phone eq null}">
                  <p><b>연락처 정보가 없습니다.</b></p>
                  </c:if>
                </div>
              </div>
              <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="features-item">
                  <div class="features-icon"><span class="icon-search"></span></div>
                  <c:if test="${viewList.marketcategory eq '팝니다' }">
                  <h3 class="features-title font-alt">물품상태</h3>
                  <p><b>${viewList.productstatus}</b></p>
                  </c:if>
                  <c:if test="${viewList.marketcategory eq '삽니다' }">
                  <h3 class="features-title font-alt">희망 물품상태</h3>
                  <p><b>${viewList.productstatus}</b></p>
                  </c:if>
                </div>
              </div>
              <div class="col-md-3 col-sm-6 col-xs-12">
                <div class="features-item">
                  <div class="features-icon"><i class="fa fa-fw">&#xf06b;</i></div>
                  
                  <c:if test="${viewList.marketcategory eq '팝니다' }">
                  <h3 class="features-title font-alt">판매상태</h3>
                  <c:if test="${viewList.dealstatus == 0}">
                  <p class="dealshow" style=" color: blue;"><b>판매중</b></p>
                  </c:if>
                  <c:if test="${viewList.dealstatus == 1}">
                  <p class="dealshow" style=" color: red;"><b>판매 완료</b></p>
                  </c:if>
                  </c:if>
                  
                  <c:if test="${viewList.marketcategory eq '삽니다' }">
                  <h3 class="features-title font-alt">구매상태</h3>
                  <c:if test="${viewList.dealstatus == 0}">
                  <p class="dealshow" style=" color: blue;"><b>구매중</b></p>
                  </c:if>
                  <c:if test="${viewList.dealstatus == 1}">
                  <p class="dealshow" style=" color: red;"><b>구매 완료</b></p>
                  </c:if>
                  </c:if>
                </div>
              </div>
            </div>
                </div>
                <div class="row" style="padding: 0 15px;">
               	  <button class="btn btn-border-d btn-round list_btn" type="submit" style="float: right; margin: 5px;">목록보기</button>
               	  <c:if test="${viewList.nickname == user_nickname}">
               	  	<c:if test="${viewList.marketcategory eq '팝니다' }">
               	  		<c:if test="${viewList.dealstatus == 0}">
		               	  <button class="btn btn-border-d btn-round state_btn " id="stateS" type="button" style="float: right; margin: 5px;" data-num="${viewList.num}" data-state="1" data-sort="sell">판매 완료</button>
		               	  <button class="btn btn-border-d btn-round state_btn " id="stateI" type="button" style="float: right; margin: 5px; display: none;" data-num="${viewList.num}" data-state="0" data-sort="sell">판매 등록</button>
               	  		</c:if>
               	  	<c:if test="${viewList.dealstatus == 1}">
		               	  <button class="btn btn-border-d btn-round state_btn " id="stateI" type="button" style="float: right; margin: 5px;" data-num="${viewList.num}" data-state="0" data-sort="sell">판매 등록</button>
		               	  <button class="btn btn-border-d btn-round state_btn " id="stateS" type="button" style="float: right; margin: 5px; display: none;" data-num="${viewList.num}" data-state="1" data-sort="sell">판매 완료</button>
               	  	</c:if>
               	  	</c:if>
               	  	<!-- 삽니다 페이지 -->
               	  	<c:if test="${viewList.marketcategory eq '삽니다' }">
               	  		<c:if test="${viewList.dealstatus == 0}">
		               	  <button class="btn btn-border-d btn-round state_btn " id="stateS" type="button" style="float: right; margin: 5px;" data-num="${viewList.num}" data-state="1" data-sort="buy">구매 완료</button>
		               	  <button class="btn btn-border-d btn-round state_btn " id="stateI" type="button" style="float: right; margin: 5px; display: none;" data-num="${viewList.num}" data-state="0" data-sort="buy">구매 등록</button>
               	  		</c:if>
               	  	<c:if test="${viewList.dealstatus == 1}">
		               	  <button class="btn btn-border-d btn-round state_btn " id="stateI" type="button" style="float: right; margin: 5px;" data-num="${viewList.num}" data-state="0" data-sort="buy">구매 등록</button>
		               	  <button class="btn btn-border-d btn-round state_btn " id="stateS" type="button" style="float: right; margin: 5px; display: none;" data-num="${viewList.num}" data-state="1" data-sort="buy">구매 완료</button>
               	  	</c:if>
               	  	</c:if>
               	  
                  <button class="btn btn-border-d btn-round delete_btn" type="button" style="float: right; margin: 5px;" data-num="${viewList.num}">글 삭제</button>
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
            </div>
          </div>
        </section>
        </div>
       <jsp:include page="../inc/Footer.jsp"/>
  </body>
</html>