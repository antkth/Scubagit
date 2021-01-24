package com.scuba.declaration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/declaration/*")
public class DeclarationController {
	@Autowired
	private DeclarationService declarationService;

	//신고 신청		num값 넘겨줄것 . ajax로 사용생각 중  
	@ResponseBody
	@RequestMapping(value = "enterDeclaration" , method = RequestMethod.POST)
	public int enterDeclaration(int num , HttpServletRequest request) {
		// 성공시(0) 반환// 이미 신고했을시 (1) 반환  //
		return declarationService.enterDeclaration(request, num);
	}
}
