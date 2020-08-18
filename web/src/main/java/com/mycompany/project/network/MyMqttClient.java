package com.mycompany.project.network;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import org.eclipse.paho.client.mqttv3.IMqttDeliveryToken;
import org.eclipse.paho.client.mqttv3.MqttCallback;
import org.eclipse.paho.client.mqttv3.MqttClient;
import org.eclipse.paho.client.mqttv3.MqttConnectOptions;
import org.eclipse.paho.client.mqttv3.MqttException;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mycompany.project.model.BlackBox;
import com.mycompany.project.service.BlackBoxService;

@Component
public class MyMqttClient {

	private static final Logger LOGGER = LoggerFactory.getLogger(MyMqttClient.class);

	private MqttClient client;
	
	private ExecutorService executorService = Executors.newFixedThreadPool(4);
	
	@Autowired
	private BlackBoxService blackBoxSerive;

	public MyMqttClient() throws MqttException {	

		// MQTT client 생성
		client = new MqttClient("tcp://192.168.3.242:1883", "subscriber");

		// 토픽 통신의 결과를 수신할 콜백 객체 세팅
		// MqttCallback은 interface
		client.setCallback(new MqttCallback() {

			@Override
			public void connectionLost(Throwable arg0) {
				LOGGER.info("MQTT broker와 연결이 끊겼습니다.");
			}

			@Override
			public void deliveryComplete(IMqttDeliveryToken arg0) {

			}

			// 메세지 수신 시 이미지 파일 저장 후 DB에 경로 저장
			@Override
			public void messageArrived(String topic, MqttMessage message) throws Exception {

				//LOGGER.info("실행");
				/*
				 * topic : camerapub/"roverName" topic을 parsing하여 rover의 이름을 알아낸다.(pk for
				 * blackbox table in DB)
				 */
				String[] topicParsingArray = topic.split("/");
				String rname = topicParsingArray[2];
				
				// 전송받은 MqttMessage 객체의 이미지 데이터 (byte[])를 String type으로 형 변환 시켜 DB에 저장
				String rimg = new String(message.getPayload());

				// DB에 저장할 BlackBox 객체 초기화
				BlackBox blackBox = new BlackBox();
				blackBox.setRname(rname);
				blackBox.setRimg(rimg);
				
				Runnable runnable = new Runnable() {
					@Override
					public void run() {
						blackBoxSerive.saveImage(blackBox);
					}
				};

				executorService.submit(runnable);
			}

		});

		// 연결 옵션 객체 생성
		MqttConnectOptions conOpt = new MqttConnectOptions();
		conOpt.setCleanSession(true);

		// MQTT 브로커에 접속하기
		client.connect(conOpt);
	}

	// 메세지 수신
	public void subscribe() throws MqttException {
		client.subscribe("/blackBox/#");
	}

	// 연결 끊기
	public void shutdown() throws MqttException {
		client.disconnect();
		client.close();
	}
}
