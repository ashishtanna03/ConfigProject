	$(function() {
		var step=1; 
		var current = 0; 
		var maximum = $('#carousel2 ul li').size(); 
		var visible = 4; 
		var speed = 400; 
		var liSize = 125;
		var carousel_height = 166;
 
 		var ulSize = liSize * maximum;   
		var divSize = 482;  
 
		$('#carousel3 ul').css("width", ulSize+"px").css("left", -(current * liSize)).css("position", "absolute");
 
		$('#carousel3').css("width", divSize+"px").css("height", carousel_height+"px").css("overflow","hidden").css("visibility", "visible").css("position", "relative"); 
 
		$('#related_btnnext3').click(function() { 
			/*if(current + step < 0 || current + step > maximum - visible) {return; }
			else {*/
			if(current<step && current>=0) {
				current += 1;
				$('#carousel3 ul').animate({'left': -(491*current)/*(liSize * current)*/}, speed, null);
				
			}
			//return false;
		});
 
		$('#related_btnprev3').click(function() { 
			/*if(current - step < 0 || current - step > maximum - visible) {return; }
			else {*/
			if(current>0) {
				current -= 1;
				$('#carousel3 ul').animate({'left': -(491*current)/*(liSize * current)*/}, speed, null);
			}
			//return false;
		});
	});