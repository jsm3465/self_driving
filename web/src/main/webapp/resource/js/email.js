function fun1() {
	var memail = $("#orangeForm-email").val();
	$.ajax({
		url : "emailCheck.do",
		type : "post",
		data : {
			memail : memail
		},
		success : function(data) {
			console.log(typeof (data));
			eval(data);
		}
	})
}
function fun2() {
	var mkey = $("#orangeForm-email2").val();
	$.ajax({
		url : "emailKey.do",
		type : "post",
		data : {
			mkey : mkey
		},
		success : function(data) {
			console.log(typeof (data));
			eval(data);
		}
	})
}
