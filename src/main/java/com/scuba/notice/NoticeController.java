package com.scuba.notice;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.scuba.common.Common;
import com.scuba.freeboard.FreeBoardVO;

@RequestMapping(value = "/Notice/*")
@Controller
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	private ModelAndView modelAndView = new ModelAndView();
	Common common = new Common();

	//공지사항 리스트 이동
	@RequestMapping(value = "moveNoticeList")
	public ModelAndView moveNoticeList(HttpServletRequest request,
									   @RequestParam(defaultValue = "") String search,
									   @RequestParam(defaultValue = "1") int nowpage) {
		request.getSession().setAttribute("category", "notice");
		modelAndView.addObject("map",noticeService.getNoticeList(search, nowpage));
		modelAndView.setViewName("N_notice/List");
		return modelAndView;
	}
	
	//공지사항 글쓰기 이동
	@RequestMapping(value = "moveWrite")
	public ModelAndView moveWrite(HttpServletRequest request) {
		request.getSession().setAttribute("category", "notice");
		modelAndView.setViewName("N_notice/Write");
		return modelAndView;
	}
	
	// 글 등록
	@RequestMapping(value = "writeinsert", method = RequestMethod.POST)
	public ModelAndView writeinsert(NoticeVO noticeVO, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// Service 글 등록
		HashMap<String, Object> resultMap = noticeService.write(noticeVO, request, response);
		int writeResult = (Integer) resultMap.get("writeResult");
		// 글 등록 성공시 (1:이미지o 2:이미지x)
		if (writeResult == 1 || writeResult == 2) {
			// 게시글 번호
			modelAndView.addObject("num", resultMap.get("contentNum"));
			modelAndView.setViewName("redirect:/Notice/moveNoticeView");
		} else { // 글 등록 실패시
			String notice = "글 등록 실패";
			common.noticeMethod(request, response, notice);
			modelAndView.setViewName("member/Login");
		}
		return modelAndView;
	}
	
	//공지사항 글 상세보기
	@RequestMapping(value = "moveNoticeView")
	public ModelAndView moveNoticeView(int num) {
		modelAndView.addObject("noticeVO", noticeService.getNoticeInfo(num));
		modelAndView.setViewName("N_notice/View");
		return modelAndView;
	}
	
	//삭제 구문
	@RequestMapping(value = "delNotice")
	public ModelAndView delNotice(int num) {
		noticeService.delNotice(num);
		modelAndView.setViewName("redirect:/Notice/moveNoticeList");
		return modelAndView;
	}
	
	//글 수정하기 이동
	@RequestMapping(value = "moveModify")
	public ModelAndView moveModify(int num , HttpServletRequest request) {
		NoticeVO noticeVO = noticeService.getNoticeInfo(num);
		request.getSession().setAttribute("modifyCheck", noticeVO.getNum());
		request.getSession().setAttribute("category",noticeVO.getCommunityname());
		modelAndView.addObject("noticeVO",noticeVO);
		modelAndView.setViewName("N_notice/Modify");
		return modelAndView;
	}
	
	// 글수정 취소
	@RequestMapping(value = "modiFyCancle")
	public ModelAndView modiFyCancle(NoticeVO noticeVO, HttpServletRequest request, HttpServletResponse response) {
		//글 수정 취소 시 필요한 vo객체 들고옴
		noticeVO = noticeService.getNoticeInfo(noticeVO.getNum());
		//글 수정 취소 서비스
		noticeService.modiFyCancle(noticeVO, request, response);
		modelAndView.setViewName("redirect:/Notice/moveNoticeList");
		return modelAndView;
	}
	
	// 글 수정 등록
		@RequestMapping(value = "Modifyinsert", method = RequestMethod.POST)
		public ModelAndView Modifyinsert(NoticeVO noticeVO, HttpServletRequest request, HttpServletResponse response)
					throws Exception {
				int originalNum = (Integer)request.getSession().getAttribute("modifyCheck");
				int nowNum = noticeVO.getNum(); 
				//뷰페이지 악의적인 조작 검증
				if(originalNum == nowNum) {
					// Service 글 수정
					HashMap<String, Object> resultMap = noticeService.Modify(noticeVO, request, response);
					// 글 수정 결과 리턴값 
					int modifyResult = (Integer)resultMap.get("modifyResult");
					// 글 수정 성공시 (1:이미지o 2:이미지x)
					if(modifyResult == 1 || modifyResult == 2) {
						modelAndView.addObject("num", resultMap.get("contentNum"));
						modelAndView.setViewName("redirect:/Notice/moveNoticeView");
					} else {
						String notice = "글 수정 실패";
						common.noticeMethod(request, response, notice);
						modelAndView.setViewName("member/Login");
					}
				} else { // 사용자의 악의적인 조작이 있을 시
					String notice = "경고 : 잘못된 데이터 요청 (악의적인 데이터 수정)";
					common.noticeMethod(request, response, notice);
					modelAndView.setViewName("member/Login");
				}
				return modelAndView;
			}
}
