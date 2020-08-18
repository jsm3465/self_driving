
function fun1() {
	var memail = $("#orangeForm-email").val();
	$.ajax({
		url : "passemailCheck.do",
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
			console.log(data);
			console.log(typeof (data));
			if(data.result == ("success")){
				console.log("ㅎㅇㅎㅇ");
				$("#next").show();
			}
		}
	})
}

/*$('.form-control validate').focusout(function () {
    var pwd1 = $("#orangeForm-pass").val();
    var pwd2 = $("#orangeForm-pass2").val();

    if ( pwd1 != '' && pwd2 == '' ) {
        null;
    } else if (pwd1 != "" || pwd2 != "") {
        if (pwd1 == pwd2) {
            $("#alert-success").css('display', 'inline-block');
            $("#alert-danger").css('display', 'none');
        } else {
            alert("비밀번호가 일치하지 않습니다. 비밀번호를 재확인해주세요.");
            $("#alert-success").css('display', 'none');
            $("#alert-danger").css('display', 'inline-block');
        }
    }
});*/
