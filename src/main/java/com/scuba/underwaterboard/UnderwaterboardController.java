package com.scuba.underwaterboard;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.scuba.common.Common;
import com.scuba.reply.ReplyService;
import com.scuba.reply.ReplyVO;

@Controller
@RequestMapping("/underWaterBoard/*")
public class UnderwaterboardController {
	
	@Autowired
	UnderwaterboardService underwaterboardService;
	@Autowired
	ReplyService replyservice;
	
	private ModelAndView mav = new ModelAndView();
	Common common = new Common();
	UnderwaterboardVO underwaterboardCheckVO = new UnderwaterboardVO();

	// 수중 게시판 이동 , 수중 게시판 전체 리스트 조회
	@RequestMapping(value = "underWaterBoardList", method = RequestMethod.GET)
	public ModelAndView underWaterBoardList(HttpServletRequest request, @RequestParam(defaultValue = "writedate") String sort,
											@RequestParam(defaultValue = "1")int nowpage, @RequestParam(defaultValue = "")String search) {
		
		request.getSession().setAttribute("category", "underwater");
		// 수중게시판 전체 글 조회
		mav.addObject("map", underwaterboardService.allBoardList(request, nowpage, search, sort));
		mav.setViewName("C_underWater/List");
		return mav;
	}
	
	// 자유게시판 정렬값으로 리스트 뿌려주기
	@RequestMapping(value = "SortList", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> SortList(HttpServletRequest request, @RequestParam(defaultValue = "writedate") String sort, 
										 @RequestParam(defaultValue = "1")int nowpage,
										 @RequestParam(defaultValue = "")String search) {
		return underwaterboardService.SortList(sort, nowpage, search);
	}

	// 수중 게시판 글 쓰기 이동
	@RequestMapping(value = "underWaterBoardWrite")
	public ModelAndView underWaterBoardWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String user_id = (String)request.getSession().getAttribute("user_id");
		// 로그인 유무 확인
		if (user_id == null || user_id == "") {
			String notice = "로그인을 해주세요";
			common.noticeMethod(request, response, notice);
			mav.setViewName("member/Login");
		} else {
			mav.setViewName("C_underWater/Write");
		}
		return mav;
	}
	
	
	// 수중 게시판 글 등록
	@RequestMapping(value = "writeinsert", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView writeinsert(UnderwaterboardVO underwaterboardVO, @RequestParam MultipartFile file,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("해쉬 태그 : " + underwaterboardVO.getHashtag());
		HashMap<String, Object> resultMap = underwaterboardService.writeinsert(underwaterboardVO, file, request, response);
		
		int writeResult = (Integer) resultMap.get("writeResult");
		// 글 등록 성공시 (1:이미지o 2:이미지x)
		if (writeResult == 1 || writeResult == 2) {
			// 게시글 번호
			mav.addObject("num", resultMap.get("contentNum"));
			mav.setViewName("redirect:/underWaterBoard/underWaterBoardView");
		} else { // 글 등록 실패시
			String notice = "글 등록 실패";
			common.noticeMethod(request, response, notice);
			mav.setViewName("member/Login");
		}
		return mav;
	}

	// 상세보기 페이지 이동
	@RequestMapping(value = "underWaterBoardView")
	public ModelAndView underWaterBoardView(ReplyVO replyVO, UnderwaterboardVO underwaterboardVO, HttpServletRequest request) {
		mav.addObject("viewList", underwaterboardService.viewList(underwaterboardVO.getNum()));
		//게시글 번호 저장(댓글)
		replyVO.setPostnum(underwaterboardVO.getNum());
		//커뮤니티 카테고리 저장
		replyVO.setCommunityname((String)request.getSession().getAttribute("category"));
		//댓글 리스트
		mav.addObject("replyList", replyservice.replyList(replyVO));
		//대댓글 리스트
		mav.addObject("rereplyList", replyservice.replyList2(replyVO));		
		mav.setViewName("C_underWater/View");
		return mav;
	}
	
	//수중 게시판 글 수정 페이지 이동
	@RequestMapping(value = "underWaterBoardModify")
	public ModelAndView underWaterBoardModify(UnderwaterboardVO underwaterboardVO, HttpServletRequest request, HttpServletResponse response) {
//		System.out.println(freeboardVO.getNum());
		request.getSession().setAttribute("category",underwaterboardVO.getCommunityname());
		request.getSession().setAttribute("modifyCheck", underwaterboardVO.getNum());
		mav.addObject("modifyList", underwaterboardService.ModifyList(underwaterboardVO.getNum()));
		
		mav.setViewName("C_underWater/Modify");
		return mav;
		}	
	
	// 글 수정 등록
	@RequestMapping(value = "Modifyinsert", method = RequestMethod.POST)
	public ModelAndView Modifyinsert(UnderwaterboardVO underwaterboardVO, @RequestParam MultipartFile file, HttpServletRequest request, HttpServletResponse response)
				throws Exception {
			int originalNum = (Integer)request.getSession().getAttribute("modifyCheck");
			int nowNum = underwaterboardVO.getNum();
			System.out.println("썸네일 임지 : " + underwaterboardVO.getThumbnail());
			//뷰페이지 악의적인 조작 검증
			if(originalNum == nowNum) {
				// Service 글 수정
				HashMap<String, Object> resultMap = underwaterboardService.Modify(underwaterboardVO, file, request, response);
				// 글 수정 결과 리턴값
				int modifyResult = (Integer)resultMap.get("modifyResult");
				// 글 수정 성공시 (1:이미지o 2:이미지x)
				if(modifyResult == 1 || modifyResult == 2) {
					mav.addObject("num", resultMap.get("contentNum"));
					mav.setViewName("redirect:/underWaterBoard/underWaterBoardView");
				} else {
					String notice = "글 수정 실패";
					common.noticeMethod(request, response, notice);
					mav.setViewName("member/Login");
				}
			} else { // 사용자의 악의적인 조작이 있을 시
				String notice = "경고 : 잘못된 데이터 요청 (잘못된 접근입니다. 다시 시도 하여주십시오.)";
				common.noticeMethod(request, response, notice);
				mav.setViewName("member/Login");
			}
			return mav;
		}	
	
	// 글 삭제
	@RequestMapping(value = "underWaterBoardDelete")
	public ModelAndView underWaterBoardDelete(UnderwaterboardVO underwaterboardVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String user_nickname = (String)request.getSession().getAttribute("user_nickname");
		String write_nickname = underwaterboardService.idCheck(underwaterboardVO.getNum());
		//유저아이디와 작성자 아이디 체크
		if(write_nickname.equals(user_nickname)){ //게시글 삭제
			int deleteResult = underwaterboardService.condelete(request, response, underwaterboardVO.getNum());
			if(deleteResult == 1 || deleteResult == 2) {
				mav.setViewName("redirect:/underWaterBoard/underWaterBoardList");
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
		mav.setViewName("redirect:/underWaterBoard/underWaterBoardList");
		return mav;
	}
		
	// 글수정 취소
	@RequestMapping(value = "modiFyCancle")
	public ModelAndView modiFyCancle(UnderwaterboardVO underwaterboardVO, HttpServletRequest request, HttpServletResponse response) {
		//글 수정 취소 시 필요한 vo객체 들고옴
		underwaterboardVO = underwaterboardService.ModifyList(underwaterboardVO.getNum());
		//글 수정 취소 서비스
		underwaterboardService.modiFyCancle(underwaterboardVO, request, response);
		mav.setViewName("redirect:/underWaterBoard/underWaterBoardList");
		return mav;
	}
	
}
