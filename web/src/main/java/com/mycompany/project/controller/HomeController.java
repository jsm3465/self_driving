package com.mycompany.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/home")
public class HomeController {
	private static final Logger LOGGER = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping("/main.do")
	public String main() {
		LOGGER.info("실행");
		return "home/main";
	}
	
	@RequestMapping("/cameraTest.do")
	public String cameraTest() {
		LOGGER.info("실행");
		return "home/cameraTest";
	}
	
	@RequestMapping("/control_center.do")
	public String control_center() {
		LOGGER.info("실행");
		return "home/control_center";
	}
	
	@RequestMapping("/signup.do")
	public String signup() {
		LOGGER.info("실행");
		return "redirect:/home/main.do";
	}
	
	@RequestMapping("/main2.do")
	public String main2() {
		LOGGER.info("실행");
		return "home/main2";
	}
	
	@RequestMapping("/move.do")
	public String move() {
		LOGGER.info("실행");
		return "home/move";
	}
}













