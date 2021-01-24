package com.scuba.declaration;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class DeclarationDAO {
	@Autowired
	private SqlSession sqlSession;
	
	//신고 중복 확인
	public int CheckDeclaration(HashMap<String,Object> map) {
		return sqlSession.selectOne("mapper.Declaration.CheckDeclaration",map);
	}
	//신고 번호 체크하기
	public int CheckNum() {
		return sqlSession.selectOne("mapper.Declaration.CheckNum");
	}
	//신고 번호 구하기
	public int getNum() {
		return sqlSession.selectOne("mapper.Declaration.getNum");
	}
	//신고하기
	public void enterDeclaration(DeclarationVO declarationVO) {
		sqlSession.insert("mapper.Declaration.enterDeclaration", declarationVO);
	}
	//피신고자 아이디 구하기
	public String getId(HashMap<String,Object> map) {
		return sqlSession.selectOne("mapper.Declaration.getId",map);
	}
	//피신고자 decCount 증가
	public void addDecCount(String id) {
		sqlSession.update("mapper.Declaration.addDecCount",id);
	}
	//decCount 체크
	public int CheckDecCount(String id) {
		return sqlSession.selectOne("mapper.Declaration.CheckDecCount",id);
	}
	//사용자 상태 변경
	public void changeMemberStatus(String id) {
		sqlSession.update("mapper.Declaration.changeMemberStatus",id);
	}
	//신고당한 횟수 가져오기
	public int getDecCount(HashMap<String,Object> map) {
		return sqlSession.selectOne("mapper.Declaration.getDecCount",map);
	}
	//글 상태 변경
	public void changeWrittenStatus(HashMap<String,Object> map) {
		sqlSession.update("mapper.Declaration.changeWrittenStatus",map);
	}
	//리조트 피신고자 가져오기
	public String getResortId(int num) {
		return sqlSession.selectOne("mapper.Declaration.getResortId",num);
	}
	//리조트 상태 변경
	public void changeResortStatus(int num) {
		sqlSession.update("mapper.Declaration.changeResortStatus",num);
	}
}
