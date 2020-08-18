$(function() {
	$('#orangeForm-id').keyup(function(event) {
		if (!(event.keyCode >= 37 && event.keyCode <= 40)) {
			var inputVal = $(this).val();
			$(this).val($(this).val().replace(/[^_a-z0-9]/gi, '')); // _(underscore),
																	// 영어, 숫자만
																	// 가능
		}
	});
	
	$("#orangeForm-yy").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9]/gi,''));
        }
    });
    
});