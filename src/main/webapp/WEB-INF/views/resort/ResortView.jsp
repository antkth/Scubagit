<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리조트 상세보기</title>
<script type="text/javascript">
function changeStatus() {
	var num = '${resortVO.num}';
	var status = $('#status option:selected').val();
	$.ajax({
		url:'${contextPath}/Resort/changeResortStatusView',
		type:'POST',
		data:{num:num,status:status},
		success: function () {
		}
	});
}
function reviewWrite() {
	var grade = $("#grade option:selected").val();
	$.ajax({
		url:'${contextPath}/Resort/reviewCheck',
		type:'POST',
		data: {num:'${resortVO.num}' , nickName : '${user_nickname}'},
		success: function (data) {
	if(grade == 0){
		alert("별점을 선택해주세요 . ");
	}else if($('#contents').val()==""){
		alert("내용을 입력 해주세요 .");
	}else if(data==1){
		alert("이미 리뷰를 등록하셧습니다.");
	}else{
		$('#form').submit();
	}
		}
	});
}
</script>
</head>
<body>
<!-- 관리자 , 작성자 일때 버튼 보이기 , 출입 가능 하기 설정 해야함. -->
<!-- 리조트 정보 -->
        <section class="module-small">
          <div class="container">
            <div class="row"> 
              <div class="col-sm-8">
                <div class="post">
					<div class="post-images-slider" style="height: 600px;">
	                  <ul class="slides">
	                    <li><img class="center-block" src="${contextPath}/resources/images/Resort/thumbnail/${resortVO.num}/${resortVO.image1}"/></li>
						<c:if test="${resortVO.image2 != null && resortVO.image2 != ''}">
						<li><img class="center-block" src="${contextPath}/resources/images/Resort/thumbnail/${resortVO.num}/${resortVO.image2}"/></li>
						</c:if>
						<c:if test="${resortVO.image3 != null && resortVO.image3 != ''}">
						<li><img class="center-block" src="${contextPath}/resources/images/Resort/thumbnail/${resortVO.num}/${resortVO.image3}"/></li>
						</c:if>
	                  </ul>
                	</div>                 
                	<div class="post-header font-alt">
                    <h1 class="post-title">${resortVO.resortName}</h1>
                    <div class="post-meta">${resortVO.nickName}| ${resortVO.enterDate} | ♥ 개수 
                    </div>
                  </div>
                  <div class="post-entry">
                    <p>${resortVO.contents}</p>
                  </div>
                </div>
                <div class="row">
                  <select onchange="changeStatus()" id="status" style="float: right; margin: 5px; height: 33px;">
                  	<c:choose>
                  		<c:when test="${resortVO.resortStatus==0}">
                  			<option selected="selected" value="0">비활성</option>
                  			<option value="1">활성</option>
                  			<option value="2">삭제</option>
                  		</c:when>
                  		<c:when test="${resortVO.resortStatus==1}">
                  			<option value="0">비활성</option>
                  			<option selected="selected" value="1">활성</option>
                  			<option value="2">삭제</option>
                  		</c:when>
						<c:otherwise>
							<option value="0">비활성</option>
                  			<option value="1">활성</option>
                  			<option selected="selected" value="2">삭제</option>
						</c:otherwise>                  		
                  	</c:choose>
                  </select>
               	  <button class="btn btn-border-d btn-round" type="button" style="float: right; margin: 5px;">목록보기</button>
                  <button class="btn btn-border-d btn-round" type="button" onclick="location.href='${contextPath}/Resort/delResort?num=${resortVO.num}'" style="float: right; margin: 5px;">글 삭제</button>
                  <button class="btn btn-border-d btn-round" type="button" onclick="location.href='${contextPath}/Resort/moveResortMod?num=${resortVO.num}'" style="float: right; margin: 5px;">글 수정</button>
                </div>
              </div>
<!--               위 ( 이미지 , 설명 ) // 아래 ( 사이드바 ) -->
              <div class="col-sm-4 col-md-3 col-md-offset-1 sidebar">
                <div class="widget">
                  <h5 class="widget-title font-alt">근처의 다른 숖(파워광고)</h5>
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
                  <h5 class="widget-title font-alt">해쉬태그</h5>
                  <div class="tags font-serif">
                  ${resortVO.tag}
                  </div>
                </div> <br><br><br>
              </div>
            </div>
          </div>
