package com.scuba.jobSearchboard;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class JobSearchboardDAO {

	@Autowired
	SqlSession sqlsession;
	
	// 구인 게시판 모든(글) 리스트 조회
	public List<JobSearchboardVO> allBoardList1(HashMap<String, Object> map) {
		return sqlsession.selectList("mapper.JobSearchboard.allBoardList1", map);
	}
	
	// 구직 게시판 모든(글) 리스트 조회
	public List<JobSearchboardVO> allBoardList2(HashMap<String, Object> map) {
		return sqlsession.selectList("mapper.JobSearchboard.allBoardList2", map);
	}

	// 글 작성
	public int write(JobSearchboardVO jobsearchboardVO) {
		int insertResult = sqlsession.insert("mapper.JobSearchboard.write", jobsearchboardVO);
		return insertResult;
	}

	// 최신 게시글 번호 조회
	public int getMaxNum() {
		int insertResult = sqlsession.selectOne("mapper.JobSearchboard.getMaxNum");
		System.out.println("인서트 리조트 : " + insertResult);
		return insertResult;
	}

	// 이미지 경로 변경
	public int contentChange(HashMap<String, Object> map) {
		return sqlsession.update("mapper.JobSearchboard.contentChange", map);
	}
	
	//글 상세보기
	public JobSearchboardVO viewList(int contentNum) {
		return sqlsession.selectOne("mapper.JobSearchboard.viewList", contentNum);
	}
	
	//게시글 수정페이지 이동
	public JobSearchboardVO ModifyList(int contentNum) {
		return sqlsession.selectOne("mapper.JobSearchboard.ModifyList", contentNum);
	}
	
	//게시글 수정
	public int Modify(JobSearchboardVO jobsearchboardVO) {
		return sqlsession.update("mapper.JobSearchboard.Modify", jobsearchboardVO);
	}

	//게시글 삭제 시 닉네임 일치여부 체크
	public String idCheck(int contentNum) {
		return sqlsession.selectOne("mapper.JobSearchboard.idCheck", contentNum);
	}

	//게시글 삭제
	public int condelete(int contentNum) {
		return sqlsession.delete("mapper.JobSearchboard.condelete", contentNum);
	}
	
	//리스트 토탈 구하기 (구인)
	public int getTotal1(String search1, String searchsort) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search1", search1);
		map.put("searchsort", searchsort);
		return sqlsession.selectOne("mapper.JobSearchboard.getTotal1", map);
	}

	//리스트 토탈 구하기 (구직)
	public int getTotal2(String search2, String searchsort) {
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("search2", search2);
		map.put("searchsort", searchsort);
		return sqlsession.selectOne("mapper.JobSearchboard.getTotal2", map);
	}
		
		
		
}
