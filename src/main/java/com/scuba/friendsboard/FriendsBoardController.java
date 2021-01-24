package com.scuba.friendsboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.scuba.common.Common;
import com.scuba.reply.ReplyService;
import com.scuba.reply.ReplyVO;

@Controller
@RequestMapping("/friendsBoard/*")
public class FriendsBoardController {

	@Autowired
	FriendsBoardService friendsboardService;
	@Autowired
	ReplyService replyservice;
	
	ModelAndView mav = new ModelAndView();
	Common common = new Common();

	// 동료모집 게시판 이동
	@RequestMapping(value = "friendsBoardList")
	public ModelAndView friendsBoardList(HttpServletRequest request, @RequestParam(defaultValue = "")String search, 
									     @RequestParam(defaultValue = "writedate")String sort, @RequestParam(defaultValue = "1")int nowpage) {
		request.getSession().setAttribute("category", "friends");
		// 후기게시판 전체 글 조회
		mav.addObject("map", friendsboardService.allBoardList(request, search, nowpage, sort));
		mav.setViewName("C_friends/List");
		return mav;
	}
	
	// 동료 모집 게시판 정렬값으로 리스트 뿌려주기
		@RequestMapping(value = "SortList", method = RequestMethod.POST)
		@ResponseBody
		public  Map<String, Object> SortList(HttpServletRequest request,  @RequestParam(defaultValue = "writedate") String sort,
											 @RequestParam(defaultValue = "1")int nowpage, @RequestParam(defaultValue = "")String search) {
			return friendsboardService.SortList(sort, nowpage, search);
		}

	// 중고장터 게시판 글 쓰기 페이지 이동
	@RequestMapping(value = "friendsBoardWrite")
	public ModelAndView friendsBoardWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String user_id = (String) request.getSession().getAttribute("user_id");

