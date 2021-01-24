package com.scuba.marketboard;

import java.util.HashMap;
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
import com.scuba.jobSearchboard.JobSearchboardVO;
import com.scuba.reply.ReplyService;
import com.scuba.reply.ReplyVO;

@Controller
@RequestMapping("/marketBoard/*")
public class MarketBoardController {

	@Autowired
	MarketBoardService marketboardService;
	@Autowired
	ReplyService replyservice;

	ModelAndView mav = new ModelAndView();
	Common common = new Common();

	// 중고장터 게시판 이동
	@RequestMapping(value = "marketBoardList")
	public ModelAndView marketBoardList(HttpServletRequest request, @RequestParam(defaultValue = "")String search1, @RequestParam(defaultValue = "")String search2,
			   @RequestParam(defaultValue = "")String searchsort, @RequestParam(defaultValue = "1")int nowpage1,  @RequestParam(defaultValue = "1")int nowpage2) {
		request.getSession().setAttribute("category", "market");
		// 후기게시판 전체 글 조회
		mav.addObject("map", marketboardService.allBoardList(search1, search2, searchsort, nowpage1, nowpage2));
		mav.setViewName("C_market/List");
		return mav;

	}

	// 중고장터 게시판 글 쓰기 페이지 이동
	@RequestMapping(value = "marketBoardWrite")
	public ModelAndView marketBoardWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String user_id = (String) request.getSession().getAttribute("user_id");

		// 비로그인 시 로그인 페이지로 이동시킴
		if (user_id == "" || user_id == null) {
			String notice = "로그인을 해주세요";
			common.noticeMethod(request, response, notice);
			mav.setViewName("member/Login");
		} else {
			mav.setViewName("C_market/Write");
		}
		return mav;
	}

	// 중고장터 게시판 글 등록
	@RequestMapping(value = "WriteInsert", method = RequestMethod.POST)
	public ModelAndView WriteInsert(MarketBoardVO marketboardVO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		HashMap<String, Object> resultMap = marketboardService.WriteInsert(marketboardVO, request, response);
		int writeResult = (Integer) resultMap.get("writeResult");
		// 글 등록 성공시 (1:이미지o 2:이미지x)
		if (writeResult == 1 || writeResult == 2) {
			// 게시글 번호
			mav.addObject("num", resultMap.get("contentNum"));
			mav.setViewName("redirect:/marketBoard/marketBoardView");
		} else { // 글 등록 실패시
			String notice = "글 등록 실패";
			common.noticeMethod(request, response, notice);
			mav.setViewName("member/Login");
		}
		return mav;
	}

	// 상세보기 페이지 이동
	@RequestMapping(value = "marketBoardView")
	public ModelAndView marketBoardView(ReplyVO replyVO, MarketBoardVO marketboardVO, HttpServletRequest request) {
		mav.addObject("viewList", marketboardService.viewList(marketboardVO.getNum()));
		//게시글 번호 저장(댓글)
		replyVO.setPostnum(marketboardVO.getNum());
		//커뮤니티 카테고리 저장
		replyVO.setCommunityname((String)request.getSession().getAttribute("category"));
		//댓글 리스트
		mav.addObject("replyList", replyservice.replyList(replyVO));
		//대댓글 리스트
		mav.addObject("rereplyList", replyservice.replyList2(replyVO));
		mav.setViewName("C_market/View");
		return mav;
	}
	
	// 글 수정 페이지 이동
	@RequestMapping(value = "marketBoardModify")
	public ModelAndView marketBoardModify(MarketBoardVO marketboardVO, HttpServletRequest request, HttpServletResponse response) {
		//수정 시 임의적인 글 번호 변경 방지를 위한 체크 값
		request.getSession().setAttribute("modifyCheck", marketboardVO.getNum());
		request.getSession().setAttribute("category",marketboardVO.getCommunityname());
		mav.addObject("modifyList", marketboardService.ModifyList(marketboardVO.getNum()));
		mav.setViewName("C_market/Modify");
		return mav;
		}	
	
	// 글 수정 등록
	@RequestMapping(value = "Modifyinsert", method = RequestMethod.POST)
	public ModelAndView Modifyinsert(MarketBoardVO marketboardVO, HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			int originalNum = (Integer)request.getSession().getAttribute("modifyCheck");
			int nowNum = marketboardVO.getNum(); 
			//뷰페이지 악의적인 조작 검증
			if(originalNum == nowNum) {
				// Service 글 수정
				HashMap<String, Object> resultMap = marketboardService.Modify(marketboardVO, request, response);
				// 글 수정 결과 리턴값 
				int modifyResult = (Integer)resultMap.get("modifyResult");
				// 글 수정 성공시 (1:이미지o 2:이미지x)
				if(modifyResult == 1 || modifyResult == 2) {
					mav.addObject("num", resultMap.get("contentNum"));
					mav.setViewName("redirect:/marketBoard/marketBoardView");
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
	@RequestMapping(value = "marketBoardDelete")
	public ModelAndView marketBoardDelete(MarketBoardVO marketboardVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String user_nickname = (String)request.getSession().getAttribute("user_nickname");
		String write_nickname = marketboardService.idCheck(marketboardVO.getNum());
		//유저아이디와 작성자 아이디 체크
		if(write_nickname.equals(user_nickname)){
			int deleteResult = marketboardService.condelete(request, response, marketboardVO.getNum());
			if(deleteResult == 1 || deleteResult == 2) {
				mav.setViewName("redirect:/marketBoard/marketBoardList");
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
		mav.setViewName("redirect:/marketBoard/marketBoardList");
		return mav;
	}
	
	// 글수정 취소
	@RequestMapping(value = "modiFyCancle")
	public ModelAndView modiFyCancle(MarketBoardVO marketboardVO, HttpServletRequest request, HttpServletResponse response) {
		//글 수정 취소 시 필요한 vo객체 들고옴
		marketboardVO = marketboardService.ModifyList(marketboardVO.getNum());
		//글 수정 취소 서비스
		marketboardService.modiFyCancle(marketboardVO, request, response);
		mav.setViewName("redirect:/marketBoard/marketBoardList");
		return mav;
	}	
	
	// 판매 상태 변경
	@RequestMapping(value = "dealstate")
	@ResponseBody
	public int dealState(HttpServletRequest request, HttpServletResponse response, @RequestParam int state, int num) {
		return marketboardService.dealState(state, num);
	}		
	
}
