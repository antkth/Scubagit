package com.scuba.information;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.scuba.resort.ResortVO;

@Repository
public class InformationDAO {
	@Autowired
	private SqlSession sqlSession;
	
	//파일 업로드
	public void FileUpload(MultipartFile file,String url) throws Exception {
		File saveFile =new File(url,file.getOriginalFilename());
		if(!new File(url).exists()) new File(url).mkdirs();
		file.transferTo(saveFile);
	}
	//국가 DB 인설트
	public void enterCountry(InformationVO informationVO) {
		sqlSession.insert("mapper.information.enterCountry",informationVO);
	}
	//국가명 리스트 가져오기
	public List<String> getCountryName(){
		return sqlSession.selectList("mapper.information.getCountryName");
	}
	//국가명에따른 이미지 가져오기
	public InformationVO getCountryinfo(String CountryName) {
		return sqlSession.selectOne("mapper.information.getCountryinfo",CountryName);
	}
	//도시 DB 인설트
	public void enterCity(InformationVO informationVO) {
		sqlSession.insert("mapper.information.enterCity",informationVO);
	}
	//국가에 따른 도시명 가져오기
	public List<String> getCityList(String CountryName){
		return sqlSession.selectList("mapper.information.getCityList",CountryName);
	}
	//도시 등록시 국가에 따른 도시명 가져오기
	public List<String> getEnterCityList(String CountryName){
		return sqlSession.selectList("mapper.information.getEnterCityList",CountryName);
	}
	//도시 정보 가져오기 
	public InformationVO getCityinfo(String CityName) {
		return sqlSession.selectOne("mapper.information.getCityinfo",CityName);
	}
	//국가 포인트 정보 가져오기
	public List<HashMap<String, Object>> getCountryPointinfo(String countryName) {
		return sqlSession.selectList("mapper.information.getCountryPointinfo",countryName);
	}
	//다이빙사이트 리스트 가져오기
	public List<InformationVO> getDivinglist(String CityName){
		return sqlSession.selectList("mapper.information.getDivinglist",CityName);
	}
	//국가 테이블 도시가 도시테이블 도시에 있는지 확인 
	public int CityCheck (String CityName) {
		return sqlSession.selectOne("mapper.information.CityCheck", CityName);
	}
	//다이빙사이트 정보 가져오기
	public InformationVO DivingSiteinfo(HashMap<String,Object> map) {
		return sqlSession.selectOne("mapper.information.DivingSiteinfo",map);
	}
	//어류등록
	public void SendFish(InformationVO informationVO) {
		sqlSession.insert("mapper.information.SendFish",informationVO);
	}
	//어류 리스트 가져오기
	public List<InformationVO> getFishList(){
		return sqlSession.selectList("mapper.information.getFishList");
	}
	//특정 어류 서식지 가져오기
	public String getHauntingCity(String FishName) {
		return sqlSession.selectOne("mapper.information.getHauntingCity",FishName);
	}
	//어류 서식지 추가
	public void addHaunting(HashMap<String,Object> map) {
		sqlSession.update("mapper.information.addHaunting",map);
	}
	//국가페이지 도시 이미지 띄어주기
	public List<HashMap<String,Object>> antherCityArea(String CountryName){
		return sqlSession.selectList("mapper.information.antherCityArea",CountryName);
	}
	//도시페이지 어류 가져오기
	public List<HashMap<String,Object>> getFishinCity(String CityName){
		return sqlSession.selectList("mapper.information.getFishinCity",CityName);
	}
	//랜덤 도시이름 가져오기
	public String getRandomCityName() {
		return sqlSession.selectOne("mapper.information.getRandomCityName");
	}
	//도시명으로 리조트 가져오기
	public List<ResortVO> getCityResortList(String CityName){
		return sqlSession.selectList("mapper.resort.getCityResortList",CityName);
	}
	//인덱스 도시명으로 리조트 리스트 가져오기
	public List<ResortVO> getIndexCityResortList(String CityName){
		return sqlSession.selectList("mapper.resort.getIndexCityResortList", CityName);
	}
	//도시 리스트 가져오기
	public List<String> getAllCityList(){
		return sqlSession.selectList("mapper.information.getAllCityList");
	}
}
