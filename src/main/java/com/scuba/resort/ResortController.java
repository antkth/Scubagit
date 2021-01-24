package com.scuba.resort;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/Resort/*")
public class ResortController {
	@Autowired
	private ResortService resortService;
	private ModelAndView modelAndView = new ModelAndView();
	
	//리조트 리스트 이동
	@RequestMapping(value = "moveResortList" )
	public ModelAndView moveResortList(@RequestParam(defaultValue = "") String search,
									   @RequestParam(defaultValue = "") String city,
									   @RequestParam(defaultValue = "enterDate") String order,
									   @RequestParam(defaultValue = "1") int nowpage, HttpServletRequest request) {
		request.getSession().setAttribute("category", "resort");
		modelAndView.addObject("map",resortService.getResrotList(search, city, order, nowpage));
		modelAndView.setViewName("resort/ResortList");
		return modelAndView;
	}
	//리조트 등록 이동
	@RequestMapping(value = "moveResortWriter" )
	public ModelAndView moveResortWriter(HttpServletRequest request) {
		modelAndView.setViewName("resort/ResortWriter");
		return modelAndView;
	}
	//리조트 등록
	@RequestMapping(value = "EnterResort" , method = RequestMethod.POST)
	public ModelAndView EnterResort(MultipartHttpServletRequest multipartHttpServletRequest, 
									HttpServletRequest request,
									HttpServletResponse response) throws Exception{
		int num = resortService.EnterResort(multipartHttpServletRequest, request , response);
		modelAndView.setViewName("redirect:/Resort/moveViewResort?num="+num);
		return modelAndView;
	}
	//리조트 관리자 페이지 이동
	@RequestMapping(value = "moveResortAdmin")
	public ModelAndView moveResortAdmin(@RequestParam(defaultValue = "1") int nowpage,
										@RequestParam(defaultValue = "0") int resortStatus,
										@RequestParam(defaultValue = "") String search) {
		modelAndView.addObject("map",resortService.getAdminResortList(nowpage, resortStatus,search));
		modelAndView.setViewName("resort/M-ResortList");
		return modelAndView;
	}
	//리조트 상세보기 이동
	@RequestMapping(value = "moveViewResort")
	public ModelAndView moveViewResort(int num,HttpServletRequest request) {
		request.getSession().setAttribute("category", "resort");
		modelAndView.addObject("resortVO",resortService.getResortInfo(num));
		modelAndView.addObject("reviews",resortService.getReviewsList(num));
		modelAndView.setViewName("resort/ResortView");
		return modelAndView;
	}
	//리조트 삭제
	@RequestMapping(value = "delResort")
	public ModelAndView delResort(int num) {
		//아이디 체크 구문 추가
		resortService.delResort(num);
		modelAndView.setViewName("redirect:/Resort/moveResortList");
		return modelAndView;
	}
	//리조트 상태 변경 (리스트)
	@ResponseBody
	@RequestMapping(value = "changeResortStatusList",method = RequestMethod.POST)
	public void changeResortStatusList(int num , int status) {
		if(status == 1) {
			status = 0 ;
		}else {
			status = 1;
		}
		resortService.changeResortStatus(num, status);
	}
	//리조트 상태 변경 (뷰)
	@ResponseBody
	@RequestMapping(value = "changeResortStatusView",method = RequestMethod.POST)
	public void changeResortStatusView(int num , int status) {
		resortService.changeResortStatus(num, status);
	}
	//리조트 수정페이지 이동
	@RequestMapping(value = "moveResortMod")
	public ModelAndView moveResortMod(int num , HttpServletRequest request) {
		request.getSession().setAttribute("category","Resort");
		modelAndView.addObject("resortinfo",resortService.getResortInfo(num));
		modelAndView.setViewName("resort/ResortMod");
		return modelAndView;
	}
	//리조트 수정
	@RequestMapping(value = "ResortMod" ,method = RequestMethod.POST)
	public ModelAndView ResortMod(ResortVO resortVO , HttpServletRequest request, HttpServletResponse response,
								  MultipartHttpServletRequest multipartHttpServletRequest) throws Exception{
		resortService.ResortMod(resortVO, request, response , multipartHttpServletRequest);
		modelAndView.setViewName("redirect:/Resort/moveViewResort?num="+resortVO.getNum());
		return modelAndView;
	}
	//리뷰 작성
	@RequestMapping(value = "ReviewsWrite" , method = RequestMethod.POST)
	public ModelAndView ReviewsWrite(ResortVO resortVO,
									HttpServletRequest request) {
		resortService.ReviewsWrite(resortVO, request);
		modelAndView.setViewName("redirect:/Resort/moveViewResort?num="+resortVO.getNum());
		return modelAndView;
	}
	//리뷰 글  썻는지 확인
	@ResponseBody
	@RequestMapping(value = "reviewCheck" , method = RequestMethod.POST)
	public int reviewCheck(int num , String nickName) {
		int check = resortService.reviewCheck(num, nickName);
		return check;
	}
	//리뷰 삭제
	public ModelAndView delReviews(int num , HttpServletRequest request) {
		resortService.delReviews(num, (String)request.getSession().getAttribute("user_nickname"));
		modelAndView.setViewName("redirect:/Resort/moveViewResort?num="+num);
		return modelAndView;
	}
	
}
