package com.scuba.member;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
@Controller
@RequestMapping("/member/*")
public class MemberController {

	@Autowired
	MemberService memberService;
	
	private ModelAndView modelAndView = new ModelAndView();
//	로그인페이지 이동
	@RequestMapping(value = "login")
	public ModelAndView login() {
		modelAndView.setViewName("member/Login");
		modelAndView.addObject("msg","");
		return modelAndView;
	}
//	비밀번호찾기 이동
	@RequestMapping(value = "findUser")
	public ModelAndView findUser() {
		modelAndView.setViewName("member/FindUser");
		return modelAndView;
	}
//	회원가입 이동
	@RequestMapping(value = "signUp")
	public ModelAndView signUp() {
		modelAndView.setViewName("member/SignUp");
		return modelAndView; 
	} 
//회원가입
	@RequestMapping(value = "userjoin" , method = RequestMethod.POST)
	public ModelAndView userjoin(MemberVO memberVO,
								HttpServletRequest request) throws Exception {
		memberService.joinMember(memberVO);
		request.getSession().setAttribute("user_id",memberVO.getId());
		request.getSession().setAttribute("user_nickname", memberVO.getNickname());
		modelAndView.setViewName("redirect:/index/main");
		return modelAndView;
	}
//로그인
	@RequestMapping(value = "userLogin" , method = RequestMethod.POST)
	public ModelAndView userLogin(MemberVO memberVO
								,HttpServletRequest request) throws Exception {
		HashMap<String,Object> map = memberService.memberlogin(memberVO, request);
		modelAndView.addObject("msg",map.get("msg"));
		modelAndView.setViewName((String)map.get("nextPage"));
		return modelAndView;
	}
//아이디 중복확인
	@ResponseBody
	@RequestMapping(value = "idCheck" , method = RequestMethod.POST)
	public int idCheck(String id) throws Exception{
		return memberService.idCheck(id) ;
	}
//닉네임 체크
	@ResponseBody
	@RequestMapping(value = "nicknameCheck" , method = RequestMethod.POST)
	public int nicknameCheck(String nickname) throws Exception{
		return memberService.nicknameCheck(nickname) ;
	}
//이메일 체크
	@ResponseBody
	@RequestMapping(value = "emailCheck" , method = RequestMethod.POST)
	public int emailCheck(String email) throws Exception{
		return memberService.emailCheck(email) ;
	}
//이메일 인증
	@ResponseBody
	@RequestMapping(value = "emailSend", method = RequestMethod.POST)
	public int emailSend(String email) throws Exception {
		return memberService.sendemail(email);
	}
//아이디 찾기
	@ResponseBody
	@RequestMapping(value = "findId", method = RequestMethod.POST)
	public String findId(String email) throws Exception {
		return memberService.findId(email);
	}
//비밀번호 찾기
	@ResponseBody
	@RequestMapping(value = "sendEmailPwd", method = RequestMethod.POST)
	public String sendEmailPwd(String id , String email) throws Exception {
		return memberService.sendEmailPwd(id, email);
	}
//비밀번호 찾기 메일보내기
	@ResponseBody
	@RequestMapping(value = "sendEmailPwd2", method = RequestMethod.POST)
	public int sendEmailPwd2(String id , String email) throws Exception {
		return memberService.sendEmailPwd2(id, email);
	}
//비밀번호 변경 이동
	@RequestMapping(value = "PwdChange" , method = RequestMethod.POST)
	public ModelAndView PwdChange(String id){
		modelAndView.addObject("id",id);
		modelAndView.setViewName("member/PwdChange");
		return modelAndView;
	}
//비밀번호 변경
	@RequestMapping(value = "findPwdChage" , method = RequestMethod.POST)
	public ModelAndView findPwdChage(MemberVO memberVO,
									HttpServletRequest request) throws Exception{
		memberService.findPwdChage(memberVO);
		request.getSession().setAttribute("id",memberVO.getId());
		modelAndView.setViewName("redirect:/index/main");
		return modelAndView;
	}
	//회원정보 페이지 이동
	@RequestMapping(value = "MoveuserUpdate")
	public ModelAndView MoveuserUpdate(HttpServletRequest request) {
		modelAndView.addObject("userinfo",memberService.getuserinfo((String)request.getSession().getAttribute("user_id")));
		modelAndView.setViewName("member/UserUpdate");
		return modelAndView;
		}
	//로그아웃
	@RequestMapping(value = "logout")
	public ModelAndView logout(HttpServletRequest request) {
		request.getSession().removeAttribute("user_id");
		request.getSession().removeAttribute("user_nickname");
		modelAndView.setViewName("redirect:/index/main");
		return modelAndView;
	}
	//회원정보 수정
	@RequestMapping(value = "memberChange" , method = RequestMethod.POST)
	public ModelAndView memberChange(MultipartHttpServletRequest multipartHttpServletRequest,
									HttpSession session) throws Exception{
		memberService.memberChange(multipartHttpServletRequest , session);
		modelAndView.setViewName("redirect:/index/main");
		return modelAndView;
	}
	//비밀번호 확인
	@ResponseBody
	@RequestMapping(value = "pwdcheck" , method = RequestMethod.POST)
	public int pwdcheck(MemberVO memberVO) throws Exception {
		return memberService.pwdcheck(memberVO);
	}
	//유저 정보 수정시 닉네임 체크
	@ResponseBody
	@RequestMapping(value = "userUpdatenicknameCheck" , method = RequestMethod.POST)
	public int userUpdatenicknameCheck(String nickname,String id) {
		return memberService.userUpdatenicknameCheck(nickname, id);
	}
}
