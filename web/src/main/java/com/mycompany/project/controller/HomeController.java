package com.mycompany.project.controller;

import javax.annotation.PostConstruct;

import org.eclipse.paho.client.mqttv3.MqttException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.project.network.MyMqttClient;

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

	@GetMapping("/no22.do")
	public String no22() {
		LOGGER.info("실행");
		return "home/no22";
	}

<<<<<<< HEAD
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
=======
	@RequestMapping("/carInfo.do")
	public String carInfo() {
		LOGGER.info("실행");
		return "home/carInfo";
	}
	
	
>>>>>>> ec314a797cab064d7ac51425972f0a89c6c184da
}
