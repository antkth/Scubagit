package com.scuba.freeboard;

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
@RequestMapping("/freeBoard/*")
public class FreeBoardController {

	@Autowired
	FreeBoardService freeboardService;
	@Autowired
	ReplyService replyservice;
	
	private ModelAndView mav = new ModelAndView();
	Common common = new Common();
	FreeBoardVO freeboardCheckVO = new FreeBoardVO();
	
	// 자유게시판 이동 , 자유게시판 전체 리스트 조회
	@RequestMapping(value = "freeBoardList", method = RequestMethod.GET)
	public ModelAndView freeBoardList(HttpServletRequest request, @RequestParam(defaultValue = "")String search 
									  ,@RequestParam(defaultValue = "writedate")String sort,
									   @RequestParam(defaultValue = "1")int nowpage) {
		request.getSession().setAttribute("category", "free");
		// 자유게시판 전체 글 조회
		mav.addObject("map", freeboardService.allBoardList(request,nowpage, search, sort));
		mav.setViewName("C_free/List");
		return mav;
	}
	
	// 자유게시판 정렬값으로 리스트 뿌려주기
	@RequestMapping(value = "SortList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> SortList(HttpServletRequest request, @RequestParam(defaultValue = "writedate") String sort, 
										 @RequestParam(defaultValue = "1")int nowpage,
										 @RequestParam(defaultValue = "")String search) {
		return freeboardService.SortList(sort, nowpage, search);
	}
	
	// 글쓰기 페이지 이동
	@RequestMapping(value = "writeboard")
	public ModelAndView writeboard(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String user_id = (String)request.getSession().getAttribute("user_id");
		//로그인 유무 확인
		if(user_id == null) {
			String notice = "로그인을 해주세요";
			common.noticeMethod(request, response, notice);
			mav.setViewName("member/Login");
		} else {
			mav.setViewName("C_free/Write");
		}
		return mav;
	}

	// 상세보기 페이지 이동
	@RequestMapping(value = "freeBoardView")
	public ModelAndView freeboardView(ReplyVO replyVO, FreeBoardVO freeboardVO, @RequestParam(defaultValue = "1")int nowpage
									  , @RequestParam(defaultValue = "")String search, HttpServletRequest request
									  , @RequestParam(defaultValue = "writedate")String sort) {
		//해당 게시글 정보
		mav.addObject("viewList", freeboardService.viewList(freeboardVO.getNum()));
		//게시글 번호 저장(댓글)
		replyVO.setPostnum(freeboardVO.getNum());
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
		mav.setViewName("C_free/View");
		return mav;
	}
	
	// 글 수정 페이지 이동
	@RequestMapping(value = "freeboarModify")
	public ModelAndView freeboarModify(FreeBoardVO freeboardVO, HttpServletRequest request, HttpServletResponse response) {
		request.getSession().setAttribute("modifyCheck", freeboardVO.getNum());
		request.getSession().setAttribute("category",freeboardVO.getCommunityname());
		mav.addObject("modifyList", freeboardService.ModifyList(freeboardVO.getNum()));
		mav.setViewName("C_free/Modify");
		return mav;
		}

	// 글 등록
	@RequestMapping(value = "writeinsert", method = RequestMethod.POST)
	public ModelAndView writeinsert(FreeBoardVO freeboardVO, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// Service 글 등록
		HashMap<String, Object> resultMap = freeboardService.write(freeboardVO, request, response);
		int writeResult = (Integer) resultMap.get("writeResult");
		// 글 등록 성공시 (1:이미지o 2:이미지x)
		if (writeResult == 1 || writeResult == 2) {
			// 게시글 번호
			mav.addObject("num", resultMap.get("contentNum"));
			mav.setViewName("redirect:/freeBoard/freeBoardView");
		} else { // 글 등록 실패시
			String notice = "글 등록 실패";
			common.noticeMethod(request, response, notice);
			mav.setViewName("member/Login");
		}
		return mav;
	}
	
	// 글 수정 등록
	@RequestMapping(value = "Modifyinsert", method = RequestMethod.POST)
	public ModelAndView Modifyinsert(FreeBoardVO freeboardVO, HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			int originalNum = (Integer)request.getSession().getAttribute("modifyCheck");
			int nowNum = freeboardVO.getNum(); 
			
			//뷰페이지 악의적인 조작 검증
			if(originalNum == nowNum) {
				// Service 글 수정
				HashMap<String, Object> resultMap = freeboardService.Modify(freeboardVO, request, response);
				// 글 수정 결과 리턴값 
				int modifyResult = (Integer)resultMap.get("modifyResult");
				// 글 수정 성공시 (1:이미지o 2:이미지x)
				if(modifyResult == 1 || modifyResult == 2) {
					mav.addObject("num", resultMap.get("contentNum"));
					mav.setViewName("redirect:/freeBoard/freeBoardView");
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
	@RequestMapping(value = "freeBoardDelete")
	public ModelAndView freeboardDelete(FreeBoardVO freeboardVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String user_nickname = (String)request.getSession().getAttribute("user_nickname");
		String write_nickname = freeboardService.idCheck(freeboardVO.getNum());
		//유저아이디와 작성자 아이디 체크
		if(write_nickname.equals(user_nickname)){
			int deleteResult = freeboardService.condelete(request, response, freeboardVO.getNum());
			if(deleteResult == 1 || deleteResult == 2) {
				mav.setViewName("redirect:/freeBoard/freeBoardList");
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
		mav.setViewName("redirect:/freeBoard/freeBoardList");
		return mav;
	}
	
	// 글수정 취소
	@RequestMapping(value = "modiFyCancle")
	public ModelAndView modiFyCancle(FreeBoardVO freeboardVO, HttpServletRequest request, HttpServletResponse response) {
		//글 수정 취소 시 필요한 vo객체 들고옴
		freeboardVO = freeboardService.ModifyList(freeboardVO.getNum());
		//글 수정 취소 서비스
		freeboardService.modiFyCancle(freeboardVO, request, response);
		mav.setViewName("redirect:/freeBoard/freeBoardList");
		return mav;
	}
}