<!--         리조트 정보 , 리뷰 , 인삿말 -->
          <div class="container" style="margin-top: -140px;">
            <div class="row mt-70">
              <div class="col-sm-12">
                <ul class="nav nav-tabs font-alt" role="tablist">
                  <li class="active"><a href="#description" data-toggle="tab"><span class="icon-tools-2"></span>인사말</a></li>
                  <li><a href="#data-sheet" data-toggle="tab"><span class="icon-tools-2"></span>리조트정보</a></li>
                  <li><a href="#reviews" data-toggle="tab"><span class="icon-tools-2"></span>리뷰(갯수)</a></li>
                </ul>
                <div class="tab-content">
                  <div class="tab-pane active" id="description">
					<p>${resortVO.simpleIntroduce}</p>
                  </div>
                  <div class="tab-pane" id="data-sheet">
                    <table class="table table-striped ds-table table-responsive">
                      <tbody>
                        <tr>
                          <th width="20%">리조트 이름</th>
                          <td colspan="3">${resortVO.resortName}</td>
                        </tr>
                        <tr>
                          <th>주소</th>
                          <td>${resortVO.homepageAddress}</td>
                          <th>휴대폰</th>
                          <td>${resortVO.phoneNumber}</td>
                        </tr>
                        <tr>
                          <th>홈페이지 주소</th>
                          <td >${resortVO.homepageAddress}</td>
                          <th><img src="${contextPath}/resources/assets/images/kakaoIcon.png" width="19px" alt="kakaoIcon"></th>
                          <td>${resortVO.cacaoId}</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <div class="tab-pane" id="reviews">
                    <div class="comments reviews" style="margin-top: -3%;">
                    <div class="comment-form mt-30">
                      <form id="form" method="post" action="${contextPath}/Resort/ReviewsWrite">
                      <input type="hidden" name="num" value="${resortVO.num}">
                        <div class="row">
                          <div class="col-sm-2" style="float: right;">
                            <div class="form-group" style="width: 132.5px; float: right;">
                              <select class="form-control" id="grade" name="grade">
                                <option selected="selected" disabled="disabled" value="0">별점</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                                <option value="5">5</option>
                              </select>
                            </div>
                          </div>
                          </div>
                          <div class="row">
                          <div class="col-sm-12">
                            <div class="form-group">
                              <textarea class="form-control" id="contents" name="contents" rows="4" placeholder="Review" style="resize: none;"></textarea>
                            </div>
                          </div>
                          <div class="col-sm-12">
                            <button class="btn btn-border-d btn-round" type="button" onclick="reviewWrite()" style="float: right;">댓글 등록</button>
                          </div>
                        </div>
                      </form>
                    </div>
                    
                    <c:forEach items="${reviews}" var="review">
                   	  <div class="comment clearfix">
                        <div class="comment-avatar"><img src="${contextPath}/resources/upload/member/${review.image1}"/></div>
                        <div class="comment-content clearfix">
                          <div class="comment-author font-alt">${review.nickName}
                          <c:if test="${review.nickName == user_nickname }">
                          <a href="${contextPath}/Resort/delReviews?num=${resortVO.num}" style="color: red; float: right;">삭제</a>
                          </c:if>
                          </div>
                          <div class="comment-body">
                            <p>${review.contents}</p>
                          </div>
                          <div class="comment-meta font-alt">${review.enterDate} -
                          <c:forEach begin="1" end="5" var="i">
							<c:choose>
								<c:when test="${i<=review.grade}">
									<span><i class="fa fa-star star"></i></span>
								</c:when>
								<c:otherwise>
									<span><i class="fa fa-star star-off"></i></span>
								</c:otherwise>
							</c:choose>
                          </c:forEach>
                          </div>
                        </div>
                     </div>
                    </c:forEach>
                    </div>
                    
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
<!--         리조트 정보 -->
<!--         다른 샾 -->
		        <hr class="divider-w">
        <section class="module" style="padding-top: 0px;">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <div class="module-subtitle font-serif">같은 지역의 다른 리조트</div>
              </div>
            </div>
            <div class="row">
              <div class="owl-carousel text-center" data-items="5" data-pagination="false" data-navigation="false">
                <div class="owl-item">
                  <div class="col-sm-12">
                    <div class="ex-product"><a href="#"><img src="${contextPath}/resources/assets/images/shop/product-1.jpg" alt="Leather belt"/></a>
                      <h4 class="shop-item-title font-alt"><a href="#">Leather belt</a></h4>
                    </div>
                  </div>
                </div>
                <div class="owl-item">
                  <div class="col-sm-12">
                    <div class="ex-product"><a href="#"><img src="${contextPath}/resources/assets/images/shop/product-3.jpg" alt="Derby shoes"/></a>
                      <h4 class="shop-item-title font-alt"><a href="#">Derby shoes</a></h4>
                    </div>
                  </div>
                </div>
                <div class="owl-item">
                  <div class="col-sm-12">
                    <div class="ex-product"><a href="#"><img src="${contextPath}/resources/assets/images/shop/product-2.jpg" alt="Leather belt"/></a>
                      <h4 class="shop-item-title font-alt"><a href="#">Leather belt</a></h4>
                    </div>
                  </div>
                </div>
                <div class="owl-item">
                  <div class="col-sm-12">
                    <div class="ex-product"><a href="#"><img src="${contextPath}/resources/assets/images/shop/product-4.jpg" alt="Leather belt"/></a>
                      <h4 class="shop-item-title font-alt"><a href="#">Leather belt</a></h4>
                    </div>
                  </div>
                </div>
                <div class="owl-item">
                  <div class="col-sm-12">
                    <div class="ex-product"><a href="#"><img src="${contextPath}/resources/assets/images/shop/product-5.jpg" alt="Chelsea boots"/></a>
                      <h4 class="shop-item-title font-alt"><a href="#">Chelsea boots</a></h4>
                    </div>
                  </div>
                </div>
                <div class="owl-item">
                  <div class="col-sm-12">
                    <div class="ex-product"><a href="#"><img src="${contextPath}/resources/assets/images/shop/product-6.jpg" alt="Leather belt"/></a>
                      <h4 class="shop-item-title font-alt"><a href="#">Leather belt</a></h4>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>
<!-- 		다른 샾 -->
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>