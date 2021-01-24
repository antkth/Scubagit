<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	
	//댓글 리스트 가져오기 (신박하네 ??)
	function getReplyList(groupnum, sort) {
		//해당 게시글 번호
		var postnum = ${viewList.num};
		$.ajax({
			url : "${contextPath}/reply/replyList",
			type : "post",
			data : {"postnum":postnum},
			success : function(data) {
					var str = "";
					$("#repList").empty();
					//댓글 , 대댓글 등록시 댓글 등록칸 비워주기
					$("#replycontent").val("");
					str = ReplyList(data);
					$("#repList").append(str);
					if(sort == 1) {
						$(".rep2"+groupnum).show();
					}
			},
			error : function(data) {
				alert("통신 실패");
				$("#replycontent").val("");
			}
		});
	}
	
	//댓글 리스트 공통메서드
	function ReplyList(data) {
		var str = "";
		str += "<div class='comment clearfix'>";
		$.each(data.replyList, function(i) {
			var thereis = 0;
			var num = data.replyList[i].num;
			var img = data.replyList[i].image;
			var nickname = data.replyList[i].nickname;
			var replycontent = data.replyList[i].replycontent;
			var replygroup_num = data.replyList[i].replygroup_num;
			var replytype = data.replyList[i].replytype;
			var status = data.replyList[i].status;
			var writeDate = Timestampformat(data.replyList[i].writedate);
			//댓글
			if(status != 1) {
				str += "<div class='comment-avatar'>";
				str += " <img src='${contextPath}/resources/upload/member/"+img+"' alt='avatar'>";
				str += " </div>";
				str += "<div class='comment-content clearfix'>";
				str += " <div class='comment-author font-alt'>"+nickname+"</div>";
				str += "<div id='replymodform"+num+"'>"
				str += "  <div class='comment-body'>";
				str += "	<p id='repconarea"+num+"'>"+replycontent+"</p>";
				str += "  </div>";
				str += " <div id='replyform"+num+"' class='comment-meta font-alt'>"+writeDate+" - ";
				if("${user_nickname}"==nickname) {
					str += "<a class='replymodify' data-sort='0' href='javascript:;' data-groupnum='"+num+"' data-num='"+num+"'>수정</a> ㅣ <a class='replydelete_btn' data-sort='0' href='javascript:;' data-groupnum='"+num+"' data-num='"+num+"'>삭제</a> ㅣ";
				}
				str += "<a class='reply' href='javascript:;' data-groupnum='"+num+"' data-sort='0' data-num='"+num+"'>댓글</a>";
				str += " </div>";
				str += " </div>";
					//댓글 리스트 보기
					$.each(data.rereplyList, function(z) {
						var replygroup_num3 = data.rereplyList[z].replygroup_num;
						var status3 = data.rereplyList[z].status;
						if(status3 != 1) {
							if(num == replygroup_num3){ ++thereis; };
						}
					});
					if(thereis >= 1) {
						str += "<a href='javascript:;' class='listshow' id='listshow"+num+"' data-repnum='"+num+"'>";
						str += "댓글 보기";
						str += "</a>";
					}
				str += "</div>";
					//대댓글
					$.each(data.rereplyList, function(j) {
						var num2 = data.rereplyList[j].num;
						var img2 = data.rereplyList[j].image;
						var nickname2 = data.rereplyList[j].nickname;
						var replycontent2 = data.rereplyList[j].replycontent;
						var replygroup_num2 = data.rereplyList[j].replygroup_num;
						var replytype2 = data.rereplyList[j].replytype;
						var status2 = data.rereplyList[j].status;
						var writeDate2 = Timestampformat(data.rereplyList[j].writedate);
					   if(status2 != 1) {
						if(num == replygroup_num2) {
							str += "<div class='comment clearfix rep2"+num+"' style='display: none;'>";
							str += " <div class='comment-avatar'>";
							str += " <img src='${contextPath}/resources/upload/member/"+img2+"' alt='avatar'>";
							str += " </div>";
							str += "<div class='comment-content clearfix'>";
							str += " <div class='comment-author font-alt'>"+nickname2+"</div>";
							str += "<div id='replymodform"+num2+"'>"
							str += "<div class='comment-body'>";
							str += "<p id='repconarea"+num2+"'>"+replycontent2+"</p>";
							str += "</div>";
							str += " <div id='rereplyform"+num2+"' class='comment-meta font-alt'>"+writeDate2+" - ";
							if("${user_nickname}"==nickname2) {
								str += "<a class='replymodify' href='javascript:;' data-sort='1' data-groupnum='"+num+"' data-num='"+num2+"'>수정</a> ㅣ <a class='replydelete_btn' href='javascript:;' data-sort='1' data-groupnum='"+num+"' data-num='"+num2+"'>삭제</a> ㅣ";
							}
							str += "<a class='reply' href='javascript:;' data-nname='"+nickname2+"' data-sort='1' data-groupnum='"+num+"' data-num='"+num2+"'>댓글</a>";
							str += "</div>";
							str += "</div>";
							str += "</div>";
							str += "</div>";
						}
					   }
					});
				} // 댓글 상태
			});
			str += "</div>";
			return str;
	}
	
	//날짜 포맷
	function Timestampformat(writedate) {
		//날짜 포맷	//timestamp 포맷
		const timestamp = writedate;
		var date = new Date(timestamp);
		var year = date.getFullYear();
		var month = (date.getMonth()+1);
		var day = date.getDate();
		return year+"-"+(("00"+month.toString()).slice(-2))+"-"+(("00"+day.toString()).slice(-2));
	}
	
	//HTML 태그 제거 function
	function htmlDel(content) {
		var changeHTML = content.replace(/(<([^>]+)>)/ig,"");
		return changeHTML.replace(/(?:\r\n|\r|\n)/g, '<br />');
	}
	
	//댓글 등록
	$(document).on("click", ".reply_btn", function() {
		//해당 게시글 번호
		var postnum = ${viewList.num};
		//HTMl 태그 제거
		var replycontent = htmlDel($("#replycontent").val());
		//유효성 및 정규식
		if(replycontent.trim() == "") {
			alert("공백이 아닌 댓글을 500자 이내로 작성해주세요.");
			$("#replycontent").val("");
			$("#replycontent").focus();
			return;
		} else if(replycontent == "") {
			alert("내용을 입력해주세요.");
			$("#replycontent").focus();
			return;
		} else if(replycontent.length >= 500) {
			alert("댓글을 500자 이내로 작성해주세요.");
			var contentChange = replycontent.replace(/<br\s*[\/]?>/gi, "\r\n");
			$("#replycontent").val(contentChange.slice(0,499));
			$("#replycontent").focus();
			return;
		}
		
		$.ajax({
			url : "${contextPath}/reply/replywrite",
			type : "post",
			data : {"replycontent":replycontent, 
					"postnum":postnum},
			success : function(data) {
				if(data.loginstatus == "No") {
					alert("로그인 후 이용해주세요");
					location.href="${contextPath}/member/login";
				} else {
					var str = "";
					$("#repList").empty();
					//댓글 , 대댓글 등록시 댓글 등록칸 비워주기
					$("#replycontent").val("");
					str = ReplyList(data);
					$("#repList").append(str);
				}
			},
			error : function(data) {
				alert("댓글 등록 실패");
				$("#replycontent").val("");
				location.href="${contextPath}/freeBoard/freeBoardView?num=${viewList.num}&nowpage=${nowpage}&search=${search}&sort=${sort}";
				
			}
		});
	});
	
	//댓글의 댓글 버튼 / 댓글 입력 폼 생성
	$(document).on("click", ".reply", function() {
		//부모글 번호
		var groupnum = $(this).data("groupnum");
		// 대댓글 , 대대댓글 구분
		var sort = $(this).data("sort"); 
		//해당 댓글 번호
		var num = $(this).data("num");
		//댓글 날짜
		var writedate = $(this).data("wrdate");
		var str = "";
		//대댓글일때
		if (sort == 0) {
			$("#replyform"+num).empty();
			str += "<textarea class='form-control' id='replybox"+num+"' name='replycontent' rows='4' placeholder='댓글을 입력하세요' style='resize: none;'></textarea>";
			str += "<button class='btn btn-border-d btn-round replybox_btn' data-groupnum='"+groupnum+"' data-num='"+num+"' type='button' style='float: right; margin-top: 2%;'>댓글 등록</button>"
			str += "<button class='btn btn-border-d btn-round repcancle_btn' data-sort='0' data-groupnum='"+groupnum+"' data-num='"+num+"' type='button' style='float: right; margin-top: 2%; margin-right: 1%;'>취소</button>"
			$("#replyform"+num).append(str);
		} else if (sort == 1) { //대대댓글일때
			var name = $(this).data("nname");
			$("#rereplyform"+num).empty();
			str += "<textarea class='form-control' id='replybox"+num+"' name='replycontent' rows='4' placeholder='댓글을 입력하세요' style='resize: none;'>@"+name+" </textarea>";
			str += "<button class='btn btn-border-d btn-round replybox_btn' data-groupnum='"+groupnum+"' data-num='"+num+"' type='button' style='float: right; margin-top: 2%;'>댓글 등록</button>"
			str += "<button class='btn btn-border-d btn-round repcancle_btn' data-sort='1' data-groupnum='"+groupnum+"' type='button' style='float: right; margin-top: 2%; margin-right: 1%;'>취소</button>"
			$("#rereplyform"+num).append(str);
		}
	});
	
	//댓글 쓰기 취소
	$(document).on("click", ".repcancle_btn", function() {
		//해당 댓글(부모글) 번호
		var groupnum = $(this).data("groupnum");
		var sort = $(this).data("sort");
		getReplyList(groupnum, sort);
	});
	
	//대댓글 등록
	$(document).on("click", ".replybox_btn", function() {
		//해당 댓글(자신) 번호
		var num = $(this).data("num");
		//해당 댓글(부모글) 번호
		var groupnum = $(this).data("groupnum");
		//해당 게시글 번호
		var postnum = ${viewList.num};
		//HTMl 태그 제거
		var replycontent = htmlDel($("#replybox"+num).val());
		//유효성 및 정규식
		if(replycontent == "") {
			alert("내용을 입력해주세요.");
			$("#replycontent").focus();
			return;
		} else if(replycontent.length >= 500) {
			alert("댓글을 500자 이내로 작성해주세요.");
			$("#replycontent").text(replycontent.slice(0,499));
			$("#replycontent").focus();
			return;
		}
		$.ajax({
			url : "${contextPath}/reply/rereplywrite",
			type : "post",
			data : {"replygroup_num" : groupnum, 
					"replycontent" : replycontent,
					"postnum" : postnum},
			success : function(data) {
				var str = "";
				if(data.loginstatus == "No") {
					alert("로그인 후 이용해주세요");
					location.href="${contextPath}/member/login";
				} else {
				$("#repList").empty();
				//댓글 , 대댓글 등록시 댓글 등록칸 비워주기
				$("#replycontent").val("");
				str = ReplyList(data);
				$("#repList").append(str);
				
					//댓글리스트 보여주기
				$(".rep2"+groupnum).show();
				$("#listshow"+groupnum).html("댓글 닫기");
				//슬라이드 효과 제거 시 주석 제거
//					$("#listshow"+groupnum).attr("class", "listhide");
//					$("#listshow"+groupnum).attr("id", "listhide"+groupnum);
				}
			},
			error : function(data) {
				alert("댓글 등록 실패");
				$("#replycontent").val("");
				location.href="${contextPath}/freeBoard/freeBoardView?num=${viewList.num}&nowpage=${nowpage}&search=${search}&sort=${sort}";
			}
		});
	});
	
	//댓글 수정 입력폼 생성
	$(document).on("click", ".replymodify", function() {
		//부모글 번호
		var groupnum = $(this).data("groupnum");
		var sort = $(this).data("sort");
		//해당 댓글 번호
		var num = $(this).data("num");
		//해당 댓글 내용
		var content = $("#repconarea"+num).html();
		var contentChange = content.replace(/<br\s*[\/]?>/gi, "\r\n");
		var str = "";
		//대댓글일때
			$("#replymodform"+num).empty();
			if(sort == 0) {
				str += "<textarea class='form-control' id='replymodbox"+num+"' name='replycontent' rows='4' placeholder='댓글을 입력하세요' style='resize: none;'>"+contentChange+"</textarea>";
    			str += "<button class='btn btn-border-d btn-round replymod_btn' data-sort='0' data-groupnum='"+groupnum+"' data-num='"+num+"' type='button' style='float: right; margin-top: 2%;'>댓글 수정</button>"
    			str += "<button class='btn btn-border-d btn-round repcancle_btn' data-groupnum='"+groupnum+"' data-sort='0' type='button' style='float: right; margin-top: 2%; margin-right: 1%;'>취소</button>"
			} else if(sort == 1){
				str += "<textarea class='form-control' id='replymodbox"+num+"' name='replycontent' rows='4' placeholder='댓글을 입력하세요' style='resize: none;'>"+contentChange+"</textarea>";
    			str += "<button class='btn btn-border-d btn-round replymod_btn' data-sort='1' data-groupnum='"+groupnum+"' data-num='"+num+"' type='button' style='float: right; margin-top: 2%;'>댓글 수정</button>"
    			str += "<button class='btn btn-border-d btn-round repcancle_btn' data-groupnum='"+groupnum+"' data-sort='1' type='button' style='float: right; margin-top: 2%; margin-right: 1%;'>취소</button>"
			}
			
			$("#replymodform"+num).append(str);
	});
	
	//댓글 수정
	$(document).on("click", ".replymod_btn", function() {
		//부모글 번호
		var groupnum = $(this).data("groupnum");
		var sort = $(this).data("sort");
		//해당 댓글(자신) 번호
		var num = $(this).data("num");
		//해당 게시글 번호
		var postnum = ${viewList.num};
		//HTMl 태그 제거
		var replycontent = htmlDel($("#replymodbox"+num).val());
		//유효성 및 정규식
		if(replycontent == "") {
			alert("내용을 입력해주세요.");
			$("#replycontent").focus();
			return;
		} else if(replycontent.length >= 500) {
			alert("댓글을 500자 이내로 작성해주세요.");
			$("#replycontent").val(replycontent.slice(0,499));
			$("#replycontent").focus();
			return;
		}
		$.ajax({
			url : "${contextPath}/reply/replymodify",
			type : "post",
			data : {"replycontent" : replycontent,
					"postnum" : postnum,
					"num" : num},
			success : function(data) {
				var str = "";
				$("#repList").empty();
				$("#replycontent").val("");
				str = ReplyList(data);
				$("#repList").append(str);
				
					//댓글리스트 보여주기
					if(sort == 1) {
						$(".rep2"+groupnum).show();
						$("#listshow"+groupnum).html("댓글 닫기");
					}
			},
			error : function(data) {
				alert("댓글 수정 실패");
				$("#replycontent").val("");
				location.href="${contextPath}/freeBoard/freeBoardView?num=${viewList.num}&nowpage=${nowpage}&search=${search}&sort=${sort}";
			}
		});
	});
	
	//댓글 삭제
	$(document).on("click", ".replydelete_btn", function() {
		//부모글 번호
		var groupnum = $(this).data("groupnum");
		var sort = $(this).data("sort");
		//해당 댓글(자신) 번호
		var num = $(this).data("num");
		//해당 게시글 번호
		var postnum = ${viewList.num};
		var notice = "";
		if(sort ==0) {
			notice = "하위 댓글도 다 삭제됩니다. 댓글을 삭제하시겠습니까? ";
		} else if(sort ==1) {
			notice = "댓글을 삭제하시겠습니까? ";
		}
		if(confirm(notice)==true) {
			$.ajax({
    			url : "${contextPath}/reply/replydelete",
    			type : "post",
    			data : {"replygroup_num" : groupnum,
    					"postnum" : postnum,
    					"num" : num,
    					"sort" : sort},
    			success : function(data) {
    				var str = "";
					$("#repList").empty();
					$("#replycontent").val("");
					str = ReplyList(data);
					$("#repList").append(str);
					
 					//댓글리스트 보여주기
 					if(sort == 1) {
 						$(".rep2"+groupnum).show();
 						$("#listshow"+groupnum).html("댓글 닫기");
 					}
				},
				error : function(data) {
					alert("댓글 삭제 실패");
					$("#replycontent").val("");
					location.href="${contextPath}/freeBoard/freeBoardView?num=${viewList.num}&nowpage=${nowpage}&search=${search}&sort=${sort}";
				}
    		});
		} else { //삭제 취소시
			return;
		}
	});
	
	//댓글 보기
	$(document).on("click", ".listshow", function() {
		//해당 댓글 번호(부모 댓글 번호)
		var repnum = $(this).data("repnum");

		//2. 슬라이드 효과 on
		if($(".rep2"+repnum).is(":visible")){
			$(".rep2"+repnum).slideUp();
			$("#listshow"+repnum).html("댓글 보기");
		}else{
			$(".rep2"+repnum).slideDown();
			$("#listshow"+repnum).html("댓글 닫기");
		}
	});	
	
	

