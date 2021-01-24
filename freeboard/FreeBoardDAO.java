package com.scuba.freeboard;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FreeBoardDAO {
	@Autowired
	private SqlSession sqlsession;

	// 자유게시판 모든(글)리스트 조회
	public List<FreeBoardVO> allBoardList() {
		return sqlsession.selectList("mapper.Freeboard.allBoardList");
	}

	// 글 작성
	public int write(FreeBoardVO freeboardVO) {
		int insertResult = sqlsession.insert("mapper.Freeboard.write", freeboardVO);

		return insertResult;
	}
	
	//이미지 경로 변경
	public int contentChange(HashMap<String, Object> map) {
		return sqlsession.update("mapper.Freeboard.contentChange", map);
	}
	
	// 최신 게시글  번호 조회
	public int getMaxNum() {
		return sqlsession.selectOne("mapper.Freeboard.getMaxNum");
	}

	//글 상세보기
	public FreeBoardVO viewList(int contentNum) {
		return sqlsession.selectOne("mapper.Freeboard.viewList", contentNum);
	}
	
	//게시글 삭제
	public int condelete(int contentNum) {
		return sqlsession.delete("mapper.Freeboard.condelete", contentNum);
	}
	
	//게시글 삭제 시 닉네임 일치여부 체크
	public String idCheck(int contentNum) {
		return sqlsession.selectOne("mapper.Freeboard.idCheck", contentNum);
	}
	
	//게시글 수정페이지 이동
	public FreeBoardVO ModifyList(int contentNum) {
		return sqlsession.selectOne("mapper.Freeboard.ModifyList", contentNum);
	}
	
	//게시글 수정
	public int Modify(FreeBoardVO freeBoardVO) {
		return sqlsession.update("mapper.Freeboard.Modify", freeBoardVO);
		
	}

	


}
