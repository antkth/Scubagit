package com.scuba.underwaterboard;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scuba.freeboard.FreeBoardVO;

@Repository
public class UnderwaterboardDAO {
	
	@Autowired
	private SqlSession sqlsession;

	// 최신 게시글 번호 조회
	public int getMaxNum() {
		return sqlsession.selectOne("mapper.UnderWaterboard.getMaxNum");
	}
	
	// 글 작성(등록)
	public int write(UnderwaterboardVO underwaterboardVO) {
		int insertResult = sqlsession.insert("mapper.UnderWaterboard.write", underwaterboardVO);
		return insertResult;
	}

	// 이미지 경로 변경
	public int contentChange(HashMap<String, Object> map) {
		return sqlsession.update("mapper.UnderWaterboard.contentChange", map);
	}

	// 글 상세보기
	public UnderwaterboardVO viewList(int contentNum) {
		return sqlsession.selectOne("mapper.UnderWaterboard.viewList", contentNum);
	}

	// 수중 게시판 모든(글)리스트 조회
	public List<UnderwaterboardVO> allBoardList(HashMap<String, Object> map) {
		return sqlsession.selectList("mapper.UnderWaterboard.allBoardList", map);
	}

	// 글 수정 페이지 이동
	public UnderwaterboardVO ModifyList(int contentnum) {
		return sqlsession.selectOne("mapper.UnderWaterboard.ModifyList", contentnum);
	}

	// 게시글 수정
	public int Modify(UnderwaterboardVO underwaterboardVO) {
		return sqlsession.update("mapper.UnderWaterboard.Modify", underwaterboardVO);
	}

	// 게시글 삭제 시 닉네임 일치여부 체크
	public String idCheck(int contentNum) {
		return sqlsession.selectOne("mapper.UnderWaterboard.idCheck", contentNum);
	}
	
	// 게시글 삭제
	public int condelete(int contentNum) {
		return sqlsession.delete("mapper.UnderWaterboard.condelete", contentNum);
	}

	//게시글 전체 수 구하기
	public int getTotal(String search) {
		return sqlsession.selectOne("mapper.UnderWaterboard.getTotal", search);
	}
	
	//정렬순 게시 글 조회
	public List<FreeBoardVO> SortList(HashMap<String, Object> map) {
		return sqlsession.selectList("mapper.UnderWaterboard.SortList", map);
	}

}
