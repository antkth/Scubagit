package com.scuba.freeboard;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class FreeBoardVO {
	private int num;
	private String nickname;
	private int viewcount;
	private int likecount;
	private Date writedate;
	private String title;
	private String content;
	private String communityname;
	private int status;
}
