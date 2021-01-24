package com.scuba.member;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.HashMap;

import javax.mail.internet.MimeMessage;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

@Repository
public class MemberDAO {
	
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private JavaMailSender mailSender;
	
	//파일업로드
	public String FileUpload(MultipartFile file,String url) throws Exception {
		Date date_now = new Date(System.currentTimeMillis());
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
		String filename = format.format(date_now)+"_"+file.getOriginalFilename();
		File saveFile =new File(url,filename);
		if(!new File(url).exists()) new File(url).mkdirs();
		file.transferTo(saveFile);
		return filename;
	}
	//메일 보내기
		public void sendMail(String email , String title , String content) throws Exception{
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
			messageHelper.setFrom("scuba");
			messageHelper.setTo(email);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			mailSender.send(message);
		}
	//회원가입
	public void joinMember(MemberVO memberVO) {
		sqlSession.insert("mapper.member.joinMember",memberVO);
	}
	//아이디 확인
	public int idCheck(String id) {
		return sqlSession.selectOne("mapper.member.idCheck",id);
	}
	//비밀번호 가져오기
	public String getPwd(String id) {
		return sqlSession.selectOne("mapper.member.getPwd",id);
	}
	//닉네임 확인
	public int nicknameCheck(String nickname) {
		return sqlSession.selectOne("mapper.member.nicknameCheck",nickname);
	}
	//이메일 체크
	public int emailCheck(String email) {
		return sqlSession.selectOne("mapper.member.emailCheck",email);
	}
	//아이디 찾기
	public String findId(String email) {
		return sqlSession.selectOne("mapper.member.findId",email);
	}
	//이메일 확인하기
	public String findEmail(String id) {
		return sqlSession.selectOne("mapper.member.findEmail",id);
	}
	//비밀번호 찾기 변경
	public void findPwdChage(MemberVO memberVO) {
		sqlSession.selectOne("mapper.member.findPwdChage",memberVO);
	}
	//유저 정보 가져오기
	public MemberVO getuserinfo(String id) {
		return sqlSession.selectOne("mapper.member.getuserinfo",id);
	}
	//회원정보 수정시 닉네임 체크
	public int userUpdatenicknameCheck(HashMap<String,Object> map) {
		return sqlSession.selectOne("mapper.member.userUpdatenicknameCheck",map);
	}
	//회원 정보 수정
	public int memberChange(HashMap<String,Object> map) {
		return sqlSession.update("mapper.member.memberChange",map);
	}
}
