$(document).ready(function () {

    $("#register").click(function () {
        $("div#panel").slideDown("slow");
        $("#close").css("display", "block");
        $("#open").css("display", "none");
        document.getElementById('after-login').style.display="none";
        document.getElementById('before-login').style.display="block";
        document.getElementById("outer-login").style.display="none";
        document.getElementById("register").style.display="none";
        document.getElementById("j_username").style.display="none";
        document.getElementById("j_password").style.display="none";
    });

    $("#logout").click(function(){
        $("div#panel").slideUp("slow");
        $("#close").css("display", "none");
        $("#open").css("display", "none");
        document.getElementById("outer-login").style.display="block";
        document.getElementById("register").style.display="block";
        document.getElementById("j_username").style.display="block";
        document.getElementById("j_password").style.display="block";
        document.getElementById('before-login').style.display="block";
        document.getElementById('after-login').style.display="none";
    });

    // Expand Panel after login
    $("#outer-login").click(function () {
    });

    // Expand Panel after login
    $("#inner-login").click(function () {

    });

    // Collapse Panel
    $("#close").click(function () {
        $("div#panel").slideUp("slow");
        if(document.getElementById('before-login').style.display=="block"){
            $("#close").css("display", "none");
            $("#open").css("display", "none");
            document.getElementById("outer-login").style.display="block";
            document.getElementById("register").style.display="block";
            document.getElementById("j_username").style.display="block";
            document.getElementById("j_password").style.display="block";
            document.getElementById('after-login').style.display="none";
        }
        else{
            $("#close").css("display", "none");
            $("#open").css("display", "block");
        }
    });
});