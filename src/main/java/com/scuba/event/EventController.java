package com.scuba.event;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.scuba.common.Common;
import com.scuba.friendsboard.FriendsBoardVO;
import com.scuba.reply.ReplyVO;

@Controller
@RequestMapping(value = "/Event/*")
public class EventController {
	
	@Autowired
	private EventService eventService;
	private ModelAndView modelAndView = new ModelAndView();
	Common common = new Common();
	
	//이벤트 리스트 이동
	@RequestMapping(value = "moveEventList")
	public ModelAndView moveEventList(HttpServletRequest request,
									   @RequestParam(defaultValue = "1") int nowpage) {
		request.getSession().setAttribute("category", "event");
		modelAndView.addObject("map",eventService.allBoardList(request, nowpage));
		modelAndView.setViewName("N_event/List");
		return modelAndView;
	}
	
	//이벤트 글쓰기 이동
	@RequestMapping(value = "moveWrite")
	public ModelAndView moveWrite(HttpServletRequest request) {
		request.getSession().setAttribute("category", "event");
		modelAndView.setViewName("N_event/Write");
		return modelAndView;
	}
	
	// 이벤트 게시판 글 등록
	@RequestMapping(value = "WriteInsert", method = RequestMethod.POST)
	public ModelAndView WriteInsert(EventVO eventVO, HttpServletRequest request,
			HttpServletResponse response ,
			@RequestParam MultipartFile file) throws Exception {
		eventVO.setCommunityname((String)request.getSession().getAttribute("category"));
		
		HashMap<String, Object> resultMap = eventService.WriteInsert(eventVO,file, request, response);
		int writeResult = (Integer) resultMap.get("writeResult");
		// 글 등록 성공시 (1:이미지o 2:이미지x)
		if (writeResult == 1 || writeResult == 2) {
			// 게시글 번호
			modelAndView.addObject("num", resultMap.get("contentNum"));
			modelAndView.setViewName("redirect:/Event/moveEventList");
		} else { // 글 등록 실패시
			String notice = "글 등록 실패";
			common.noticeMethod(request, response, notice);
			modelAndView.setViewName("member/Login");
		}
		return modelAndView;
	}
	
	// 글쓰기 취소
	@RequestMapping(value = "writeCancle")
	public ModelAndView writeCancle() {
		modelAndView.setViewName("redirect:/event/moveEventList");
		return modelAndView;
	}	
	
	// 상세보기 페이지 이동
		@RequestMapping(value = "eventView")
		public ModelAndView marketBoardView(EventVO eventVO,  @RequestParam(defaultValue = "1")int nowpage
											, HttpServletRequest request) {
			modelAndView.addObject("viewList", eventService.viewList(eventVO.getNum()));
			//페이징, 검색, 정렬 값
			modelAndView.addObject("nowpage", nowpage);
			modelAndView.setViewName("N_event/View");
			return modelAndView;
	}	
	
		// 글 삭제
		@RequestMapping(value = "EventBoardDelete")
		public ModelAndView EventBoardDelete(EventVO eventVO, HttpServletRequest request, HttpServletResponse response) throws Exception {
			String user_nickname = (String)request.getSession().getAttribute("user_nickname");
			String write_nickname = eventService.idCheck(eventVO.getNum());
			//유저아이디와 작성자 아이디 체크
			if(write_nickname.equals(user_nickname)){
				int deleteResult = eventService.condelete(eventVO.getNum());
				if(deleteResult == 1) {
					modelAndView.setViewName("redirect:/Event/moveEventList");
				} else {
					String notice = "글 삭제에 실패 하였습니다.";
					common.noticeMethod(request, response, notice);
					modelAndView.setViewName("member/Login");
				}
			} else {
				String notice = "본인이 작성한 글이 아닙니다.";
				common.noticeMethod(request, response, notice);
				modelAndView.setViewName("member/Login");
			}
			
			return modelAndView;
		}
		
		// 글 수정 페이지 이동
		@RequestMapping(value = "EventBoardModify")
		public ModelAndView EventBoardModify(EventVO eventVO, HttpServletRequest request, HttpServletResponse response) {
			//수정 시 임의적인 글 번호 변경 방지를 위한 체크 값
			request.getSession().setAttribute("modifyCheck", eventVO.getNum());
			request.getSession().setAttribute("category",eventVO.getCommunityname());
			modelAndView.addObject("modifyList", eventService.ModifyList(eventVO.getNum()));
			modelAndView.setViewName("N_event/Modify");
			return modelAndView;
			}
		
		// 글수정 취소
		@RequestMapping(value = "modiFyCancle")
		public ModelAndView modiFyCancle(EventVO eventVO, HttpServletRequest request, HttpServletResponse response) {
			//글 수정 취소 시 필요한 vo객체 들고옴
			eventVO = eventService.ModifyList(eventVO.getNum());
			//글 수정 취소 서비스
			eventService.modiFyCancle(eventVO, request, response);
			modelAndView.setViewName("redirect:/Event/moveEventList");
			return modelAndView;
		}	
		// 글 수정 등록
		@RequestMapping(value = "Modifyinsert", method = RequestMethod.POST)
		public ModelAndView Modifyinsert(EventVO eventVO, @RequestParam MultipartFile file , HttpServletRequest request, HttpServletResponse response)
					throws Exception {
				int originalNum = (Integer)request.getSession().getAttribute("modifyCheck");
				int nowNum = eventVO.getNum(); 
				System.out.println("여기 : " + originalNum);
				System.out.println("저기 : " +nowNum);
				//뷰페이지 악의적인 조작 검증
				if(originalNum == nowNum) {
					// Service 글 수정
					HashMap<String, Object> resultMap = eventService.Modify(eventVO, file , request, response);
					// 글 수정 결과 리턴값 
					int modifyResult = (Integer)resultMap.get("modifyResult");
					// 글 수정 성공시 (1:이미지o 2:이미지x)
					if(modifyResult == 1 || modifyResult == 2) {
						modelAndView.addObject("num", resultMap.get("contentNum"));
						modelAndView.setViewName("redirect:/Event/eventView");
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
