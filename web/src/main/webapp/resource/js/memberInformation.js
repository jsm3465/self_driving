function fun3() {
	var baseMpassword = $("#orangeForm-pass2").val();
	var mpasswordNew = $("#orangeForm-pass3").val();

	if (mpasswordNew.length < 8) {
		alert("새 비밀번호 8자리 이상 입력해주세요");
		console.log("이프문");
	} else {
		$.ajax({
			url : "changePassword.do",
			type : "post",
			data : {
				baseMpassword : baseMpassword,
				mpasswordNew : mpasswordNew
			},
			success : function(data) {
				eval(data);
				window.location = "../member/memberInformationForm.do";
			}
		})
	}
}

function fun4() {
	var baseMpassword = $("#orangeForm-pass4").val();

	$.ajax({
		url : "deleteMember.do",
		type : "post",
		data : {
			baseMpassword : baseMpassword
		},
		success : function(data) {
			eval(data);
			window.location = "../home/main.do";
		}
	})

}

$(function() {
	$('#orangeForm-id').keyup(function(event) {
		if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val($(this).val().replace(/[^_a-z0-9]/gi, '')); // _(underscore),
			// 영어, 숫자만
			// 가능
		}
	});

	$("#orangeForm-yy").keyup(function(event) {
		if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^0-9]/gi, ''));
		}
	});

});