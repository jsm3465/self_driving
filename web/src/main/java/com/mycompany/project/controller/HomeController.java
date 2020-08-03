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
	
	@GetMapping("/no10.do")
	public String no10() {
		LOGGER.info("실행");
		return "home/no10";
	}
	
	@GetMapping("/no14.do")
	public String no14() {
		LOGGER.info("실행");
		return "home/no14";
	}
	
	@GetMapping("/no15.do")
	public String no15() {
		LOGGER.info("실행");
		return "home/no15";
	}
	
	@GetMapping("/no18.do")
	public String no18() {
		LOGGER.info("실행");
		return "home/no18";
	}
	
	@GetMapping("/no22.do")
	public String no22() {
		LOGGER.info("실행");
		return "home/no22";
	}
	
}