		// 비로그인 시 로그인 페이지로 이동시킴
		if (user_id == "" || user_id == null) {
			String notice = "로그인을 해주세요";
			common.noticeMethod(request, response, notice);
			mav.setViewName("member/Login");
		} else {
			mav.setViewName("C_friends/Write");
		}
		return mav;
	}
	
	// 동료모집 게시판 글 등록
	@RequestMapping(value = "WriteInsert", method = RequestMethod.POST)
	public ModelAndView WriteInsert(FriendsBoardVO friendsboardVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		friendsboardVO.setCommunityname((String)request.getSession().getAttribute("category"));
		
		HashMap<String, Object> resultMap = friendsboardService.WriteInsert(friendsboardVO, request, response);
		int writeResult = (Integer) resultMap.get("writeResult");
		// 글 등록 성공시 (1:이미지o 2:이미지x)
		if (writeResult == 1 || writeResult == 2) {
			// 게시글 번호
			mav.addObject("num", resultMap.get("contentNum"));
			mav.setViewName("redirect:/friendsBoard/friendsBoardView");
		} else { // 글 등록 실패시
			String notice = "글 등록 실패";
			common.noticeMethod(request, response, notice);
			mav.setViewName("member/Login");
		}
		return mav;
	}
	
	// 상세보기 페이지 이동
	@RequestMapping(value = "friendsBoardView")
	public ModelAndView marketBoardView(ReplyVO replyVO, FriendsBoardVO friendsboardVO,  @RequestParam(defaultValue = "1")int nowpage
										, @RequestParam(defaultValue = "")String search, HttpServletRequest request
										, @RequestParam(defaultValue = "writedate")String sort) {
		mav.addObject("viewList", friendsboardService.viewList(friendsboardVO.getNum()));
		//게시글 번호 저장(댓글)
		replyVO.setPostnum(friendsboardVO.getNum());
		//커뮤니티 카테고리 저장
		replyVO.setCommunityname((String)request.getSession().getAttribute("category"));
		//댓글 리스트
		mav.addObject("replyList", replyservice.replyList(replyVO));
		//대댓글 리스트
		mav.addObject("rereplyList", replyservice.replyList2(replyVO));		
		//페이징, 검색, 정렬 값
		mav.addObject("nowpage", nowpage);
		mav.addObject("search", search);
		mav.addObject("sort", sort);
		mav.setViewName("C_friends/View");
		return mav;
	}	
	
	// 글 수정 페이지 이동
	@RequestMapping(value = "friendsBoardModify")
	public ModelAndView friendsBoardModify(FriendsBoardVO friendsboardVO, HttpServletRequest request, HttpServletResponse response) {
		//수정 시 임의적인 글 번호 변경 방지를 위한 체크 값
		request.getSession().setAttribute("modifyCheck", friendsboardVO.getNum());
		request.getSession().setAttribute("category",friendsboardVO.getCommunityname());
		mav.addObject("modifyList", friendsboardService.ModifyList(friendsboardVO.getNum()));
		mav.setViewName("C_friends/Modify");
		return mav;
		}
	
	// 글 수정 등록
	@RequestMapping(value = "Modifyinsert", method = RequestMethod.POST)
	public ModelAndView Modifyinsert(FriendsBoardVO friendsboardVO, HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			int originalNum = (Integer)request.getSession().getAttribute("modifyCheck");
			int nowNum = friendsboardVO.getNum(); 
			//뷰페이지 악의적인 조작 검증
			if(originalNum == nowNum) {
				// Service 글 수정
				HashMap<String, Object> resultMap = friendsboardService.Modify(friendsboardVO, request, response);
				// 글 수정 결과 리턴값 
				int modifyResult = (Integer)resultMap.get("modifyResult");
				// 글 수정 성공시 (1:이미지o 2:이미지x)
				if(modifyResult == 1 || modifyResult == 2) {
					mav.addObject("num", resultMap.get("contentNum"));
					mav.setViewName("redirect:/friendsBoard/friendsBoardView");
				} else {
					String notice = "글 수정 실패";
					common.noticeMethod(request, response, notice);
					mav.setViewName("member/Login");
				}
			} else { // 사용자의 악의적인 조작이 있을 시
				String notice = "경고 : 잘못된 데이터 요청 (악의적인 데이터 수정)";
				common.noticeMethod(request, response, notice);
				mav.setViewName("member/Login");
			}
			return mav;
		}	
	
	// 글 삭제
	@RequestMapping(value = "friendsBoardDelete")
	public ModelAndView friendsBoardDelete(FriendsBoardVO friendsboardVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String user_nickname = (String)request.getSession().getAttribute("user_nickname");
		String write_nickname = friendsboardService.idCheck(friendsboardVO.getNum());
		//유저아이디와 작성자 아이디 체크
		if(write_nickname.equals(user_nickname)){
			int deleteResult = friendsboardService.condelete(request, response, friendsboardVO.getNum());
			if(deleteResult == 1 || deleteResult == 2) {
				mav.setViewName("redirect:/friendsBoard/friendsBoardList");
			} else {
				String notice = "글 삭제에 실패 하였습니다.";
				common.noticeMethod(request, response, notice);
				mav.setViewName("member/Login");
			}
		} else {
			String notice = "본인이 작성한 글이 아닙니다.";
			common.noticeMethod(request, response, notice);
			mav.setViewName("member/Login");
		}
		
		return mav;
	}	
	
	// 글쓰기 취소
	@RequestMapping(value = "writeCancle")
	public ModelAndView writeCancle() {
		mav.setViewName("redirect:/friendsBoard/friendsBoardList");
		return mav;
	}	
	
	// 글수정 취소
	@RequestMapping(value = "modiFyCancle")
	public ModelAndView modiFyCancle(FriendsBoardVO friendsboardVO, HttpServletRequest request, HttpServletResponse response) {
		//글 수정 취소 시 필요한 vo객체 들고옴
		friendsboardVO = friendsboardService.ModifyList(friendsboardVO.getNum());
		//글 수정 취소 서비스
		friendsboardService.modiFyCancle(friendsboardVO, request, response);
		mav.setViewName("redirect:/friendsBoard/friendsBoardList");
		return mav;
	}	

}
