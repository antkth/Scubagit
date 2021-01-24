<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.product-title{margin: 0;}
p{margin: 0;}
</style>
<script type="text/javascript">
function resortStatusChange() {
	var resortStatus = $('#resortStatus option:selected').val();
	location.href='${contextPath}/Resort/moveResortAdmin?resortStatus='+resortStatus+'&search=${map.search}';
}
function changeStatus(num,status) {
	document.getElementById(num).onclick = null;
	$.ajax({
		url:'${contextPath}/Resort/changeResortStatusList',
		type:'POST',
		data:{num:num,status:status},
		success: function() {
			
		}
	});
	$('#'+num).html("변경되었습니다.");
}
</script>
</head>
<body>
        <section class="module">
          <div class="container">
            <div class="row">
              <div class="col-sm-8" style="text-align:-webkit-center;">
                <form role="form" action="${contextPath}/Resort/moveResortAdmin" style="width: 300px; margin-bottom: 20px;">
                  <div class="search-box">
                    <input class="form-control" name="search" type="text" value="${map.search}" placeholder="Search..."/>
                    <button class="search-btn" type="submit"><i class="fa fa-search"></i></button>
                  </div>
                </form>
                <div class="row">
                <select class="form-control" id="resortStatus" onchange="resortStatusChange()" style="float: right; width: 15%; min-width: 102px;">
                  <c:choose>
                  	<c:when test="${map.resortStatus==0}">
                  		<option selected="selected" value="0">비 활성화</option>
		                <option value="1">활성화</option>
		                <option value="2">삭제</option>
                  	</c:when>
                  	<c:when test="${map.resortStatus==1}">
                  		<option value="0">비 활성화</option>
		                <option selected="selected" value="1">활성화</option>
		                <option value="2">삭제</option>
                  	</c:when>
                  	<c:when test="${map.resortStatus==2}">
                  		<option value="0">비 활성화</option>
		                <option value="1">활성화</option>
		                <option selected="selected" value="2">삭제</option>
                  	</c:when>
                  </c:choose>
                </select>
              </div>
            	<div class="row">
              <table class="table table-striped table-border checkout-table" style="text-align-last: center; vertical-align: bottom; margin-top: 1%;">
                  <tbody>
                    <tr style="text-align: center;">
                      <th class="hidden-xs" width="10%">번호</th>
                      <th class="hidden-xs" width="10%">닉네임</th>
                      <th width="40%">리조트 이름</th>
                      <th width="10%">연락처</th>
                      <th width="15%">지역</th>
                      <th width="15%">상태</th>
                    </tr>
                    <c:forEach items="${map.resortList}" var="resortVO">
                    <tr style="text-align: center;">
                      <td class="hidden-xs"><h6 class="product-title font-alt">${resortVO.num}</h6></td>
                      <td class="hidden-xs">
                        <h6 class="product-title font-alt">${resortVO.nickName}</h6>
                      </td>
                      <td>
                        <h6 class="product-title font-alt"><a href="${contextPath}/Resort/moveViewResort?num=${resortVO.num}">${resortVO.resortName}</a></h6>
                      </td>
                      <td>
                        <h6 class="product-title font-alt">${resortVO.phoneNumber}</h6>
                        <p><img src="${contextPath}/resources/assets/images/kakaoIcon.png" alt="kakaologo" width="13px">&nbsp;${resortVO.cacaoId}</p>
                      </td>
                      <td>
                        <p>${resortVO.country}<br>${resortVO.city}</p>
                      </td>
                      <td>
                        <h6 class="product-title font-alt">
						<c:if test="${resortVO.resortStatus==0}">
						<a id="${resortVO.num}" onclick="changeStatus('${resortVO.num}','${resortVO.resortStatus}')"><font color="cornflowerblue">비활성</font></a>
						</c:if>
						<c:if test="${resortVO.resortStatus==1}">
						<a id="${resortVO.num}" onclick="changeStatus('${resortVO.num}','${resortVO.resortStatus}')"><font color="blue">활성</font></a>
						</c:if>
						<c:if test="${resortVO.resortStatus==2}">
						<font color="red">삭제</font>
						</c:if>
                        
                        </h6>
                      </td>
                    </tr>
                    </c:forEach>
                  </tbody>
                  </table>
                  </div>
                <div class="pagination font-alt">
                <c:if test="${map.blockfirst!=1}">
                <a href="${contextPath}/Resort/moveResortAdmin?nowpage=${map.blockfirst-1}&resortStatus=${map.resortStatus}&search=${map.search}"><i class="fa fa-angle-left"></i></a>
                </c:if>
                <c:forEach begin="${map.blockfirst}" end="${map.blocklast}" var="i">
                <a href="${contextPath}/Resort/moveResortAdmin?nowpage=${i}&resortStatus=${map.resortStatus}&search=${map.search}">${i}</a>
                </c:forEach>
                <c:if test="${map.totalpage != map.blocklast }">
                <a href="${contextPath}/Resort/moveResortAdmin?nowpage=${map.blocklast+1}&resortStatus=${map.resortStatus}&search=${map.search}"><i class="fa fa-angle-right"></i></a>
                </c:if>
                </div>
              </div>
              <div class="col-sm-4 col-md-3 col-md-offset-1 sidebar">
                <div class="widget">
                  <h5 class="widget-title font-alt">관리자 페이지</h5>
                  <ul class="icon-list">
                    <li><a href="#">회원정보 확인</a></li>
                    <li><a href="#">1대1문의 내역</a></li>
                    <li><a href="#">신고 리스트</a></li>
                    <li><a href="#">다이빙샵 등록 확인</a></li>
                    <li><a href="#">어류 등록</a></li>
                    <li><a href="#">다이빙 포인트 등록</a></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </section>
<jsp:include page="../inc/Footer.jsp"/>
</body>
</html>