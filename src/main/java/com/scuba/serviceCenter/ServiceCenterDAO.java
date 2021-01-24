package com.scuba.serviceCenter;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ServiceCenterDAO {

	@Autowired
	private SqlSession sqlSession;
	
	//질문 테이블 null 체크
	public int QuestionsNullCheck() {
		return sqlSession.selectOne("mapper.Service.QuestionsNullCheck");
	}
	//질문 테이블 Num 구하기
	public int getQuestionsMaxNum() {
		return sqlSession.selectOne("mapper.Service.getQuestionsMaxNum");
	}
	//질문 테이블 글쓰기
	public int EnterQuestions(ServiceCenterVO serviceCenterVO) {
		return sqlSession.insert("mapper.Service.EnterQuestions",serviceCenterVO);
	}
	//질문 테이블 카테고리 가져오기
	public List<String> getQuestionsCategory(){
		return sqlSession.selectList("mapper.Service.getQuestionsCategory");
	}
	//질문 테이블 글 리스트 가져오기
	public List<ServiceCenterVO> getQuestionsList(String category){
		return sqlSession.selectList("mapper.Service.getQuestionsList",category);
	}
	//자주묻는 질문 리스트 가져오기
	public List<ServiceCenterVO> getTopQuestionsList(){
		return sqlSession.selectList("mapper.Service.getTopQuestionsList");
	}
	//관리자 페이지 리스트 가져오기
	public List<ServiceCenterVO> getList(int TopQuestions){
		return sqlSession.selectList("mapper.Service.getList",TopQuestions);
	}
	//자주묻는질문 변경
	public void changeQuestions(HashMap<String,Integer> map) {
		sqlSession.update("mapper.Service.changeQuestions",map);
	}
	//관리자 질문 삭제
	public void delQuestions(int Num) {
		sqlSession.delete("mapper.Service.delQuestions",Num);
	}
	//질문 테이블 null 체크
	public int InquiryNullCheck() {
		return sqlSession.selectOne("mapper.Service.InquiryNullCheck");
	}
	//질문 테이블 Num 구하기
	public int getInquiryMaxNum() {
		return sqlSession.selectOne("mapper.Service.getInquiryMaxNum");
	}
	//1대1문의 테이블 글쓰기
	public int EnterInquiry(ServiceCenterVO serviceCenterVO) {
		return sqlSession.insert("mapper.Service.EnterInquiry",serviceCenterVO);
	}
	//1대1문의 아이디에 따른 리스트 가져오기
	public List<ServiceCenterVO> getinquirylist(String id){
		return sqlSession.selectList("mapper.Service.getinquirylist",id);
	}
	//1대1문의 관리자 페이지 리스트 가져오기
	public List<ServiceCenterVO> getAllinquiryList(int answerstatus){
		return sqlSession.selectList("mapper.Service.getAllinquiryList", answerstatus);
	}
	//1대1문의 글번호로 정보 가져오기
	public ServiceCenterVO getinquiryinfo(int Num) {
		return sqlSession.selectOne("mapper.Service.getinquiryinfo",Num);
	}
	//1대1문의 수정하기
	public void ModInquiry(ServiceCenterVO serviceCenterVO) {
		sqlSession.update("mapper.Service.ModInquiry",serviceCenterVO);
	}
}
