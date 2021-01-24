package com.scuba.reviewboard;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scuba.freeboard.FreeBoardVO;

@Repository
public class ReviewboardDAO {
	
	@Autowired
	private SqlSession sqlsession;

	// 최신 게시글 번호 조회
	public int getMaxNum() {

		return sqlsession.selectOne("mapper.Reviewboard.getMaxNum");
	}

	// 글 작성(등록)
	public int write(ReviewboardVO reviewboardVO) {

		int insertResult = sqlsession.insert("mapper.Reviewboard.write", reviewboardVO);
		return insertResult;
	}

	// 이미지 경로 변경
	public int contentChange(HashMap<String, Object> map) {
		return sqlsession.update("mapper.Reviewboard.contentChange", map);
	}
	
	// 글 상세보기
	public ReviewboardVO viewList(int contentNum) {
		return sqlsession.selectOne("mapper.Reviewboard.viewList", contentNum);
	}

	// 후기 게시판 모든(글)리스트 조회
	public List<ReviewboardVO> allBoardList(HashMap<String, Object> map) {
		return sqlsession.selectList("mapper.Reviewboard.allBoardList", map);
	}

	// 글 수정 페이지 이동
	public ReviewboardVO ModifyList(int contentnum) {
		return sqlsession.selectOne("mapper.Reviewboard.ModifyList", contentnum);
	}

	// 게시글 수정
	public int Modify(ReviewboardVO reviewboardVO) {
		return sqlsession.update("mapper.Reviewboard.Modify", reviewboardVO);
	}

	// 게시글 삭제 시 닉네임 일치여부 체크
	public String idCheck(int contentNum) {
		return sqlsession.selectOne("mapper.Reviewboard.idCheck", contentNum);
	}
	
	// 게시글 삭제
	public int condelete(int contentNum) {
		return sqlsession.delete("mapper.Reviewboard.condelete", contentNum);
	}
	
	//게시글 총 개수 구하기
	public int getTotal(String search, String consort) {
		System.out.println("뭔데 : "+search);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("consort", consort);
		System.out.println(sqlsession.selectOne("mapper.Reviewboard.getTotal", map));
		return sqlsession.selectOne("mapper.Reviewboard.getTotal", map);
	}

	//정렬순 게시 글 조회
	public List<ReviewboardVO> SortList(HashMap<String, Object> map) {
		System.out.println(sqlsession.selectList("mapper.Reviewboard.SortList", map));
		return sqlsession.selectList("mapper.Reviewboard.SortList", map);
	}

}
