package com.scuba.serviceCenter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/Service/*")
public class ServiceCenterController {
	
	private ModelAndView modelAndView = new ModelAndView();
	@Autowired
	private ServiceCenterService serviceCenterService; 
	//서비스센터 이동
	@RequestMapping(value = "moveServiceCenter", method = RequestMethod.GET)
	public ModelAndView moveServiceCenter() {
		HashMap<String,Object> map = serviceCenterService.getQuestionsList();
		modelAndView.addObject("CategoryList", map.get("CategoryList"));
		modelAndView.addObject("TopQuestionsList", map.get("TopQuestionsList"));
		modelAndView.setViewName("serviceCenter/S-Questions");
		return modelAndView;
	}
	//질문 글쓰기 이동
	@RequestMapping(value = "MoveServiceWrite", method = RequestMethod.GET)
	public ModelAndView MoveServiceWrite() {
		modelAndView.addObject("CategoryList",serviceCenterService.getQuestionsCategory());
		modelAndView.setViewName("serviceCenter/M-ServiceWrite");
		return modelAndView;
	}
	//질문 글쓰기
	@RequestMapping(value = "EnterService", method = RequestMethod.POST)
	public ModelAndView EnterService(@ModelAttribute ServiceCenterVO serviceCenterVO) {
		serviceCenterService.EnterQuestions(serviceCenterVO);
		modelAndView.setViewName("serviceCenter/M-ServiceWrite");
		return modelAndView;
	}
	//서비스센터 글 가져오기
	@ResponseBody
	@RequestMapping(value = "getServiceList" , method = RequestMethod.POST)
	public JSONArray getServiceList(String Category) {
		List<ServiceCenterVO> list = serviceCenterService.getServiceList(Category);
		JSONArray jsonArray = new JSONArray();
		for(int i = 0 ; i < list.size();i++) {
			jsonArray.add(list.get(i));
		}
		jsonArray.add(0, Category);
		return jsonArray;
	}
	//질문 리스트 이동
	@RequestMapping(value = "MoveServiceList", method = RequestMethod.GET)
	public ModelAndView MoveServiceList() {
		modelAndView.addObject("CategoryList",serviceCenterService.getQuestionsCategory());
		modelAndView.setViewName("serviceCenter/M-ServiceList");
		return modelAndView;
	}
	//관리자페이지 리스트 변경
	@ResponseBody
	@RequestMapping(value = "getList" , method = RequestMethod.POST)
	public JSONArray getList(int TopQuestions) {
		List<ServiceCenterVO> list = serviceCenterService.getList(TopQuestions);
		JSONArray jsonArray = new JSONArray();
		for(int i = 0 ; i < list.size(); i++) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("Num",list.get(i).getNum());
			jsonObject.put("Category",list.get(i).getCategory());
			jsonObject.put("Title",list.get(i).getTitle());
			jsonObject.put("Contents",list.get(i).getContents());
			jsonObject.put("TopQuestions",list.get(i).getTopQuestions());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	//관리자 리스트 페이지 상태 변경
	@ResponseBody
	@RequestMapping(value = "changeQuestions" , method = RequestMethod.POST)
	public void changeQuestions(int TopQuestions ,int Num) {
		int setQuestions = 0;
		if(TopQuestions == 0) setQuestions = 1;
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		map.put("TopQuestions", setQuestions);
		map.put("Num",Num);
		serviceCenterService.changeQuestions(map);
		
	}
	//관리자 리스트페이지 질문 삭제
	@ResponseBody
	@RequestMapping(value = "delQuestions" , method = RequestMethod.POST)
	public void delQuestions(int Num) {
		serviceCenterService.delQuestions(Num);
	}
	//1대1문의 글쓰기
	@RequestMapping(value = "writeinquiry", method = RequestMethod.POST)
	public ModelAndView writeinquiry(ServiceCenterVO serviceCenterVO,
									HttpSession session) {
		serviceCenterVO.setId((String)session.getAttribute("user_id"));
		serviceCenterService.Enterinquiry(serviceCenterVO);
		modelAndView.setViewName("redirect:/Service/moveServiceCenter");
		return modelAndView;
	}
	//1대1문의 리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "getinquirylist" , method = RequestMethod.POST)
	public JSONArray getinquirylist(String id) {
		JSONArray jsonArray = serviceCenterService.getinquirylist(id);
		return jsonArray;
	}
	//1대1문의 리스트 이동
	@RequestMapping(value = "MoveInquiryList", method = RequestMethod.GET)
	public ModelAndView MoveInquiryList() {
		modelAndView.setViewName("serviceCenter/M-Inquiry");
		return modelAndView;
	}
	//1대1문의 관리자 페이지 리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "getAllinquiryList" , method = RequestMethod.POST)
	public JSONArray getAllinquiryList(int answerstatus) {
		return serviceCenterService.getAllinquiryList(answerstatus);
	}
	//1대1문의 정보 수정 이동
	@RequestMapping(value = "MoveModInquiry", method = RequestMethod.GET)
	public ModelAndView MoveModInquiry(int Num) {
		modelAndView.addObject("info",serviceCenterService.getinquiryinfo(Num));
		modelAndView.setViewName("serviceCenter/M-ModInquiry");
		return modelAndView;
	}
	//1대1문의 정보 수정하기
	@RequestMapping(value = "ModInquiry" , method = RequestMethod.POST)
	public ModelAndView ModInquiry(ServiceCenterVO serviceCenterVO) {
		serviceCenterService.ModInquiry(serviceCenterVO);
		modelAndView.setViewName("redirect:/Service/moveServiceCenter");
		return modelAndView;
	}
}
