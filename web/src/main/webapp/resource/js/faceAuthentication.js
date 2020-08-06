$(document).ready(function(){
	var login = false;
	
	//얼굴 인식 실행
	// login 변수 갱신
	
	//로그인한 정보와 얼굴 인식 정보 불일치
	//alert후 main.jsp로 redirect
	if(login){
		alert("인증에 실패 했습니다.");
		$("#next").attr("action", "redirectToMain.do");
		document.nextPage.submit();
	}
	else{
		alert("인증에 성공 했습니다.");
		$("#next").attr("action", "../rover/roverList.do");
		document.nextPage.submit();
	}
})