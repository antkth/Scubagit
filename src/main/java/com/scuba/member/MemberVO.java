package com.scuba.member;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
public class MemberVO {
	private String id;
	private String pwd;
	private String nickname;
	private String email , image;
	private int status;
	private int decCount;
}
