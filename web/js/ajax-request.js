var res;
var resJson;
var req;
var isInnerLogin=false;
var isOuterLogin=false;
if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
    req = new XMLHttpRequest();
}
else {// code for IE6, IE5
    req = new ActiveXObject("Microsoft.XMLHTTP");
}

req.onreadystatechange = function () {
    if (req.readyState == 4 && req.status == 200) {
        document.getElementById('loading-login').style.display="none";

        res=req.response;
        resJson = JSON && JSON.parse(res) || $.parseJSON(res);
        ajaxLogInRequest(resJson);
    }
};

/*---------------------Login Requests----------------*/
function sendLogInInfo(){
    isInnerLogin = false;
    isOuterLogin = true;
    document.getElementById('loading-login').style.display="block";
    document.getElementById('before-login').style.display="none";
    document.getElementById('after-login').style.display="none";
    document.getElementById('error-message').style.display="none";

    $("div#panel").slideDown("slow", function() {
        $("#close").css("display", "block");
        $("#open").css("display", "none");
    });

    $("#open").click(function () {
        $("div#panel").slideDown("slow");
        $("#close").css("display", "block");
        $("#open").css("display", "none");
    });

    req.open('POST','/j_spring_security_check?j_username='+document.getElementById('j_username').value+'&j_password='+document.getElementById('j_password').value,true);
    req.send();
}

function sendInnerLogInInfo(){
    isInnerLogin=true;
    isOuterLogin=false;
    document.getElementById('loading-login').style.display="block";
    document.getElementById('error-message').style.display="none";
    document.getElementById('before-login').style.display="none";
    document.getElementById('after-login').style.display="none";

    $("#open").click(function () {
        $("div#panel").slideDown("slow");
        $("#close").css("display", "block");
        $("#open").css("display", "none");
    });

    req.open('POST','/j_spring_security_check?j_username='+document.getElementById('inner_username').value+'&j_password='+document.getElementById('inner_password').value,true);
    req.send();
}

