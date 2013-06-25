	jQuery(function() {
		var current = 0; 
		var maximum = jQuery('#carousel1 ul li').size();
		var visible = 5;
		var speed = 400; 
		var liSize = 131;
		var carousel_height = 174;
 		var ulSize = liSize * maximum;   
		var divSize = 641;

        jQuery('#carousel1 ul').css("width", ulSize+"px").css("left", -(current * liSize)).css("position", "absolute");

        jQuery('#carousel1').css("width", divSize+"px").css("height", carousel_height+"px").css("overflow","hidden").css("visibility", "visible").css("position", "relative");

        jQuery('.related_btnnext').click(function() {
			/*if(current + step < 0 || current + step > maximum - visible) {return; }
			else {*/
			if(current<step && current>=0) {
				current += 1;
                jQuery('#carousel1 ul').animate({'left': -(651*current)/*(liSize * current)*/}, speed, null);
				
			}
			//return false;
		});

        jQuery('.related_btnprev').click(function() {
			/*if(current - step < 0 || current - step > maximum - visible) {return; }
			else {*/
			if(current>0) {
				current -= 1;
                jQuery('#carousel1 ul').animate({'left': -(651*current)/*(liSize * current)*/}, speed, null);
			}
			//return false;
		});
	});