<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <link href="/css/global.css" rel="stylesheet" type="text/css" media="all" />

    <title>Contact Verification</title>
    <style>
        #signup-form h1{font-size:1.4em;font-weight:bold;padding-bottom:15px;margin-left:-15px;}
        div#signup-form{padding:20px;}
        #signupform h3{font-size:1.2em;margin-bottom:5px;width:auto;float:left;font-weight:bold;margin-top:3px;}
        #signupform .price-txt{background:#EDEDED;border-radius: 4px 4px 4px 4px;padding: 3px 5px;margin:0px 4px 4px 4px;}
    </style>

    <script type="text/javascript">
        var firstCount = true, timeOver= false;
        var verifyButton, intervalId;

        var Timer, timerIntervalId;
        var TotalSeconds=120;

        function verifyMissCall(clickedOnButton) {

            if(firstCount) {
                firstCount=false;
                verifyButton = $("#verify-button");
                verifyButton.tooltipster({content:'',timer:2000,trigger:'custom',position:'top'});
            } else if(timeOver) {
                return;
            }

            var callVerifyReq;
            var callVerifyRes;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                callVerifyReq = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                callVerifyReq = new ActiveXObject("Microsoft.XMLHTTP");
            }

            callVerifyReq.onreadystatechange = function () {
                if (callVerifyReq.readyState == 4 && callVerifyReq.status==200) {

                    callVerifyRes=eval(''+callVerifyReq.response);
                    if(callVerifyRes.VerificationStatus=="VERIFIED") {
                        if(callVerifyRes.NumberType!="Mobile") {
                            verifyButton.tooltipster('update','Only Mobile<br/>numbers are allowed.<br/>Try again registering<br/>with mobile number.'); verifyButton.tooltipster('show');
                        } else if(callVerifyRes.VerifiedMobileNumber=="<%=request.getParameter("contactNo")%>") {
                            document.getElementById('register-form').submit();
                        }
                    } else if(clickedOnButton){
                        window.clearInterval(intervalId);
                        intervalId = window.setInterval(function() { verifyMissCall(false) }, 5000);
                        verifyButton.tooltipster('update','We haven\'t received<br/>your Misscall yet.'); verifyButton.tooltipster('show');
                    }
                }
            };

            var callVerifyUrl = "http://jusdias.com/readershive/dial2verify_misscall_verify.php?sessionId=<%=request.getParameter("sessionId")%>";

            callVerifyReq.open('GET', callVerifyUrl, true);
            callVerifyReq.send();
        }

        $(document).ready(function() {
            Timer = document.getElementById("timer");
            timerIntervalId = window.setInterval(function() { UpdateTimer() }, 1200);
        });

        function UpdateTimer() {
            TotalSeconds = TotalSeconds-0.5;
            if(TotalSeconds%5==0) {
                verifyMissCall(false);
            }
            if(TotalSeconds<=0) {
                timeOver=true;
                window.clearInterval(timerIntervalId);
                $.lightbox().close();
            }
            Timer.innerHTML = Math.floor(TotalSeconds);
        }

    </script>

</head>
<body style="margin-left:25px;margin-top:25px;">

<div id="signup-form">
    <h1 style="text-align: center;">Contact No. Verification</h1>
    <form id="register-form" action="<%=request.getParameter("action")%>" method="post">

        <p>
            Please give a Miss Call from <b>"<%=request.getParameter("contactNo")%>"</b> to the number displayed below to continue :
        </p>
        <br/>
        <h1 style="text-align: center;"><%=request.getParameter("verificationNode")%></h1>
        <br/>

        <a href="javascript:{}" id="verify-button" class="button2" style="width: 60px;margin-left: 93px;" onclick="verifyMissCall(true);">Verify</a>
        <br/><br/><br/>
        <p>After <b id="timer">120</b> seconds, this box will be closed.</p><br/>
        <p>Note : You won't be charged for the call. Call will be disconnected after 2-3 rings. After the call disconnects, click on the "Verify" to continue.</p>

        <%
            if(request.getParameter("firstName")!=null) {
        %>
        <input type="hidden" name="firstName" value="<%=request.getParameter("firstName")%>"/>
        <%
            }
            if(request.getParameter("lastName")!=null) {
        %>
        <input type="hidden" name="lastName" value="<%=request.getParameter("lastName")%>"/>
        <%
            }
            if(request.getParameter("emailId")!=null) {
        %>
        <input type="hidden" name="emailId" value="<%=request.getParameter("emailId")%>"/>
        <%
            }
            if(request.getParameter("password")!=null) {
        %>
        <input type="hidden" name="password" value="<%=request.getParameter("password")%>"/>
        <%
            }
        %>
        <input type="hidden" name="contactNo" value="<%=request.getParameter("contactNo")%>"/>

    </form>

</div>
</body>
</html>