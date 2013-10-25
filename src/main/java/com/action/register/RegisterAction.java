package com.action.register;

import com.EmailService;
import com.EncryptWithMd5;
import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.LoginInfo;
import com.pojo.hibernate.UserInfo;
import com.service.UserService;
import com.service.login.UserLoginService;
import nl.captcha.Captcha;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Date;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/16/13
 * Time: 4:05 PM
 * To change this template use File | Settings | File Templates.
 */
public class RegisterAction extends ActionSupport /*implements SessionAware*/{

    private String firstName;
    private String lastName;
    private String emailId;
    private String password;
//    private String answer;
    private String contactNo;
    private String activationToken;
    private Long time;
    //private SessionMap sessionMap; //for captcha

    private UserLoginService userLoginService;
    private UserService userService;

    private String result;
    private String resultHeader;
    private String resultMessage;

    private final String prefixActivationToken="E-Mail ID : ";

    private EncryptWithMd5 encryptWithMd5 = new EncryptWithMd5();
    private EmailService emailService;

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    /*public void setSession(Map<String, Object> stringObjectMap) {
        this.sessionMap=(SessionMap)stringObjectMap;
    }                       */

    public void setActivationToken(String activationToken) {
        this.activationToken = activationToken;
    }

    public void setTime(Long time) {
        this.time = time;
    }

    public void setUserLoginService(UserLoginService userLoginService) {
        this.userLoginService = userLoginService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setEmailService(EmailService emailService) {
        this.emailService = emailService;
    }

    public String getResult() {
        return result;
    }

    public String getResultHeader() {
        return resultHeader;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public String register(){
        /*Verifying captcha*/
//        Captcha captcha = (Captcha) sessionMap.get(Captcha.NAME);
        //request.setCharacterEncoding("UTF-8"); // Do this so we can capture non-Latin chars

        //if logged in then return error
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
            return ERROR;
        }

//        if (captcha.isCorrect(answer)) {

            if(emailId==null || emailId.equals("") || password==null || password.equals("") || contactNo==null || contactNo==""){
                return ERROR;
            }

            //check if email id exists
            if(userService.getUserById(emailId)!=null) {
                resultHeader = "Email ID already exists";
                resultMessage = "The Email-ID you provided already exists in our database. " +
                        "\nIf you have forgot the password, you can get it by clicking the link \"Forgot your Password\" in the top panel. " +
                        "\nAnd, check if you have activated your account or not. " +
                        "( At the time of registration we had sent you a mail with activation link, click on it to activate your account. If you can't find the mail check it in Spam\\Junk folder.)";
                return SUCCESS;
            }

            //check if contact no. exists
            if(userService.isContactNoExists(contactNo)) {
                resultHeader = "Contact No. already exists";
                resultMessage = "The Contact No. you provided already exists in our database. " +
                        "\nRegister with a different number. " +
                        "\nWe request you to not make fake/multiple accounts, so other users can also get the benefits.";
                return SUCCESS;
            }

            //Encrypt Password
            String encryptedPassword = encryptWithMd5.encrypt(password);

            LoginInfo loginInfo = new LoginInfo();
            loginInfo.setEmailId(emailId);
            loginInfo.setPassword(encryptedPassword);
            loginInfo.setRole(2);
            loginInfo.setActive(true);
            userLoginService.saveLoginInfo(loginInfo);

            UserInfo userInfo = new UserInfo();
            userInfo.setFirstName(firstName);
            userInfo.setLastName(lastName);
            userInfo.setLoginInfoByEmailId(loginInfo);
            userInfo.setEmailVerified(false);
            userInfo.setUserBalance(0);
        userInfo.setUserContact(contactNo);
            userService.saveUserInfo(userInfo);

            //sending verify link via email
            activationToken = encryptWithMd5.encrypt(prefixActivationToken+loginInfo.getEmailId());
            String toName = userInfo.getFirstName()+" "+userInfo.getLastName();
            String message = "<a href='http://localhost:8080/register/ActivateAccount.action?emailId="+loginInfo.getEmailId()+"&activationToken="+activationToken+"'>Click Here</a> to activate your Readers' Hive Account." +
                    "<br/>If you can't click on the above link, copy and paste below link in your browser to activate account :" +
                    "<br/>http://localhost:8080/register/ActivateAccount.action?emailId="+loginInfo.getEmailId()+"&activationToken="+activationToken;
            emailService.sendEmail("ashishtanna.03@gmail.com","Activate your Readers' Hive account", message, toName, loginInfo.getEmailId());

            resultHeader = "Registration Successful";
            resultMessage = "Congratulations, you have registered successfully. " +
                    "\nWe have sent you a mail with activation link. Check your E-Mail account & click on the link to activate your account. " +
                    "(If you can\'t find the mail in your Inbox, check you Spam/Junk folder. If it is there, then move it to your Inbox, to get future e-mails in your Inbox directly.) " +
                    "\nYou must activate your account to complete your registration." +
                    "\n(This is mandatory to prevent hackers/bots from creating multiple fake accounts.) ";
            return SUCCESS;
        /*}
        else {
            resultHeader = "Captcha Incorrect";
            resultMessage = "The captcha you entered was wrong." +
                    "Try again to register. You can register using the form in the top panel.";
            return SUCCESS;
        }*/
    }

    public String activateAccount(){

        //if logged in then return error
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
            return ERROR;
        }

        String encryptedEmail = encryptWithMd5.encrypt(prefixActivationToken+emailId);
        if (encryptedEmail.equals(activationToken)){
            UserInfo user = userService.getUserById(emailId);
            if(user.getEmailVerified()) {
                resultHeader = "Your account is activated already";
                resultMessage = "The account, associated with this e-mail id \""+emailId+"\", is already active.";
                return SUCCESS;
            } else {
                user.setEmailVerified(true);
                user.setUserBalance(150);

                resultHeader = "Account Activated";
                resultMessage = "Congratulations, your account is now activated." +
                        "\nNow login to share your old books & buy your favourite books on Readers' Hive." +
                        "\nYou have also got 150 points as a joining Bonus. Have fun. :)";
                return SUCCESS;
            }
        }
        else {
            return ERROR;
        }
    }

