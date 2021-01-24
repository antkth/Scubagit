package com.scuba.event;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.scuba.common.Common;
import com.scuba.friendsboard.FriendsBoardVO;
import com.scuba.underwaterboard.UnderwaterboardVO;

@Service
public class EventService {
	@Autowired
	private EventDAO eventDAO;
	Common common = new Common();
	
	// 이벤트 게시판 글 작성
		public HashMap<String, Object> WriteInsert(EventVO eventVO,MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IOException {

			String nickname = (String) request.getSession().getAttribute("user_nickname");
			eventVO.setNickname(nickname);
			String userId = (String) request.getSession().getAttribute("user_id");
			// 이미지 사용 여부
			int imgexists = 0;
			String category = (String) request.getSession().getAttribute("category");
			
			
			// 이미지 이름 얻어오기(실제이름)
			String fileOriginalName = file.getOriginalFilename();
			// 파일 확장자 얻기
			String ext = fileOriginalName.substring(fileOriginalName.lastIndexOf("."));
			// 이미지 이름 UUID사용 후 수정
			UUID uuid = UUID.randomUUID();
			// 업로드 될 파일 이름 UUID.확장자
			String fileSaveName = uuid.toString() + ext;
			// 이미지 파일이름 VO 설정
			eventVO.setThumbnail(fileSaveName);
			String thumbNail = eventVO.getThumbnail();
			
			
			// **********************커뮤니티이름 설정 (추 후 이 형태로 다 바꿔야함)*****************************
			eventVO.setCommunityname(category);
			// 컨텐트 내용 저장후 정규식을 이용하여 src 경로만 추출
			String content = eventVO.getContent();
			// src경로 추출 정규식 ********src태그만 뽑아오는
			// 정규식<src=[\\\\\\\"']?([^>\\\\\\\"']+)[\\\\\\\"']?[^>]*>*******
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
				// 이미지 유무 확인
				imgexists = 1;
			}
			// 글 등록 결과 값
			HashMap<String, Object> resultmap = new HashMap<String, Object>();
			// DB 인설트 구문 성공시 1 반환 글 작성 완료시 진행
			if (eventDAO.write(eventVO) == 1) {
				// 최근게시글 번호 값 가져오기 새로생길 저장 폴더 이름(추가될 게시글 번호) 용도
				String folderNum = Integer.toString(eventDAO.getMaxNum());
				common.ThumbnailUpload(file, thumbNail, folderNum, category, request, response);
				// 이미지가 있을 때
				if (imgexists == 1) {
					// 글 등록 성공시 임시폴더 파일 서버폴더로 이동 후 임시폴더 삭제 *서버폴더는 카테고리/글번호로 한다
					System.out.println("폴더 넘 : " + folderNum);
					int result = common.imguploadServer(request, response, realimglist, category, folderNum);
					// 이미지 이동 성공 시 (임시 -> 서버) src 경로 변경
					if (result == 1) {
						// 이미지 경로 변경
						String beforeContent = eventVO.getContent();
						System.out.println("beforeContent : " + beforeContent);
						String changePath = beforeContent.replace("Temporary", category);
						System.out.println("changePath : " + changePath);
						String afterContent = changePath.replace(userId, folderNum);
						System.out.println("에프터 컨텐  11111: " + afterContent);
						HashMap<String, Object> map = new HashMap<String, Object>();
						map.put("afterContent", afterContent);
						map.put("contentNum", folderNum);
						// 이미지 경로 수정
						if (eventDAO.contentChange(map) == 1) {
							System.out.println("1");
							System.out.println();
							resultmap.put("contentNum", folderNum);
							resultmap.put("writeResult", 1); // content 내용 path변경 성공
						} else {
							// 글삭제 쿼리 넣어줘야함
							/* 글 삭제 쿼리 */
							System.out.println("2");
							resultmap.put("writeResult", 0); // 글 등록 실패
						}
					} else {
						// 글삭제 쿼리 넣어줘야함
						/* 글 삭제 쿼리 */
						System.out.println("3");
						resultmap.put("writeResult", 0);
					}
				} else {// 이미지 없을때
					resultmap.put("contentNum", folderNum);
					resultmap.put("writeResult", 2); // 이미지 없는글 인서트 성공
				}
			} else {
				System.out.println("4");
				resultmap.put("writeResult", 0); // 글 등록 실패
			}
			return resultmap;
		}
		
