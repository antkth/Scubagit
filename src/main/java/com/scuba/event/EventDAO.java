package com.scuba.event;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scuba.friendsboard.FriendsBoardVO;

@Repository
public class EventDAO {
	@Autowired
	private SqlSession sqlsession;
	
		// 이벤트 게시판 모든  리스트 조회
		public List<EventVO> allBoardList(HashMap<String, Object> map) {
			return sqlsession.selectList("mapper.event.allBoardList", map);
		}
	
		// 글 작성
		public int write(EventVO eventVO) {
			return sqlsession.insert("mapper.event.write", eventVO);
		}
		
		// 최신 게시글 번호 조회
		public int getMaxNum() {
			return sqlsession.selectOne("mapper.event.getMaxNum");
		}
		
		// 이미지 경로 변경
		public int contentChange(HashMap<String, Object> map) {
			return sqlsession.update("mapper.event.contentChange", map);
		}
		
		//리스트 토탈 구하기
		public int getTotal() {
			return sqlsession.selectOne("mapper.event.getTotal");
		}
		
		// 글 상세 보기
		public EventVO viewList(int contentNum) {
			return sqlsession.selectOne("mapper.event.viewList", contentNum);
		}
		
		//게시글 삭제 시 닉네임 일치여부 체크
		public String idCheck(int contentNum) {
			return sqlsession.selectOne("mapper.event.idCheck", contentNum);
		}
		
		//게시글 삭제(업데이트)
		public int condelete(int contentNum) {
			return sqlsession.update("mapper.event.condelete",contentNum);
		}
		
		//게시글 수정페이지 이동
		public EventVO ModifyList(int contentNum) {
			return sqlsession.selectOne("mapper.event.ModifyList", contentNum);
		}
		
		//게시글 수정
		public int Modify(EventVO eventVO) {
			return sqlsession.update("mapper.event.Modify", eventVO);
		}
}
