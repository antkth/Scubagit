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
				} else if($("#introduction").val() == "") {
					alert("인사말을 입력해주세요.");
					$("#introduction").focus();
					return false;
				} else if($("#startdate").val() == "") {
					alert("출발 일자를 선택해주세요.");
					$("#startdate").focus();
					return false;
				} else if($("#enddate").val() == "") {
					alert("도착 일자를 선택해주세요.");
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
					$("#mform").attr("action", "${contextPath}/Event/Modifyinsert");
					$("#mform").submit();
				}
			});
			
			$("#enddate").change(function() {
				if($("#enddate").val() < $("#startdate").val()) {
					alert("도착일자가 출발일자보다 이전입니다.");
					$("#enddate").val("");
					$("#enddate").focus();
				}
			});
			
			//돌아가기 버튼
	    	$(".back_btn").click(function() {
	    		if(confirm("글 수정을 취소 하시겠습니까 ?") == true) {
	    			location.href="${contextPath}/Event/modiFyCancle?num="+${modifyList.num};
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
                <h4 class="font-alt mb-0">이벤트 게시판 글 수정</h4>
                <hr class="divider-w mt-10 mb-20">
                 <form class="form" id="mform" role="form" method="post" enctype="multipart/form-data">
                  <div class="form-group" style="float: left; margin-right: 5%; width: 30%;">
                  	<h5><b>번호</b></h5>
                    <input class="form-control input-lg" type="text" name="num" value="${modifyList.num}"  readonly="readonly"/>
					<input type="hidden" name="communityname" value="${modifyList.communityname}">
                  </div>
                  <div class="form-group" style="float: left; margin-right: 5%; width: 30%;">
                  	<h5><b>작성자</b></h5>
                    <input class="form-control input-lg" type="text" name="nickname" value="${modifyList.nickname}" readonly="readonly"/>
                  </div>                  
                  <div class="form-group" style="float: left; width: 30%;">
                  	<h5><b>작성날짜</b></h5>
                    <input class="form-control input-lg" type="text" name="writeDate" value="${modifyList.writeDate}" readonly="readonly"/>
                  </div>
                  <div class="form-group" style="clear: both;">
                  	<h5><b>제목</b></h5>
                    <input class="form-control input-lg" type="text" name="title" value="${modifyList.title}" id="title"/>
                  </div>
                  <div class="form-group">
                  	<h5><b>썸네일 이미지 등록</b></h5>
                    <input type="file" accept="image/jpeg, .jpg, .png, .gif" class="form-control input-lg custom-file-input" name="file" id="filename">
                  </div>
                  <div class="form-group" id="preimg">        
                   <h4><b>썸네일 이미지</b></h4>
                   <img id="preImage" src="${contextPath}/resources/images/${modifyList.communityname}/Thumbnail/${modifyList.num}/${modifyList.thumbnail}" style="width: 245px; height: 141px;"> <br>
                   <input type="hidden" name="thumbnail" value="${modifyList.thumbnail}">
                  </div>
                  <div class="form-group">
                  	<h5><b>한줄 소개</b></h5>
                  	<textarea class="form-control" id="introduction" name="introduction" rows="2" style="resize: none;">${modifyList.introduction}</textarea>
                    <h5><b>이벤트 기간</b></h5>
                    <div class="input-group" style="float: left; width: 50%;">
                    <div class="input-group-addon">시작 일자</div>
                    <input class="form-control input-lg" value="${modifyList.startdate}" id="startdate" type="date" name="startdate" placeholder="출발일"/>
                  	</div>
                  	<div class="input-group" style="float: left; width: 50%;">
                    <div class="input-group-addon">종료 일자</div>
                    <input class="form-control input-lg" value="${modifyList.enddate}" id="enddate" type="date" name="enddate" placeholder="도착일"/>
                  	</div>
                  </div>
                  <div style="clear: both;">
				  <textarea class="form-control" rows="10" name="content" id="content" style="width:100%; min-width:260px; height:30em; display:none;">
                  ${modifyList.content}
                  </textarea>
                  </div>
                  <div style="float: right;">
                  <button class="btn btn-border-d btn-round Modify_btn" type="button">수정하기</button>
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
			filebrowserUploadUrl: "${contextPath}/Common/imguploadModify?num=${modifyList.num}",
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