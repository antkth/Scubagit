<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <title>Titan | Multipurpose HTML5 Template</title>
  </head>
  <body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
      <div class="main">
        <section class="module-small">
          <div class="container">
            <div class="row">
              <div class="col-sm-8 col-sm-offset-2">
                <div class="post">
                  <div class="post-header font-alt">
                    <h1 class="post-title">${noticeVO.title}</h1>
                    <div class="post-meta"> ${noticeVO.nickname}  | ${noticeVO.writedate}
                    </div>
                  </div>
                  <div class="post-entry">
                    <p>${noticeVO.content}</p>
                    </div>
                </div>
                <div class="row" style="padding: 0 15px;">
               	  <button class="btn btn-border-d btn-round" type="button" onclick='history.back()' style="float: right; margin: 5px;">목록보기</button>
                  <button class="btn btn-border-d btn-round" type="button" onclick="location.href='${contextPath}/Notice/delNotice?num=${noticeVO.num}'" style="float: right; margin: 5px;">글 삭제</button>
                  <button class="btn btn-border-d btn-round" type="button" onclick="location.href='${contextPath}/Notice/moveModify?num=${noticeVO.num}'" style="float: right; margin: 5px;">글 수정</button>
                </div>
              </div>
            </div>
          </div>
        </section>
        </div>
       <jsp:include page="../inc/Footer.jsp"/>
  </body>
</html>