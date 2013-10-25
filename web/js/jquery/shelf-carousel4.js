$(function() {
    var current = 0;
    var maximum = $('#carousel5 ul li').size();
    var visible = 4;
    var speed = 400;
    var liSize = 125;
    var carousel_height = 210;

    var ulSize = liSize * maximum;
    var divSize = 482;

    $('#carousel5 ul').css("width", ulSize+"px").css("left", -(current * liSize)).css("position", "absolute");

    $('#carousel5').css("width", divSize+"px").css("height", carousel_height+"px").css("overflow","hidden").css("visibility", "visible").css("position", "relative");

    $('#related_btnnext4').click(function() {
        /*if(current + step < 0 || current + step > maximum - visible) {return; }
         else {*/
        if(current<requestedBooksSteps && current>=0) {
            current += 1;
            $('#carousel5 ul').animate({'left': -(491*current)/*(liSize * current)*/}, speed, null);

        }
        //return false;
    });

    $('#related_btnprev4').click(function() {
        /*if(current - step < 0 || current - step > maximum - visible) {return; }
         else {*/
        if(current>0) {
            current -= 1;
            $('#carousel5 ul').animate({'left': -(491*current)/*(liSize * current)*/}, speed, null);
        }
        //return false;
    });
});