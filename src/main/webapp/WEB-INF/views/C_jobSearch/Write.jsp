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
				} else if($("#jobcate > option:selected").val() == "") {
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
					$("#wform").attr("action", "${contextPath}/jobSearchBoard/WriteInsert");
					$("#wform").submit();
				}
			});
			
			//돌아가기 버튼
	    	$(".back_btn").click(function() {
	    		if(confirm("글 작성을 취소 하시겠습니까 ?") == true) {
	    			location.href="${contextPath}/jobSearchBoard/writeCancle";
		    		} else {
		    			return false;
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
                <h4 class="font-alt mb-0">구인 구직 글 작성</h4>
                <hr class="divider-w mt-10 mb-20">
                <form class="form" id="wform" role="form" method="post">
                  <div class="form-group">
                  <input type="hidden" name="communityname" value="${category}">
                  	<h5><b>제목</b></h5>
                    <input name="title" class="form-control input-lg" type="text" id="title" placeholder="제목을 입력하세요(1~50자 사이로 입력해주세요.)"/>
                  </div>
                  <div class="form-group">
                  	<h5><b>카테고리</b></h5>
		                <select class="form-control" name="jobcategory" id="jobcate">
		                  <option selected="selected" disabled="disabled" value="">선택해주세요 .</option>
		                  <option value="구인">구인</option>
		                  <option value="구직">구직</option>
		                </select>
                  </div>
                  <div>
                  <textarea class="form-control" rows="10" name="content" id="content" style="width:100%; min-width:260px; height:30em; display:none;"></textarea>
                  </div>
                  <div style="float: right;">
                  <button class="btn btn-border-d btn-round wrt_btn" type="button">글쓰기</button>
                  <button class="btn btn-border-d btn-round back_btn" type="button">돌아가기</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </section>
        </div>
       <jsp:include page="../inc/Footer.jsp"/>
       
 <!-- ck에디터 관련 -->
    <script type="text/javascript">
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
		CKEDITOR.replace('content', {
			height : 500,
			width : 750,
			filebrowserUploadUrl: "${contextPath}/Common/imgupload",
			enterMode:'2'
		});
		
	//제목 글자 수 정규식
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
	
	//글자 수 초과 감지
	CKEDITOR.instances.content.on('key', function() {
		var content = this.getData();
		var length = content.length;
		if(length > 3000) {
		alert("3000글자 이내로 작성해 주세요");
	    this.setData(content.slice(0, 2999));
		}
	});
	
	</script>
  </body>
</html>