var res;
var resJson;
var req;
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
    document.getElementById('loading-login').style.display="block";
    document.getElementById('before-login').style.display="none";
    document.getElementById('after-login').style.display="none";
    $("div#panel").slideDown("slow");
    req.open('POST','/j_spring_security_check?j_username='+document.getElementById('j_username').value+'&j_password='+document.getElementById('j_password').value,true);
    req.send();
}

function sendInnerLogInInfo(){

    document.getElementById('loading-login').style.display="block";
    document.getElementById('before-login').style.display="none";
    document.getElementById('after-login').style.display="none";
    req.open('POST','/j_spring_security_check?j_username='+document.getElementById('inner_username').value+'&j_password='+document.getElementById('inner_password').value,true);
    req.send();
}

function ajaxLogInRequest(resJson){
    if(resJson.result=="error"){
        document.getElementById('error-message').style.display="block";
        document.getElementById('before-login').style.display="block";
        document.getElementById('after-login').style.display="none";
    }
    else{
        $("#loading-login").hide();
        $("#error-message").hide();
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
        notificationList.innerHTML = "";
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
                    case 0 : notificationList.innerHTML+="<li><img src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> wants to be your Friend.<br/>Accept Request? <a href='/user/AcceptRequest.action?userId="+notificationListJson[i].userId+"' target='_blank'>Yes</a></li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 1 : notificationList.innerHTML+="<li><img src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> has accepted your Friend Request.</li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 2 : notificationList.innerHTML+="<li><img src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> has recommended<br/><a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a> by "+authorList+" to you.</li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 3 : notificationList.innerHTML+="<li><img src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> has requested<br/><a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a> by "+authorList+".<br/>Want to Share? <a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].bookId+"'>Yes</a></li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 4 : notificationList.innerHTML+="<li><img src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> has shared<br/><a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a> by "+authorList+".<br/>Want to Buy? <a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].bookId+"'>Yes</a></li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 5 : notificationList.innerHTML+="<li><img src='"+objectImg+"'/><a href='/user/UserProfile.action?userId="+notificationListJson[i].userId+"'>"+notificationListJson[i].userName+"</a> has bought the<br/><a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a> by "+authorList+" which you had shared.</li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                    case 6 :
                        if(notificationListJson[i].objectImg==null){objectImg="/images/no-book-cover.jpg";}else{objectImg=notificationListJson[i].objectImg;}
                        notificationList.innerHTML+="<li><img src='"+objectImg+"'/>The book <a href='/book/GetBookInfo.action?bookId="+notificationListJson[i].objectId+"'>"+notificationListJson[i].bookTitle+"</a> by "+authorList+" which you requested is now available.</li><span>"+notificationListJson[i].date+"</span><hr/>";break;
                }
            }
        }
//        document.getElementById('notification-container').innerHTML = notificationList;

        /*For scrollbar*/

        $(function () {
            $('#notification-container').jScrollPane();
            $('#friends-activity-container').jScrollPane();
        });

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
    }
}
/*------------------End Login Requests------------------*/

/*----------Logout Request--------------*/
function sendLogOutRequest(){
    //req=new XMLHttpRequest();
    req.open('POST','/j_spring_security_logout');
    req.send();
    if(req.readyState==4){
        res=req.response;
        resJson = JSON && JSON.parse(res) || $.parseJSON(res);
        ajaxLogInRequest(resJson);
    }
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
    req.open('POST','/LoggedIn',true);
    req.send();
    // Expand Panel
    $("#open").click(function () {
        $("div#panel").slideDown("slow");
        $("#close").css("display", "block");
        $("#open").css("display", "none");
    });
}
/*---------------/LoggedIn Request--------------*/

