package com.mycompany.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
public class HomeController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);

	@RequestMapping("/temp.do")
	public String temp() {
		LOGGER.info("실행");
		return "home/temp";
	}
	@RequestMapping("/main.do")
	public String main() {
		LOGGER.info("실행");
		return "home/main";
	}

	@RequestMapping("/redirectToMain.do")
	public String redirectToMain() {
		LOGGER.info("실행");
		return "redirect:main.do";
	}

	@GetMapping("/cctvScreen.do")
	public String cctvScreen() {
		LOGGER.info("실행");
		return "home/cctvScreen";
	}

	@RequestMapping("/signup.do")
	public String signup() {
		LOGGER.info("실행");
		return "member/sign_up";
	}

	@RequestMapping("/faceAuthentication.do")
	public String faceAuthentication() {
		LOGGER.info("실행");
		return "home/faceAuthentication";
	}

	@RequestMapping("/faceResist.do")
	public String faceResist() {
		LOGGER.info("실행");
		return "home/faceResist";
	}
}
