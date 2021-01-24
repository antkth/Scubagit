<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <title>Titan | Multipurpose HTML5 Template</title>
    <script src="${contextPath}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
			//썸네일 뛰워주기
					$(document).ready(function() {
			$("#filename").on("change", function() {
				readURL(this);
			});
			function readURL(input) {
				if(input.files && input.files[0]){
					$("#preimg").empty();
					$("#preimg").html("<h4><b>썸네일 이미지</b></h4>");
					$("#preimg").append("<img id='preImage' src='#' style='width: 200px;'> <br>");
					var reader = new FileReader();
					reader.readAsDataURL(input.files[0]);
					reader.onload = function (e) {
						$("#preImage").attr("src", e.target.result);						
					}
				}
			}
		});
			
			//전송 버튼 클릭 시
			$(".wrt_btn").click(function() {
				var content = CKEDITOR.instances.content.getData();
				var length = CKEDITOR.instances.content.getData().length;
				//유효성 체크
				if($("#title").val() == "") {
					alert("제목을 입력해 주세요");
					$("#title").focus();
					return false;
				} else if($("#introduction").val() == "") {
					alert("인사말을 입력해주세요.");
					$("#introduction").focus();
					return false;
				} else if($("#startdate").val() == "") {
					alert("이벤트 시작 일자를 선택해주세요.");
					$("#startdate").focus();
					return false;
				} else if($("#enddate").val() == "") {
					alert("이벤트 종료 일자를 선택해주세요.");
					$("#enddate").focus();
					return false;
				} else if(content == "") {
					alert("내용을 입력해주세요");
					$("#content").focus();
					CKEDITOR.instances.content.focus();
					return false;
				} else if(length >3000) {
					alert("3000글자 이내로 작성해주세요 ");
					$("#content").focus();
				} else {
					$("#wform").attr("action", "${contextPath}/Event/WriteInsert");
					$("#wform").submit();
				}
			});
			
			$("#enddate").change(function() {
				if($("#enddate").val() < $("#startdate").val()) {
					alert("시작일자가 종료일자보다 이전입니다.");
					$("#enddate").val("");
					$("#enddate").focus();
				}
			});
			
			//돌아가기 버튼
	    	$(".back_btn").click(function() {
	    		if(confirm("글 작성을 취소 하시겠습니까 ?") == true) {
	    		location.href="${contextPath}/friendsBoard/writeCancle";
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
                <h4 class="font-alt mb-0">이벤트 게시판 글 작성</h4>
                <hr class="divider-w mt-10 mb-20">
                <form class="form" role="form" id="wform" method="post" enctype="multipart/form-data">
                  <div class="form-group">
                  	<h5><b>제목</b></h5>
                    <input class="form-control input-lg" id="title" name="title" type="text" placeholder="제목을 입력하세요(메인 제목)"/>
                  </div>
                  <div class="form-group">
                  	<h5><b>썸네일 이미지 등록</b></h5>
                    <input type="file" class="form-control input-lg custom-file-input" id="filename" name="file">
                  </div>
                  <div class="form-group" id="preimg">
                   
                  </div>
                  <div class="form-group">
                  	<h5><b>한줄 소개</b></h5>
                    <input class="form-control" type="text" id="introduction" name="introduction" placeholder="간단한 한줄(서브 제목)"/>
                    <h5><b>이벤트 기간</b></h5>
                    <div class="input-group" style="float: left; width: 50%;">
                    <div class="input-group-addon">시작 일자</div>
                    <input class="form-control input-lg" id="startdate" type="date" name="startdate" placeholder="출발일"/>
                  	</div>
                  	<div class="input-group" style="float: left; width: 50%;">
                    <div class="input-group-addon">종료 일자</div>
                    <input class="form-control input-lg" id="enddate" type="date" name="enddate" placeholder="도착일"/>
                  	</div>
                  </div>
                  <div style="clear: both;">
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
    <script type="text/javascript">
    
    //ck에디터 디자인
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
				$("#title").val("");
				$("#title").focus();
			}
		}
	});
	//인사말 글자 수 정규식
	$("#introduction").on('blur',function(){
		if($("#introduction").val() != "") {
			var title = $("#introduction").val();
			var titletrim = title.trim();
			var pattern = /^.{1,50}$/; 
			if(!title.trim() == "") {
				if(!title.match(pattern)) {
					alert("인사말을 1~50자 사이로 입력해주세요.");
					$("#introduction").val("");
					$("#introduction").focus();
				}
			}else {
				alert("공백이 아닌 인사말을 1~50자 사이로 입력해주세요.");
				$("#introduction").val("");
				$("#introduction").focus();
			}
		}
	});
	//글자 수 초과 감지
	CKEDITOR.instances.content.on('key', function() {
		var content = this.getData();
		var length = content.length;
		if(length > 3000) {
		alert("3000글자 이내로 작성해주세요");
	    this.setData(content.slice(0, 2999));
		}
	});
	</script>       
  </body>
</html>