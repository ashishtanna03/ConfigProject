	jQuery(function() {
		var current = 0; 
		var maximum = jQuery('#carousel1 ul li').size();
		var visible = 4;
		var speed = 400; 
		var liSize = 138;
		var carousel_height = 174;
 		var ulSize = liSize * maximum;   
		var divSize = 529;

        jQuery('#carousel1 ul').css("width", ulSize+"px").css("left", -(current * liSize)).css("position", "absolute");

        jQuery('#carousel1').css("width", divSize+"px").css("height", carousel_height+"px").css("overflow","hidden").css("visibility", "visible").css("position", "relative");

        jQuery('#related_btnnext1').click(function() {
			/*if(current + step < 0 || current + step > maximum - visible) {return; }
			else {*/
			if(current<steps && current>=0) {
				current += 1;
                jQuery('#carousel1 ul').animate({'left': -(544*current)/*(liSize * current)*/}, speed, null);
				
			}
			//return false;
		});

        jQuery('#related_btnprev1').click(function() {
			/*if(current - step < 0 || current - step > maximum - visible) {return; }
			else {*/
			if(current>0) {
				current -= 1;
                jQuery('#carousel1 ul').animate({'left': -(544*current)/*(liSize * current)*/}, speed, null);
			}
			//return false;
		});
	});