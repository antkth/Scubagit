package com.scuba.notice;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scuba.freeboard.FreeBoardVO;

@Repository
public class NoticeDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 글 작성
	public int write(NoticeVO noticeVO) {
		int insertResult = sqlSession.insert("mapper.notice.write", noticeVO);
		return insertResult;
	}
	// 최신 게시글  번호 조회
	public int getMaxNum() {
		return sqlSession.selectOne("mapper.notice.getMaxNum");
	}
	//이미지 경로 변경
	public int contentChange(HashMap<String, Object> map) {
		return sqlSession.update("mapper.notice.contentChange", map);
	}
	//공지리스트 총 갯수 구하기
	public int gettotal(String search) {
		return sqlSession.selectOne("mapper.notice.gettotal",search);
	}
	//공지리스트 가져오기
	public List<NoticeVO> getNoticeList(HashMap<String,Object> map){
		return sqlSession.selectList("mapper.notice.getNoticeList",map);
	}
	//글 정보 가져오기
	public NoticeVO getNoticeInfo(int num) {
		return sqlSession.selectOne("mapper.notice.getNoticeInfo",num);
	}
	//공지사항 삭제
	public void delNotice(int num) {
		sqlSession.update("mapper.notice.delNotice",num);
	}
	//게시글 수정
	public int Modify(NoticeVO noticeVO) {
		return sqlSession.update("mapper.notice.Modify", noticeVO);
	}
	//조회수 증가
	public void viewcountadd(int num) {
		sqlSession.update("mapper.notice.viewcountadd",num);
	}
}
