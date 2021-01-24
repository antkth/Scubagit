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
		if(searchval == '구인') {
			$(".searchbox").attr("name", "search1");
		} else if(searchval == '구직') {
			$(".searchbox").attr("name", "search2");
		} else {
			$(".searchbox").attr("name", "search1");
		}
	}
    
    $(document).ready(function() {
    		//구인 , 구직 정렬값 설정
    		var csortval = "구인";
    		$(".joffer").click(function() {
				csortval = "구인";
			});
    		$(".jsearch").click(function() {
				csortval = "구직"; 
			});
    		
    		//글쓰기 페이지 이동
			$(".wrt_btn").click(function() {
				location.href="${contextPath}/jobSearchBoard/JobSearchWrite"
			});
			
			//상세글 보기위해 글 번호 전달
	    	$(".title_btn").click(function() {
				var num = $(this).data("num");
				location.href="${contextPath}/jobSearchBoard/jobSearchBoardView?num="+num;
			});
    		
	    	//검색 기능
	    	$(".sbutton").click(function() {
	    		var search = $(".search").val();
	    		$("#sform").attr("action", "${contextPath}/jobSearchBoard/jobSearchBoardList");
				$("#sform").submit();
			});			
	    	
	    	//구인/구직 검색값 구별
	    	$(".serachselect").change(function() {
				var searchval = $(".serachselect > option:selected").val();
				if(searchval == '구인') {
					$(".searchbox").attr("name", "search1");
				} else if(searchval == '구직') {
					$(".searchbox").attr("name", "search2");
				} else {
					$(".searchbox").attr("name", "search1");
				}
			});
	    	
		});1
    	
    </script>
  </head>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
      <div class="main">
      
        <section class="module">
          <div class="container">
          	<div class="row">
              <div class="col-sm-6 col-sm-offset-3">
              <form role="form" id="sform">
                <h1 class="module-title font-alt" style="margin-bottom: 5%">구인 구직 게시판</h1>
                <select class="form-control serachselect" name="searchsort" style="width: 25%; float: left;">
                  <c:choose>
                  	<c:when test="${map.searchsort == '구인' }">
                  		<option value="구인" selected="selected">구인</option>
                    	<option value="구직" >구직</option>
                  	</c:when>
                  	<c:when test="${map.searchsort == '구직' }">
                  		<option value="구인" >구인</option>
                    	<option value="구직" selected="selected">구직</option>
                  	</c:when>
                  	<c:otherwise>
                  		<option value="구인" selected="selected">구인</option>
                    	<option value="구직" >구직</option>
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
            <div class="row" style="margin: 10px 0;">
            	<select class="form-control sort" id="sort" name="sort" style="width: 100px; float: left;">
            		<option value="writedate" selected="selected">등록순</option>
                 	<option value="likecount">좋아요순</option>
                  	<option value="viewcount">조회순</option>
            	</select>
            	<button class="btn btn-border-d btn-round wrt_btn" style="float: right;">글쓰기</button>
            </div>
         <div class="row" style="clear: both;">
         
          <!-- 카테고리 시작 -->
          <div class="col-sm-12">
           <c:if test="${map.searchsort == '구인' || map.searchsort == ''}">
            <div role="tabpanel">
                  <ul class="nav nav-tabs font-alt" id="csort" role="tablist">
                    <li class="active"><a href="#support" data-toggle="tab" class="joffer"><i class="fa fa-fw">&#xf0ac;</i>구인</a></li>
                    <li ><a href="#sales" data-toggle="tab" class="jsearch"><i class="fa fa-fw">&#xf0c0;</i>구직</a></li>
                  </ul>
             <div class="tab-content">
             <!-- 구인 카테고리 -->   
               <div class="tab-pane active" id="support">
                <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr>
                      <th class="hidden-xs" width="7%">글번호</th>
                      <th width="48%">제목</th>
                      <th class="hidden-xs" width="15%">작성자</th>
                      <th width="15%">작성일</th>
                      <th width="15%">조회</th>
                    </tr>
                    <!-- 글 리스트 -->
                    <c:forEach var="list" items="${map.jobSearchBoardList1}">
                    <fmt:formatDate var="writeDate" value="${list.writedate}"/>
                    <tr>
                      <td class="hidden-xs">${list.num}</td>
                      <td>
                        <h5 class="product-title font-alt"><a href="javascript:;" class="title_btn" data-num="${list.num}">${list.title}</a></h5>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt">${list.nickname}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${writeDate}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.viewcount}</h5>
                      </td>
                    </tr>
                    </c:forEach>
                  </tbody>
                </table>
                	<!-- 페이징 -->
             		<div class="col-sm-12" style="text-align: center;">
                		 <div class="pagination font-alt" id="pagelist">
			                <c:if test="${map.paging1.blockfirst!=1}">
			                <a href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage1=${map.paging1.blockfirst-1}&search1=${map.search1}&sort=${map.sort}&searchsort=구인"><i class="fa fa-angle-left page" data-num="${map.paging1.blockfirst-1}"></i></a>
			                </c:if>
			                <c:forEach begin="${map.paging1.blockfirst}" end="${map.paging1.blocklast}" var="i">
			                <c:if test="${map.paging1.nowpage == i }">
			                <a class="active page pagenum" style="background: #cdebfa;" href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage1=${i}&search1=${map.search1}&sort=${map.sort}&searchsort=구인" data-now="${map.paging1.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                <c:if test="${map.paging1.nowpage != i }">
			                <a class="active page pagenum" href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage1=${i}&search1=${map.search1}&sort=${map.sort}&searchsort=구인" data-now="${map.paging1.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                </c:forEach>
			                <c:if test="${map.paging1.blocklast != map.paging1.totalpage}">
			                <a href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage1=${map.paging1.blocklast+1}&search1=${map.search1}&sort=${map.sort}&searchsort=구인"><i class="fa fa-angle-right page" data-num="${map.paging1.blocklast+1}"></i></a>
			                </c:if>
			               </div>
                	</div>
                	<!-- 페이징 -->
             	<!-- 구인 카테고리 --> 
                    </div>
               <!-- 구직 카테고리 -->       
              <div class="tab-pane" id="sales">
                <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr>
                      <th class="hidden-xs" width="7%">글번호</th>
                      <th width="48%">제목</th>
                      <th class="hidden-xs" width="15%">작성자</th>
                      <th width="15%">작성일</th>
                      <th width="15%">조회</th>
                    </tr>
                    <c:forEach var="list" items="${map.jobSearchBoardList2}">
                    <fmt:formatDate var="writeDate" value="${list.writedate}"/>
                    <tr>
                      <td class="hidden-xs">${list.num}</td>
                      <td>
                         <h5 class="product-title font-alt"><a href="javascript:;" class="title_btn" data-num="${list.num}">${list.title}</a></h5>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt">${list.nickname}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${writeDate}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.viewcount}</h5>
                      </td>
                    </tr>
                    </c:forEach>
                  </tbody>
                </table>
             	<!-- 구직 카테고리 --> 
             		<!-- 페이징 -->
             		<div class="col-sm-12" style="text-align: center;">
                		 <div class="pagination font-alt" id="pagelist">
			                <c:if test="${map.paging2.blockfirst!=1}">
			                <a href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage2=${map.paging2.blockfirst-1}&search2=${map.search2}&sort=${map.sort}&searchsort=구직"><i class="fa fa-angle-left page" data-num="${map.paging2.blockfirst-1}"></i></a>
			                </c:if>
			                <c:forEach begin="${map.paging2.blockfirst}" end="${map.paging2.blocklast}" var="i">
			                <c:if test="${map.paging2.nowpage == i }">
			                <a class="active page pagenum" style="background: #cdebfa;" href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage2=${i}&search2=${map.search2}&sort=${map.sort}&searchsort=구직" data-now="${map.paging2.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                <c:if test="${map.paging2.nowpage != i }">
			                <a class="active page pagenum" href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage2=${i}&search2=${map.search2}&sort=${map.sort}&searchsort=구직" data-now="${map.paging2.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                </c:forEach>
			                <c:if test="${map.paging2.blocklast != map.paging2.totalpage}">
			                <a href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage2=${map.paging2.blocklast+1}&search2=${map.search2}&sort=${map.sort}&searchsort=구직"><i class="fa fa-angle-right page" data-num="${map.paging2.blocklast+1}"></i></a>
			                </c:if>
			               </div>
                	</div>
                	<!-- 페이징 -->
                    </div>
                  </div>
                </div>
                </c:if>
            
            <c:if test="${map.searchsort == '구직'}">
            <div role="tabpanel">
                  <ul class="nav nav-tabs font-alt" role="tablist">
                    <li ><a href="#support" data-toggle="tab" class="joffer"><i class="fa fa-fw">&#xf0ac;</i>구인</a></li>
                    <li class="active"><a href="#sales" class="jsearch" data-toggle="tab"><i class="fa fa-fw">&#xf0c0;</i>구직</a></li>
                  </ul>
             <div class="tab-content">
             <!-- 구인 카테고리 -->   
               <div class="tab-pane" id="support">
                <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr>
                      <th class="hidden-xs" width="7%">글번호</th>
                      <th width="48%">제목</th>
                      <th class="hidden-xs" width="15%">작성자</th>
                      <th width="15%">작성일</th>
                      <th width="15%">조회</th>
                    </tr>
                    <!-- 글 리스트 -->
                    <c:forEach var="list" items="${map.jobSearchBoardList1}">
                    <fmt:formatDate var="writeDate" value="${list.writedate}"/>
                    <tr>
                      <td class="hidden-xs">${list.num}</td>
                      <td>
                        <h5 class="product-title font-alt"><a href="javascript:;" class="title_btn" data-num="${list.num}">${list.title}</a></h5>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt">${list.nickname}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${writeDate}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.viewcount}</h5>
                      </td>
                    </tr>
                    </c:forEach>
                  </tbody>
                </table>
                	<!-- 페이징 -->
             		<div class="col-sm-12" style="text-align: center;">
                		 <div class="pagination font-alt" id="pagelist">
			                <c:if test="${map.paging1.blockfirst!=1}">
			                <a href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage1=${map.paging1.blockfirst-1}&search1=${map.search1}&sort=${map.sort}&searchsort=구인"><i class="fa fa-angle-left page" data-num="${map.paging1.blockfirst-1}"></i></a>
			                </c:if>
			                <c:forEach begin="${map.paging1.blockfirst}" end="${map.paging1.blocklast}" var="i">
			                <c:if test="${map.paging1.nowpage == i }">
			                <a class="active page pagenum" style="background: #cdebfa;" href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage1=${i}&search1=${map.search1}&sort=${map.sort}&searchsort=구인" data-now="${map.paging1.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                <c:if test="${map.paging1.nowpage != i }">
			                <a class="active page pagenum" href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage1=${i}&search1=${map.search1}&sort=${map.sort}&searchsort=구인" data-now="${map.paging1.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                </c:forEach>
			                <c:if test="${map.paging1.blocklast != map.paging1.totalpage}">
			                <a href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage1=${map.paging1.blocklast+1}&search1=${map.search1}&sort=${map.sort}&searchsort=구인"><i class="fa fa-angle-right page" data-num="${map.paging1.blocklast+1}"></i></a>
			                </c:if>
			               </div>
                	</div>
                	<!-- 페이징 -->
             	<!-- 구인 카테고리 --> 
                    </div>
               <!-- 구직 카테고리 -->       
              <div class="tab-pane active" id="sales">
                <table class="table table-striped table-border checkout-table">
                  <tbody>
                    <tr>
                      <th class="hidden-xs" width="7%">글번호</th>
                      <th width="48%">제목</th>
                      <th class="hidden-xs" width="15%">작성자</th>
                      <th width="15%">작성일</th>
                      <th width="15%">조회</th>
                    </tr>
                    <c:forEach var="list" items="${map.jobSearchBoardList2}">
                    <fmt:formatDate var="writeDate" value="${list.writedate}"/>
                    <tr>
                      <td class="hidden-xs">${list.num}</td>
                      <td>
                         <h5 class="product-title font-alt"><a href="javascript:;" class="title_btn" data-num="${list.num}">${list.title}</a></h5>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt">${list.nickname}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${writeDate}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.viewcount}</h5>
                      </td>
                    </tr>
                    </c:forEach>
                  </tbody>
                </table>
                	<!-- 페이징 -->
             		<div class="col-sm-12" style="text-align: center;">
                		 <div class="pagination font-alt" id="pagelist">
			                <c:if test="${map.paging2.blockfirst!=1}">
			                <a href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage2=${map.paging2.blockfirst-1}&search2=${map.search2}&sort=${map.sort}&searchsort=구직"><i class="fa fa-angle-left page" data-num="${map.paging2.blockfirst-1}"></i></a>
			                </c:if>
			                <c:forEach begin="${map.paging2.blockfirst}" end="${map.paging2.blocklast}" var="i">
			                <c:if test="${map.paging2.nowpage == i }">
			                <a class="active page pagenum" style="background: #cdebfa;" href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage2=${i}&search2=${map.search2}&sort=${map.sort}&searchsort=구직" data-now="${map.paging2.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                <c:if test="${map.paging2.nowpage != i }">
			                <a class="active page pagenum" href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage2=${i}&search2=${map.search2}&sort=${map.sort}&searchsort=구직" data-now="${map.paging2.nowpage}" data-num="${i}">${i}</a>
			                </c:if>
			                </c:forEach>
			                <c:if test="${map.paging2.blocklast != map.paging2.totalpage}">
			                <a href="${contextPath}/jobSearchBoard/jobSearchBoardList?nowpage2=${map.paging2.blocklast+1}&search2=${map.search2}&sort=${map.sort}&searchsort=구직"><i class="fa fa-angle-right page" data-num="${map.paging2.blocklast+1}"></i></a>
			                </c:if>
			               </div>
                	</div>
                	<!-- 페이징 -->
              </div>
              	<!-- 구직 카테고리 --> 
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