package com.scuba.jobSearchboard;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scuba.common.Common;

@Service
public class JobSearchboardService {
	
	@Autowired
	JobSearchboardDAO jobsearchboardDAO;
	
	Common common = new Common();
	
	//구인 구직 게시판 모든(글)리스트 조회
	public Map<String, Object> allBoardList(String search1, String search2, String searchsort, int nowpage1, int nowpage2) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		//구인
		map.put("paging1",common.paging(nowpage1, getTotal1(search1, searchsort), 20, 5));
		//구직
		map.put("paging2",common.paging(nowpage2, getTotal2(search2 ,searchsort), 20, 5));
		map.put("search1", "%"+search1+"%");
		map.put("search2", "%"+search2+"%");
		map.put("searchsort", searchsort);
		//구인 게시판
		map.put("jobSearchBoardList1", jobsearchboardDAO.allBoardList1(map));
		//구직 게시판
		map.put("jobSearchBoardList2", jobsearchboardDAO.allBoardList2(map));
		map.put("search1", search1);
		map.put("search2", search2);
		return map;
	}
	
	//구인 구직 게시판 글 작성
	public HashMap<String, Object> WriteInsert(JobSearchboardVO jobsearchboardVO, HttpServletRequest request,
			HttpServletResponse response) {
		
		String nickname = (String) request.getSession().getAttribute("user_nickname");
		jobsearchboardVO.setNickname(nickname);
		String userId = (String) request.getSession().getAttribute("user_id");
		// 이미지 사용 여부
		int imgexists = 0;
		String category = (String)request.getSession().getAttribute("category");
		// 컨텐트 내용 저장후 정규식을 이용하여 src 경로만 추출
		String content = jobsearchboardVO.getContent();
		// src경로 추출 정규식 ********src태그만 뽑아오는 정규식<src=[\\\\\\\"']?([^>\\\\\\\"']+)[\\\\\\\"']?[^>]*>*******
		Pattern pattern = Pattern.compile("<img[^>]*src=[\\\"']?(?!https:)([^>\\\"']+)[\\\"']?[^>]*>");
		Matcher matcher = pattern.matcher(content);
		// imglist : src경로 list , realimglist : 실제 이미지(파일)명 list
		ArrayList<String> imglist = new ArrayList<String>();
		ArrayList<String> realimglist = new ArrayList<String>();
		// while문 list증가 변수용 i
		int i = 0;
		// 컨텐트 전체내용에서 src경로가 나올때까지 설정한 정규식을 통하여 추출함
		while (matcher.find()) {
			System.out.println("정규식 추출" + matcher.group(1));
			if (matcher.group(1) == null) {
				break;
			}
			// 정규식으로 src경로 추출 후 list에 담아줌
			imglist.add(matcher.group(1));
			// 이미지명만 따로 추출
			realimglist.add(imglist.get(i).substring(imglist.get(i).lastIndexOf("/") + 1));
			i++;
			//이미지 유무 확인
			imgexists = 1;
		}
		//글 등록 결과 값
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		// DB 인설트 구문 성공시 1 반환 글 작성 완료시 진행
		if (jobsearchboardDAO.write(jobsearchboardVO) == 1) {
			// 최근게시글 번호 값 가져오기 새로생길 저장 폴더 이름(추가될 게시글 번호) 용도
			String folderNum = Integer.toString(jobsearchboardDAO.getMaxNum());
			//이미지가 있을 때
			if (imgexists == 1) {
				// 글 등록 성공시 임시폴더 파일 서버폴더로 이동 후 임시폴더 삭제  *서버폴더는 카테고리/글번호로 한다
				System.out.println("폴더 넘 : " + folderNum);
				int result = common.imguploadServer(request, response, realimglist, category, folderNum);
				// 이미지 이동 성공 시 (임시 -> 서버) src 경로 변경
				if (result == 1) {
					//이미지 경로 변경
					String beforeContent = jobsearchboardVO.getContent();
					System.out.println("beforeContent : " + beforeContent);
					String changePath = beforeContent.replace("Temporary", category);
					System.out.println("changePath : " + changePath);
					String afterContent = changePath.replace(userId, folderNum);
					System.out.println("에프터 컨텐  11111: " + afterContent);
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("afterContent", afterContent);
					map.put("contentNum", folderNum);
					System.out.println("에프터 컨텐 : " + map.get("afterContent"));
					System.out.println("컨텐 넘버  : " + map.get("contentNum"));
					//이미지 경로 수정
					if (jobsearchboardDAO.contentChange(map) == 1) {
						System.out.println("1");
						System.out.println();
						resultmap.put("contentNum", folderNum);
						resultmap.put("writeResult", 1); //content 내용 path변경 성공 
					}else {
						//글삭제 쿼리 넣어줘야함
						/* 글 삭제 쿼리*/
						System.out.println("2");
						resultmap.put("writeResult", 0); //글 등록 실패
					}
				}else {
					//글삭제 쿼리 넣어줘야함
					/* 글 삭제 쿼리*/
					System.out.println("3");
					resultmap.put("writeResult", 0);
				}
			} else {//이미지 없을때
				resultmap.put("contentNum", folderNum);
				resultmap.put("writeResult", 2); //이미지 없는글 인서트 성공
			}
		} else {
			System.out.println("4");
			resultmap.put("writeResult", 0); //글 등록 실패
		}
		return resultmap;		
	}
	
	//글 상세보기
	public JobSearchboardVO viewList(int contentNum) {
		return jobsearchboardDAO.viewList(contentNum);
	}
	
	//게시글 수정 페이지 이동(수정 글 정보 select)
	public JobSearchboardVO ModifyList(int contentNum) {
		return jobsearchboardDAO.ModifyList(contentNum);
	}

	//게시글 수정 등록
	public HashMap<String, Object> Modify(JobSearchboardVO jobsearchboardVO, HttpServletRequest request, HttpServletResponse response) {
		//카테고리 값 얻기 
		String category = (String)request.getSession().getAttribute("category");
		//폴더 명 얻기
		String folderNum = Integer.toString(jobsearchboardVO.getNum());
		// 컨텐트 내용 저장후 정규식을 이용하여 src 경로만 추출
		String content = jobsearchboardVO.getContent();
		// src경로 추출 정규식 ********src태그 뽑아오는 거<src=[\\\\\\\"']?([^>\\\\\\\"']+)[\\\\\\\"']?[^>]*>*******
		Pattern pattern = Pattern.compile("<img[^>]*src=[\\\"']?(?!https:)([^>\\\"']+)[\\\"']?[^>]*>");
		Matcher matcher = pattern.matcher(content);
		// imglist : src경로 list , realimglist : 실제 이미지(파일)명 list
		ArrayList<String> imglist = new ArrayList<String>();
		ArrayList<String> realimglist = new ArrayList<String>();
		//이미지 유무 확인 
		int imgexists = 0;
		// while문 list증가 변수용 i
		int i = 0;
		// 컨텐트 전체내용에서 src경로가 나올때까지 설정한 정규식을 통하여 추출함
		while (matcher.find()) {
			System.out.println("정규식 추출" + matcher.group(1));
			if (matcher.group(1) == null) {
				break;
			}
			// 정규식으로 src경로 추출 후 list에 담아줌
			imglist.add(matcher.group(1));
			// 이미지명만 따로 추출
			realimglist.add(imglist.get(i).substring(imglist.get(i).lastIndexOf("/") + 1));
			System.out.println("리얼이미지 네임 리스트 : " + realimglist.get(i));
			i++;
			//이미지 유무 확인
			imgexists = 1;
		}
		//글 수정 결과 값
		HashMap<String, Object> resultmap = new HashMap<String, Object>();
		//수정된 글 DB 전송
		//글 수정 성공시
		if(jobsearchboardDAO.Modify(jobsearchboardVO) == 1) {
			//이미지가 있을 때
			if(imgexists == 1) {
				int imgModifyResult = common.imguploadModifyServer(request, response, realimglist, category, folderNum);
				//이미지 처리 성공 시
				if(imgModifyResult == 1) {
					resultmap.put("contentNum", folderNum);
					resultmap.put("modifyResult", 1);
				} else { //이미지 처리 실패
					resultmap.put("modifyResult", 0);
				}
			} else { //이미지 없을 시
				System.out.println("이미지없다 ");
				//수정 된 글 이미지 없을 시 서버 디렉토리 삭제 해줌
				if(common.DirDelete(request, response, category, folderNum) ==1 || common.DirDelete(request, response, category, folderNum) == 2) {
					resultmap.put("contentNum", folderNum);
					resultmap.put("modifyResult", 2); //이미지 없는 글 수정 성공
				} else { //이미지 처리 실패
					resultmap.put("modifyResult", 0); //디렉토리 삭제 실패 영역임
				}
				
			}
		} else { //글 수정 실패시 리턴값 0 반환
			resultmap.put("contentNum", folderNum);
			resultmap.put("modifyResult", 0);
		}
		return resultmap;
	}

	//게시글 삭제 시 닉네임 일치여부 체크
	public String idCheck(int contentNum) {
		return jobsearchboardDAO.idCheck(contentNum);
	}

	//게시글 삭제
	public int condelete(HttpServletRequest request, HttpServletResponse response, int contentNum) {
		//게시판 종류, 저장 폴더 이름 가져오기
		JobSearchboardVO jobsearchboardVO =  jobsearchboardDAO.viewList(contentNum);
		String category = jobsearchboardVO.getCommunityname();
		String folderNum = Integer.toString(jobsearchboardVO.getNum());
		//게시글 삭제 Result값
		int Result = 0;
		//글 삭제 완료시 1반환
		int deleteResult = jobsearchboardDAO.condelete(contentNum);
		if(deleteResult == 1) {
			//글 삭제 완료시 -> 서버 파일 저장 폴더 삭제
			//1 : 성공 / 0 : 실패 / 2: 이미지 첨부 게시글 아님
			Result = common.DirDelete(request, response, category, folderNum);
			System.out.println("리조트  : " + Result);
		} else if(deleteResult == 2){
			Result = 2;
		} else {
			Result = 0;
		}
		return Result;
	}
	
	//글 수정 취소 시
	public void modiFyCancle(JobSearchboardVO jobsearchboardVO, HttpServletRequest request, HttpServletResponse response) {
		//수정 취소 결과 값 0: 실패 / 1: 성공
//				int modiFyCancleResult = 0;
				//카테고리 값 얻기 
				String category = jobsearchboardVO.getCommunityname();
				//폴더 명 얻기
				String folderNum = Integer.toString(jobsearchboardVO.getNum());
				// 컨텐트 내용 저장후 정규식을 이용하여 src 경로만 추출
				String content = jobsearchboardVO.getContent();
				// src경로 추출 정규식 ********src태그 뽑아오는 거<src=[\\\\\\\"']?([^>\\\\\\\"']+)[\\\\\\\"']?[^>]*>*******
				Pattern pattern = Pattern.compile("<img[^>]*src=[\\\"']?(?!https:)([^>\\\"']+)[\\\"']?[^>]*>");
				Matcher matcher = pattern.matcher(content);
				// imglist : src경로 list , realimglist : 실제 이미지(파일)명 list
				ArrayList<String> imglist = new ArrayList<String>();
				ArrayList<String> realimglist = new ArrayList<String>();
				//이미지 유무 확인 
				int imgexists = 0;
				// while문 list증가 변수용 i
				int i = 0;
				// 컨텐트 전체내용에서 src경로가 나올때까지 설정한 정규식을 통하여 추출함
				while (matcher.find()) {
					if (matcher.group(1) == null) {
						break;
					}
					// 정규식으로 src경로 추출 후 list에 담아줌
					imglist.add(matcher.group(1));
					// 이미지명만 따로 추출
					realimglist.add(imglist.get(i).substring(imglist.get(i).lastIndexOf("/") + 1));
					i++;
					//이미지 유무 확인
					imgexists = 1;
				}
				if(imgexists == 1) {
					common.imguploadModifyServer(request, response, realimglist, category, folderNum);
				} else { //이미지 없을 시
					System.out.println("이미지 없음");
					//수정 된 글 이미지 없을 시 서버 디렉토리 삭제 해줌
					common.DirDelete(request, response, category, folderNum);
				}
	}
	
	//전체글 개수 조회 (구인)
	public int getTotal1(String search1, String searchsort) {
		String searchvalue = "%"+search1+"%";
		//전체글 조회
		return jobsearchboardDAO.getTotal1(searchvalue, searchsort);
	}	
	
	//전체글 개수 조회 (구직)
	public int getTotal2(String search2, String searchsort) {
		String searchvalue = "%"+search2+"%";
		//전체글 조회
		return jobsearchboardDAO.getTotal2(searchvalue, searchsort);
	}		
	
}
