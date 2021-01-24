package com.scuba.friendsboard;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.scuba.freeboard.FreeBoardVO;
import com.scuba.marketboard.MarketBoardVO;

@Repository
public class FriendsBoardDAO {

	@Autowired
	SqlSession sqlsession;
	
	// 구인/구직 게시판 모든(글) 리스트 조회
	public List<FriendsBoardVO> allBoardList(HashMap<String, Object> map) {
		return sqlsession.selectList("mapper.FriendsBoard.allBoardList", map);
	}
	
	// 글 작성
	public int write(FriendsBoardVO friendsboardVO) {
		int insertResult = 0;
		// kakao 아이디만 입력 시
		if (friendsboardVO.getPhone() == "" || friendsboardVO.getPhone() == null) {
			insertResult = sqlsession.insert("mapper.FriendsBoard.writekakao", friendsboardVO);
			// phone만 입력 시
		} else if (friendsboardVO.getKakao()== "" || friendsboardVO.getKakao() == null) {
			insertResult = sqlsession.insert("mapper.FriendsBoard.writephone", friendsboardVO);
		} else { // 둘 다 입력 시
			insertResult = sqlsession.insert("mapper.FriendsBoard.write", friendsboardVO);
		}
		return insertResult;
	}

	// 최신 게시글 번호 조회
	public int getMaxNum() {
		int insertResult = sqlsession.selectOne("mapper.FriendsBoard.getMaxNum");
		return insertResult;
	}

	// 이미지 경로 변경
	public int contentChange(HashMap<String, Object> map) {
		return sqlsession.update("mapper.FriendsBoard.contentChange", map);
	}

	// 글 상세 보기
	public FriendsBoardVO viewList(int contentNum) {
		return sqlsession.selectOne("mapper.FriendsBoard.viewList", contentNum);
	}

	//게시글 수정페이지 이동
	public FriendsBoardVO ModifyList(int contentNum) {
		return sqlsession.selectOne("mapper.FriendsBoard.ModifyList", contentNum);
	}

	//게시글 수정
	public int Modify(FriendsBoardVO friendsboardVO) {
			//kakao아이디만 입력 시
		if (friendsboardVO.getPhone() == "" || friendsboardVO.getPhone() == null) {
			return sqlsession.update("mapper.FriendsBoard.Modifykakao", friendsboardVO);
			// phone만 입력 시
		} else if (friendsboardVO.getKakao()== "" || friendsboardVO.getKakao() == null) {
			return sqlsession.update("mapper.FriendsBoard.Modifyphone", friendsboardVO);
		} else { // 둘 다 입력 시
			return sqlsession.update("mapper.FriendsBoard.Modify", friendsboardVO);
		}
	}

	//게시글 삭제 시 닉네임 일치여부 체크
	public String idCheck(int contentNum) {
		return sqlsession.selectOne("mapper.FriendsBoard.idCheck", contentNum);
	}

	//게시글 삭제
	public int condelete(int contentNum) {
		return sqlsession.delete("mapper.FriendsBoard.condelete", contentNum);
	}

	//정렬순 리스트
	public List<FriendsBoardVO> SortList(HashMap<String, Object> map) {
		return sqlsession.selectList("mapper.FriendsBoard.SortList", map);
	}

	//리스트 토탈 구하기
	public int getTotal(String search) {
		return sqlsession.selectOne("mapper.FriendsBoard.getTotal", search);
	}



}
