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

import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/16/13
 * Time: 4:05 PM
 * To change this template use File | Settings | File Templates.
 */
public class RegisterAction extends ActionSupport implements SessionAware{

    private String firstName;
    private String lastName;
    private String emailId;
    private String password;
    private String answer;
    private String activationToken;
    private SessionMap sessionMap;

    private UserLoginService userLoginService;
    private UserService userService;

    private String result;

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

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public void setSession(Map<String, Object> stringObjectMap) {
        this.sessionMap=(SessionMap)stringObjectMap;
    }

    public void setActivationToken(String activationToken) {
        this.activationToken = activationToken;
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

    public String register(){
        /*Verifying captcha*/
        Captcha captcha = (Captcha) sessionMap.get(Captcha.NAME);
        System.out.println(answer);
        //request.setCharacterEncoding("UTF-8"); // Do this so we can capture non-Latin chars
        if (captcha.isCorrect(answer)) {
            System.out.println("Correct captcha");

            if(emailId==null || emailId.equals("") || password==null || password.equals("")){
                result="error";
                return SUCCESS;
            }

            //Encrypt Password
            String encryptedPassword = encryptWithMd5.encrypt(password);
            System.out.println(encryptedPassword);

            LoginInfo loginInfo = new LoginInfo();
            loginInfo.setEmailId(emailId);
            loginInfo.setPassword(encryptedPassword);
            loginInfo.setRole(2);
            loginInfo.setActive(true);
            userLoginService.saveLoginInfo(loginInfo);

            System.out.println("saved login info");

            UserInfo userInfo = new UserInfo();
            userInfo.setFirstName(firstName);
            userInfo.setLastName(lastName);
            userInfo.setLoginInfoByEmailId(loginInfo);
            userInfo.setEmailVerified(false);
            userInfo.setUserBalance(150);
            userService.saveUserInfo(userInfo);

            //sending verify link via email
            emailService = new EmailService();
            activationToken = encryptWithMd5.encrypt(prefixActivationToken+loginInfo.getEmailId());
            String message = userInfo.getFirstName()+" "+userInfo.getLastName()+"<br/>"+
                    "<a href='http://localhost:8080/register/ActivateAccount.action?emailId="+loginInfo.getEmailId()+"&activationToken="+activationToken+"'>Activate</a>";
            emailService.sendEmail("ashishtanna.03@gmail.com","Activate your Reader's Hive account",message,loginInfo.getEmailId());
            System.out.println("Activation Link : "+message);
            result="success";
        }
        else {
            System.out.println("Wrong!!!");
            result="error";
        }
        return SUCCESS;
    }

    public String activateAccount(){
        String encryptedEmail = encryptWithMd5.encrypt(prefixActivationToken+emailId);
        if (encryptedEmail.equals(activationToken)){
            userService.getUserById(emailId).setEmailVerified(true);
            result="success";
        }
        else {
            result="error";
        }
        return SUCCESS;
    }

}
