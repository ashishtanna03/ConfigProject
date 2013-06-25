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
}
function clickonregpwd(){
    if(document.getElementById("regpwd").value=="Password"){
        document.getElementById("regpwd").value="";
    }
}
function clickoncaptcha(){
    if(document.getElementById("answer").value=="Enter Captcha Here"){
        document.getElementById("answer").value="";
    }
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
}
function bluronregpwd(){
    if(document.getElementById("regpwd").value==""){
        document.getElementById("regpwd").value="Password";
    }
}

function bluroncaptcha(){
    if(document.getElementById("answer").value==""){
        document.getElementById("answer").value="Enter Captcha Here";
    }
}    /*
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
             sendLogInInfo();
         }
     });


 });
$(function(){
    $("#j_username").keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            sendLogInInfo();
        }
    });


});
$(function(){
    $("#inner_password").keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            sendInnerLogInInfo();
        }
    });


});
$(function(){
    $("#inner_username").keypress(function(event) {
        if (event.which == 13) {
            event.preventDefault();
            sendInnerLogInInfo();
        }
    });


});
$(function() {

        $("answer").keypress(function(e) {
            if(e.which == 10 || e.which == 13) {
                e.preventDefault();
                sendRegisterInfo();
            }
        });
    });