function ajaxLogInRequest(resJson){
    if(resJson.result=="error"){
        $("div#panel").slideDown("slow");
        $("#close").css("display", "block");
        $("#open").css("display", "none");
        $("#loading-login").css("display", "none");
        $("#error-message").css("display", "block");
        document.getElementById('after-login').style.display="none";
        document.getElementById('before-login').style.display="block";
        document.getElementById("outer-login").style.display="none";
        document.getElementById("register").style.display="none";
        document.getElementById("j_username").style.display="none";
        document.getElementById("j_password").style.display="none";

        document.getElementById('inner_username').innerHTML = document.getElementById('j_username').innerHTML;
        document.getElementById('inner_password').innerHTML = document.getElementById('j_password').innerHTML;
    } else if(resJson.result=="inactive") {
        $("div#panel").slideUp("slow");
        forceLogout(function(verify) {
                if(verify){
                    //opening custom-error-message.jsp page with submitting two parameters
                    var form = document.createElement("form");
                    form.setAttribute("method", "post");
                    form.setAttribute("action", "/custom-message-page.jsp");

                    var resultHeader = document.createElement("input");
                    resultHeader.setAttribute("type", "hidden");
                    resultHeader.setAttribute("name", "resultHeader");
                    resultHeader.setAttribute("value", resJson.resultHeader);

                    form.appendChild(resultHeader);

                    var resultMessage = document.createElement("input");
                    resultMessage.setAttribute("type", "hidden");
                    resultMessage.setAttribute("name", "resultMessage");
                    resultMessage.setAttribute("value", resJson.resultMessage);

                    form.appendChild(resultMessage);

                    document.body.appendChild(form);
                    form.submit();
                } else {
                    document.location.href="http://localhost:8080/error.jsp";
                }
            }
        );
    } else{
        $("#error-message").css("display", "none");
        document.getElementById('j_username').style.display="none";
        document.getElementById('j_password').style.display="none";
        document.getElementById('outer-login').style.display="none";
        document.getElementById('register').style.display="none";

        if($("div#panel").is(':hidden')){
            document.getElementById('close').style.display="none";
            document.getElementById('open').style.display="block";
        }else{
            document.getElementById('close').style.display="block";
            document.getElementById('open').style.display="none";
        }

        document.getElementById('before-login').style.display="none";
        document.getElementById('after-login').style.display="block";

        /*Setting User's Name*/
        var userFullName = resJson.user.firstName +" "+ resJson.user.lastName;
        document.getElementById('uname_head').innerHTML=userFullName;

        /*User's Avail Points*/
        document.getElementById('avail_points_value').innerHTML=resJson.user.userBalance;

        /*User's Profile Pic*/
        if(resJson.user.userImg==null)
            document.getElementById('head-user-img').setAttribute("src","/images/no-profile-pic.png")
        else
            document.getElementById('head-user-img').setAttribute("src",resJson.user.userImg)

        if(resJson.user.noOfItems>0){
            if(resJson.user.noOfItems==1)
                document.getElementsByClassName('ajax_cart_quantity')[0].innerHTML = '1 Product';
            else {
                document.getElementsByClassName('ajax_cart_quantity')[0].innerHTML = resJson.user.noOfItems + ' Products';
            }
        } else {
            document.getElementsByClassName('ajax_cart_quantity')[0].innerHTML = "(Empty)";
        }

        /*Notification*/
        var notificationListJson = resJson.user.notificationList;
        var notificationList = document.getElementById('notification-container');
        var friendRequestList = document.getElementById('friends-activity-container');
        notificationList.innerHTML = "";
        friendRequestList.innerHTML = "";
        if(notificationListJson!=null){
            var objectImg, authors,authorList="";
            for(var i=notificationListJson.length-1;i>=0;i--){
                authorList="";
                if(notificationListJson[i].authors!=null) {
                    authors = notificationListJson[i].authors;
                    for(var j =0;j<authors.length;j++){
                        authorList+="<a href='/author/GetAuthorInfo.action?authorId="+authors[j].authorId+"'>"+authors[j].authorName+"</a>";
                        if(j+1!=authors.length){
                            authorList+=", ";
                        }
                    }
                }
                else{authors=null;}
                if(notificationListJson[i].objectImg==null){objectImg="/images/no-profile-pic.png";}else{objectImg=notificationListJson[i].objectImg;}
                switch (notificationListJson[i].notificationType){
                    case 0 : friendRequestList.innerHTML+="<li><img style='width:60px;height:60px;' src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> wants to be your Friend.<br/>Accept Request? <a href='/user/AcceptRequest.action?userId="+notificationListJson[i].userId+"' target='_blank'>Yes</a></li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 1 : notificationList.innerHTML+="<li><img style='width:60px;height:60px;' src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> has accepted your Friend Request.</li><span>"+notificationListJson[i].date+"</span><hr/>";break;
//                    case 2 : notificationList.innerHTML+="<li><img src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> has recommended<br/><a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a> by "+authorList+" to you.</li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 3 : notificationList.innerHTML+="<li><img style='width:60px;height:60px;' src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> has requested<br/><a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a> by "+authorList+".<br/>Want to Share? <a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>Yes</a></li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 4 : notificationList.innerHTML+="<li><img style='width:60px;height:60px;' src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> has shared<br/><a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a> by "+authorList+".<br/>Want to Buy? <a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>Yes</a></li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 5 : notificationList.innerHTML+="<li><img style='width:60px;height:60px;' src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> has bought the<br/><a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a> by "+authorList+" which you had shared.</li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 6 :
                        if(notificationListJson[i].objectImg==null){objectImg="/images/no-book-cover.jpg";}else{objectImg=notificationListJson[i].objectImg;}
                        notificationList.innerHTML+="<li><img src='"+objectImg+"'/>The book <a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a> by "+authorList+" which you requested is now available.</li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 7 :
                        if(notificationListJson[i].objectImg==null){objectImg="/images/no-author-pic.jpg";}else{objectImg=notificationListJson[i].objectImg;}
                        notificationList.innerHTML+="<li><img src='"+objectImg+"'/>We have added a new book of the author, <a href='/author/GetAuthorInfo.action?authorId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a>, you are following.</li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                }
            }
        }

        if(notificationList.innerHTML=="") {
            notificationList.innerHTML+="<li>No Notifications.</li>";
        }
        if(friendRequestList.innerHTML=="") {
            friendRequestList.innerHTML+="<li>No Friend Requests.</li>";
        }

        if(!isInnerLogin && isOuterLogin) {

        } else if(isInnerLogin && !isOuterLogin) {
            $("#close").css("display", "block");
            $("#open").css("display", "none");
        }

        if(isInnerLogin || isOuterLogin) {

            $('#notification-container').jScrollPane();
            $('#friends-activity-container').jScrollPane();

            $('#notification-container').jScrollPane({
                horizontalGutter: 5,
                verticalGutter: 5,
                'showArrows': false
            });

            $('#friends-activity-container').jScrollPane({
                horizontalGutter: 5,
                verticalGutter: 5,
                'showArrows': false
            });

            $('.jspDrag').hide();
            $('.jspScrollable').mouseenter(function () {
                $(this).find('.jspDrag').stop(true, true).fadeIn('slow');
            });

            $('.jspScrollable').mouseleave(function () {
                $(this).find('.jspDrag').stop(true, true).fadeOut('slow');
            });
        }
    }
}
/*------------------End Login Requests------------------*/

/*----------Force Logout Request--------------*/
//logout if email is not verified
function forceLogout(callback){

    var forceLogoutReq;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        forceLogoutReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        forceLogoutReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    forceLogoutReq.onreadystatechange = function () {
        if (forceLogoutReq.readyState == 4 && forceLogoutReq.status == 200) {
            callback(true);
        }
    };

    forceLogoutReq.open('POST','/j_spring_security_logout');
    forceLogoutReq.send();
}
/*----------End Force Logout Request--------------*/

/*----------Logout Request--------------*/
function sendLogOutRequest(){

    var logoutReq;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        logoutReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        logoutReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    logoutReq.onreadystatechange = function () {
        if (logoutReq.readyState == 4 && logoutReq.status == 200) {
            document.location.href="http://localhost:8080/index.jsp";
        }
    };
    logoutReq.open('POST','/j_spring_security_logout');
    logoutReq.send();
}
/*----------End Logout Request--------------*/

/*----------Check IF User Is Logged IN--------------*/
function isLoggedIn(callback){
    var isLogReq, isLogRes;
    var isLogResJson;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        isLogReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        isLogReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    isLogReq.onreadystatechange = function () {
        if (isLogReq.readyState == 4 && isLogReq.status == 200) {
            isLogRes=isLogReq.response;
            isLogResJson = JSON && JSON.parse(isLogRes) || $.parseJSON(isLogRes);

            if(isLogResJson.result == "success"){
                callback(true);
            } else {
                callback(false);
            }
        }
    };
    isLogReq.open('POST','/IsLoggedIn.action',true);
    isLogReq.send();
    return false;
}
/*----------/Check IF User Is Logged IN--------------*/

/*---------------LoggedIn Request--------------*/
function getLoggedInInfo(){
    isInnerLogin=false;
    isOuterLogin=false;
    req.open('POST','/LoggedIn',true);
    req.send();
    // Expand Panel
    $("#open").click(function () {
        $("div#panel").slideDown("slow", function() {

            $('#notification-container').jScrollPane();
            $('#friends-activity-container').jScrollPane();

            $('#notification-container').jScrollPane({
                horizontalGutter: 5,
                verticalGutter: 5,
                'showArrows': false
            });

            $('#friends-activity-container').jScrollPane({
                horizontalGutter: 5,
                verticalGutter: 5,
                'showArrows': false
            });

            $('.jspDrag').hide();
            $('.jspScrollable').mouseenter(function () {
                $(this).find('.jspDrag').stop(true, true).fadeIn('slow');
            });

            $('.jspScrollable').mouseleave(function () {
                $(this).find('.jspDrag').stop(true, true).fadeOut('slow');
            });

        });
        $("#close").css("display", "block");
        $("#open").css("display", "none");
    });
}
/*---------------/LoggedIn Request--------------*/

/*----------------Register Request------------------*/
function verifyAndSendRegisterInfo(){

    var submitButton = $("#register-submit");
    submitButton.tooltipster({content:'',timer:2000,trigger:'custom',position:'bottom'});

    var acceptTerms = $("#accept-terms");
    if(!acceptTerms.is(':checked')) {
        submitButton.tooltipster('update','You must accept<br/>Terms & Conditions to Register.'); submitButton.tooltipster('show'); return;
    }

    var firstName = $("input[name=firstName]:first");
    firstName.tooltipster({content:'',timer:2000,trigger:'custom',position:'left'});
    if(firstName.val()==null || $.trim(firstName.val())=="" || firstName.val()=="First Name") {
        firstName.tooltipster('update','First Name can\'t<br/>be empty.'); firstName.tooltipster('show'); return;
    }

    var lastName = $('input[name=lastName]:first');
    lastName.tooltipster({content:'',timer:2000,trigger:'custom',position:'left'});
    if(lastName.val()==null || $.trim(lastName.val())=="" || lastName.val()=="Last Name") {
        lastName.tooltipster('update','Last Name can\'t<br/>be empty.'); lastName.tooltipster('show'); return;
    }

    var emailId = $("input[name=emailId]:first");
    emailId.tooltipster('hide');
    if(emailId.val()==null || $.trim(emailId.val())=="" || emailId.val()=="E-Mail Address") {
        emailId.tooltipster('update','E-Mail Address<br/>can\'t be empty.'); emailId.tooltipster('show'); return;
    } else if(!validateEmail(emailId.val())) {
        emailId.tooltipster('update','Please, Enter valid<br/>E-Mail Address.'); emailId.tooltipster('show'); return;
    }

    var password = $("input[name=password]:first");
    password.tooltipster({content:'',timer:2000,trigger:'custom',position:'left'});
    if(password.val()==null || $.trim(password.val())=="" || password.val()=="Password") {
        password.tooltipster('update','Password can\'t<br/>be empty.'); password.tooltipster('show'); return;
    } else if(password.val().length<8 || password.val().length>30) {
        password.tooltipster('update','Password must be of 8-30 characters.'); password.tooltipster('show'); return;
    }

    /*var answer = $("input[name=answer]:first");
    answer.tooltipster({content:'',timer:2000,trigger:'custom',position:'left'});
    if(answer.val()==null || $.trim(answer.val())=="" || answer.val()=="Enter Captcha Here") {
        answer.tooltipster('update','You must enter<br/>the Captcha.'); answer.tooltipster('show'); return;
    }*/

    var contactNo = $("input[name=contactNo]:first");
    contactNo.tooltipster('hide');
    if(contactNo.val()==null || $.trim(contactNo.val())=="" || contactNo.val()=="Contact No.") {
        contactNo.tooltipster('update','Contact No. can\'t<br/>be empty.'); contactNo.tooltipster('show'); return;
    } else if(contactNo.val().length!=10) {
        contactNo.tooltipster('update','Contact No. must be<br/> valid & of 10 digits.'); contactNo.tooltipster('show'); return;
    }

    var missCallReq;
    var missCallRes;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        missCallReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        missCallReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    missCallReq.onreadystatechange = function () {
        if (missCallReq.readyState == 4 && missCallReq.status == 200) {

            missCallRes=eval(missCallReq.response);

            if(missCallRes.APIStatus=="Success") {
                var contactVerify = $("#contact-verification");
                var contactVerifyUrl = "/lightbox-pages/contact-verification.jsp?lightbox[width]=330&lightbox[height]=290"+
                    "&sessionId="+missCallRes.SessionId+
                    "&verificationNode="+missCallRes.VerificationNode+
                    "&action=/register/Register.action"+
                    "&firstName="+firstName.val()+
                    "&lastName="+lastName.val()+
                    "&emailId="+emailId.val() +
                    "&password="+password.val()+
                    "&contactNo="+contactNo.val();
                contactVerify.attr("href", contactVerifyUrl);
                contactVerify[0].click();
            } else {
                submitButton.tooltipster('update','An Error occurred.<br/>Try again later.'); submitButton.tooltipster('show'); return;
            }

        }
    };

    var missCallUrl = "http://jusdias.com/readershive/dial2verify_misscall_request.php?contactNo="+contactNo.val();

    missCallReq.open('GET', missCallUrl, true);
    missCallReq.send();
}

/*---------------/Register Request-----------------*/

/*---------------editprof---------------*/

function saveProfileChanges(){
    var regEx = /^[a-zA-Z]+$/;
    var regEx1 = /^[0-9]+$/;
    var regEx2 = /((?:https?\:\/\/|www\.)(?:[-a-z0-9]+\.)*[-a-z0-9]+.*)/i;
    $('#first-name').tooltipster({content:'',timer:2000,trigger:'custom',position:'right'});
    $('#last-name').tooltipster({content:'',timer:2000,trigger:'custom',position:'right'});
    $('#postal-code').tooltipster({content:'',timer:2000,trigger:'custom',position:'right'});
    $('#contact-no').tooltipster({content:'',timer:2000,trigger:'custom',position:'right'});
    $('#web-blo').tooltipster({content:'',timer:2000,trigger:'custom',position:'right'});
    $('#save-changes').tooltipster({content:'',timer:2000,trigger:'custom',position:'right'});

    if(document.getElementById('first-name').value==""){$('#first-name').tooltipster('update','Please, Enter valid value.');$('#first-name').tooltipster('show');return;}
    else if(!regEx.test(document.getElementById('first-name').value)){$('#first-name').tooltipster('update','Only characters allowed.');$('#first-name').tooltipster('show');return;}
    if(document.getElementById('last-name').value==""){$('#last-name').tooltipster('update','Please, Enter valid value.');$('#last-name').tooltipster('show');return;}
    else if(!regEx.test(document.getElementById('last-name').value)){$('#last-name').tooltipster('update','Only characters allowed.');$('#last-name').tooltipster('show');return;}
    if(document.getElementById('postal-code').value==""){$('#postal-code').tooltipster('update','Please, Enter valid value.');$('#postal-code').tooltipster('show');return;}
    else if(!regEx1.test(document.getElementById('postal-code').value)){$('#postal-code').tooltipster('update','Only numbers allowed.');$('#postal-code').tooltipster('show');return;}
    if(document.getElementById('contact-no').value==""){$('#contact-no').tooltipster('update','Please, Enter valid value.');$('#contact-no').tooltipster('show');return;}
    else if(!regEx1.test(document.getElementById('contact-no').value)){$('#contact-no').tooltipster('update','Only numbers allowed.');$('#contact-no').tooltipster('show');return;}
    if(document.getElementById('web-blo').value==""){$('#web-blo').tooltipster('update','Please, Enter valid value.');$('#web-blo').tooltipster('show');return;}
    else if(!regEx2.test(document.getElementById('web-blo').value)){$('#web-blo').tooltipster('update','Please, Enter a valid URL.');$('#web-blo').tooltipster('show');return;}

    var savRes,saveResJson,saveReq;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        saveReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        saveReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    saveReq.onreadystatechange = function () {
        if (saveReq.readyState == 4 && saveReq.status == 200) {
            savRes=saveReq.response;
            saveResJson = JSON && JSON.parse(savRes) || $.parseJSON(savRes);
            var theButton = $('#save-changes');
            if(saveResJson.result=="success"){
                theButton.tooltipster('update','Changes Saved.');
            }
            else{
                theButton.tooltipster('update',"Error Occurred.<br/>Try again later.")
            }
            theButton.tooltipster('enable');
            theButton.tooltipster('show');
        }
    };

    //get favourite genres of user
    var genreList = document.getElementById('userFavGenres');
    var selectedGenres = "";
    for (var genreIndex = 0; genreIndex < genreList.options.length; genreIndex++) {
        if (genreList.options[genreIndex].selected) {
            selectedGenres += '&userFavGenres='+genreList.options[genreIndex].value;
        }
    }

    //getting selected gender value
    var genderButtons = document.getElementsByName("gender");
    var selectedGender;
    for (var i = 0; i < genderButtons.length; i++) {
        if (genderButtons[i].checked) {
            selectedGender = genderButtons[i].value;
        }
    }
    var cityMenu = document.getElementById("city-name");
    var occupationMenu = document.getElementById("occuname");

    saveReq.open('POST','/editprofile/SaveProfileChanges.action?firstName='+document.getElementById('first-name').value+
        '&lastName='+document.getElementById('last-name').value+
        '&userCity='+cityMenu.options[cityMenu.selectedIndex].value+
        '&userBirthdate='+dojo.widget.byId('birth-date').getValue()+
        '&userGender='+selectedGender+
        '&userPostalCode='+document.getElementById('postal-code').value+
        '&userOccupation='+occupationMenu.options[occupationMenu.selectedIndex].value+
        selectedGenres+// user favourite genres
        '&userWebsite='+document.getElementById('web-blo').value+
        '&userContact='+document.getElementById('contact-no').value+
        '&userAddress='+document.getElementById('user-add').value,
        false);

    saveReq.send();

}

function changePassword(){

    $('#conf_pwd').tooltipster({content:'',trigger:'custom',position:'right'});
    if(document.getElementById('new_pwd').value!=document.getElementById('conf_pwd').value){$('#conf_pwd').tooltipster('update','Passwords do not match.');$('#conf_pwd').tooltipster('show');return;}

    var pwdRes,pwdResJson,pwdReq;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        pwdReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        pwdReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    pwdReq.onreadystatechange = function () {
        if (pwdReq.readyState == 4 && pwdReq.status == 200) {
            pwdRes=pwdReq.response;
            pwdResJson = JSON && JSON.parse(pwdRes) || $.parseJSON(pwdRes);
            var theButton = $('#save-changes2');
            if(pwdResJson.result=="success"){
                theButton.tooltipster('update','Password changed successfully.');
            } else if(pwdResJson.result=="wrong"){
                theButton.tooltipster('update','The password you<br/>entered is wrong.');
            }
            else{
                theButton.tooltipster('update',"Error Occurred.<br/>Try again later.")
            }
            theButton.tooltipster('enable');
            theButton.tooltipster('show');
        }
    };
    var pwdUrl = "/user/ChangePassword.action?oldPassword="+document.getElementById('old_pwd').value+"&newPassword="+document.getElementById('new_pwd').value;
    pwdReq.open('POST',pwdUrl,true);
    pwdReq.send();

}

/*---------------/editprof---------------*/


/*---------------Reset Password---------------*/

function resetPassword(){

    var resetPassword = $('#reset-password');
    resetPassword.tooltipster({content:'',trigger:'custom',position:'right'});
    var retypePassword = $('#retype-password');
    retypePassword.tooltipster({content:'',trigger:'custom',position:'right'});

    if(resetPassword.val()==null || $.trim(resetPassword.val())=="") {
        resetPassword.tooltipster('update','Password can\'t<br/>be empty.'); resetPassword.tooltipster('show'); return;
    } else if(resetPassword.val().length<8 || resetPassword.val().length>30) {
        resetPassword.tooltipster('update','Password must be of<br/>8-30 characters.'); resetPassword.tooltipster('show'); return;
    }

    if(resetPassword.val()!=retypePassword.val()){
        retypePassword.tooltipster('update','Passwords do not<br/>match.'); retypePassword.tooltipster('show');return;
    }

    document.getElementById('reset-password-form').submit();

}

/*---------------/Reset Password---------------*/


/*-----------Search Results------------*/
//function loadSearchResults(){
    /*var searchReq;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        searchReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        searchReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    searchReq.open('POST','/search/LoadSearchResults.action?searchQuery='+document.getElementsByName('searchQuery')[0].value,true);
    searchReq.send();*/
   /* window.location = '/search/LoadSearchResults.action?searchQuery='+document.getElementsByName('searchQuery')[0].value+
                    '&pageNo='+document.getElementsByName('pageNo')[0].value+
                    '&maxResults='+document.getElementsByName('maxResults')[0].value
                    ;*/
//}
/*-----------/Search Results------------*/

/*-----------Follow/UnFollow------------*/

function followRequest(reqType,authorId){
    var followReq, followRes;
    var reqUrl;
    var button;
    var resJson,replaceWith, replaceValueWith;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        followReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        followReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    $('.followButton').tooltipster({
        animation: 'fade',
        timer:2000,
        trigger:'custom',
        content:''
    });

    if(reqType=="notLoggedIn"){
        $('.followButton').tooltipster('update','You must be Logged in<br/>to Follow the Author.');
        $('.followButton').tooltipster('show');
        return;
    }
    else{
        reqUrl = "/author/"+reqType+".action?authorId="+authorId;
    }

    followReq.open('POST',reqUrl,true);
    followReq.send();

    followReq.onreadystatechange = function () {
        if (followReq.readyState == 4 && followReq.status == 200) {
            followRes=followReq.response;
            resJson = JSON && JSON.parse(followRes) || $.parseJSON(followRes);

            if(resJson.result=="success"){
                button = document.getElementById(reqType);
                if(reqType=="Follow"){
                    replaceWith="Unfollow";
                    replaceValueWith = "(-) Unfollow";

                    $('.followButton').tooltipster('update','You are now Following<br/>the Author.');
                    $('.followButton').tooltipster('show');
                }
                else{
                    replaceWith="Follow";
                    replaceValueWith = "(+) Follow";

                    $('.followButton').tooltipster('update','Now, You won\'t get<br/>any updates of the author.');
                    $('.followButton').tooltipster('show');
                }

                button.id=replaceWith;
                button.onclick = function(){followRequest(replaceWith,authorId)};
                button.innerHTML = replaceValueWith;
            }
            else{
                $('.followButton').tooltipster('update','An Error Occurred. Check<br/>if You are Logged In.');
                $('.followButton').tooltipster('show');
            }
        }
    };
}

/*-----------/Follow/UnFollow-----------*/

/*----------Friend or Unfriend Reuest---------------*/

function friendRequest(reqType,userId){
    var friendReq, friendRes;
    var reqUrl;
    var button;
    var resJson,replaceWith, replaceValueWith;
    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        friendReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        friendReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    var addFriendButton = $('.addFriendButton');
    addFriendButton.tooltipster({
        animation: 'fade',
        timer:2000,
        trigger:'custom',
        content:''
    });

    if(reqType=="notLoggedIn"){
        addFriendButton.tooltipster('update','You must be Logged in<br/>to send Friend Request.');
        addFriendButton.tooltipster('show');
        return;
    }
    else{
        reqUrl = "/user/"+reqType+".action?userId="+userId;
    }

    friendReq.open('POST',reqUrl,true);
    friendReq.send();

    friendReq.onreadystatechange = function () {
        if (friendReq.readyState == 4 && friendReq.status == 200) {
            friendRes=friendReq.response;
            resJson = JSON && JSON.parse(friendRes) || $.parseJSON(friendRes);

            if(resJson.result=="success"){
                button = document.getElementById(reqType);
                if(reqType=="FriendRequest"){
                    replaceWith="CancelRequest";
                    replaceValueWith = "Cancel Request";

                    addFriendButton.tooltipster('update','Your Friend request<br/>is sent to the user.');
                    addFriendButton.tooltipster('show');
                } else if(reqType=="CancelRequest") {
                    replaceWith="FriendRequest";
                    replaceValueWith = "(+) Add as Friend";

                    addFriendButton.tooltipster('update','Your Friend request<br/>is removed.');
                    addFriendButton.tooltipster('show');
                } else{
                    replaceWith="FriendRequest";
                    replaceValueWith = "(+) Add as Friend";
                }

                button.id=replaceWith;
                button.onclick = function(){friendRequest(replaceWith,userId)};
                button.innerHTML = replaceValueWith;
            }
            else{
                $('.followButton').tooltipster('update','An Error Occurred. Check<br/>if You are Logged In.');
                $('.followButton').tooltipster('show');
            }
        }
    };
}

/*----------/Friend or Unfriend Reuest---------------*/

/*-----------Share Book---------------*/
function shareBook(){

    var shareRes;
    var shareResJson;
    var shareReq;

    var bookConditionMenu = document.getElementById('book-condition');
    var selectedCondition = bookConditionMenu.options[bookConditionMenu.selectedIndex].value;

    var bookSharingPrice = document.getElementsByName("sharingPrice")[0].value;
    var bookMrp = document.getElementsByName("bookMrp")[0].value;

    $('.tooltip').tooltipster({
        animation: 'fade',
        timer:2000,
        trigger:'custom',
        content:''/*,
        functionAfter:function (origin){
            $.lightbox().close();
        } */
    });

    if(bookSharingPrice==null || bookSharingPrice==""
        || document.getElementsByName("userAddress")[0].value==null
        || document.getElementsByName("userAddress")[0].value==""
        || document.getElementsByName("userPostalCode")[0].value==null
        || document.getElementsByName("userPostalCode")[0].value==""
        || document.getElementsByName("conditionDescription")[0].value==null
        || document.getElementsByName("conditionDescription")[0].value=="") {

        $('.tooltip').tooltipster('update','All fields are mandatory.');
        $('.tooltip').tooltipster('show');
        return;
    }

    if(parseInt(bookSharingPrice)>parseInt(bookMrp)) {
        $('.tooltip').tooltipster('update','Points must be less than or<br/>equal to  MRP.');
        $('.tooltip').tooltipster('show');
        return;
    }

    if(document.getElementsByName("userPostalCode")[0].value.length!=6) {
        $('.tooltip').tooltipster('update','Postal code is<br/>not valid.');
        $('.tooltip').tooltipster('show');
        return;
    }

    var shareUrl="/share/ShareBook.action?conditionDescription="+document.getElementsByName("conditionDescription")[0].value+
        "&conditionRating="+selectedCondition+
        "&bookId="+document.getElementsByName("bookId")[0].value+
        "&sharingPrice="+document.getElementsByName("sharingPrice")[0].value+
        "&userAddress="+document.getElementsByName("userAddress")[0].value+
        "&userPostalCode="+document.getElementsByName("userPostalCode")[0].value;

    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        shareReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        shareReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    shareReq.onreadystatechange = function () {
        if (shareReq.readyState == 4 && shareReq.status == 200) {

            shareRes=shareReq.response;
            shareResJson = JSON && JSON.parse(shareRes) || $.parseJSON(shareRes);
            if(shareResJson.result=="success"){
                $('.tooltip').tooltipster('update','Book shared successfully.');
                $('.tooltip').tooltipster('show');
            } else if(shareResJson.result=="shared") {
                $('.tooltip').tooltipster('update','You have already shared<br/>the same book.');
                $('.tooltip').tooltipster('show');
            } else if(shareResJson.result=="inCart") {
                $('.tooltip').tooltipster('update','You can\'t share the Book<br/>which is in your Cart.');
                $('.tooltip').tooltipster('show');
            } else {
                $('.tooltip').tooltipster('update','Error Occurred.<br/>Check If you are Logged In.');
                $('.tooltip').tooltipster('show');
            }
        }
    };

    shareReq.open('POST',shareUrl,true);
    shareReq.send();

}
/*-----------/Share Book---------------*/

/*-----------Unshare Book---------------*/
function unshareBook(lendId, buttonId){

    var unshareRes;
    var unshareResJson;
    var unshareReq;

    $(buttonId).tooltipster({
        animation: 'fade',
        timer:2000,
        trigger:'custom',
        content:'',
         functionAfter:function (origin){
            location.reload();
         }
    });

    var unshareUrl="/share/UnshareBook.action?lendId="+lendId;

    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        unshareReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        unshareReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    unshareReq.onreadystatechange = function () {
        if (unshareReq.readyState == 4 && unshareReq.status == 200) {

            unshareRes=unshareReq.response;
            unshareResJson = JSON && JSON.parse(unshareRes) || $.parseJSON(unshareRes);
            if(unshareResJson.result=="success"){
                location.reload();
            } else if(unshareResJson.result=="notShared") {
                $(buttonId).tooltipster('update','It seems you have already<br/>unshared the book or it is sold.');
                $(buttonId).tooltipster('show');
            } else {
                $(buttonId).tooltipster('update','Error Occurred.<br/>Check If you are Logged In.');
                $(buttonId).tooltipster('show');
            }
        }
    };

    unshareReq.open('POST',unshareUrl,true);
    unshareReq.send();

}
/*-----------/Unshare Book---------------*/

/*----------Rate Book--------------*/

function rateBook(score,bookId,buttonId) {
    var rateReq;
    var rateResJson;
    var rateRes;
    var rateUrl="/book/RateBook.action?bookId="+bookId+"&rating="+score;

    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        rateReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        rateReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    rateReq.onreadystatechange = function () {
        if (rateReq.readyState == 4 && rateReq.status == 200) {
            rateRes=rateReq.response;
            rateResJson = JSON && JSON.parse(rateRes) || $.parseJSON(rateRes);

            if(rateResJson.result=="success"){
                //Do Nothing.
            } else {
                $(buttonId).tooltipster('update','An Error Occurred. Check If<br/>you are Logged In.');
                $(buttonId).tooltipster('show');
            }
        }
    };

    rateReq.open('POST',rateUrl,true);
    rateReq.send();
}

/*----------/Rate Book--------------*/


/*----------Add To Cart--------------*/

function addBookToCart(lendId,buttonId){
    var addToCartReq;
    var addToCartResJson;
    var addToCartRes;
    var addToCartUrl="/cart/AddToCart.action?lendId="+lendId;

    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        addToCartReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        addToCartReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    addToCartReq.onreadystatechange = function () {
        if (addToCartReq.readyState == 4 && addToCartReq.status == 200) {
            addToCartRes=addToCartReq.response;
            addToCartResJson = JSON && JSON.parse(addToCartRes) || $.parseJSON(addToCartRes);
            $(buttonId).tooltipster({
                animation: 'fade',
                timer:2000,
                trigger:'custom',
                content:''
            });
            if(addToCartResJson.result=="inCart"){
                $(buttonId).tooltipster('update','Book is already in<br/>your Shopping Cart.');
                $(buttonId).tooltipster('show');
            }
            else if(addToCartResJson.result=="shared"){
                $(buttonId).tooltipster('update','You cant buy the Book,<br/>which you have shared.');
                $(buttonId).tooltipster('show');
            }
            else if(addToCartResJson.result=="success"){
                $(buttonId).tooltipster('update','Book is added to<br/>cart successfully.');
                $(buttonId).tooltipster('show');
//                alert("Success");
            } else {
//                alert("ERROR....!!!!!!");
                $(buttonId).tooltipster('update','An Error Occurred. Check<br/>if You are Logged In.');
                $(buttonId).tooltipster('show');
            }
        }
    };

    addToCartReq.open('POST',addToCartUrl,true);
    addToCartReq.send();
}

/*----------/Add To Cart--------------*/

/*----------Add To WishList--------------*/

function addBookToWishList(bookId, buttonId){
    var addToWishListReq;
    var addToWishListResJson;
    var addToWishListRes;
    var addToWishListUrl="/shelf/AddToWishList.action?bookId="+bookId;

    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        addToWishListReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        addToWishListReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    addToWishListReq.onreadystatechange = function () {
        if (addToWishListReq.readyState == 4 && addToWishListReq.status == 200) {
            addToWishListRes=addToWishListReq.response;
            addToWishListResJson = JSON && JSON.parse(addToWishListRes) || $.parseJSON(addToWishListRes);
            $(buttonId).tooltipster({
                animation: 'fade',
                timer:2000,
                trigger:'custom',
                content:''
            });

            if(addToWishListResJson.result=="success"){
                $(buttonId).tooltipster('update','Book is added to<br/>your WishList successfully.');
                $(buttonId).tooltipster('show');
//                alert("Success");
            } else {
//                alert("ERROR....!!!!!!");
                $(buttonId).tooltipster('update','An Error Occurred.<br/> Check if you are Logged In.');
                $(buttonId).tooltipster('show');
            }
        }
    };

    addToWishListReq.open('POST',addToWishListUrl,true);
    addToWishListReq.send();
}

/*----------/Add To WishList--------------*/

/*----------Add To Cart--------------*/

function requestBook(bookId,buttonId){
    var reqBookReq;
    var reqBookResJson;
    var reqBookRes;
    var reqBookUrl="/book/RequestBook.action?bookId="+bookId;

    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        reqBookReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        reqBookReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    reqBookReq.onreadystatechange = function () {
        if (reqBookReq.readyState == 4 && reqBookReq.status == 200) {
            reqBookRes=reqBookReq.response;
            reqBookResJson = JSON && JSON.parse(reqBookRes) || $.parseJSON(reqBookRes);
            $(buttonId).tooltipster({
                animation: 'fade',
                timer:2000,
                trigger:'custom',
                content:''
            });

            if(reqBookResJson.result=="success"){
                $(buttonId).tooltipster('update','You will be notified as soon<br/>as the book will be available');
                $(buttonId).tooltipster('show');
//                alert("Success");
            } else if(reqBookResJson.result=="requested") {
                $(buttonId).tooltipster('update','You have already<br/>requested the book.');
                $(buttonId).tooltipster('show');
            } else if(reqBookResJson.result=="shared") {
                $(buttonId).tooltipster('update','You can\'t request the<br/>book which you have shared.');
                $(buttonId).tooltipster('show');
            } else if(reqBookResJson.result=="inCart") {
                $(buttonId).tooltipster('update','You have already added<br/>this book in your Cart.');
                $(buttonId).tooltipster('show');
            } else {
                $(buttonId).tooltipster('update','An Error occurred. Check<br/>if you are Logged In');
                $(buttonId).tooltipster('show');
            }
        }
    };

    reqBookReq.open('POST',reqBookUrl,true);
    reqBookReq.send();
}

/*----------/Add To Cart--------------*/

/*--------Set User Reputation---------*/
function setUserReputation(lendId, menuId) {
    var userReputationReq;
    var userReputationResJson;
    var userReputationRes;

    var menu = $(menuId);

    var userReputationUrl="/user/SetUserReputation.action?lendId="+lendId+"&reputation="+menu.val();

    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        userReputationReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        userReputationReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    userReputationReq.onreadystatechange = function () {
        if (userReputationReq.readyState == 4 && userReputationReq.status == 200) {
            userReputationRes=userReputationReq.response;
            userReputationResJson = JSON && JSON.parse(userReputationRes) || $.parseJSON(userReputationRes);
            menu.tooltipster({
                animation: 'fade',
                timer:2000,
                trigger:'custom',
                position:'right',
                content:''
            });

            if(userReputationResJson.result=="success"){
                menu.tooltipster('update','Changes saved.');
                menu.tooltipster('show');
            } else {
                menu.tooltipster('update','An Error occurred. Check<br/>if you are Logged In');
                menu.tooltipster('show');
            }
        }
    };

    userReputationReq.open('POST',userReputationUrl,true);
    userReputationReq.send();
}
/*--------/Set User Reputation---------*/

/*--------Change Sort Search Results---------*/
function changeSortBy(excludeOutOfStock, maxResults, filterGenre, filterLanguage, filterPriceRange, searchQuery) {
    var sortMenu = $("#selectPrductSort");
    document.location.href = "http://localhost:8080/search/LoadSearchResults.action?newRequest=true&excludeOutOfStock="+excludeOutOfStock+"&pageNo=0&maxResults="+maxResults+"&sortBy="+sortMenu.val()+"&filterGenre="+filterGenre+"&filterLanguage="+filterLanguage+"&filterPriceRange="+filterPriceRange+"&searchQuery="+searchQuery;
}
/*--------/Change Sort Search Results---------*/

/*-----------Add Book---------------*/
function addBookToSystem(){

    var addBookBtn = $('#add-book-btn');

    addBookBtn.tooltipster({
        animation: 'fade',
        timer:2000,
        trigger:'custom',
        content:''
    });

    if(document.getElementById("add-book-title").value==null || document.getElementById("add-book-title").value=="") {
        addBookBtn.tooltipster('update','Book Title can\'t<br/>be empty.');
        addBookBtn.tooltipster('show');
        return;
    }

    var isbn = document.getElementById("add-book-isbn").value;
    if(isbn==null || isbn=="") {
        addBookBtn.tooltipster('update','ISBN can\'t be empty.');
        addBookBtn.tooltipster('show');
        return;
    }

    if(isbn.length!=10 && isbn.length!=13) {
        addBookBtn.tooltipster('update','ISBN must be of<br/>10 or 13 digits.');
        addBookBtn.tooltipster('show');
        return;
    }

    var publishingYear = document.getElementById("add-book-year").value;
    if(publishingYear==null || publishingYear=="") {
        addBookBtn.tooltipster('update','Publishing Year can\'t<br/>be empty.');
        addBookBtn.tooltipster('show');
        return;
    }
    if(publishingYear.length!=4) {
        addBookBtn.tooltipster('update','Publishing Year must<br/>be of 4 digits.');
        addBookBtn.tooltipster('show');
        return;
    }

    var bookMrp = document.getElementById('add-book-mrp').value;
    if(bookMrp==null || bookMrp=="") {
        addBookBtn.tooltipster('update','Book MRP can\'t<br/>be empty.');
        addBookBtn.tooltipster('show');
        return;
    }
    if(bookMrp.length>4) {
        addBookBtn.tooltipster('update','Book MRP must<br/>be valid.');
        addBookBtn.tooltipster('show');
        return;
    }

    document.getElementById('add-book-form').submit();

}
/*-----------/Add Book---------------*/


/*-----------Send Message - Contact Us---------------*/

function sendMessage() {
    var sendMessageReq;
    var sendMessageResJson;
    var sendMessageRes;

    var sendBtn = $('#send-mail');

    sendBtn.tooltipster({
        animation: 'fade',
        timer:2000,
        trigger:'custom',
        content:''
    });

    var contactName = document.getElementById("contact-name");
    var contactEmail = document.getElementById("contact-email");
    var contactSubject = document.getElementById("contact-subject");
    var contactMessage = document.getElementById("contact-message");

    if(contactName==null || contactName.value==""
        || contactEmail==null || contactEmail.value==""
        || contactSubject==null || contactSubject.value==""
        || contactMessage==null || contactMessage.value==""
        ) {
        sendBtn.tooltipster('update','All fields are mandatory.');
        sendBtn.tooltipster('show');
        return;
    }

    if(!validateEmail(contactEmail.value)) {
        sendBtn.tooltipster('update','E-Mail Address is not valid.');
        sendBtn.tooltipster('show');
        return;
    }

    var sendMessageUrl="/SendMessage.action?contactName="+contactName.value
        +"&contactEmail="+contactEmail.value
        +"&contactSubject="+contactSubject.value
        +"&contactMessage="+contactMessage.value;

    if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
        sendMessageReq = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
        sendMessageReq = new ActiveXObject("Microsoft.XMLHTTP");
    }

    sendMessageReq.onreadystatechange = function () {
        if (sendMessageReq.readyState == 4 && sendMessageReq.status == 200) {
            sendMessageRes=sendMessageReq.response;
            sendMessageResJson = JSON && JSON.parse(sendMessageRes) || $.parseJSON(sendMessageRes);

            if(sendMessageResJson.result=="success"){
                sendBtn.tooltipster('update','Mail sent.');
                sendBtn.tooltipster('show');

                //setting all values to blank
                contactName.value="";
                contactEmail.value="";
                contactSubject.value="";
                contactMessage.value="";
            } else {
                sendBtn.tooltipster('update','An Error occurred.<br/>Please, Try again later.');
                sendBtn.tooltipster('show');
            }
        }
    };

    sendMessageReq.open('POST',sendMessageUrl,true);
    sendMessageReq.send();
}

