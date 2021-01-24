package com.scuba.serviceCenter;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ServiceCenterService {

	@Autowired
	private ServiceCenterDAO serviceCenterDAO;
	//질문테이블 카테고리 가져오기
	public List<String> getQuestionsCategory(){
		return serviceCenterDAO.getQuestionsCategory();
	}
	//질문 테이블 글쓰기
	public void EnterQuestions(ServiceCenterVO serviceCenterVO) {
		int Num = 1 ; 
		if(serviceCenterDAO.QuestionsNullCheck()!=0) {
			Num = serviceCenterDAO.getQuestionsMaxNum()+1;
		}
		serviceCenterVO.setNum(Num);
		serviceCenterDAO.EnterQuestions(serviceCenterVO);
	}
	//질문 테이블 리스트 가져오기
	public HashMap<String,Object> getQuestionsList() {
		HashMap<String,Object> map = new HashMap<String, Object>();
		List<String> CategoryList = serviceCenterDAO.getQuestionsCategory();
		map.put("CategoryList",CategoryList);
		map.put("TopQuestionsList",serviceCenterDAO.getTopQuestionsList());
		return map;
	}
	//서비스센터 글 가져오기
	public List<ServiceCenterVO> getServiceList(String category) {
		return serviceCenterDAO.getQuestionsList(category);
	}
	//관리자 페이지 리스트 가져오기
	public List<ServiceCenterVO> getList(int TopQuestions){
		return serviceCenterDAO.getList(TopQuestions);
	}
	//자주묻는질문 변경
	public void changeQuestions(HashMap<String,Integer> map) {
		serviceCenterDAO.changeQuestions(map);
	}
	//관리자 질문 삭제
	public void delQuestions(int Num) {
		serviceCenterDAO.delQuestions(Num);
	}
	//1대1문의 테이블 글쓰기
	public void Enterinquiry(ServiceCenterVO serviceCenterVO) {
		int Num = 1 ; 
		if(serviceCenterDAO.InquiryNullCheck()!=0) {
			Num = serviceCenterDAO.getInquiryMaxNum()+1;
		}
		serviceCenterVO.setNum(Num);
		serviceCenterDAO.EnterInquiry(serviceCenterVO);
	}
	//1대1 문의 아이디에 따른 리스트 가져오기
	public JSONArray getinquirylist(String id) {
		List<ServiceCenterVO> list = serviceCenterDAO.getinquirylist(id);
		JSONArray jsonArray = new JSONArray();
		for(int i = 0 ; i < list.size() ; i ++) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("Num", list.get(i).getNum());
			jsonObject.put("title", list.get(i).getTitle());
			jsonObject.put("contents", list.get(i).getContents());
			jsonObject.put("answer", list.get(i).getAnswer());
			jsonObject.put("answerstatus", list.get(i).getAnswerstatus());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	//1대1문의 관리자 페이지 리스트 가져오기
	public JSONArray getAllinquiryList(int answerstatus) {
		List<ServiceCenterVO> list = serviceCenterDAO.getAllinquiryList(answerstatus);
		JSONArray jsonArray = new JSONArray();
		for(int i = 0 ; i <list.size(); i++) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("id",list.get(i).getId());
			jsonObject.put("Num",list.get(i).getNum());
			jsonObject.put("title",list.get(i).getTitle());
			jsonObject.put("contents",list.get(i).getContents());
			jsonObject.put("writedate",new SimpleDateFormat("yyyy/MM/dd").format(list.get(i).getWritedate()));
			jsonObject.put("answer",list.get(i).getAnswer());
			jsonObject.put("answerstatus",list.get(i).getAnswerstatus());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	//1대1문의 글번호로 정보 가져오기
	public ServiceCenterVO getinquiryinfo(int Num) {
		return serviceCenterDAO.getinquiryinfo(Num);
	}
	//1대1문의 수정하기
	public void ModInquiry(ServiceCenterVO serviceCenterVO) {
		serviceCenterDAO.ModInquiry(serviceCenterVO);
	}
}
