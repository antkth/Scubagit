package com.scuba.serviceCenter;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
public class ServiceCenterVO {
	private String category , title , contents , id , answer;
	private int Num , topQuestions , answerstatus;
	private Timestamp writedate;
}