function validateEmail(elementValue){
    var emailPattern = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return emailPattern.test(elementValue);
}
/*-----------/Send Message - Contact Us---------------*/

/*-----------Upload Image Methods---------------*/
function openFileBrowser() {
    var evt = document.createEvent("MouseEvents");
    evt.initEvent("click", true, false);
    document.getElementById('upload-profile-pic').dispatchEvent(evt);
}

var uploadedImage;
var lightBoxNotOpened=true;//to prevent image from opening twice in lightbox

function checkUploadedFile() {
    var fileElement = document.getElementById("upload-profile-pic");
    var fileExtension = "";
    if (fileElement.value.lastIndexOf(".") > 0) {
        fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
    }
    if (fileExtension == "jpg" || fileExtension == "JPG" || fileExtension == "jpeg") {

//        var formData = new FormData();

        //formData.append('uploadedImage', uploadedImage);

        var imageReader = new FileReader();
        imageReader.onload = function(e) {

            $("#uploaded-image").attr("src", e.target.result);
            $("#crop-profile-pic")[0].click();

        };
        imageReader.readAsDataURL(fileElement.files[0]);

        /*$.ajax({
            url:'user/UploadProfilePicture.action',
            type:"POST",
            data: formData,
            processData: false,
            cache:false,
            contentType : false,
            success:function(res) {
                alert(res.result);
            },
            error:function() {
                alert("Error");
            }
        }); */

        return false;
    }
    else {
        return false;
    }
}

/*-----------/Upload Image Methods---------------*/