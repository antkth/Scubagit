package com.scuba.notice;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.scuba.common.Common;
import com.scuba.freeboard.FreeBoardVO;

@Service
public class NoticeService {

	@Autowired
	private NoticeDAO noticeDAO;
	Common common = new Common();
	//글 작성
		public HashMap<String, Object> write(NoticeVO noticeVO, HttpServletRequest request, HttpServletResponse response)
				throws IOException {
			// ID값 설정 지워도 됨 나중에
//			request.getSession().setAttribute("user_id", "test3");
			// 닉네임값 설정 지워도 됨 나중에
//			request.getSession().setAttribute("user_nickname", "1");
			// 임시 닉네임값.
			String id = (String)request.getSession().getAttribute("user_id");
			String nickname = (String)request.getSession().getAttribute("user_nickname");
			noticeVO.setNickname(nickname);
			// 이미지 사용 여부
			int imgexists = 0;
			// 커뮤니티 이름설정 카테고리 
			String category = (String)request.getSession().getAttribute("category");
			noticeVO.setCommunityname(category);
			// 컨텐트 내용 저장후 정규식을 이용하여 src 경로만 추출
			String content = noticeVO.getContent();
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
			if (noticeDAO.write(noticeVO) == 1) {
				// 최근게시글 번호 값 가져오기 새로생길 저장 폴더 이름(추가될 게시글 번호) 용도
				String folderNum = Integer.toString(noticeDAO.getMaxNum());
				//이미지가 있을 때
				if (imgexists == 1) {
					// 글 등록 성공시 임시폴더 파일 서버폴더로 이동 후 임시폴더 삭제  *서버폴더는 카테고리/글번호로 한다
					int result = common.imguploadServer(request, response, realimglist, category, folderNum);
					// 이미지 이동 성공 시 (임시 -> 서버) src 경로 변경
					if (result == 1) {
						//이미지 경로 변경
						String beforeContent = noticeVO.getContent();
						String changePath = beforeContent.replace("Temporary", category);
						String afterContent = changePath.replace(id, folderNum);
						HashMap<String, Object> map = new HashMap<String, Object>();
						map.put("afterContent", afterContent);
						map.put("contentNum", folderNum);
						//이미지 경로 수정
						if (noticeDAO.contentChange(map) == 1) {
							resultmap.put("contentNum", folderNum);
							resultmap.put("writeResult", 1); //content 내용 path변경 성공 
						}else {
							//글삭제 쿼리 넣어줘야함
							/* 글 삭제 쿼리*/
							resultmap.put("writeResult", 0); //글 등록 실패
						}
					}else {
						//글삭제 쿼리 넣어줘야함
						/* 글 삭제 쿼리*/
						resultmap.put("writeResult", 0);
					}
				} else {//이미지 없을때
					resultmap.put("contentNum", folderNum);
					resultmap.put("writeResult", 2); //이미지 없는글 인서트 성공
				}
			} else {
				resultmap.put("writeResult", 0); //글 등록 실패
			}
			return resultmap;
		}
		
		//공지사항 리스트 가져오기
		public Map<String,Object> getNoticeList(String search , int nowpage){
			HashMap<String,Object> map = new HashMap<String, Object>();
			int total = noticeDAO.gettotal("%"+search+"%");
			map = common.paging(nowpage, total, 5,3);
			map.put("search","%"+search+"%");
			map.put("noticeList",noticeDAO.getNoticeList(map));
			map.put("search",search);
			map.put("nowpage",nowpage);
			return map;
		}
		
		//글 정보 가져오기
		public NoticeVO getNoticeInfo(int num) {
			//조회수증가
			noticeDAO.viewcountadd(num);
			return noticeDAO.getNoticeInfo(num);
		}
		
		//글 삭제 
		public void delNotice(int num) {
			noticeDAO.delNotice(num);
		}
		
		//글 수정 취소 시
		public void modiFyCancle(NoticeVO noticeVO, HttpServletRequest request, HttpServletResponse response) {
			//수정 취소 결과 값 0: 실패 / 1: 성공
			int modiFyCancleResult = 0;
			//카테고리 값 얻기 
			String category = noticeVO.getCommunityname();
			//폴더 명 얻기
			String folderNum = Integer.toString(noticeVO.getNum());
			// 컨텐트 내용 저장후 정규식을 이용하여 src 경로만 추출
			String content = noticeVO.getContent();
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
				System.out.println("정규식 추출" +i+ matcher.group(1));
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
			if(imgexists == 1) {
				common.imguploadModifyServer(request, response, realimglist, category, folderNum);
			} else { //이미지 없을 시
				System.out.println("이미지없다 ");
				//수정 된 글 이미지 없을 시 서버 디렉토리 삭제 해줌
				common.DirDelete(request, response, category, folderNum);
				
			}
		}
		
		//게시글 수정 등록
		public HashMap<String, Object> Modify(NoticeVO noticeVO, HttpServletRequest request, HttpServletResponse response) {
					//수정 등록 결과값
					int modifyResult = 0;
					//카테고리 값 얻기 
					String category = noticeVO.getCommunityname();
					//폴더 명 얻기
					String folderNum = Integer.toString(noticeVO.getNum());
					
					
					
					
					// 컨텐트 내용 저장후 정규식을 이용하여 src 경로만 추출
					String content = noticeVO.getContent();
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
					if(noticeDAO.Modify(noticeVO) == 1) {
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
		
}
