package com.scuba.reply;


import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class ReplyVO {
	
	private int num; //댓글 번호
	private int postnum; //게시글 번호
	private String communityname; //커뮤니티 카테고리
	private String replycontent; //댓글 내용
	private Date writedate; //댓글 작성일자
	private String nickname; //댓글 작성자
	private int replygroup_num; //댓글 그룹번호
	private int replytype; //댓글 구분 0 : 댓글 / 1 : 대댓글
	private int status; //댓글 상태 0:게시 / 1:삭제
	private String image; //멤버 이미지
	
}
