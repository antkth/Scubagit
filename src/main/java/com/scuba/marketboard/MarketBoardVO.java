package com.scuba.marketboard;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class MarketBoardVO {
	private int num;
	private String nickname;
	private int viewcount;
	private Date writedate;
	private int likecount;
	private String title;
	private String content;
	private String communityname;
	private int dealstatus;
	private String phone;
	private String price;
	private String productstatus;
	private String marketcategory;
	private int status;
	
	
}
