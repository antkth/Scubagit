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
				} else if($("#marketcate > option:selected").val() == "") {
					alert("팝니다/삽니다를 선택 해주세요.");
					$("#marketcate").focus();
					return false;
				} else if($("#price").val() == "") {
					alert("가격을 입력해 주세요.");
					$("#price").focus();
					return false;
				} else if($("#productstatus > option:selected").val() == "") {
					alert("물품 상태를 선택해주세요.");
					$("#productstatus").focus();
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
					$("#wform").attr("action", "${contextPath}/marketBoard/Modifyinsert");
					$("#wform").submit();
				}
			});
			
			//돌아가기(수정 취소)버튼
	    	$(".back_btn").click(function() {
	    		if(confirm("글 수정을 취소 하시겠습니까 ?") == true) {
	    			location.href="${contextPath}/marketBoard/modiFyCancle?num="+${modifyList.num};
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
                <h4 class="font-alt mb-0">중고장터 글 수정</h4>
                <hr class="divider-w mt-10 mb-20">
                <form class="form" id="wform" role="form" method="post">
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
		                <select class="form-control" id="marketcate" name="marketcategory">
		                  <option selected="selected" id="marketcate" disabled="disabled" value="">선택해주세요 .</option>
		                  <option value="팝니다">팝니다</option>
		                  <option value="삽니다">삽니다</option>
		                </select>
                  </div>
                  <div class="pa" style="display: flex;">
                  <div class="form-group" style="flex: 1; margin-right: 1%;">
                  	<h5><b>연락처</b></h5>
                    <input class="form-control input-lg" name="phone" type="text" value="${modifyList.phone}"/>
                  </div>
                  <div class="form-group" style="flex: 1; margin-right: 1%;">
                  	<h5><b>희망가격</b></h5>
                    <input class="form-control input-lg" name="price" type="text" value="${modifyList.price}"/>
                  </div>
                  <div class="form-group" style="flex: 1; margin-right: 1%;">
                  	<h5><b>물품상태</b></h5>
		                <select class="form-control" id="productstatus" name="productstatus" style="height: 43px;">
		                  <option selected="selected" disabled="disabled" value="">선택해주세요 .</option>
		                  <option value="좋음">좋음</option>
		                  <option value="양호">양호</option>
		                  <option value="수리요함">수리요함</option>
		                </select>
                  </div>
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
			}
			
		}
	});
	//가격 정규식
	$("#price").on('blur',function(){
		if($("#price").val() != "") {
			var title = $("#price").val();
			var titletrim = title.trim();
			var pattern = /^.{1,50}$/; 
			if(!title.trim() == "") {
				if(!title.match(pattern)) {
					alert("가격을 1~20자 사이로 입력해주세요.");
					$("#price").val("");
					$("#price").focus();
				}
			}else {
				alert("공백이 아닌 가격을 1~20자 사이로 입력해주세요.");
				$("#price").val("");
				$("#price").focus();
			}
			
		}
	});
	//연락처 정규식
	$("#phone").on('blur',function(){
		if($("#phone").val() != "") {
			var title = $("#phone").val();
			console.log(title);
			var titletrim = title.trim();
			var pattern = /^\d{3}-\d{3,4}-\d{4}$/;
			if(!title.trim() == "") {
				if(!title.match(pattern)) {
					alert("***-****-**** 형식으로 입력해주세요.");
					$("#phone").val("");
					$("#phone").focus();
				}
			}else {
				alert("공백이 아닌 연락처를 ***-****-**** 형식으로 입력해주세요.");
				$("#phone").val("");
				$("#phone").focus();
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