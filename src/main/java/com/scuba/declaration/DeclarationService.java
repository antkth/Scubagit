package com.scuba.declaration;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DeclarationService {
	@Autowired
	private DeclarationDAO declarationDAO;
	
	//신고하기
	public int enterDeclaration(HttpServletRequest request,int num){

		//이미 신고했는지 확인
		String user_id = (String)request.getSession().getAttribute("user_id");
		String category = (String)request.getSession().getAttribute("category");
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("category",category);
		map.put("num",num);
		map.put("id",user_id);

		//반환값
		int Check = declarationDAO.CheckDeclaration(map);
		
		if(Check == 0) {
			//신고 번호 지정
			int declarationNum = 1;
			if(declarationDAO.CheckNum()!=0) declarationNum = declarationDAO.getNum();
			
			//피신고자 아이디 구하기
			String respondent="";
				if(category=="resort") {
					respondent = declarationDAO.getResortId(num);
				}else {
					respondent = declarationDAO.getId(map);
				}
			
			//DB 추가 VO 제작
			DeclarationVO declarationVO = new DeclarationVO();
			declarationVO.setReporter(user_id);
			declarationVO.setRespondent(respondent);
			declarationVO.setCategory(category);
			declarationVO.setNum(num);
			declarationVO.setDeclarationNum(declarationNum);
			
			//DB 추가
			declarationDAO.enterDeclaration(declarationVO);
			
			//피신고자 decCount 증가
			declarationDAO.addDecCount(user_id);
			
			//피신고자 decCount 체크후 상태 변경
			if(declarationDAO.CheckDecCount(user_id) >= 10)
				//현제 1로 변경 중 필요시 수정요망
				declarationDAO.changeMemberStatus(user_id);
			
			//신고횟수 일정량 이상시 글 상태 변경
			if(declarationDAO.getDecCount(map) >= 5)
				//현제 1로 변경 중 수정 요망
				if(category=="resort") {
					declarationDAO.changeResortStatus(num);
				}else {
					declarationDAO.changeWrittenStatus(map);
				}
		}
		return Check;
	}
}
