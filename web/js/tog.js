$(document).ready(function() {
    $('#toggleMe1').hide();
    $('#toggleMe2').hide();
    $('#toggleMe3').hide();
});

function slideUpDown(slider){
	if($("#" + slider).is(":hidden"))
		{
		var text = $("#"+slider+"header").text();
		$("#" + slider).slideDown('slow');
		text = text.replace("+","-");
		$("#"+slider+"header").html(text);
		}
	else
		{
		var text = $("#"+slider+"header").text();
		$("#" + slider).slideUp('slow');
		text = text.replace("-","+");
		$("#"+slider+"header").html(text);
		}
}