    public String resendActivationMail() {

        //if logged in then return error
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
            return ERROR;
        }

        if (emailId!=null && !emailId.equals("")) {
            //check if email id exists
            UserInfo user = userService.getUserById(emailId);
            if(user==null) {
                resultHeader = "Email ID doesn't exist";
                resultMessage = "The Email-ID you provided,"+emailId+" ,doesn't exist in our database. " +
                        "\nThat means you haven't registered yet, try to register using the form in top panel. " +
                        "\nIt's possible that when you have tried to register using this e-mail id last time, some error could have occurred , so please try again to register. " +
                        "\nIf you entered wrong e-mail id by mistake, try again : <a id=\\\"resend-mail-btn\\\" href=\\\"/lightbox-pages/resend-activation-mail.jsp?lightbox[width]=180&lightbox[height]=100\\\">Click Here</a> to get Activation Mail.\" +\n" +
                        "\"<script type=\\\"text/javascript\\\">\" +\n" +
                        "\"$(document).ready(function(){ \" +\n" +
                        "\"$('#resend-mail-btn').lightbox();\" +\n" +
                        "\"});</script>\"";
                return SUCCESS;
            } else if(user.getEmailVerified()) {
                resultHeader = "Your account is activated already";
                resultMessage = "The account, associated with e-mail id you gave \""+emailId+"\", is already active." +
                        "\nTry to login again.";
                return SUCCESS;
            } else {

                //sending verify link via email
                activationToken = encryptWithMd5.encrypt(prefixActivationToken+emailId);
                String toName = user.getFirstName()+" "+user.getLastName();
                String message = "<a href='http://localhost:8080/register/ActivateAccount.action?emailId="+emailId+"&activationToken="+activationToken+"'>Click Here</a> to activate your Readers' Hive Account." +
                        "<br/>If you can't click on the above link, copy and paste below link in your browser to activate account :" +
                        "<br/>http://localhost:8080/register/ActivateAccount.action?emailId="+emailId+"&activationToken="+activationToken;
                emailService.sendEmail("ashishtanna.03@gmail.com","Activate your Readers' Hive account", message, toName, emailId);

                resultHeader = "Verify your E-Mail Address";
                resultMessage = "We have sent the activation mail again on E-Mail address : "+emailId +
                        "\nCheck your Inbox, and click on the link given in the mail." +
                        "\nIf you can't see the mail in Inbox, check in your Spam/Junk folder, if it is there move it to your inbox to receive our future mails in your inbox directly." +
                        "\nIf you still can't login to your account, <a href=\"/contact.jsp\">Contact us</a>";
                return SUCCESS;
            }
        } else
            return ERROR;
    }

    public String resetPasswordMail() {

        //if logged in then return error
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
            return ERROR;
        }

        if (emailId!=null && !emailId.equals("")) {
            //check if email id exists
            UserInfo user = userService.getUserById(emailId);
            if(user==null) {
                resultHeader = "Email ID doesn't exist";
                resultMessage = "The Email-ID you provided,"+emailId+" ,doesn't exist in our database. " +
                        "\nThat means you haven't registered yet, try to register using the form in top panel. " +
                        "\nIt's possible that when you have tried to register using this e-mail id last time, some error could have occurred , so please try again to register. " +
                        "\nIf you entered wrong e-mail id by mistake, try again : <a onclick=\"openResetLightbox();\" >Click Here</a> to reset password.\" +\n" +
                        "\"<script type=\\\"text/javascript\\\">\" +\n" +
                        "\"function openResetLightbox(){ \" +\n" +
                        "\" $('#reset-password-btn').lightbox();\" +\n" +
                        "\"}</script>\"";
                return SUCCESS;
            } else {
                //sending reset password link via email
                Date currentTime = new Date();
                activationToken = encryptWithMd5.encrypt(prefixActivationToken+emailId+currentTime.getTime());
                String toName = user.getFirstName()+" "+user.getLastName();
                String message = "<a href='http://localhost:8080/ResetPasswordPage.action?emailId="+emailId+"&time="+currentTime.getTime()+"&activationToken="+activationToken+"'>Click Here</a> to reset password of your Readers' Hive Account." +
                        "<br/>If you can't click on the above link, copy and paste below link in your browser to reset password of your account :" +
                        "<br/>http://localhost:8080/ResetPasswordPage.action?emailId="+emailId+"&time="+currentTime.getTime()+"&activationToken="+activationToken+
                        "<br/><br/>NOTE : The link will not work after 24 Hours.";
                emailService.sendEmail("miteshthakkar99@gmail.com","Reset Password of your Readers' Hive account", message, toName, emailId);

                resultHeader = "Check your E-Mail Account";
                resultMessage = "We have sent the reset password mail on your E-Mail address ( "+emailId +" )."+
                        "\nCheck your Inbox, and click on the link given in the mail to reset password." +
                        "\nIf you can't see the mail in Inbox, check in your Spam/Junk folder, if it is there move it to your inbox to receive our future mails in your inbox directly.";
                return SUCCESS;
            }
        } else
            return ERROR;
    }

    public String verifyResetPasswordLink() {
        if (emailId!=null && !emailId.equals("") && time!=null && activationToken!=null && !activationToken.equals("")) {

            Date currentTime = new Date();
            if(activationToken.equals(encryptWithMd5.encrypt(prefixActivationToken+emailId+time))) {
                if (currentTime.getTime()-time<86400000) { //check if link is not more than 24 hours old 24(h)*60(min)*60(sec)*1000(milis)=86400000
                    resultHeader = "Reset Password";
                    resultMessage = "Type your new password below :"+
                            "\n<br/><br/><form action='/ResetPassword.action' id=\"reset-password-form\" method='post'>" +
                            "<label for=\"reset-password\"><b>New Password :</b></label>&nbsp;" +
                            "<input type=\"password\" id=\"reset-password\" name=\"newPassword\" />" +
                            "<input type=\"hidden\" name=\"emailId\" value=\""+emailId+"\" />" +
                            "</form>" +
                            "<br/><label for=\"retype-password\"><b>Retype New Password :</b></label>&nbsp;" +
                            "<input type=\"password\" id=\"retype-password\" />" +
                            "<br/><a href\"javascript:{}\" class=\"button2\" onclick=\"resetPassword();\">Reset Password</a>" +
                            "\n";
                } else {
                    resultHeader = "Link is expired";
                    resultMessage = "The link which you tried is expired." +
                            "\nTry again to reset password."+
                            "\nYou have to click on the link within 24 hours or the link will not work." +
                            "\nIf you still have problem , <a href=\"/contact.jsp\">Contact us</a>";
                }
            } else {
                resultHeader = "Link is modified/broken";
                resultMessage = "The link which you tried is modified/broken."+
                        "\nRecheck your link or try again to reset password." +
                        "\nIf you still have problem , <a href=\"/contact.jsp\">Contact us</a>";
            }

            return SUCCESS;
        } else {
            return ERROR;
        }
    }

}
