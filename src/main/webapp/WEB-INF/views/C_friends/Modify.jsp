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
				} else if($("#appmethod").val() == "") {
					alert("신청방법을 입력해주세요.");
					$("#appmethod").focus();
					return false;
				} else if($("#state").val() == "") {
					alert("목적지를 입력해주세요.");
					$("#state").focus();
					return false;
				} else if($("#startdate").val() == "") {
					alert("출발 일자를 선택해주세요.");
					$("#startdate").focus();
					return false;
				} else if($("#enddate").val() == "") {
					alert("도착 일자를 선택해주세요.");
					$("#enddate").focus();
					return false;
				} else if($("#membercount").val() == "") {
					alert("총 인원을 입력해주세요.");
					$("#enddate").focus();
					return false;
				} else if($("#nowcount").val() == "") {
					alert("현재 인원을 입력해주세요.");
					$("#enddate").focus();
					return false;
				} else if($("#phone").val() == "" && $("#kakao").val() == "") {
					alert("휴대폰번호 또는 카카오 아이디를 하나 이상 입력해주세요.");
					$("#phone").focus();
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
					$("#wform").attr("action", "${contextPath}/friendsBoard/Modifyinsert");
					$("#wform").submit();
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
	    			location.href="${contextPath}/friendsBoard/modiFyCancle?num="+${modifyList.num};
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
                <h4 class="font-alt mb-0">동료모집 글 수정</h4>
                <hr class="divider-w mt-10 mb-20">
                <form id="wform" class="form" role="form" method="post">
               	  <div class="form-group" style="float: left; margin-right: 5%; width: 30%;">
                  	<h5><b>번호</b></h5>
                    <input class="form-control input-lg" name="num" type="text" value="${modifyList.num}" readonly="readonly"/>
                  </div>            
                  <div class="form-group" style="float: left; width: 30%;">
                  	<h5><b>작성날짜</b></h5>
                    <input class="form-control input-lg" type="text" value="${modifyList.writedate}" readonly="readonly"/>
                  </div>
                  <div class="form-group" style="clear: both;">
                  	<h5><b>제목</b></h5>
                    <input class="form-control input-lg" name="title" id="title" type="text" value="${modifyList.title}"/>
                  </div>
                  <div class="form-group">
                  	<h5><b>인사말</b></h5>
                  <textarea class="form-control" id="introduction" name="introduction" rows="2" style="resize: none;">${modifyList.introduction}</textarea>
                  </div>
                  <div class="form-group">
                  	<h5><b>신청방법</b></h5>
                  <textarea class="form-control" id="appmethod" name="appmethod" rows="2" style="resize: none;">${modifyList.appmethod}</textarea>
                  </div>
                  <div class="form-group">
                  	<h5><b>여행 계획</b></h5>
                    <input class="form-control input-lg" id="state" name="state" value="${modifyList.state}" type="text"/>
                  <div class="input-group" style="float: left; width: 50%;">
                    <div class="input-group-addon">출발일</div>
                    <input class="form-control input-lg" id="startdate" value="${modifyList.startdate}" name="startdate" type="date" name="date"/>
                  </div>
                  <div class="input-group" style="float: left; width: 50%;">
                    <div class="input-group-addon">도착일</div>
                    <input class="form-control input-lg" id="enddate" value="${modifyList.enddate}" name="enddate" type="date" name="date"/>
                  </div>
                  </div>
                  <div class="form-group">
                  	<h5><b>모집 인원</b></h5>
                    <input class="form-control input-lg" id="membercount" name="membercount" value="${modifyList.membercount}" type="text" style="width: 50%; float: left;"/>
                    <input class="form-control input-lg" id="nowcount" name="nowcount" type="text" value="${modifyList.nowcount}" style="width: 50%; float: left;"/>
                  </div>
                  <div class="form-group" style="clear: both; padding-top: 5px;">
                  	<h5><b>연락처</b></h5>
                    <input class="form-control input-lg" id="phone" name="phone" value="${modifyList.phone}" type="text" style="width: 50%; float: left;"/>
                    <input class="form-control input-lg" id="kakao" name="kakao" value="${modifyList.kakao}" type="text" style="width: 50%; float: left;"/>
                  </div>
                  <div style="clear: both;">
                  <textarea class="form-control" rows="10" name="content" id="content" style="width:100%; min-width:260px; height:30em; display:none;">
                  	${modifyList.content}
                  </textarea>
                  </div>
                  <div class="form-group">
                  	<h5><b>태그</b></h5>
                  <textarea class="form-control" rows="2" style="resize: none;"></textarea>
                  </div>
                  <div style="float: right;">
                  <button class="btn btn-border-d btn-round wrt_btn" type="button">수정하기</button>
                  <button class="btn btn-border-d btn-round back_btn" type="button">취소</button>
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
	//신청방법 글자 수 정규식
	$("#appmethod").on('blur',function(){
		if($("#appmethod").val() != "") {
			var title = $("#appmethod").val();
			var titletrim = title.trim();
			var pattern = /^.{1,250}$/; 
			if(!title.trim() == "") {
				if(!title.match(pattern)) {
					alert("신청방법을 1~250자 사이로 입력해주세요.");
					$("#appmethod").val("");
					$("#appmethod").focus();
				}
			}else {
				alert("공백이 아닌 신청방법을 1~250자 사이로 입력해주세요.");
				$("#appmethod").val("");
				$("#appmethod").focus();
			}
		}
	});
	//목적지 글자 수 정규식
	$("#state").on('blur',function(){
		if($("#state").val() != "") {
			var title = $("#state").val();
			var titletrim = title.trim();
			var pattern = /^.{1,50}$/; 
			if(!title.trim() == "") {
				if(!title.match(pattern)) {
					alert("목적지를 1~50자 사이로 입력해주세요.");
					$("#state").val("");
					$("#state").focus();
				}
			}else {
				alert("공백이 아닌 목적지를 1~50자 사이로 입력해주세요.");
				$("#state").val("");
				$("#state").focus();
			}
		}
	});
	//카카오 아이디 정규식
	$("#kakao").on('blur',function(){
		if($("#kakao").val() != "") {
			var title = $("#kakao").val();
			var titletrim = title.trim();
			var pattern = /^.{1,100}$/; 
			if(!title.trim() == "") {
				if(!title.match(pattern)) {
					alert("아이디를 1~100자 사이로 입력해주세요.");
					$("#kakao").val("");
					$("#kakao").focus();
				}
			}else {
				alert("공백이 아닌 아이디를 1~100자 사이로 입력해주세요.");
				$("#kakao").val("");
				$("#kakao").focus();
			}
		}
	});
	//총 인원수 정규식
	$("#membercount").on('keyup',function(){
		if($("#membercount").val() != "") {
			var title = $("#membercount").val();
			var titletrim = title.trim();
			var pattern = /^[0-9]*$/; 
			if(!title.trim() == "") {
				if(!title.match(pattern)) {
					alert("숫자만 입력해주세요.");
					$("#membercount").val("");
					$("#membercount").focus();
				}
			}else {
				alert("공백이 아닌 숫자를 입력해주세요.");
				$("#membercount").val("");
				$("#membercount").focus();
			}
		}
	});
	//현재 인원수 정규식
	$("#nowcount").on('keyup',function(){
		if($("#nowcount").val() != "") {
			var title = $("#nowcount").val();
			var titletrim = title.trim();
			var pattern = /^[0-9]*$/; 
			if(!title.trim() == "") {
				if(!title.match(pattern)) {
					alert("숫자만 입력해주세요.");
					$("#nowcount").val("");
					$("#nowcount").focus();
				}
			}else {
				alert("공백이 아닌 숫자를 입력해주세요.");
				$("#nowcount").val("");
				$("#nowcount").focus();
			}
		}
	});
	//연락처 정규식
	$("#phone").on('blur',function(){
		if($("#phone").val() != "") {
			var title = $("#phone").val();
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