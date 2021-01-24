package com.scuba.declaration;

import java.sql.Timestamp;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Component
@Getter
@Setter
public class DeclarationVO {
	private int declarationNum,num;
	private String reporter,respondent,category;
	private Timestamp declarationDate;
}
