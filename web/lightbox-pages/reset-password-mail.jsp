<html>
<head>
    <link href="/css/global.css" rel="stylesheet" type="text/css" media="all" />

    <title>Reset Password</title>
    <style>
        #signupform h2{font-size:1.2em;margin-bottom:5px;}
    </style>
    <script type="text/javascript">
        function resetPasswordMail() {
            var emailId = $("#resetPwdEmail");
            emailId.tooltipster({content:'',timer:2000,trigger:'custom',position:'top'});
            if(emailId.val()==null || $.trim(emailId.val())=="") {
                emailId.tooltipster('update','E-Mail Address<br/>can\'t be empty.'); emailId.tooltipster('show'); return;
            } else if(!validateEmail(emailId.val())) {
                emailId.tooltipster('update','Please, Enter valid<br/>E-Mail Address.'); emailId.tooltipster('show'); return;
            }

            document.getElementById('reset-password-form').submit();
        }
    </script>
</head>
<body style="margin-left:25px;margin-top:25px;">

<div id="signup-form">
    <form id="reset-password-form" action="/ResetPasswordMail.action" method="post">
        <h2>
            Enter Your E-Mail ID :
        </h2>
        <input type="text" id="resetPwdEmail" name="emailId" /><br/><br/>
        <a href="javascript:{}" class="button2" onclick="resetPasswordMail();">Submit</a>
    </form>

</div>
</body>
</html>