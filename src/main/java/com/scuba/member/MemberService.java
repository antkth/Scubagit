package com.scuba.member;

import java.io.File;
import java.util.Base64;
import java.util.HashMap;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Service
public class MemberService {

	@Autowired
	private MemberDAO memberDAO;

	//회원가입
	public void joinMember(MemberVO memberVO) throws Exception{
		memberVO.setPwd(pwdchange(memberVO.getPwd()));
		memberDAO.joinMember(memberVO);
	}
	//로그인
	public HashMap<String,Object> memberlogin(MemberVO memberVO,HttpServletRequest request) throws Exception {
		String msg ="";
		String nextPage ="";
		if(1 == memberDAO.idCheck(memberVO.getId())) {
			if(pwdchange(memberVO.getPwd()).equals(memberDAO.getPwd(memberVO.getId()))) {
				memberVO = memberDAO.getuserinfo(memberVO.getId());
				if(memberVO.getStatus()==1) {
					msg = "정지된 이용자 입니다 . 고객센터에 문의해 주세요";
					nextPage = "member/Login";
				}else {
					request.getSession().setAttribute("user_id",memberVO.getId());
					request.getSession().setAttribute("user_nickname",memberVO.getNickname());
					nextPage = "redirect:/index/main";
				}
			}else {
				msg = "비밀번호가 틀렸습니다 .";
				nextPage = "member/Login";
			}
		}else {
			msg ="아이디가 틀렸습니다 .";
			nextPage = "member/Login";
		}
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("msg",msg);
		map.put("nextPage",nextPage);
		return map;
	}
	//아이디 체크
	public int idCheck(String id) {
		int idCheck=0;
		if(1==memberDAO.idCheck(id)) {
			idCheck = 1; // 이미 존재하는 아이디
		}else {
			idCheck = 2; // 없는 아이디 
		}
		return idCheck;
	}
	//닉네임 확인
	public int nicknameCheck(String nickname) {
		int nicknameCheck=0;
		if(1==memberDAO.nicknameCheck(nickname)) {
			nicknameCheck = 1; // 이미 존재하는 닉네임
		}else {
			nicknameCheck = 2; // 없는 닉네임
		}
		return nicknameCheck;
	}
	//이메일 체크
	public int emailCheck(String email) {
		int emailCheck=0;
		if(1==memberDAO.emailCheck(email)) {
			emailCheck = 1; // 이미 존재하는 이메일
		}else {
			emailCheck = 2; // 없는 이메일
		}
		return emailCheck;
	}
	//인증이메일 보내기
	public int sendemail(String email) throws Exception{
		//인증번호 생성
		int random = (int)(Math.random()*1000000);
		if(random<100000) random += 100000;
		String title = "이메일 인증 메일입니다 . ";
		String content = "인증 번호는 "+ random + " 입니다.";
		memberDAO.sendMail(email, title, content);
		return random;
	}
	//비밀번호 찾기
	public String sendEmailPwd(String id , String email) throws Exception {
		String pwdCheck="";
		if(memberDAO.idCheck(id)==0) {
			pwdCheck = "noneId"; //회원 없음
		}else if(!memberDAO.findEmail(id).equals(email)){
			pwdCheck = "noneEmail"; // 이메일 없음
		}
		return pwdCheck;
	}
	//비밀번호 찾기 인증메일 보내기
	public int sendEmailPwd2(String id , String email) throws Exception {
		int CheckNum=0;
		//인증번호 생성
		int random = (int)(Math.random()*1000000);
		if(random<100000) random += 100000;
			String title = "비밀번호 찾기 이메일 입니다 .";
			String content = id + " 님의 인증 번호는 "+ random +"입니다."; 
			CheckNum = random;
			memberDAO.sendMail(email, title, content);
		return CheckNum;
	}
	//아이디 찾기
	public String findId(String email) {
		String callId="";
		if(memberDAO.emailCheck(email)==0) {
			callId = "none"; //회원 없음
		}else {
			callId = memberDAO.findId(email);
		}
		return callId;
	}
	//비밀번호 찾기 변경
	public void findPwdChage(MemberVO memberVO) {
		memberDAO.findPwdChage(memberVO);
	}
	//유저 정보 가져오기
	public MemberVO getuserinfo(String id) {
		return memberDAO.getuserinfo(id);
	}
	//비밀번호 확인
	public int pwdcheck(MemberVO memberVO) throws Exception{
		int check = 0 ;
		String pwd = memberDAO.getPwd(memberVO.getId());
		if(!pwd.equals(pwdchange(memberVO.getPwd()))){
			check = 1;
		}return check;
	}
	//유저 정보 수정시 닉네임 체크
	public int userUpdatenicknameCheck(String nickname , String id) {
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("nickname",nickname);
		map.put("id",id);
		return memberDAO.userUpdatenicknameCheck(map);
	}
	//회원정보 수정
	public void memberChange (MultipartHttpServletRequest multipartHttpServletRequest , HttpSession session) throws Exception{
		String id = multipartHttpServletRequest.getParameter("id");
		String nickname = multipartHttpServletRequest.getParameter("nickname");
		String image = "basic.png";
		if(multipartHttpServletRequest.getFile("image").getOriginalFilename()!="") {
		MultipartFile file = multipartHttpServletRequest.getFile("image");
		String url = session.getServletContext().getRealPath("/resources/upload/member/");
		image = memberDAO.FileUpload(file, url);
		String beforimage = multipartHttpServletRequest.getParameter("beforimage");
		if(!beforimage.equals("basic.png")) {
			//이전 이미지 삭제
			File delfile = new File(url + beforimage);
			delfile.delete();
		}
		}
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("nickname",nickname);
		map.put("image",image);
		memberDAO.memberChange(map);
	}
	//비밀번호 보안 SHA-256방식
    private String pwdchange(String plainText) throws Exception {
    	String Alg = "AES/CBC/PKCS5Padding";
    	String PK = "012123453456731234890123451234012";
    	String IV = PK.substring(0,16);
        Cipher cipher = Cipher.getInstance(Alg);
        SecretKeySpec keySpec = new SecretKeySpec(IV.getBytes(), "AES");
        IvParameterSpec ivParamSpec = new IvParameterSpec(IV.getBytes());
        cipher.init(Cipher.ENCRYPT_MODE, keySpec, ivParamSpec);
        
        byte[] encrypted = cipher.doFinal(plainText.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(encrypted);
    }
    
}
