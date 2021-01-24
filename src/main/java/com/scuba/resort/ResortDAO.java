package com.scuba.resort;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

@Repository
public class ResortDAO {
	@Autowired
	private SqlSession sqlSession;
	//등록리조트 갯수 구하기
	public int CheckNum(){
		return sqlSession.selectOne("mapper.resort.CheckNum");
	}
	//최대 번호 구하기
	public int getMaxNum(){
		return sqlSession.selectOne("mapper.resort.getMaxNum");
	}
	//파일 업로드
	public void FileUpload(MultipartFile file,String url) throws Exception {
		File saveFile =new File(url,file.getOriginalFilename());
		if(!new File(url).exists()) new File(url).mkdirs();
		file.transferTo(saveFile);
	}
	//파일 삭제
	public void FileDel(String filename , String url) throws Exception{
		File delfile = new File(url + filename);
		delfile.delete();
	}
	//리조트 등록하기
	public int EnterResort(ResortVO resortVO) {
		return sqlSession.insert("mapper.resort.EnterResort", resortVO);
	}
	//리조트 글 갯수 가져오기
	public int getResortCount(HashMap<String,Object> map) {
		return sqlSession.selectOne("mapper.resort.getResortCount",map);
	}
	//관리자 페이지 리조트 리스트 가져오기
	public List<ResortVO> getAdminResortList(HashMap<String,Object> map){
		return sqlSession.selectList("mapper.resort.getAdminResortList",map);
	}
	//이미지 경로 변경
	public int contentChange(HashMap map) {
		return sqlSession.update("mapper.resort.contentChange", map);
	}
	//글번호로 리조트 정보 가져오기
	public ResortVO getResortInfo(int num) {
		return sqlSession.selectOne("mapper.resort.getResortInfo",num);
	}
	//조회수 증가
	public void viewCountAdd(int num) {
		sqlSession.update("mapper.resort.viewCountAdd",num);
	}
	//리조트 상태 변경
	public void changeResortStatus(HashMap<String,Object> map) {
		sqlSession.update("mapper.resort.changeResortStatus",map);
	}
	//리조트 삭제
	public void delResort(int num) {
		sqlSession.update("mapper.resort.delResort",num);
	}
	//리조트 토탈 구하기
	public int gettotal(HashMap<String,Object> map) {
		return sqlSession.selectOne("mapper.resort.gettotal",map);
	}
	//리조트 리스트 가져오기
	public List<ResortVO> getResrotList(HashMap<String,Object> map){
		return sqlSession.selectList("mapper.resort.getResrotList",map);
	}
	//리조트 수정하기
	public int ResortMod(ResortVO resortVO) {
		return sqlSession.update("mapper.resort.ResortMod",resortVO);
	}
	//리뷰 등록
	public void ReviewsWrite(ResortVO resortVO) {
		sqlSession.insert("mapper.resort.ReviewsWrite",resortVO);
	}
	//리뷰 리스트 가져오기
	public List<ResortVO> getReviewsList(int num){
		return sqlSession.selectList("mapper.resort.getReviewsList",num);
	}
	//리뷰 썻는지 확인
	public int reviewCheck(HashMap<String,Object> map) {
		return sqlSession.selectOne("mapper.resort.reviewCheck",map);
	}
	//리뷰 삭제 
	public void delReviews(HashMap<String,Object> map) {
		sqlSession.delete("mapper.resort.delReviews",map);
	}
}
