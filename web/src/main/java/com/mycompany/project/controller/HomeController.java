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
	
	@RequestMapping("/redirectToMain.do")
	public String redirectToMain() {
		LOGGER.info("실행");
		return "redirect:main.do";
	}
	
	@RequestMapping("/drivingMode.do")
	public String drivingMode() {
		LOGGER.info("실행");
		return "home/drivingMode";
	}
	
	@RequestMapping("/manualDriving.do")
	public String manualDriving() {	
		LOGGER.info("실행");
		return "home/manualDriving";
	}
	
	@RequestMapping("/carInfo.do")
	public String carInfo() {
		LOGGER.info("실행");
		return "home/carInfo";
	}
}













