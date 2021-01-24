package com.scuba.underwaterboard;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Component
@Data
public class UnderwaterboardVO {
	private int num;
	private String nickname;
	private String thumbnail;
	private int viewcount;
	private int likecount;
	private Date writedate;
	private String title;
	private String content;
	private String communityname;
	private String introduction;
	private String country;
	private String area;
	private String hashtag;
	private int status;
}