/*----------------Register Request------------------*/
function sendRegisterInfo(){
    req.open('POST','/register/Register.action?answer='+document.getElementById('answer').value+
        '&firstName='+document.getElementById('fname').value+
        '&lastName='+document.getElementById('lname').value+
        '&emailId='+document.getElementById('email').value+
        '&password='+document.getElementById('regpwd').value,
        false);
    req.send();
    if(req.readyState==4){
        res=req.response;
        resJson = JSON && JSON.parse(res) || $.parseJSON(res);
        alert(resJson.result);
    }
}
/*---------------/Register Request-----------------*/

/*---------------editprof---------------*/

function saveProfileChanges(){
    var regEx = /^[A-z]+$/;
    var regEx1 = /^[0-9]+$/;
    var regEx2 = /((?:https?\:\/\/|www\.)(?:[-a-z0-9]+\.)*[-a-z0-9]+.*)/i;
    $('#fname').tooltipster({content:'',trigger:'custom',position:'right'});
    $('#lname').tooltipster({content:'',trigger:'custom',position:'right'});
    $('#postal-code').tooltipster({content:'',trigger:'custom',position:'right'});
    $('#contact-no').tooltipster({content:'',trigger:'custom',position:'right'});
    $('#web-blo').tooltipster({content:'',trigger:'custom',position:'right'});
    if(document.getElementById('fname').value==""){$('#fname').tooltipster('update','Please, Enter valid value.');$('#fname').tooltipster('show');return;}
    else if(!regEx.test(document.getElementById('fname').value)){$('#fname').tooltipster('update','Only characters allowed.');$('#fname').tooltipster('show');return;}
    if(document.getElementById('lname').value==""){$('#lname').tooltipster('update','Please, Enter valid value.');$('#lname').tooltipster('show');return;}
    else if(!regEx.test(document.getElementById('lname').value)){$('#lname').tooltipster('update','Only characters allowed.');$('#lname').tooltipster('show');return;}
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

    //getting selected gender value
    var genderButtons = document.getElementsByName("gender");
    var selectedGender;
    for (var i = 0; i < genderButtons.length; i++) {
        if (genderButtons[i].checked) {
            selectedGender = genderButtons[i].value;
        }
    }
    var cityMenu = document.getElementById("city-name");

    saveReq.open('POST','/editprofile/SaveProfileChanges.action?firstName='+document.getElementById('fname').value+
        '&lastName='+document.getElementById('lname').value+
        '&userCity='+cityMenu.options[cityMenu.selectedIndex].value+
        '&userBirthdate='+dojo.widget.byId('birth-date').getValue()+
        '&userGender='+selectedGender+
        '&userPostalCode='+document.getElementById('postal-code').value+
        '&userOccupation='+document.getElementById('occuname').value+
        '&userFavGenres='+document.getElementById('favgen').value+
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

    if(reqType=="notLoggedIn"){
        alert("Not Logged In");
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
                    replaceWith="UnfriendRequest";
                    replaceValueWith = "(-) Unfriend";
                    alert("success");
                }
                else{
                    replaceWith="FriendRequest";
                    replaceValueWith = "(+) Add as Friend";
                    alert("success");
                }

                button.id=replaceWith;
                button.onclick = function(){friendRequest(replaceWith,userId)};
                button.innerHTML = replaceValueWith;
            }
            else{
                alert("Error..!!");
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
        || document.getElementsByName("userContact")[0].value==null
        || document.getElementsByName("userContact")[0].value==""
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

    var shareUrl="/share/ShareBook.action?conditionDescription="+document.getElementsByName("conditionDescription")[0].value+
        "&conditionRating="+selectedCondition+
        "&bookId="+document.getElementsByName("bookId")[0].value+
        "&sharingPrice="+document.getElementsByName("sharingPrice")[0].value+
        "&userAddress="+document.getElementsByName("userAddress")[0].value+
        "&userContacte="+document.getElementsByName("userContact")[0].value;

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
            } else {
//                alert("ERROR....!!!!!!");
                $(buttonId).tooltipster('update','An Error Occurred.');
                $(buttonId).tooltipster('show');
            }
        }
    };

    reqBookReq.open('POST',reqBookUrl,true);
    reqBookReq.send();
}

/*----------/Add To Cart--------------*/