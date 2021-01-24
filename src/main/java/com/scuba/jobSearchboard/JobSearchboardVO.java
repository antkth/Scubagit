package com.scuba.jobSearchboard;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class JobSearchboardVO {
	private int num;
	private String nickname;
	private int viewcount;
	private Date writedate;
	private int likecount;
	private String title;
	private String content;
	private String communityname;
	private String jobcategory;
	private int status;
}
