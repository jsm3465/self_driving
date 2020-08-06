package com.mycompany.project.controller;

import javax.annotation.PostConstruct;

import org.eclipse.paho.client.mqttv3.MqttException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.mycompany.project.network.MyMqttClient;

@Controller
public class BlackBoxController {
	
	@Autowired
	private MyMqttClient mqttSubscribe;
	
	@PostConstruct
	public void init() throws MqttException {
		mqttSubscribe.subscribe();
	}
}