		// 이벤트 게시판 모든(글) 리스트 조회
		public Map<String, Object> allBoardList(HttpServletRequest request, int nowpage) {
			
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			//페이징 관련
			map = common.paging(nowpage, eventDAO.getTotal(), 9, 5);
			//동료게시판 전체 리스트
			map.put("eventList", eventDAO.allBoardList(map));
			return map;
		}
		
		// 글 상세보기
		public EventVO viewList(int contentNum) {
			return eventDAO.viewList(contentNum);
		}
		
		//게시글 삭제 시 닉네임 일치여부 체크
		public String idCheck(int contentNum) {
			return eventDAO.idCheck(contentNum);
		}
		
		//게시글 삭제
		public int condelete(int contentNum) {
			return eventDAO.condelete(contentNum);
		}
		
		//게시글 수정 페이지 이동(수정 글 정보 select)
		public EventVO ModifyList(int contentNum) {
			return eventDAO.ModifyList(contentNum);
		}
		//글 수정 취소 시
		public void modiFyCancle(EventVO eventVO, HttpServletRequest request, HttpServletResponse response) {
			//수정 취소 결과 값 0: 실패 / 1: 성공
//			int modiFyCancleResult = 0;
			//카테고리 값 얻기 
			String category = eventVO.getCommunityname();
			//폴더 명 얻기
			String folderNum = Integer.toString(eventVO.getNum());
			// 컨텐트 내용 저장후 정규식을 이용하여 src 경로만 추출
			String content = eventVO.getContent();
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
		
		// 글 수정 등록
		public HashMap<String, Object> Modify(EventVO eventVO, MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws IllegalStateException, IOException {
			//수정 등록 결과값
			int modifyResult = 0;
			//카테고리 값 얻기 
			String category = eventVO.getCommunityname();
			//폴더 명 얻기
			String folderNum = Integer.toString(eventVO.getNum());
			String thumbNail = "baseImage.jpg";
			// 썸네일 이미지 이름 설정
			// 썸네일을 변경하지 않았을 때 (수정 시) 기존 이름 그대로 사용
			System.out.println("썸네일 임지 2 : " + eventVO.getThumbnail());
			if(eventVO.getThumbnail() == "" || eventVO.getThumbnail() == null) {
				if (file.getSize() > 0) {
					System.out.println("여기를 탄다고 ? ");
					// 이미지 이름 얻어오기(실제이름)
					String fileOriginalName = file.getOriginalFilename();
					// 파일 확장자 얻기
					String ext = fileOriginalName.substring(fileOriginalName.lastIndexOf("."));
					// 이미지 이름 UUID사용 후 수정
					UUID uuid = UUID.randomUUID();
					// 업로드 될 파일 이름 UUID.확장자
					String fileSaveName = uuid.toString() + ext;
					// 이미지 파일이름 VO 설정
					eventVO.setThumbnail(fileSaveName);
					thumbNail = eventVO.getThumbnail();
					System.out.println("썸네일 " + thumbNail);
				} else { //이미지 없을 시 baseImage로 설정
					eventVO.setThumbnail(thumbNail);
					}
			}
		
			// 컨텐트 내용 저장후 정규식을 이용하여 src 경로만 추출
			String content = eventVO.getContent();
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
			if(eventDAO.Modify(eventVO) == 1) {
				//썸네일이미지 파일을 올렸을 때 이미지 업로드
				if(file.getSize() > 0) {
					common.ThumbnailUpload(file, thumbNail, folderNum, category, request, response);
					//글 수정 성공 시 기존 썸네일 이미지 삭제
					common.ThumbnailModify(eventVO.getThumbnail(), folderNum, file, category, request, response );
				}
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
					if(common.DirDelete(request, response, category, folderNum) == 1 || common.DirDelete(request, response, category, folderNum) == 2) {
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
