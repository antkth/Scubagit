<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/Top.jsp" %>
<!DOCTYPE html>
<html lang="en-US" dir="ltr">
  <head>
    <title>Titan | Multipurpose HTML5 Template</title>
    <script src="${contextPath}/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
<!-- 	<script src="./editor.js"></script> -->

	<script type="text/javascript">
		$(document).ready(function() {
			//썸네일 미리보기
			$("#filename").on("change", function(event) {
				var formData = new FormData();
				var inputFile = this.files;
				
				for(var i=0; i<inputFile.length; i++) {
					formData.append("imgfile", inputFile[i]);
				}
				//썸네일 이미지 유효성 체크
				$.ajax({
					contentType : false,
					processData : false,
					url : "${contextPath}/Common/imgCheck",
					data : formData,
					type : "post",
					success : function (data) {
						var check = data;
						if(check == 1 ) {
							alert("파일 형식을 확인해주세요");
							$("#filename").val("");
							$("#preimg").empty();
						} else if(check == 2) {
							alert("파일 크기를 확인해주세요");
							$("#filename").val("");
							$("#preimg").empty();
						} else if(check == 3) {
							
						}
					},
					error : function(data) {
						alert("통신 실패");
					}
				});
				readURL(this);
			});
			
			
			//썸네일 미리보기 태그 삽입
			function readURL(input) {
				if(input.files && input.files[0]){
					$("#preimg").empty();
					$("#preimg").html("<h4><b>썸네일 이미지</b></h4>");
					$("#preimg").append("<img id='preImage' src='#' style='width: 245px; height: 141px;'> <br>");
					var reader = new FileReader();
					reader.readAsDataURL(input.files[0]);
					reader.onload = function (e) {
						$("#preImage").attr("src", e.target.result);						
					}
				}
			}
			
			
			
			//전송 버튼 클릭 시
			$(".wrt_btn").click(function() {
				var content = CKEDITOR.instances.content.getData();
				var length = CKEDITOR.instances.content.getData().length;
				//유효성 체크
				if($("#title").val() == "") {
					alert("제목을 입력해 주세요");
					$("#title").focus();
					return false;
				} else if($("#introduction").val() =="") {
					$("#introduction").focus();
					alert("간단한 소개글을 입력해 주세요");
					return false;
				} else if($("#country > option:selected").val() == "") {
					$("#country").focus();
					alert("국가를 선택 해주세요.");
					return false;
				} else if($("#area > option:selected").val() == "") {
					$("#area").focus();
					alert("지역을 선택 해주세요.");
					return false;
				} else if(content == "") {
					$("#content").focus();
					alert("내용을 입력해주세요");
					CKEDITOR.instances.content.focus();
					return false;
				}  else if(length >3000) {
					$("#content").focus();
					alert("3000글자 이내로 작성해주세요 ");
				} else {
					$("#wform").attr("action", "${contextPath}/underWaterBoard/writeinsert");
					$("#wform").submit();
				}
			});
			
			//돌아가기 버튼
	    	$(".back_btn").click(function() {
	    		location.href="${contextPath}/underWaterBoard/underWaterBoardList";
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
                <h4 class="font-alt mb-0">수중 갤러리 글 작성</h4>
                <hr class="divider-w mt-10 mb-20">
                <form class="form" role="form" id="wform" method="post" enctype="multipart/form-data">
                  <div class="form-group">
                  	<input type="hidden" name="communityname" value="${category}">
                  	<h5><b>제목</b></h5>
                    <input class="form-control input-lg" name="title" type="text" id="title" placeholder="제목을 입력하세요(메인 제목)"/>
                  </div>
                  <div class="form-group">
                  	<h5><b>썸네일 이미지 등록</b></h5>
                  	<input type="text" hidden="hidden" />
                    <input type="file" accept="image/jpeg, .jpg, .png, .gif" class="form-control input-lg custom-file-input" name="file" id="filename">
                  </div>
                  <!-- 썸 네일 미리보기 -->
                  <div class="form-group" id="preimg">
                   
                  </div>
                  <div class="form-group">
                  	<h5><b>한줄 소개</b></h5>
                    <input class="form-control" id="introduction" name="introduction" type="text" placeholder="간단한 한줄(서브 제목)"/>
                  </div>
                  <div class="form-group" style="height: 62px;">
                  	<h5><b>지역</b></h5>
	                  <select class="form-control" id="country" name="country" style="width: 50%; float: left;">
	                  <option selected="selected" disabled="disabled" value="">국가</option>
	                  <option value="대한민국">대한민국</option>
	                  <option value="화성">화성</option>
	                  </select>
	                  <select class="form-control" id="area" name="area" style="width: 50%; float: left;">
	                  <option selected="selected" disabled="disabled" value="">지역</option>
	                  <option value="경기도">경기도</option>
	                  <option value="부산">부산</option>
	                  </select>
                  </div>
                  <div style="clear: both;">
                  <textarea class="form-control" rows="10" name="content" id="content" style="width:100%; min-width:260px; height:30em; display:none;"></textarea>
                  </div>
                  <div class="form-group">
                  	<h5><b>태그</b></h5>
                  <textarea class="form-control" rows="2" name="hashtag" placeholder="태그" style="resize: none;"></textarea>
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
	
	//간단한 인사 말 글자 수 정규식
	$("#introduction").on('blur',function(){
		if($("#introduction").val() != "") {
			var introduction = $("#introduction").val();
			var pattern = /^.{1,50}$/; 
			if(!introduction.trim() == "") {
				if(!introduction.match(pattern)) {
					alert("소개글을 1~50자 사이로 입력해주세요.");
					$("#introduction").val("");
					$("#introduction").focus();
				}
			}else {
				alert("공백이 아닌 소개글을 1~50자 사이로 입력해주세요.");
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