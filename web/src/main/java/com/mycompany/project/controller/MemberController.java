package com.mycompany.project.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.mycompany.project.common.Key;
import com.mycompany.project.model.Member;
import com.mycompany.project.service.MemberService;
import com.mycompany.project.validator.MemberValidator;

@Controller
@RequestMapping("/member")
public class MemberController {
	private static final Logger LOGGER = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;

	@Autowired
	private MemberValidator memberValidator;

	@Autowired
	private JavaMailSender sender;

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.addValidators(memberValidator);
	}

	@RequestMapping("/main.do")
	public String main() {
		LOGGER.info("실행");
		return "home/main";
	}

	@RequestMapping("/signinForm.do")
	public String signinForm(Member member) {
		LOGGER.info("실행");
		return "member/signIn";
	}

	@RequestMapping("/signin.do")
	public String signin(@Valid Member member, BindingResult bindingResult, HttpSession session) {
		LOGGER.info("실행");
		int result = memberService.signin(member);
		String view = "member/signIn";
		if (result == MemberService.LOGIN_SUCCESS) {
			// 로그인 성공
			member.setMstate(1);
			memberService.updateStateByMid(member);
			session.setAttribute("sessionMid", member.getMid());
			view = "member/faceAuthentication";
		} else if (result == MemberService.LOGIN_FAIL_MID) {
			// 아이디 틀림
			bindingResult.rejectValue("mid", "login.fail.mid");
			return view;
		} else if (result == MemberService.LOGIN_FAIL_MPASSWORD) {
			// 비밀번호 틀림
			bindingResult.rejectValue("mpassword", "login.fail.mpassword");
			return view;
		}

		return view;
	}

	@RequestMapping("/signupForm.do")
	public String signupForm(Member member) {
		LOGGER.info("실행");
		return "member/signUp";
	}

	@RequestMapping("/signup.do")
	public String signup(@Valid Member member, BindingResult bindingResult, String mbirthM, String mbirthD) {
		Member dbMember = memberService.selectByMid(member.getMid());
		member.setMbirth(member.getMbirth() + mbirthM + mbirthD);
		String view = "member/signUp";

		// 아이디 공백
		if (member.getMid().length() == 0 || member.getMid().trim() == null) {
			bindingResult.rejectValue("mid", "errors.mid.required");
			return view;
		} /*
			 * else if (dbMember.getMid() != null) { // 아이디 중복 체크
			 * bindingResult.rejectValue("mid", "", "이미 등록된 아이디입니다."); return view; }
			 */

		// 패스워드 공백
		else if (member.getMpassword().length() == 0 || member.getMpassword().trim() == null) {
			bindingResult.rejectValue("mpassword", "errors.mpassword.required");
			return view;
		} else if (member.getMpassword().length() < 8) {
			// 패스워드 8자이상
			bindingResult.rejectValue("mpassword", "errors.mpassword.minlength");
			return view;
		}
		// 이름 공백
		else if (member.getMname().length() == 0 || member.getMname().trim() == null) {
			bindingResult.rejectValue("mname", "errors.mname.required");
			return view;
		}
		// 생년월일
		else if (member.getMbirth().length() < 8) {
			bindingResult.rejectValue("mbirth", "", "생년월일을 다시 확인 해주세요.");
			return view;
		}
		// 이메일 중복체크
		/*
		 * else if (member.getMemail() == dbMember.getMemail()) {
		 * bindingResult.rejectValue("memail", "", "이미 등록된 이메일입니다."); return view; }
		 */else {
			memberService.signup(member);
		}
		return "member/faceResist";
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
	public String findIdForm(Member member) {
		LOGGER.info("실행");
		return "member/findId";
	}

	@RequestMapping("findId.do")
	public String findId(@Valid Member member, BindingResult bindingResult, Model model) {
		LOGGER.info("실행");
		String mid = memberService.findId(member);
		if (mid == null) {
			bindingResult.rejectValue("mname", "", "아이디와 이메일을 다시 확인해주세요.");
			return "member/findId";
		} else {
			model.addAttribute("message", mid);
		}

		return "/member/confirmId";
	}

	@PostMapping("/idemailCheck.do")
	@ResponseBody
	public void idemailCheckSend(@RequestParam String memail, HttpServletResponse response, HttpSession session) {
		// 메일 보내기
		Member member = memberService.selectByMemail(memail);
		if (member != null) {
			LOGGER.info(memail);
			String setfrom = "wjscksgurzz1@gmail.com";
			String key = new Key().getKey(10, false);

			String tomail = memail; // 받는 사람
			String title = "회원 가입 인증 메일입니다.";
			String content = new StringBuffer().append("인증번호를 입력해주세요 인증번호는 : ").append(key).append("입니다").toString();

			try {
				response.setContentType("UTF-8");

				PrintWriter writer = response.getWriter();

				/* writer.print(key); */
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

			} catch (Exception e) {
				LOGGER.info(e.toString());
			}
		} else {
			PrintWriter out_email;
			try {
				out_email = response.getWriter();
				out_email.println("alert('There is no registered email.');");
				out_email.flush();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@RequestMapping("findPasswordForm.do")
	public String findPasswordForm(Member member) {
		LOGGER.info("실행");
		return "member/findPassword";
	}

	@RequestMapping("findPassword.do")
	public String findPassword(@Valid Member member, BindingResult bindingResult ,Model model) {
		LOGGER.info("실행");
		String password = memberService.findPassword(member);
		LOGGER.info(password);
		if (password == null) {
			bindingResult.rejectValue("mid", "", "아이디와 비밀번호와 이메일을 다시 확인해주세요.");
			return "member/findPassword";
		} else {
			model.addAttribute("message", password);
		}

		return "/member/confirmPassword";
	}
	
	@PostMapping("/passemailCheck.do")
	@ResponseBody
	public void passemailCheckSend(@RequestParam String memail, HttpServletResponse response, HttpSession session) {
		// 메일 보내기
		Member member = memberService.selectByMemail(memail);
		if (member != null) {
			LOGGER.info(memail);
			String setfrom = "wjscksgurzz1@gmail.com";
			String key = new Key().getKey(10, false);

			String tomail = memail; // 받는 사람
			String title = "회원 가입 인증 메일입니다.";
			String content = new StringBuffer().append("인증번호를 입력해주세요 인증번호는 : ").append(key).append("입니다").toString();

			try {
				response.setContentType("UTF-8");

				PrintWriter writer = response.getWriter();

				/* writer.print(key); */
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

			} catch (Exception e) {
				LOGGER.info(e.toString());
			}
		} else {
			PrintWriter out_email;
			try {
				out_email = response.getWriter();
				out_email.println("alert('There is no registered email.');");
				out_email.flush();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@RequestMapping("/faceAuthenticationForm.do")
	public String faceAuthentication() {
		LOGGER.info("실행");
		return "member/faceAuthentication";
	}

	@RequestMapping("/faceResist.do")
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
			if (member == null) {
				LOGGER.info(memail);
				String setfrom = "wjscksgurzz1@gmail.com";
				String key = new Key().getKey(10, false);

				String tomail = memail; // 받는 사람
				String title = "회원 가입 인증 메일입니다.";
				String content = new StringBuffer().append("인증번호를 입력해주세요 인증번호는 : ").append(key).append("입니다")
						.toString();

				try {
					response.setContentType("UTF-8");

					PrintWriter writer = response.getWriter();

					/* writer.print(key); */
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

				} catch (Exception e) {
					LOGGER.info(e.toString());
				}
			} else {
				PrintWriter out_email;
				try {
					out_email = response.getWriter();
					out_email.println("alert('Email already registered.');");
					out_email.flush();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
	}

	@PostMapping("emailKey.do")
	public void emailKey(Model model, String mkey, HttpServletResponse response, HttpSession session) {
		LOGGER.info("실행");
		LOGGER.info("mkey:{}", session.getAttribute("mkey"));
		if (mkey != null) {
			if (mkey.equals(session.getAttribute("mkey"))) {
				PrintWriter out_email;
				try {
					String result = "success";
					response.setContentType("application/json; charset=UTF-8");
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("result", result);
					session.setAttribute("check", "agree");
					String json = jsonObject.toString();
					out_email = response.getWriter();
					out_email.write(json);
					out_email.flush();
				} catch (Exception e) {
					try {
						out_email = response.getWriter();
						out_email.println("alert('The values are different. Please re-enter.');");
						out_email.flush();
					} catch (Exception e1) {
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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	@RequestMapping("/memberInformationForm.do")
	public String memberInformation(Member member, HttpSession session, Model model) {
		LOGGER.info("실행");
		Member dbMember = memberService.selectByMid(session.getAttribute("sessionMid").toString());
		String birth_y = dbMember.getMbirth().substring(0, 4);
		String birth_m = dbMember.getMbirth().substring(4, 6);
		String birth_d = dbMember.getMbirth().substring(6, 8);
		model.addAttribute("member", dbMember);
		model.addAttribute("birth_y", birth_y);
		model.addAttribute("birth_m", birth_m);
		model.addAttribute("birth_d", birth_d);
		
		return "member/memberInformation";
	}

	@RequestMapping("/changePassword.do")
	public void changePassword(String baseMpassword, String mpasswordNew, Member member, HttpSession session, HttpServletResponse response) throws IOException {
		LOGGER.info("실행");
		member.setMpassword(baseMpassword);
		member.setMid(session.getAttribute("sessionMid").toString());
		Member memberId = memberService.selectByMid(member.getMid());
		String memberPassword = memberId.getMpassword();
		if(memberPassword.equals(member.getMpassword())) {
			member.setMpassword(mpasswordNew);
			memberService.updatePassword(member);
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out_email = response.getWriter();
			out_email.println("alert('Success'); ");
			out_email.flush();
		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out_email = response.getWriter();
			out_email.println("alert('Please check the Password');");
			out_email.flush();
		}
		
	}
	
	@RequestMapping("/memberUpdate.do")
	public String memberUpdate(@Valid Member member, BindingResult bindingResult, String mbirthM, String mbirthD) {
		LOGGER.info("실행");
		member.setMbirth(member.getMbirth() + mbirthM + mbirthD);
		// 이름 공백
		if (member.getMname().length() == 0 || member.getMname().trim() == null) {
			bindingResult.rejectValue("mname", "errors.mname.required");
			return "member/memberInformation";
		}
		// 생년월일
		else if (member.getMbirth().length() < 8) {
			bindingResult.rejectValue("mbirth", "", "생년월일을 다시 확인 해주세요.");
			return "member/memberInformation";
		}
		if(member.getMpassword()==null) {
			String mpassWord = memberService.selectByMid(member.getMid()).getMpassword();
			member.setMpassword(mpassWord);
		}
		memberService.updateMember(member);
		
		return "redirect:/home/main.do";
	}
	
	@RequestMapping("/deleteMember.do")
	public void deleteMember(Member member, String baseMpassword, HttpSession session, HttpServletResponse response) throws IOException {
		LOGGER.info("실행");
		member.setMid(session.getAttribute("sessionMid").toString());
		Member dbMember = memberService.selectByMid(member.getMid());
		member.setMpassword(baseMpassword);
		if(member.getMpassword().equals(dbMember.getMpassword())) {
			memberService.deleteMember(member.getMid());
			session.invalidate();
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out_email = response.getWriter();
			out_email.println("alert('Success'); ");
			out_email.flush();
		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out_email = response.getWriter();
			out_email.println("alert('Please check the Password');");
			out_email.flush();
		}
	}

}
