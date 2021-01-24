package com.scuba.friendsboard;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class FriendsBoardVO {

	private int num;
	private String nickname;
	private int viewcount;
	private Date writedate;
	private int likecount;
	private String title;
	private String content;
	private String communityname;
	private String introduction;
	private String appmethod;
	private String state;
	private Date startdate;
	private Date enddate;
	private int membercount;
	private int nowcount;
	private String phone;
	private String kakao;
	private int status;
	private int memberstatus;
	private String hashtag;
	
}
