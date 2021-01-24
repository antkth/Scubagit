package com.scuba.notice;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
@ToString
@Getter
@Setter
@Component
public class NoticeVO {
	private int num , viewcount , status;
	private String nickname , title , content , communityname ;
	private Timestamp writedate;
}
