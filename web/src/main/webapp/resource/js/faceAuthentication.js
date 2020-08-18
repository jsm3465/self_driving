$(function() {

	var video = $('#video');

	// Get access to the camera!
	if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
		navigator.mediaDevices.getUserMedia({
			video : true
		}).then(function(stream) {
			// video.src = window.URL.createObjectURL(stream);
			console.log(stream);
			
			video[0].srcObject = stream;
			video[0].play();

		});
	}
	
	// mqtt subscriber, publisher 생성
	client = new Paho.MQTT.Client("192.168.3.242", 61614, new Date().getTime
			.toString());
	client.onMessageArrived = onMessageArrived;
	client.connect({
		onSuccess : onConnect
	});

	// login 변수 갱신
/*
	 로그인한 정보와 얼굴 인식 정보 불일치
	 alert후 main.jsp로 redirect
	 if (login) {
	 alert("인증에 실패 했습니다.");
	 $("#next").attr("action", "redirectToMain.do");
	 document.nextPage.submit();
	 } else {
	 alert("인증에 성공 했습니다.");
	 $("#next").attr("action", "../rover/roverList.do");
	 document.nextPage.submit();
	 }
	 */
});

function onConnect() {
	console.log("mqtt broker connected");
	client.subscribe("/camerapub/faceID");
}
function onMessageArrived(message){
	console.log(message.payloadString);
	if(message.destinationName == "/camerapub/faceID"){
		console.log(message.payloadString);
						
	}
}