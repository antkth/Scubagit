<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/Top.jsp"%>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <title>Titan | Multipurpose HTML5 Template</title>
    <script src="${contextPath}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>

	<script type="text/javascript">
	$(document).ready(function() {
		//전송 버튼 클릭 시
		$(".wrt_btn").click(function() {
			var content = CKEDITOR.instances.content.getData();
			var length = CKEDITOR.instances.content.getData().length;
			//유효성 체크
			if($("#title").val() == "") {
				alert("제목을 입력해 주세요");
				$("#title").focus();
				return false;
			} else if($("#jobcate > option:selected").val() == "" || $("#jobcate > option:selected").val() =="선택해주세요."){
				$("#jobcate").focus();
				alert("구인/구직을 선택 해주세요.");
				return false;
			} else if(content == "") {
				$("#content").focus();
				alert("내용을 입력해주세요");
				CKEDITOR.instances.content.focus();
				return false;
			} else if(length >3000) {
				$("#content").focus();
				alert("3000글자 이내로 작성해주세요 ");
			} else {
				$("#wform").attr("action", "${contextPath}/jobSearchBoard/Modifyinsert");
				$("#wform").submit();
			}
		});
		
		//돌아가기(수정 취소)버튼
    	$(".back_btn").click(function() {
    		if(confirm("글 수정을 취소 하시겠습니까 ?") == true) {
    			location.href="${contextPath}/jobSearchBoard/modiFyCancle?num="+${modifyList.num};
    		} else {
    			return;
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
              <div class="col-sm-8 col-sm-offset-2">
                <h4 class="font-alt mb-0">구인구직 글 수정</h4>
                <hr class="divider-w mt-10 mb-20">
                <form class="form" role="form" id="wform" method="post">
                  <div class="form-group" style="float: left; margin-right: 5%; width: 30%;">
                  	<h5><b>번호</b></h5>
                    <input class="form-control input-lg" name="num" type="text" value="${modifyList.num}" readonly="readonly"/>
                  </div>              
                  <div class="form-group" style="float: left; width: 30%;">
                  	<h5><b>작성날짜</b></h5>
                  	<fmt:formatDate var="writeDate" pattern="yyyy-MM-dd" value="${modifyList.writedate}"/>
                    <input class="form-control input-lg" type="text" placeholder="${writeDate}" readonly="readonly"/>
                  </div>
                  <div class="form-group" style="clear: both;">
                  	<h5><b>제목</b></h5>
                    <input class="form-control input-lg" name="title" id="title" type="text" value="${modifyList.title}"/>
                  </div>
                  <div class="form-group">
                  	<h5><b>카테고리</b></h5>
		                <select class="form-control" name="jobcategory" id="jobcate" >
		                  <option selected="selected" disabled="disabled" value="">선택해주세요.</option>
		                  <option value="구인">구인</option>
		                  <option value="구직">구직</option>
		                </select>
                  </div>
                  <div>
                  <textarea class="form-control" rows="10" name="content" id="content" style="width:100%; min-width:260px; height:30em; display:none;">
                  ${modifyList.content}
                  </textarea>
                  </div>
                  <div style="float: right;">
                  <button class="btn btn-border-d btn-round wrt_btn" type="button">수정하기</button>
                  <button class="btn btn-border-d btn-round back_btn" type="reset">취소</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </section>
        </div>
       <jsp:include page="../inc/Footer.jsp"/>
       
	<script type="text/javascript">
    //CKEDITOR Form 설정 부분 
	CKEDITOR.on('dialogDefinition', function (ev) {
        var dialogName = ev.data.name;
        var dialog = ev.data.definition.dialog;
        var dialogDefinition = ev.data.definition;
        if (dialogName == 'image') {
            dialog.on('show', function (obj) {
                this.selectPage('Upload'); //업로드텝으로 시작
            });
            dialogDefinition.removeContents('advanced'); // 자세히탭 제거
            dialogDefinition.removeContents('Link'); // 링크탭 제거
        }
    });
		//CKEDITOR 설정
		CKEDITOR.replace('content', {
			height : 500,
			width : 750,
			//이미지 업로드 경로
			filebrowserUploadUrl: "${contextPath}/Common/imguploadModify?num=${modifyList.num}",
			enterMode:'2'
		});
		
	//제목 글자 수, 내용 글자 수 정규식
	$("#title").on('blur',function(){
		if($("#title").val() != "") {
			var title = $("#title").val();
			var titletrim = title.trim();
			var pattern = /^.{1,50}$/; 
			if(!title.trim() == "") {
				if(!title.match(pattern)) {
					alert("제목을 1~50자 사이로 입력해주세요.");
					$("#title").val("");
					$("#title").focus();
				}
			}else {
				alert("공백이 아닌 제목을 1~50자 사이로 입력해주세요.");
			}
			
		}
	});
	
	//글 내용 수 초과 감지
	CKEDITOR.instances.content.on('key', function() {
		var content = this.getData();
		var length = content.length;
		if(length >= 3000) {
		alert("3000글자 이내로 작성해 주세요");
	    this.setData(content.slice(0, 2999));
		}
	});
	
	</script>
  </body>
</html>