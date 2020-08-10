$(function() {
	client = new Paho.MQTT.Client(location.hostname, 61614, new Date().getTime
			.toString());
	client.onMessageArrived = onMessageArrived;
	client.connect({
		onSuccess : onConnect
	});
});

function onConnect() {
	console.log("mqtt broker connected")
	client.subscribe("/camerapub");
}

function onMessageArrived(message) {
	console.log(message)
	if (message.destinationName == "/camerapub") {
		var cameraView = $("#cameraView").attr("src",
				"data:image/jpg;base64," + message.payloadString);
	}
}