function playBlackBox(i) {
	var rname = $("#roverNameDiv").text();
	$.ajax({
		// 비동기 요청 경로
		url : "http://192.168.3.242:8080/project/getImages.do",
		data : {
			rname : rname
		},
		// Callback
		success : function(data, testStatus, jqXHR) {
			console.log(i);
			$("#blackBoxImage").attr("src","data:image/jpg;base64," + data.item[i].img);
			if (i < Number(data.limit)) {
				playBlackBox(i+1);
			}
		}
	});
};