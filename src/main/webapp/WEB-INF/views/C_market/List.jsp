<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/Top.jsp"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <title>Titan | Multipurpose HTML5 Template</title>
    <script type="text/javascript">
    
    //서치박스 값 확인 후 해당 서치박스 name설정
    window.onload = function() {
		var searchval = $(".serachselect > option:selected").val();
		if(searchval == '팝니다') {
			$(".searchbox").attr("name", "search1");
		} else if(searchval == '삽니다') {
			$(".searchbox").attr("name", "search2");
		} else {
			$(".searchbox").attr("name", "search1");
		}
	}    
    
    	$(document).ready(function() {
			
    		//글쓰기 페이지 이동
    		$(".wrt_btn").click(function() {
				location.href="${contextPath}/marketBoard/marketBoardWrite"
			});
    		
    		//상세글 보기위해 글 번호 전달
	    	$(".title_btn").click(function() {
				var num = $(this).data("num");
				location.href="${contextPath}/marketBoard/marketBoardView?num="+num;
			});
    		
	    	//검색 기능
	    	$(".sbutton").click(function() {
	    		alert("와쓰");
	    		var search = $(".search").val();
	    		$("#sform").attr("action", "${contextPath}/marketBoard/marketBoardList");
				$("#sform").submit();
			});	
	    	
	    	//팝니다/삽니다 검색값 구별
	    	$(".serachselect").change(function() {
				var searchval = $(".serachselect > option:selected").val();
				if(searchval == '팝니다') {
					$(".searchbox").attr("name", "search1");
				} else if(searchval == '삽니다') {
					$(".searchbox").attr("name", "search2");
				} else {
					$(".searchbox").attr("name", "search1");
				}
			});
    		
		});
    </script>
    
  </head>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
      <div class="main">
        <section class="module">
          <div class="container">
          	<div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <form role="form" id="sform">
	              <h1 class="module-title font-alt" style="margin-bottom: 5%">중고장터 게시판</h1>
	              <select class="form-control serachselect" name="searchsort" style="width: 25%; float: left;">
	                 <c:choose>
	                	<c:when test="${map.searchsort == '팝니다' }">
	                 	<option value="팝니다" selected="selected">팝니다</option>
	                  	<option value="삽니다" >삽니다</option>
	                 </c:when>
	                 <c:when test="${map.searchsort == '삽니다' }">
	                 	<option value="팝니다" >팝니다</option>
	                  	<option value="삽니다" selected="selected">삽니다</option>
	                 </c:when>
	                 <c:otherwise>
	                 	<option value="팝니다" selected="selected">팝니다</option>
	                  	<option value="삽니다" >삽니다</option>
	                 </c:otherwise>
	                </c:choose>
	              </select>
	                  <div class="search-box" style="float: left; width: 75%;">
	                    <input class="form-control searchbox" name="search1" type="text" placeholder="Search..."/>
	                    <button class="search-btn sbutton" type="button"><i class="fa fa-search"></i></button>
	                  </div>
                </form>
              </div>
            </div>
            <div class="row" style="float: right; margin: 10px 0;">
            	<button class="btn btn-border-d btn-round wrt_btn">글쓰기</button>
            </div>
            <div class="row" style="clear: both;">
            
          <!-- 카테고리 시작 -->
          <div class="col-sm-12">
          <c:if test="${map.searchsort == '팝니다' || map.searchsort == ''}">
            <div role="tabpanel">
                  <ul class="nav nav-tabs font-alt" role="tablist">
                    <li class="active"><a href="#sell" data-toggle="tab"><i class="fa fa-fw">&#xf155;</i>팝니다</a></li>
                    <li><a href="#buy" data-toggle="tab"><i class="fa fa-fw">&#xf032;</i>삽니다</a></li>
                    <li><a href="#read" data-toggle="tab"><i class="fa fa-fw">&#xf0e3;</i><font color="red">필독사항</font></a></li>
                  </ul>
             <div class="tab-content">
             <!-- 팝니다 카테고리 -->   
               <div class="tab-pane active" id="sell">
                <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr>
                      <th class="hidden-xs" width="7%">글번호</th>
                      <th width="10%">판매 상태</th>
                      <th width="41%">제목</th>
                      <th class="hidden-xs" width="8%">작성자</th>
                      <th width="12%">작성일</th>
                      <th width="12%">희망가격</th>
                      <th width="10%">상태</th>
                    </tr>
                    
                    <!-- 글 리스트 -->
                    <c:forEach var="list" items="${map.marketBoardList1}">
                    <tr>
                      <td class="hidden-xs">${list.num}</td>
                      <td>
                      	<c:if test="${list.dealstatus == 0}">
                        <h5 class="product-title font-alt" style="color: blue;">판매중</h5>
                        </c:if>
                        <c:if test="${list.dealstatus == 1}">
                        <h5 class="product-title font-alt" style="color: red;">판매 완료</h5>
                        </c:if>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt"><a href="javascript:;" class="title_btn" data-num="${list.num}">${list.title}</a></h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.nickname}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.writedate}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.price}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.productstatus}</h5>
                      </td>
                    </tr>
                    </c:forEach>
                  </tbody>
                </table>
               	   <!-- 페이징 -->
             		<div class="col-sm-12" style="text-align: center;">
                		 <div class="pagination font-alt" id="pagelist">
			                <c:if test="${map.paging1.blockfirst!=1}">
			                <a href="${contextPath}/marketBoard/marketBoardList?nowpage1=${map.paging1.blockfirst-1}&search1=${map.search1}&sort=${map.sort}&searchsort=팝니다"><i class="fa fa-angle-left page" data-num="${map.paging1.blockfirst-1}"></i></a>
			                </c:if>
			                <c:forEach begin="${map.paging1.blockfirst}" end="${map.paging1.blocklast}" var="i">
			                <c:if test="${map.paging1.nowpage == i }">
			                <a class="active page pagenum" style="background: #cdebfa;" href="${contextPath}/marketBoard/marketBoardList?nowpage1=${i}&search1=${map.search1}&sort=${map.sort}&searchsort=팝니다" data-now="${map.paging1.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                <c:if test="${map.paging1.nowpage != i }">
			                <a class="active page pagenum" href="${contextPath}/marketBoard/marketBoardList?nowpage1=${i}&search1=${map.search1}&sort=${map.sort}&searchsort=팝니다" data-now="${map.paging1.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                </c:forEach>
			                <c:if test="${map.paging1.blocklast != map.paging1.totalpage}">
			                <a href="${contextPath}/marketBoard/marketBoardList?nowpage1=${map.paging1.blocklast+1}&search1=${map.search1}&sort=${map.sort}&searchsort=팝니다"><i class="fa fa-angle-right page" data-num="${map.paging1.blocklast+1}"></i></a>
			                </c:if>
			               </div>
                	</div>
                	<!-- 페이징 -->
                    </div>
              <!-- 팝니다 카테고리 --> 
              
               <!--삽니다 카테고리 -->       
              <div class="tab-pane" id="buy">
                <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr>
                      <th class="hidden-xs" width="7%">글번호</th>
                      <th width="10%">판매 상태</th>
                      <th width="41%">제목</th>
                      <th class="hidden-xs" width="10%">작성자</th>
                      <th width="15%">작성일</th>
                      <th width="12%">희망가격</th>
                      <th width="17%">상태</th>
                    </tr>
                    <c:forEach var="list" items="${map.marketBoardList2}">
                    <fmt:formatDate var="writeDate" value="${list.writedate}"/>
                    <tr>
                      <td class="hidden-xs">${list.num}</td>
                      <td>
                      	<c:if test="${list.dealstatus == 0}">
                        <h5 class="product-title font-alt" style="color: blue;">구매중</h5>
                        </c:if>
                        <c:if test="${list.dealstatus == 1}">
                        <h5 class="product-title font-alt" style="color: red;">구매 완료</h5>
                        </c:if>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt"><a href="javascript:;" class="title_btn" data-num="${list.num}">${list.title}</a></h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.nickname}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${writeDate}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.price}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.productstatus}</h5>
                      </td>
                    </tr>
                    </c:forEach>
                  </tbody>
                </table>
             	   <!-- 페이징 -->
             		<div class="col-sm-12" style="text-align: center;">
                		 <div class="pagination font-alt" id="pagelist">
			                <c:if test="${map.paging2.blockfirst!=1}">
			                <a href="${contextPath}/marketBoard/marketBoardList?nowpage2=${map.paging2.blockfirst-1}&search2=${map.search2}&sort=${map.sort}&searchsort=삽니다"><i class="fa fa-angle-left page" data-num="${map.paging2.blockfirst-1}"></i></a>
			                </c:if>
			                <c:forEach begin="${map.paging2.blockfirst}" end="${map.paging2.blocklast}" var="i">
			                <c:if test="${map.paging2.nowpage == i }">
			                <a class="active page pagenum" style="background: #cdebfa;" href="${contextPath}/marketBoard/marketBoardList?nowpage2=${i}&search2=${map.search2}&sort=${map.sort}&searchsort=삽니다" data-now="${map.paging2.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                <c:if test="${map.paging2.nowpage != i }">
			                <a class="active page pagenum" href="${contextPath}/marketBoard/marketBoardList?nowpage2=${i}&search2=${map.search2}&sort=${map.sort}&searchsort=삽니다" data-now="${map.paging2.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                </c:forEach>
			                <c:if test="${map.paging2.blocklast != map.paging2.totalpage}">
			                <a href="${contextPath}/marketBoard/marketBoardList?nowpage2=${map.paging2.blocklast+1}&search2=${map.search2}&sort=${map.sort}&searchsort=삽니다"><i class="fa fa-angle-right page" data-num="${map.paging2.blocklast+1}"></i></a>
			                </c:if>
			               </div>
                	</div>
                	<!-- 페이징 -->
                    </div>
               <!-- 삽니다 카테고리 --> 
                    <div class="tab-pane" id="read" style="font-size: 100px;">
                    <p><b>단디 팔고 단디 사라</b></p>
                    </div>
                  </div>
                </div>
                </c:if>
                
            <!-- 정렬기준값이 삽니다일 때 -->
            <c:if test="${map.searchsort == '삽니다'}">
            <div role="tabpanel">
                  <ul class="nav nav-tabs font-alt" role="tablist">
                    <li ><a href="#sell" data-toggle="tab" class="sell"><i class="fa fa-fw">&#xf155;</i>팝니다</a></li>
                    <li class="active"><a href="#buy" data-toggle="tab" class="buy"><i class="fa fa-fw">&#xf032;</i>삽니다</a></li>
                    <li><a href="#read" data-toggle="tab"><i class="fa fa-fw">&#xf0e3;</i><font color="red">필독사항</font></a></li>
                  </ul>
             <div class="tab-content">
             <!-- 팝니다 카테고리 -->   
               <div class="tab-pane" id="sell">
                <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr>
                      <th class="hidden-xs" width="7%">글번호</th>
                      <th width="10%">판매 상태</th>
                      <th width="41%">제목</th>
                      <th class="hidden-xs" width="8%">작성자</th>
                      <th width="12%">작성일</th>
                      <th width="12%">희망가격</th>
                      <th width="10%">상태</th>
                    </tr>
                    
                    <!-- 글 리스트 -->
                    <c:forEach var="list" items="${map.marketBoardList1}">
                    <tr>
                      <td class="hidden-xs">${list.num}</td>
                      <td>
                      	<c:if test="${list.dealstatus == 0}">
                        <h5 class="product-title font-alt" style="color: blue;">판매중</h5>
                        </c:if>
                        <c:if test="${list.dealstatus == 1}">
                        <h5 class="product-title font-alt" style="color: red;">판매 완료</h5>
                        </c:if>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt"><a href="javascript:;" class="title_btn" data-num="${list.num}">${list.title}</a></h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.nickname}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.writedate}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.price}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.productstatus}</h5>
                      </td>
                    </tr>
                    </c:forEach>
                  </tbody>
                </table>
               	   <!-- 페이징 -->
             		<div class="col-sm-12" style="text-align: center;">
                		 <div class="pagination font-alt" id="pagelist">
			                <c:if test="${map.paging1.blockfirst!=1}">
			                <a href="${contextPath}/marketBoard/marketBoardList?nowpage1=${map.paging1.blockfirst-1}&search1=${map.search1}&sort=${map.sort}&searchsort=팝니다"><i class="fa fa-angle-left page" data-num="${map.paging1.blockfirst-1}"></i></a>
			                </c:if>
			                <c:forEach begin="${map.paging1.blockfirst}" end="${map.paging1.blocklast}" var="i">
			                <c:if test="${map.paging1.nowpage == i }">
			                <a class="active page pagenum" style="background: #cdebfa;" href="${contextPath}/marketBoard/marketBoardList?nowpage1=${i}&search1=${map.search1}&sort=${map.sort}&searchsort=팝니다" data-now="${map.paging1.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                <c:if test="${map.paging1.nowpage != i }">
			                <a class="active page pagenum" href="${contextPath}/marketBoard/marketBoardList?nowpage1=${i}&search1=${map.search1}&sort=${map.sort}&searchsort=팝니다" data-now="${map.paging1.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                </c:forEach>
			                <c:if test="${map.paging1.blocklast != map.paging1.totalpage}">
			                <a href="${contextPath}/marketBoard/marketBoardList?nowpage1=${map.paging1.blocklast+1}&search1=${map.search1}&sort=${map.sort}&searchsort=팝니다"><i class="fa fa-angle-right page" data-num="${map.paging1.blocklast+1}"></i></a>
			                </c:if>
			               </div>
                	</div>
                   <!-- 페이징 -->
                    </div>
              <!-- 팝니다 카테고리 --> 
              
               <!--삽니다 카테고리 -->       
              <div class="tab-pane active" id="buy">
                <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr>
                      <th class="hidden-xs" width="7%">글번호</th>
                      <th width="10%">판매 상태</th>
                      <th width="41%">제목</th>
                      <th class="hidden-xs" width="10%">작성자</th>
                      <th width="15%">작성일</th>
                      <th width="12%">희망가격</th>
                      <th width="17%">상태</th>
                    </tr>
                    <c:forEach var="list" items="${map.marketBoardList2}">
                    <fmt:formatDate var="writeDate" value="${list.writedate}"/>
                    <tr>
                      <td class="hidden-xs">${list.num}</td>
                      <td>
                      	<c:if test="${list.dealstatus == 0}">
                        <h5 class="product-title font-alt" style="color: blue;">구매중</h5>
                        </c:if>
                        <c:if test="${list.dealstatus == 1}">
                        <h5 class="product-title font-alt" style="color: red;">구매 완료</h5>
                        </c:if>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt"><a href="javascript:;" class="title_btn" data-num="${list.num}">${list.title}</a></h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.nickname}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${writeDate}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.price}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.productstatus}</h5>
                      </td>
                    </tr>
                    </c:forEach>
                  </tbody>
                </table>
             	   <!-- 페이징 -->
             		<div class="col-sm-12" style="text-align: center;">
                		 <div class="pagination font-alt" id="pagelist">
			                <c:if test="${map.paging2.blockfirst!=1}">
			                <a href="${contextPath}/marketBoard/marketBoardList?nowpage2=${map.paging2.blockfirst-1}&search2=${map.search2}&sort=${map.sort}&searchsort=삽니다"><i class="fa fa-angle-left page" data-num="${map.paging2.blockfirst-1}"></i></a>
			                </c:if>
			                <c:forEach begin="${map.paging2.blockfirst}" end="${map.paging2.blocklast}" var="i">
			                <c:if test="${map.paging2.nowpage == i }">
			                <a class="active page pagenum" style="background: #cdebfa;" href="${contextPath}/marketBoard/marketBoardList?nowpage2=${i}&search2=${map.search2}&sort=${map.sort}&searchsort=삽니다" data-now="${map.paging2.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                <c:if test="${map.paging2.nowpage != i }">
			                <a class="active page pagenum" href="${contextPath}/marketBoard/marketBoardList?nowpage2=${i}&search2=${map.search2}&sort=${map.sort}&searchsort=삽니다" data-now="${map.paging2.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                </c:forEach>
			                <c:if test="${map.paging2.blocklast != map.paging2.totalpage}">
			                <a href="${contextPath}/marketBoard/marketBoardList?nowpage2=${map.paging2.blocklast+1}&search2=${map.search2}&sort=${map.sort}&searchsort=삽니다"><i class="fa fa-angle-right page" data-num="${map.paging2.blocklast+1}"></i></a>
			                </c:if>
			               </div>
                	</div>
                	<!-- 페이징 -->
                    </div>
               <!-- 삽니다 카테고리 --> 
                    <div class="tab-pane" id="read" style="font-size: 100px;">
                    <p><b>단디 팔고 단디 사라</b></p>
                    </div>
                  </div>
                </div>
                </c:if>
                </div>
                <!-- 카테고리 끝 -->
            </div>
          </div>
        </section>
      </div>
   <jsp:include page="../inc/Footer.jsp"/>
  </body>
</html>