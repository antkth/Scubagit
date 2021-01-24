package com.scuba.event;

import java.sql.Date;
import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
public class EventVO {
	private int num, viewcount , status ;
	private String nickname , thumbnail , title , content , communityname , introduction;
	private Date startdate , enddate;
	private Timestamp writeDate;
}
