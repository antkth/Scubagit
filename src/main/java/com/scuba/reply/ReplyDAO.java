package com.scuba.reply;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ReplyDAO {

	@Autowired
	private SqlSession sqlsession;
	
	//댓글 리스트 출력
	public List<ReplyVO> replyList(ReplyVO replyVO) {
		return sqlsession.selectList("mapper.Reply.replyList", replyVO);
	}
	
	//대댓글 리스트 출력
	public List<ReplyVO> replyList2(ReplyVO replyVO) {
		return sqlsession.selectList("mapper.Reply.replyList2", replyVO);
	}

	//댓글 등록
	public void replywrite(ReplyVO replyVO) {
		if(sqlsession.insert("mapper.Reply.replywrite", replyVO)==1) {
			sqlsession.update("mapper.Reply.replygroup_num", replyVO);
		}
	}

	//대댓글 등록
	public void rereplywrite(ReplyVO replyVO) {
		sqlsession.insert("mapper.Reply.rereplywrite", replyVO);
	}

	//댓글 수정
	public void replymodify(ReplyVO replyVO) {
		sqlsession.insert("mapper.Reply.replymodify", replyVO);
	}

	//부모 댓글 삭제
	public void replydelete(ReplyVO replyVO) {
		sqlsession.insert("mapper.Reply.replydelete", replyVO);
		
	}

	//자식 댓글 삭제
	public void replydelete2(ReplyVO replyVO) {
		sqlsession.insert("mapper.Reply.replydelete2", replyVO);
		
	}
	
}
