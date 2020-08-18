var roverName = $("#rname").val();
$(function() {
	client = new Paho.MQTT.Client("192.168.3.223", 61614,
			new Date().getTime.toString());
	client.onMessageArrived = onMessageArrived;
	client.connect({
		onSuccess : onConnect
	});
	
});

function onConnect() {
	console.log("mqtt broker connected");

	client.subscribe("/#");

}

function onMessageArrived(message) {
	if (message.destinationName == "/camerapub" + roverName) {
		var cameraView = $("#cameraView").attr("src",
				"data:image/jpg;base64, " + message.payloadString);
	}
	else if (message.destinationName == "/sensor" + roverName) {
		var sensor = JSON.parse(message.payloadString);
		var battery = sensor["battery"];
		console.log(battery);
	}
	
}
