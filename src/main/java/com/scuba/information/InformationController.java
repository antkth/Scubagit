package com.scuba.information;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.scuba.resort.ResortVO;

@Controller
@RequestMapping(value = "/informations/*")
public class InformationController{
	
	@Autowired
	private InformationService informationService ;
	ModelAndView modelAndView = new ModelAndView(); 

	
	//다이빙(국가) 이동
	@RequestMapping(value = "DivingCountry")
	public ModelAndView DivingCountry(HttpServletRequest request) {
		modelAndView.addObject("CountryList", informationService.getCountryName());
		if(request.getParameter("CountryName")!=null) modelAndView.addObject("nowCountryName",request.getParameter("CountryName"));
		modelAndView.setViewName("information/I-DivingCountry");
		return modelAndView;
	}
	//다이빙(국가) 등록 이동
	@RequestMapping(value = "EnterCountry")
	public ModelAndView EnterCountry() {
		modelAndView.addObject("CountryList", informationService.getCountryName());
		modelAndView.setViewName("information/M-EnterCountry");
		return modelAndView;
	}
	//다이빙(국가) 등록
	@RequestMapping(value = "sendCountry", method = RequestMethod.POST)
	public ModelAndView sendCountry(MultipartHttpServletRequest mutirequest,
									HttpSession session) throws Exception {
		informationService.enterCountry(mutirequest, session);
		modelAndView.setViewName("redirect:/informations/EnterCountry");
		return modelAndView;
	}
	//국가 등록시 카테고리 변경
	@ResponseBody
	@RequestMapping(value = "getCountryinfo", method = RequestMethod.POST)
	public JSONObject getCountryinfo(String CountryName,HttpSession session,
									HttpServletRequest request) {
		String url = request.getContextPath()+"/resources/upload/admin/information/Country/";
		InformationVO informationVO = informationService.getCountryinfo(CountryName);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("CountryName",informationVO.getCountryName());
		jsonObject.put("CountryImage", informationVO.getCountryImage());
		jsonObject.put("url",url);
		return jsonObject;
	}
	//다이빙(도시) 등록 이동
	@RequestMapping(value = "EnterCity")
	public ModelAndView EnterCity() {
		modelAndView.addObject("CountryList", informationService.getCountryName());
		modelAndView.setViewName("information/M-EnterCity");
		return modelAndView;
	}
	//다이빙(국가) 등록
	@RequestMapping(value = "sendCity", method = RequestMethod.POST)
	public ModelAndView sendCity(MultipartHttpServletRequest multirequest,
									HttpSession session) throws Exception {
		informationService.enterCity(multirequest, session);
		modelAndView.setViewName("redirect:/informations/EnterCity");
		return modelAndView;
	}
	//국가 카테고리 변경
	@ResponseBody
	@RequestMapping(value = "getCityList", method = RequestMethod.POST)
	public List<String> getCityList(String CountryName) {
		return informationService.getCityList(CountryName);
	}
	//도시 등록시 도시 카테고리 변경
	@ResponseBody
	@RequestMapping(value = "getCityinfo", method = RequestMethod.POST)
	public JSONObject getCityinfo(String CityName,HttpSession session,
									HttpServletRequest request) {
		String url = request.getContextPath()+"/resources/upload/admin/information/City/";
		InformationVO informationVO = informationService.getCityinfo(CityName);
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("CityName",informationVO.getCityName());
		jsonObject.put("CityImage", informationVO.getCityImage());
		jsonObject.put("url",url);
		return jsonObject;
	}
	//국가 등록시 카테고리 변경
	@ResponseBody
	@RequestMapping(value = "getCountryPointinfo", method = RequestMethod.POST)
	public JSONArray getCountryPointinfo(String CountryName,HttpSession session,
									HttpServletRequest request) {
		String url = request.getContextPath()+"/resources/upload/admin/information/Country/";
		List<HashMap<String,Object>> list = informationService.getCountryPointinfo(CountryName);
		JSONArray jsonArray = new JSONArray();
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("url",url);
		jsonArray.add(jsonObject);
		for(int i = 0 ; i <list.size() ; i++) {
			int check = informationService.CityCheck((String)list.get(i).get("CityName"));
			if(check != 0) jsonArray.add(list.get(i));
		}
		return jsonArray;
	}
	//다이빙(도시) 이동
	@RequestMapping(value = "DivingCity")
	public ModelAndView DivingCity(@RequestParam String CityName) {
		List<InformationVO> list = informationService.getDivinglist(CityName);
		modelAndView.addObject("CityImage",list.get(0).getCityImage());
		modelAndView.addObject("nowCityName",list.get(0).getCityName());
		modelAndView.addObject("AveTemper",list.get(0).getAveTemper());
		modelAndView.addObject("Season",list.get(0).getSeason());
		modelAndView.addObject("CityExp",list.get(0).getCityExp());
		modelAndView.addObject("CountryList",informationService.getCountryName());
		modelAndView.addObject("nowCountryName",list.get(0).getCountryName());
		modelAndView.addObject("CityList", informationService.getCityList(list.get(0).getCountryName()));
		modelAndView.addObject("FishList",informationService.getFishinCity(CityName));
		modelAndView.addObject("resortList",informationService.getCityResortList(CityName));
		modelAndView.setViewName("information/I-DivingInfo");
		return modelAndView;
	}
	//다이빙 포인트 리스트 뽑아오기
	@ResponseBody
	@RequestMapping(value = "getDivingList", method = RequestMethod.POST)
	public JSONArray getDivingList(String CityName) {
		List<InformationVO> list = informationService.getDivinglist(CityName);
		JSONArray jsonArray = new JSONArray();
		for(int i = 0 ; i <list.size() ; i++) {
			JSONObject jsonObject = new JSONObject();
			InformationVO informationVO = list.get(i);
			jsonObject.put("DivingXpoint", informationVO.getDivingXpoint());
			jsonObject.put("DivingYpoint", informationVO.getDivingYpoint());
			jsonObject.put("DivingName", informationVO.getDivingName());
			jsonObject.put("DivingRating", informationVO.getDivingRating());
			jsonObject.put("DivingDepthMin", informationVO.getDivingDepthMin());
			jsonObject.put("DivingDepthMax", informationVO.getDivingDepthMax());
			jsonArray.add(jsonObject);
		}
		return jsonArray;
	}
	//다이빙 포인트 뷰페이지 이동
	@RequestMapping(value = "DivingSiteView",method = RequestMethod.GET)
	public ModelAndView DivingSiteView(String CityName , String DivingName) {
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("CityName",CityName);
		map.put("DivingName",DivingName);
		InformationVO informationVO = informationService.DivingSiteinfo(map);
		modelAndView.addObject("CityName",informationVO.getCityName());
		modelAndView.addObject("CityImage",informationVO.getCityImage());
		modelAndView.addObject("DivingXpoint",informationVO.getDivingXpoint());
		modelAndView.addObject("DivingYpoint",informationVO.getDivingYpoint());
		modelAndView.addObject("DivingName",informationVO.getDivingName());
		modelAndView.addObject("DivingExp",informationVO.getDivingExp());
		modelAndView.addObject("DivingRating",informationVO.getDivingRating());
		modelAndView.addObject("DivingDepthMin",informationVO.getDivingDepthMin());
		modelAndView.addObject("DivingDepthMax",informationVO.getDivingDepthMax());
		modelAndView.setViewName("information/I-View");
		return modelAndView;
	}
	//어류 리스트 페이지 이동
	@RequestMapping(value = "FishList")
	public ModelAndView FishList() {
		modelAndView.addObject("FishList",informationService.getFishList());
		modelAndView.setViewName("information/M-FishList");
		return modelAndView;
	}
	//어류 등록 페이지 이동
	@RequestMapping(value = "EnterFish")
	public ModelAndView EnterFish() {
		modelAndView.setViewName("information/M-FishEnrollment");
		return modelAndView;
	}
	//어류 DB 등록
	@RequestMapping(value = "SendFish",method = RequestMethod.POST)
	public ModelAndView SendFish(MultipartHttpServletRequest multirequest,
								HttpSession session) throws Exception {
		informationService.SendFish(multirequest, session);
		modelAndView.setViewName("redirect:/EnterFish.info");
		return modelAndView;
	}
	//어류리스트 지역추가
	@ResponseBody
	@RequestMapping(value = "addHauntingCity", method = RequestMethod.POST)
	public void addHauntingCity(String CityName,String FishName) {
		String HauntingCity = informationService.getHauntingCity(FishName);
		if(!HauntingCity.contains(CityName)) HauntingCity += " "+CityName;
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("FishName",FishName);
		map.put("HauntingCity", HauntingCity);
		informationService.addHaunting(map);
	}
	//국가명에 따른  도시 이미지 가져오기
	@ResponseBody
	@RequestMapping(value = "antherCityArea", method = RequestMethod.POST)
	public JSONArray antherCityArea(String CountryName) {
		List<HashMap<String,Object>> list = informationService.antherCityArea(CountryName);
		JSONArray jsonArray = new JSONArray();
		for(int i = 0 ; i < list.size() ; i++) {
			jsonArray.add(list.get(i));
		}
		return jsonArray;
	}
	//인덱스 페이지 랜덤 지역 뿌려주기
	@ResponseBody
	@RequestMapping(value = "indexCity")
	public List<InformationVO> indexCity(){
		return informationService.indexCity();
	}
	//도시 페이지 리조트 뿌려주기
	@ResponseBody
	@RequestMapping(value = "getCountryNameList")
	public List<String> getCountryNameList(){
		return informationService.getCountryName();
	}
	//인덱스페이지 리조트 뿌려주기
	@ResponseBody
	@RequestMapping(value = "getIndexCityResortList" , method = RequestMethod.POST)
	public List<ResortVO> getIndexCityResortList(String CityName){
		return informationService.getIndexCityResortList(CityName);
	}
	//도시 체크
	@ResponseBody
	@RequestMapping(value = "CityCheck" , method = RequestMethod.POST)
	public int CityCheck(String CityName , String CountryName){
		return informationService.CityCheck(CityName, CountryName);
	}
	//시티 리스트 가져오기
	@ResponseBody
	@RequestMapping(value = "getAllCityList" , method = RequestMethod.POST)
	public List<String> getAllCityList(){
		return informationService.getAllCityList();
	}
}
