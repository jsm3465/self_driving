package com.mycompany.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletResponse;

import org.eclipse.paho.client.mqttv3.MqttException;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.mycompany.project.network.MyMqttClient;
import com.mycompany.project.service.BlackBoxService;

@Controller
public class BlackBoxController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(BlackBoxController.class);
	
	@Autowired
	private MyMqttClient mqttSubscribe;
	
	@Autowired
	private BlackBoxService blackBoxService;
	
	@PostConstruct
	public void init() throws MqttException {
		mqttSubscribe.subscribe();
	}
	
	@RequestMapping("/getImages.do")
	public void getImages(String rname, HttpServletResponse response) throws IOException {
		LOGGER.info("실행");
		//LOGGER.info(rname);
		List<String> list = blackBoxService.getImages(rname);

		//BlackBox객체의 리스트 JSON으로 변환 및 response 하기
		response.setContentType("application/json; charset=UTF-8");
		
		JSONObject jsonObject = new JSONObject();
		
		JSONArray jsonArray = new JSONArray();
		for(int i=0; i< list.size();i++) {
			JSONObject temp = new JSONObject();
			temp.put("img", list.get(i));
			jsonArray.put(temp);
		}
		
		String limit = Integer.toString(list.size());
		jsonObject.put("item", jsonArray);
		jsonObject.put("limit", limit);
		String json = jsonObject.toString();
		PrintWriter pw = response.getWriter();
		pw.write(json);
		pw.flush();
		pw.close();
	}
}
