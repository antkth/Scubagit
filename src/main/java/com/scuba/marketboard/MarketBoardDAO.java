package com.scuba.marketboard;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scuba.jobSearchboard.JobSearchboardVO;

@Repository
public class MarketBoardDAO {

	@Autowired
	private SqlSession sqlsession;

	// 팝니다게시판 모든(글) 리스트 조회
	public List<MarketBoardVO> allBoardList1(HashMap<String, Object> map) {
		return sqlsession.selectList("mapper.Marketboard.allBoardList1", map);
	}	
	
	// 삽니다 게시판 모든(글) 리스트 조회
	public List<MarketBoardVO> allBoardList2(HashMap<String, Object> map) {
		return sqlsession.selectList("mapper.Marketboard.allBoardList2", map);
	}		
	
	// 글 작성
	public int write(MarketBoardVO marketboardVO) {
		int insertResult = sqlsession.insert("mapper.Marketboard.write", marketboardVO);
		return insertResult;
	}

	// 최신 게시글 번호 조회
	public int getMaxNum() {
		int insertResult = sqlsession.selectOne("mapper.Marketboard.getMaxNum");
		return insertResult;
	}

	// 이미지 경로 변경
	public int contentChange(HashMap<String, Object> map) {
		return sqlsession.update("mapper.Marketboard.contentChange", map);
	}

	//글 상세보기
	public MarketBoardVO viewList(int contentNum) {
		return sqlsession.selectOne("mapper.Marketboard.viewList", contentNum);
	}

	//게시글 수정페이지 이동
	public MarketBoardVO ModifyList(int contentNum) {
		return sqlsession.selectOne("mapper.Marketboard.ModifyList", contentNum);
	}
	
	//게시글 수정
	public int Modify(MarketBoardVO marketboardVO) {
		return sqlsession.update("mapper.Marketboard.Modify", marketboardVO);
	}

	//게시글 삭제 시 닉네임 일치여부 체크
	public String idCheck(int contentNum) {
		return sqlsession.selectOne("mapper.Marketboard.idCheck", contentNum);
	}

	//게시글 삭제
	public int condelete(int contentNum) {
		return sqlsession.delete("mapper.Marketboard.condelete", contentNum);
	}

	//리스트 토탈 구하기 (팝니다)
	public int getTotal1(String search1, String searchsort) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search1", search1);
		map.put("searchsort", searchsort);		
		return sqlsession.selectOne("mapper.Marketboard.getTotal1", map);
	}

	//리스트 토탈 구하기 (삽니다)
	public int getTotal2(String search2, String searchsort) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search2", search2);
		map.put("searchsort", searchsort);
		return sqlsession.selectOne("mapper.Marketboard.getTotal2", map);
	}

	public int dealState(int state, int num) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("state", state);
		map.put("num", num);
		return sqlsession.update("mapper.Marketboard.dealState", map);
	}

}
