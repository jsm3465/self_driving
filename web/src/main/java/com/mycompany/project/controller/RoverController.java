package com.mycompany.project.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.project.model.Rover;
import com.mycompany.project.service.RoverService;

@Controller
@RequestMapping("/rover")
public class RoverController {

	private static final Logger LOGGER = LoggerFactory.getLogger(RoverController.class);

	@Autowired
	private RoverService roverService;

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

	@RequestMapping("/roverList.do")
	public String roverList(Model model) {
		LOGGER.info("실행");

		// 다음 화면에 출력할 등록된 로버들의 목록 가져오기
		List<Rover> list = roverService.getRoverList();

		// model 객체를 이용해서 request범위에 list객체 저장 후 jsp에서 사용한다.
		model.addAttribute("roverList", list);
		
		return "rover/roverList";
	}
	
	@RequestMapping("/resisterRover.do")
	public String resisterRover() {
		LOGGER.info("실행");
		return "rover/resisterRover";
	}

}
