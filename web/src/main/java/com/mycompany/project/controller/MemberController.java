package com.mycompany.project.controller;

import java.io.PrintWriter;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mycompany.project.common.Key;
import com.mycompany.project.model.Member;
import com.mycompany.project.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static final Logger LOGGER = LoggerFactory.getLogger(MemberController.class);
		
		@Autowired
		private MemberService memberService;
		@Autowired
		private JavaMailSender sender;
		
		@RequestMapping("/main.do")
		public String main() {
			LOGGER.info("실행");
			return "home/main";
		}
	
		@RequestMapping("/signupForm.do")
		public String signupForm() {
			LOGGER.info("실행");
			return "member/signUp";
		}
		
		@RequestMapping("/signinForm.do")
		public String signinForm() {
			LOGGER.info("실행");
			return "member/signIn";
		}
		
		@RequestMapping("/signin.do")
		public String signin(Member member, HttpSession session) {
			LOGGER.info("실행");
			int result = memberService.signin(member);
			String view = "member/signIn";
			if(result == MemberService.LOGIN_SUCCESS) {
				member.setMstate(1);
				memberService.updateStateByMid(member);
				session.setAttribute("sessionMid", member.getMid());
				view = "redirect:/home/main.do";
			} else if(result == MemberService.LOGIN_FAIL_MID) {
			} else if(result == MemberService.LOGIN_FAIL_MPASSWORD) {
			}
			return view;
		}
		
		@RequestMapping("/signup.do")
		public String signup(Member member, String mbirthM, String mbirthD) {
			member.setMbirth(member.getMbirth()+mbirthM+mbirthD);
			memberService.signup(member);
			return "redirect:/home/main.do";
		}
		
		@RequestMapping("signout.do")
		public String logout(Member member, HttpSession session) {
			member.setMid(String.valueOf(session.getAttribute("sessionMid")));
			member.setMstate(0);
			LOGGER.info(member.getMid());
			memberService.updateStateByMid(member);
			session.invalidate();
			return "redirect:/home/main.do";
		}
	
		@RequestMapping("findIdForm.do")
		public String findIdForm() {
			LOGGER.info("실행");
			return "member/findId";
		}
		
		@RequestMapping("findId.do")
		public String findId(Member member, Model model) {
			LOGGER.info("실행");
			String mid = memberService.findId(member);
			if(mid == null) {
				return "member/findId";
			} else {
				model.addAttribute("message", mid);
			}
			
			return "/member/confirmId";
		}
		
		@RequestMapping("findPasswordForm.do")
		public String findPasswordForm() {
			LOGGER.info("실행");
			return "member/findPassword";
		}
		
		@RequestMapping("findPassword.do")
		public String findPassword(Member member, Model model) {
			LOGGER.info("실행");
			String password = memberService.findPassword(member);
			if(password == null) {
				return "member/findId";
			} else {
				model.addAttribute("message", password);
			}
			
			return "/member/confirmPassword";
		}
		
		@RequestMapping("/faceAuthenticationForm.do")
		public String faceAuthentication() {
			LOGGER.info("실행");
			return "member/faceAuthentication";
		}
		
		@RequestMapping("/faceResistForm.do")
		public String faceResist() {
			LOGGER.info("실행");
			return "member/faceResist";
		}
		
		@RequestMapping("/confirmId.do")
		public String confirmId() {
			LOGGER.info("실행");
			return "member/confirmId";
		}
		
		@RequestMapping("/confirmPassword.do")
		public String confirmPassword() {
			LOGGER.info("실행");
			return "member/confirmPassword";
		}
		
		@PostMapping("/emailCheck.do")
		@ResponseBody
		public void emailCheckSend(@RequestParam String memail, HttpServletResponse response, HttpSession session) {
			// 메일 보내기
			if (memail != null) {
				Member member = memberService.selectByMemail(memail);
				if(member == null) {
					LOGGER.info(memail);
					String setfrom = "wjscksgurzz1@gmail.com";
					String key = new Key().getKey(10, false);
					
					String tomail = memail; //받는 사람
					String title = "회원 가입 인증 메일입니다.";
					String content = new StringBuffer().append("인증번호를 입력해주세요 인증번호는 : ").append(key).append("입니다").toString();
					
					try {
						response.setContentType("UTF-8");
						
						PrintWriter writer = response.getWriter();
						
						/*writer.print(key);*/
						MimeMessage message = sender.createMimeMessage();
						MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
						// 보내는 사람 생략하면 작동 x, 두번째 값은 보낼 때의 이름.
						messageHelper.setFrom(setfrom, "authentication number");
						// 받는 사람
						messageHelper.setTo(tomail);
						// 메일제목 생략 가능
						messageHelper.setSubject(title);
						messageHelper.setText(content);
						
						sender.send(message);
						response.setContentType("text/html; charset=UTF-8");
						PrintWriter out_email = response.getWriter();
						out_email.println("alert('Please check the authentication number in the email.'); ");
						out_email.flush();
						session.setAttribute("mkey", key);
						session.setAttribute("memail", memail);
					
					} catch(Exception e){
						LOGGER.info(e.toString());
					}
				} else {
					PrintWriter out_email;
					try {
						out_email = response.getWriter();
						out_email.println("alert('Email already registered.');");
						out_email.flush();
					} catch (Exception e){
						e.printStackTrace();
					}
				}
			}
		}
		
		@PostMapping("emailKey.do")
		public void emailKey(Model model, String mkey, HttpServletResponse response, HttpSession session) {
			LOGGER.info("실행");
			LOGGER.info("mkey:{}", session.getAttribute("mkey"));
			if(mkey!=null) {
				if(mkey.equals(session.getAttribute("mkey"))) {
					PrintWriter out_email;
					try {
						session.setAttribute("check", "agree");
						out_email = response.getWriter();
						out_email.println(
								"alert('success');");
						out_email.flush();
					} catch(Exception e) {
						try {
							out_email = response.getWriter();
							out_email.println("alert('The values are different. Please re-enter.');");
							out_email.flush();
						}catch(Exception e1) {
							e1.printStackTrace();
						}
						e.printStackTrace();
					}
				}
			} else {
				try {
					PrintWriter out_email = response.getWriter();
					out_email = response.getWriter();
					out_email.println("alert('insert again');");
					out_email.flush();
				}catch(Exception e) {
					e.printStackTrace();
				}
			}
		}
	
}
