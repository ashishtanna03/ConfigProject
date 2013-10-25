	$(function() {

		var current = 0; 
		var maximum = $('#carousel2 ul li').size(); 
		var visible = 4; 
		var speed = 400; 
		var liSize = 168;
		var carousel_height = 258;
 
 		var ulSize = liSize * maximum;   
		var divSize = 654;  
 
		$('#carousel2 ul').css("width", ulSize+"px").css("left", -(current * liSize)).css("position", "absolute");
 
		$('#carousel2').css("width", divSize+"px").css("height", carousel_height+"px").css("visibility", "visible").css("overflow", "hidden").css("position", "relative"); 
 
		$('#btnnext2').click(function() { 
			/*if(current + step < 0 || current + step > maximum - visible) {return; }
			else {*/
			if(current<stepsCarousel2 && current>=0) {
				current += 1;
				$('#carousel2 ul').animate({'left': -(664*current)/*(liSize * current)*/}, speed, null);				
			}
			//return false;
		});
 
		$('#btnprev2').click(function() { 
			/*if(current - step < 0 || current - step > maximum - visible) {return; }
			else {*/
			if(current>0) {
				current -= 1;
				$('#carousel2 ul').animate({'left': -(664*current)/*(liSize * current)*/}, speed, null);
			}
			//return false;
		});
	});