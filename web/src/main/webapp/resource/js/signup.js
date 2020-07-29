//아이디 입력란에 keyup 이벤트가 일어 났을때 실행할 함수 등록 
$("#id").keyup(function(){
    //입력한 문자열을 읽어온다.
    var id=$(this).val();
    //ajax 요청을 해서 서버에 전송한다.
    $.ajax({
        method:"post",
        url:"/idCheck",
        data:{inputId:id},
        success:function(data){
            var obj=JSON.parse(data);
            if(obj.canUse){//사용 가능한 아이디 라면 
                $("#overlapErr").hide();
                // 성공한 상태로 바꾸는 함수 호출
                successState("#id");
                
            }else{//사용 가능한 아이디가 아니라면 
                $("#overlapErr").show();
                errorState("#id");
            }
        }
    });
});
$("#pwd").keyup(function(){
    var pwd=$(this).val();
    // 비밀번호 검증할 정규 표현식
    var reg=/^.{8,}$/;
    if(reg.test(pwd)){//정규표현식을 통과 한다면
                $("#pwdRegErr").hide();
                successState("#pwd");
    }else{//정규표현식을 통과하지 못하면
                $("#pwdRegErr").show();
                errorState("#pwd");
    }
});
$("#rePwd").keyup(function(){
    var rePwd=$(this).val();
    var pwd=$("#pwd").val();
    // 비밀번호 같은지 확인
    if(rePwd==pwd){//비밀번호 같다면
        $("#rePwdErr").hide();
        successState("#rePwd");
    }else{//비밀번호 다르다면
        $("#rePwdErr").show();
        errorState("#rePwd");
    }
});
$("#email").keyup(function(){
    var email=$(this).val();
    // 이메일 검증할 정규 표현식
    var reg=/^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    if(reg.test(email)){//정규표현식을 통과 한다면
                $("#emailErr").hide();
                successState("#email");
    }else{//정규표현식을 통과하지 못하면
                $("#emailErr").show();
                errorState("#email");
    }
});
// 성공 상태로 바꾸는 함수
function successState(sel){
    $(sel)
    .parent()
    .removeClass("has-error")
    .addClass("has-success")
    .find(".glyphicon")
    .removeClass("glyphicon-remove")
    .addClass("glyphicon-ok")
        .show();
 
        $("#myForm button[type=submit]")
                .removeAttr("disabled");
};
// 에러 상태로 바꾸는 함수
function errorState(sel){
    $(sel)
    .parent()
    .removeClass("has-success")
    .addClass("has-error")
    .find(".glyphicon")
    .removeClass("glyphicon-ok")
    .addClass("glyphicon-remove")
        .show();
 
        $("#myForm button[type=submit]")
                .attr("disabled","disabled");
};
