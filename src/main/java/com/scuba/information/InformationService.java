package com.scuba.information;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.scuba.resort.ResortVO;
@Service
public class InformationService {
	@Autowired
	private InformationDAO informationDAO;
	//국가 DB 인설트
	public void enterCountry(MultipartHttpServletRequest mutirequest,
							HttpSession session) throws Exception{
		InformationVO informationVO = new InformationVO();
		informationVO.setCountryName(mutirequest.getParameter("CountryName"));
		if(mutirequest.getParameter("CountryImageAlread")!=null) {
			informationVO.setCountryImage(mutirequest.getParameter("CountryImageAlread"));
		}else {
			informationVO.setCountryImage(mutirequest.getFile("CountryImage").getOriginalFilename());
		}
		informationVO.setCityXpoint(Double.parseDouble(mutirequest.getParameter("CityXpoint")));
		informationVO.setCityYpoint(Double.parseDouble(mutirequest.getParameter("CityYpoint")));
		informationVO.setCityName(mutirequest.getParameter("CityName"));
		informationVO.setCityExp(mutirequest.getParameter("CityExp"));
		informationVO.setAveTemper(Integer.parseInt(mutirequest.getParameter("AveTemper")));
		//시즌 값 생성
		String Season = "";
		for(int i = 0 ; i < 12 ; i++) {
		if(mutirequest.getParameter("Season"+i) != null) Season += mutirequest.getParameter("Season"+i)+"월 ";
		}
		informationVO.setSeason(Season);
		System.out.println("시즌 :" + Season);
		if(mutirequest.getParameter("CountryImageAlread")==null) {
			//파일 업로드
			MultipartFile file = mutirequest.getFile("CountryImage");
			String url = session.getServletContext().getRealPath("/resources/upload/admin/information/Country/");
			informationDAO.FileUpload(file, url);
		}
		//DB입력 
		informationDAO.enterCountry(informationVO);
	}
	//국가명 리스트 가져오기
	public List<String> getCountryName(){
		return informationDAO.getCountryName();
	}
	//국가 정보 가져오기
	public InformationVO getCountryinfo(String CountryName) {
		return informationDAO.getCountryinfo(CountryName);
	}
	//도시 DB 인설트
	public void enterCity(MultipartHttpServletRequest multirequest,
						HttpSession session) throws Exception{
		//DB작업
		InformationVO informationVO = new InformationVO();
		informationVO.setCityName(multirequest.getParameter("CityName"));
		if(multirequest.getParameter("CityImageAlread")!=null) {
			informationVO.setCityImage(multirequest.getParameter("CityImageAlread"));
		}else {
			informationVO.setCityImage(multirequest.getFile("CityImage").getOriginalFilename());
		}
		informationVO.setCountryName(multirequest.getParameter("CountryName"));
		informationVO.setDivingXpoint(Double.parseDouble(multirequest.getParameter("DivingXpoint")));
		informationVO.setDivingYpoint(Double.parseDouble(multirequest.getParameter("DivingYpoint")));
		informationVO.setDivingName(multirequest.getParameter("DivingName"));
		informationVO.setDivingExp(multirequest.getParameter("DivingExp"));
		informationVO.setDivingRating(multirequest.getParameter("DivingRating"));
		informationVO.setDivingDepthMin(multirequest.getParameter("DivingDepthMin"));
		informationVO.setDivingDepthMax(multirequest.getParameter("DivingDepthMax"));
		informationDAO.enterCity(informationVO);
		//파일 업로드
		if(multirequest.getParameter("CityImageAlread")==null) {
		MultipartFile file = multirequest.getFile("CityImage");
		String url = session.getServletContext().getRealPath("/resources/upload/admin/information/City/");
		informationDAO.FileUpload(file, url);
		}
	}
	//국가에 따른 도시명 리스트 가져오기
	public List<String> getCityList(String CountryName){
		return informationDAO.getCityList(CountryName);
	}
	//도시 정보 가져오기
	public InformationVO getCityinfo(String CityName) {
		return informationDAO.getCityinfo(CityName);
	}
	//국가 포인트 정보 가져오기
	public List<HashMap<String,Object>> getCountryPointinfo(String CountryName){
		return informationDAO.getCountryPointinfo(CountryName);
	}
	//다이빙 포인트 리스트 가져오기
	public List<InformationVO> getDivinglist(String CityName){
		return informationDAO.getDivinglist(CityName);
	}
	//국가 테이블 도시가 도시테이블 도시에 있는지 확인 
	public int CityCheck (String CityName) {
		return informationDAO.CityCheck(CityName);
	}
	//다이빙사이트 정보 가져오기
	public InformationVO DivingSiteinfo(HashMap<String,Object> map) {
		return informationDAO.DivingSiteinfo(map);
	}
	//어류등록
	public void SendFish(MultipartHttpServletRequest multirequest,
						HttpSession session)throws Exception {
		InformationVO informationVO = new InformationVO();
		informationVO.setFishName(multirequest.getParameter("FishName"));
		informationVO.setFishExp(multirequest.getParameter("FishExp"));
		informationVO.setFishImage(multirequest.getFile("FishImage").getOriginalFilename());
		informationVO.setHauntingCity(multirequest.getParameter("HauntingCity"));
		informationDAO.SendFish(informationVO);
		MultipartFile file = multirequest.getFile("FishImage");
		String url = session.getServletContext().getRealPath("/resources/upload/admin/information/Fish/");
		informationDAO.FileUpload(file, url);
	}
	//어류리스트 가져오기
	public List<InformationVO> getFishList(){
		return informationDAO.getFishList();
	}
	//특정 어류 서식지 가져오기
	public String getHauntingCity(String FishName) {
		return informationDAO.getHauntingCity(FishName);
	}
	//어류 서식지 추가
	public void addHaunting(HashMap<String,Object> map) {
		informationDAO.addHaunting(map);
	}
	//국가페이지 도시 이미지 띄어주기
	public List<HashMap<String,Object>> antherCityArea(String CountryName){
		return informationDAO.antherCityArea(CountryName);
	}
	//도시페이지 어류 가져오기
	public List<HashMap<String,Object>> getFishinCity(String CityName){
		return informationDAO.getFishinCity("%"+CityName+"%");
	}
	//인덱스페이지 랜덤 도시 뿌려주기
	public List<InformationVO> indexCity() {
		String CityName = informationDAO.getRandomCityName();
		return informationDAO.getDivinglist(CityName);
	}
	//도시명으로 리조트 리스트 가져오기
	public List<ResortVO> getCityResortList(String CityName){
		return informationDAO.getCityResortList(CityName);
	}
	//인덱스 도시명으로 리조트 리스트 가져오기
	public List<ResortVO> getIndexCityResortList(String CityName){
		return informationDAO.getIndexCityResortList(CityName);
	}
	//도시가 나라에 있는지 확인
	public int CityCheck(String CityName , String CountryName) {
		int check = 1 ;
		List<String> list = informationDAO.getEnterCityList(CountryName);
		for(int i = 0 ; i < list.size(); i++) {
			if(list.get(i).equals(CityName)) check = 0;
		}
		return check;
	}
	//시티 리스트 가져오기
	public List<String> getAllCityList(){
		return informationDAO.getAllCityList();
	}
}
