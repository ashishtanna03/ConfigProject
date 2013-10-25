/*For Outer Login*/
function clickonuname(){
    if(document.getElementById("j_username").value=="Username"){
        document.getElementById("j_username").value="";
    }
}
function clickonpwd(){
    if(document.getElementById("j_password").value=="Password"){
        document.getElementById("j_password").value="";
    }
}
function bluronuname(){
    if(document.getElementById("j_username").value==""){
        document.getElementById("j_username").value="Username";
    }
}
function bluronpwd(){
    if(document.getElementById("j_password").value==""){
        document.getElementById("j_password").value="Password";
    }
}

/*For Register*/
function clickonfname(){
    if(document.getElementById("fname").value=="First Name"){
        document.getElementById("fname").value="";
    }
}
function clickonlname(){
    if(document.getElementById("lname").value=="Last Name"){
        document.getElementById("lname").value="";
    }
}

function clickonemail(){
    if(document.getElementById("email").value=="E-Mail Address"){
        document.getElementById("email").value="";
    }
    var emailId = $("input[name=emailId]:first");
    emailId.tooltipster('update','Note : You have to verify your<br/>E-Mail ID to complete<br/>registration. So, enter E-Mail<br/>ID of the account you<br/>can access.');
    emailId.tooltipster('show');
}

function clickonregpwd(){
    if(document.getElementById("regpwd").value=="Password"){
        document.getElementById("regpwd").value="";
    }
}
/*function clickoncaptcha(){
    if(document.getElementById("answer").value=="Enter Captcha Here"){
        document.getElementById("answer").value="";
    }
}*/
function clickoncontact(){
    if(document.getElementById("contactNo").value=="Contact No."){
        document.getElementById("contactNo").value="";
    }
    var contactNo = $("input[name=contactNo]:first");
    contactNo.tooltipster('update','Note : You have to verify your<br/>Mobile No. to complete<br/>registration. So, enter Mobile<br/>No. from which you can<br/>give us a Miss call to verify.<br/>(Verification is mandatory and its<br/>Free. Call will be disconnected<br/>automatically.)');
    contactNo.tooltipster('show');
}

function bluronfname(){
    if(document.getElementById("fname").value==""){
        document.getElementById("fname").value="First Name";
    }
}
function bluronlname(){
    if(document.getElementById("lname").value==""){
        document.getElementById("lname").value="Last Name";
    }
}
function bluronemail(){
    if(document.getElementById("email").value==""){
        document.getElementById("email").value="E-Mail Address";
    }
    $("input[name=emailId]:first").tooltipster('hide');
}
function bluronregpwd(){
    if(document.getElementById("regpwd").value==""){
        document.getElementById("regpwd").value="Password";
    }
}

/*function bluroncaptcha(){
    if(document.getElementById("answer").value==""){
        document.getElementById("answer").value="Enter Captcha Here";
    }
}*/

function bluroncontact(){
    if(document.getElementById("contactNo").value==""){
        document.getElementById("contactNo").value="Contact No.";
    }
    $("input[name=contactNo]:first").tooltipster('hide');
}

function validateContactNumber(evt) {
    var theEvent = evt || window.event;
    var key = theEvent.keyCode || theEvent.which;
    key = String.fromCharCode( key );
    var regex = /[0-9]|\./;
    if( !regex.test(key) && theEvent.keyCode!=8) {
        theEvent.returnValue = false;
        if(theEvent.preventDefault) theEvent.preventDefault();
    }
}

    /*
$(function() {
    $('searchForm').each(function() {
        $('input').keypress(function(e) {
            if(e.which == 10 || e.which == 13) {
                this.form.submit();
            }
        });
    });
});*/

 $(function(){
     $("#j_password").keypress(function(event) {
         if (event.which == 13) {
             event.preventDefault();
             $("#close").css("display", "block");
             $("#open").css("display", "none");
             sendLogInInfo();
         }
     });


 });
/*$(function(){
    $("#j_username").keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            sendLogInInfo();
        }
    });


});      */
$(function(){
    $("#inner_password").keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            sendInnerLogInInfo();
        }
    });


});   /*
$(function(){
    $("#inner_username").keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            sendInnerLogInInfo();
        }
    });


});             */

$(function() {

        $("answer").keypress(function(e) {
            if(e.which == 10 || e.which == 13) {
                e.preventDefault();
                verifyAndSendRegisterInfo();
            }
        });
    });


