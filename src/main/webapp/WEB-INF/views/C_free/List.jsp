<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
  	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
  	<link href="${contextPath}/ckeditor/contents.css" rel="stylesheet">
    <title>Titan | Multipurpose HTML5 Template</title>
    <script type="text/javascript">
    $(document).ready(function() {
    	
    	//글쓰기 페이지 이동
    	$("#writebtn").click(function() {
			location.href="${contextPath}/freeBoard/writeboard";
		});
    	
    	//상세글 보기위해 글 번호 전달
    	$(document).on("click", ".title_btn", function() {
			var num = $(this).data("num");
			var sort = $("#sort > option:selected").val();
			location.href="${contextPath}/freeBoard/freeBoardView?num="+num+"&nowpage=${map.nowpage}&sort="+sort+"&search=${map.search}";
    	});
    	
    	//검색 기능
    	$(".sbutton").click(function() {
    		var search = $(".search").val();
    		$("#sform").attr("action", "${contextPath}/freeBoard/freeBoardList");
			$("#sform").submit();
		});
    	
    	//리스트 뿌려주는 메소드
    	function list(num, title, nickname, writedate, viewcount, likecount) {
    		//timestamp 포맷
    		const timestamp = writedate;
    		var date = new Date(timestamp);
    		var year = date.getFullYear();
    		var month = (date.getMonth()+1);
    		var day = date.getDate();
    		var writeDate = year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+day.toString()).slice(-2));
			var str = "";
			str += "<tr>";
			str += "<td class='hidden-xs'>"+num+"</td>";
			str += "<td>"
			str += "<h5 class='product-title font-alt'><a href='javascript:;' class='title_btn' data-num='"+num+"'>"+title+"</a></h5>";
			str += "</td>"
			str += "<td class='hidden-xs'>"
			str += "<h5 class='product-title font-alt'>"+nickname+"</h5>";
			str += "</td>";
			str += "<td class='hidden-xs'>";
			str += "<h5 class='product-title font-alt'>"+writeDate+"</h5>";
			str += "</td>";
			str += "<td>";
			str += "<h5 class='product-title font-alt'>"+viewcount+"</h5>";
			str += "</td>";	
			str += "<td class='pr-remove'>"+likecount+"</td>";
			str += "</tr>";
			return str;
		}
    	
    	//페이징 리스트
    	function paging(data) {
    		var pstr = "";
    		if(data.blockfirst != 1) {
    			pstr += "<a href='${contextPath}/freeBoard/freeBoardList?nowpage="+data.blockfirst-1+"&search="+data.search+"'"+"><i class='fa fa-angle-left page' data-num='"+(data.blockfirst-1)+"'></i></a>";
    		}
    		for(var i= data.blockfirst; i<=data.blocklast; i++) {
    			if(data.nowpage == i) {
    				pstr += "<a class='active page pagenum' href='${contextPath}/freeBoard/freeBoardList?nowpage="+i+"&search="+data.search+"&sort="+data.sort+"'"+" style='background: #cdebfa;' data-now='"+data.nowpage+"' data-num='"+i+"'>"+i+"</a> "; 
    			} else {
    				pstr += "<a class='active page pagenum' href='${contextPath}/freeBoard/freeBoardList?nowpage="+i+"&search="+data.search+"&sort="+data.sort+"'"+ "data-now='"+data.nowpage+"' data-num='"+i+"'>"+i+"</a> "; 
    			}
    				
    		}
			if(data.blocklast != data.totalpage) {
				pstr += "<a href='${contextPath}/freeBoard/freeBoardList?nowpage="+data.nowpage+"&search="+data.search+"&sort="+data.sort+"'>"+"<i class='fa fa-angle-right page' data-num='"+(data.blocklast+1)+"'></i></a>";
			}
			
			//메소드로 빼버릴까 ;;;
			$("#navpage").empty();
			var navstr = "Page : " + data.nowpage+"/"+data.totalpage;
			$("#navpage").append(navstr);
			return pstr;
		}
    	
    	//정렬 Ajax
    	$(document).on("change", ".sort", function() {
			var sort = $("#sort > option:selected").val();
			var page = $(".pagenum").data("now");
			var search = "${map.search}";
			
			$.ajax({
				url : "${contextPath}/freeBoard/SortList",
				type : "post",
				data : {"sort":sort,
					   	"nowpage":1, //page변수로 사용해도 됨 운영방법 논의하고 추후 변경
					   	"search":search
				       },
				success : function(data) {
					var str = "";
					var pstr = "";
					$("#Ltbody").empty();
					$("#pagelist").empty();
					$.each(data.list, function(i) {
						var num = data.list[i].num;
						var title = data.list[i].title;
						var nickname = data.list[i].nickname;
						var writedate = data.list[i].writedate;
						var viewcount = data.list[i].viewcount;
						var likecount = data.list[i].likecount;
						//list 뿌려주는 메소드 호출
						str += list(num, title, nickname, writedate, viewcount, likecount);
					});
					pstr = paging(data);
					$("#pagelist").append(pstr);
					$("#Ltbody").append(str);
				},
				error : function() {
					alert("통신 실패");
				}
			});
			
		});
    	
	});
    </script>
  </head>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60" style="margin: 0px;">
      <div class="main">
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-6 col-sm-offset-3">
                <h1 class="module-tditle font-alt free" style="margin-bottom: 5%; text-align: center;">자유 게시판</h1>
                <form role="form" id="sform" style="text-align:-webkit-center">
                  <div class="search-box" style="width: 60%;">
                    <input class="form-control search" name="search" type="text" placeholder="Search..."/>
                    <button class="search-btn sbutton" type="button"><i class="fa fa-search sbutton"></i></button>
                  </div>
                </form>
              </div>
            </div>
            <div class="row" style="margin: 10px 0;">
                <select class="form-control sort" id="sort" name="sort" style="width: 100px; float: left;">
               	  <c:choose>
               	  	<c:when test="${map.sort == 'writedate'}">
               	  		<option value="writedate" selected="selected">등록순</option>
                 	 	<option value="likecount">좋아요순</option>
                  		<option value="viewcount">조회순</option>
               	  	</c:when>
               	  	<c:when test="${map.sort == 'likecount'}">
               	  		<option value="writedate">등록순</option>
                 	 	<option value="likecount" selected="selected">좋아요순</option>
                  		<option value="viewcount">조회순</option>
               	  	</c:when>
               	  	<c:when test="${map.sort == 'viewcount'}">
               	  		<option value="writedate">등록순</option>
                 	 	<option value="likecount">좋아요순</option>
                  		<option value="viewcount" selected="selected">조회순</option>
               	  	</c:when>
               	  	<c:otherwise>
               	  		<option value="writedate" selected="selected">등록순</option>
		                <option value="likecount">좋아요순</option>
		                <option value="viewcount">조회순</option>
               	  	</c:otherwise>
               	  </c:choose>
                </select>
              <button id="writebtn" class="btn btn-border-d btn-round" style="float: right;">글쓰기</button>
            </div>
            <hr class="divider-w pt-20">
            <div id="navpage">Page : ${map.nowpage}/${map.totalpage}</div>
            <div class="row">
              <div class="col-sm-12">
                <table class="table table-striped table-border checkout-table">
                    <tr>
                      <th class="hidden-xs" width="10%">글번호</th>
                      <th width="50%">제목</th>
                      <th class="hidden-xs" width="10%">작성자</th>
                      <th class="hidden-xs" width="10%">작성일</th>
                      <th width="10%">조회</th>
                      <th width="10%">좋아요</th>
                    </tr>
                    <tbody id="Ltbody">
                 	<c:forEach var="list" items="${map.freeBoardList}">
                 	<fmt:formatDate var="writeDate" pattern="yyyy-MM-dd" value="${list.writedate}"/>
                    <tr>
                      <td class="hidden-xs">${list.num}</td>
                      <td>
                        <h5 class="product-title font-alt"><a href="javascript:;" class="title_btn" data-num="${list.num}">${list.title}</a></h5>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt">${list.nickname}</h5>
                      </td>
                      <td class="hidden-xs">
                        <h5 class="product-title font-alt">${writeDate}</h5>
                      </td>
                      <td>
                        <h5 class="product-title font-alt">${list.viewcount}</h5>
                      </td>
                      <td class="pr-remove">${list.likecount}</td>
                    </tr>
                  </c:forEach>  
                  </tbody>
                </table>
              </div>
            </div>
            <!-- 페이징 -->
              <div class="col-sm-12" style="text-align: center;">
                <div class="pagination font-alt" id="pagelist">
                <c:if test="${map.blockfirst!=1}">
                <a href="${contextPath}/freeBoard/freeBoardList?nowpage=${map.blockfirst-1}&search=${map.search}&sort=${map.sort}"><i class="fa fa-angle-left page" data-num="${map.blockfirst-1}"></i></a>
                </c:if>
                <c:forEach begin="${map.blockfirst}" end="${map.blocklast}" var="i">
                <script type="text/javascript">console.log("${i}");</script>
                <c:if test="${map.nowpage == i }">
                <a class="active page pagenum" style="background: #cdebfa;" href="${contextPath}/freeBoard/freeBoardList?nowpage=${i}&search=${map.search}&sort=${map.sort}" data-now="${map.nowpage}" data-num="${i}">${i}</a>
                </c:if>
                <c:if test="${map.nowpage != i }">
                <a class="active page pagenum" href="${contextPath}/freeBoard/freeBoardList?nowpage=${i}&search=${map.search}&sort=${map.sort}" data-now="${map.nowpage}" data-num="${i}">${i}</a>
                </c:if>
                </c:forEach>
                <c:if test="${map.blocklast != map.totalpage}">
                <a href="${contextPath}/freeBoard/freeBoardList?nowpage=${map.blocklast+1}&search=${map.search}&sort=${map.sort}"><i class="fa fa-angle-right page" data-num="${map.blocklast+1}"></i></a>
                </c:if>
                </div>
              </div>
             <!-- 페이징 -->
          </div>
        </section>
      </div>
   <jsp:include page="../inc/Footer.jsp"/>
  </body>
</html>