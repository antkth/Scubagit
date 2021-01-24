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
			//썸네일 미리보기
			$("#filename").on("change", function() {
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
			$(".Modify_btn").click(function() {
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
					$("#mform").attr("action", "${contextPath}/reviewBoard/Modifyinsert");
					$("#mform").submit();
				}
			});
			
			//돌아가기(수정 취소)버튼
	    	$(".back_btn").click(function() {
	    		location.href="${contextPath}/reviewBoard/modiFyCancle?num="+${modifyList.num};
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
                <h4 class="font-alt mb-0">후기 게시판 글 수정</h4>
                <hr class="divider-w mt-10 mb-20">
                <form class="form" id="mform" role="form" method="post" enctype="multipart/form-data">
                  <div class="form-group" style="float: left; margin-right: 5%; width: 30%;">
                  	<h5><b>글 번호</b></h5>
                    <input class="form-control input-lg" name="num" type="text" value="${modifyList.num}" readonly="readonly"/>
                    <input type="hidden" name="communityname" value="${modifyList.communityname}">
                  </div>                  
                  <div class="form-group" style="float: left; width: 30%;">
                  	<h5><b>작성 일자</b></h5>
                    <input class="form-control input-lg" name="writedate" type="text" value="${modifyList.writedate}" readonly="readonly"/>
                  </div>
                  <div class="form-group" style="clear: both;">
                  	<h5><b>글 제목</b></h5>
                    <input class="form-control input-lg" name="title" type="text" value="${modifyList.title}"/>
                  </div>
                  <div class="form-group">
                  	<h5><b>썸네일 이미지 등록</b></h5>
                    <input type="file" class="form-control input-lg custom-file-input" name="file" id="filename">
                  </div>
                  <div class="form-group" id="preimg">        
                  <c:if test="${modifyList.thumbnail ne 'baseImage.jpg'}">
                   <h4><b>썸네일 이미지</b></h4>
                   <img id="preImage" src="${contextPath}/resources/images/${modifyList.communityname}/Thumbnail/${modifyList.num}/${modifyList.thumbnail}" style="width: 245px; height: 141px;"> <br>
                   <input type="hidden" name="thumbnail" value="${modifyList.thumbnail}">
                  </c:if>
                  </div>
                  <div class="form-group">
                  	<h5><b>한줄 소개</b></h5>
                    <input class="form-control" name="introduction" type="text" value="${modifyList.introduction}"/>
                  </div>
                  <div class="form-group">
                  	<h5><b>지역</b></h5>
	                  <select class="form-control" id="country" name="country" style="width: 50%; float: left;">
	                  <option selected="selected" disabled="disabled"  value="">국적</option>
	                  <option>대한민국</option>
	                  <option>화성</option>
	                  </select>
	                  <select class="form-control" id="area" name="area" style="width: 50%; float: left;">
	                  <option selected="selected" disabled="disabled"  value="">지역</option>
	                  <option>깐따삐아</option>
	                  <option>또빠뚜따</option>
	                  <option>zzz</option>
	                  </select>
                  </div>
                  <div style="clear: both;">
                  <textarea class="form-control" rows="10" name="content" id="content" style="width:100%; min-width:260px; height:30em; display:none;">
                  ${modifyList.content}
                  </textarea>
                  </div>
                  <div class="form-group">
                  	<h5><b>태그</b></h5>
                  <textarea class="form-control" name="hashtag" rows="2" style="resize: none;">${modifyList.hashtag}</textarea>
                  </div>
                  <div style="float: right;">
                  <button class="btn btn-border-d btn-round Modify_btn" type="button">글쓰기</button>
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