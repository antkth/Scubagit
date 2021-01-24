package com.scuba.resort;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Component
public class ResortVO {
	private int num ,resortStatus , viewCount;
	private String nickName , resortName, phoneNumber, cacaoId , homepageAddress;
	private String simpleIntroduce , contents , tag , address , country;
	private String image1 , image2 , image3 , city , grade;
	private Timestamp enterDate;
}
