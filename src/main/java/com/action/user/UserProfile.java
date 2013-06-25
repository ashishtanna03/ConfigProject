package com.action.user;

import com.EncryptWithMd5;
import com.opensymphony.xwork2.ActionSupport;
import com.pojo.custom.AuthorDetails;
import com.pojo.custom.FriendInfo;
import com.pojo.hibernate.AuthorInfo;
import com.pojo.hibernate.UserInfo;
import com.service.UserService;
import com.service.login.UserLoginService;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.text.*;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/10/13
 * Time: 4:26 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserProfile extends ActionSupport {
    private String emailId;
    private String oldPassword;
    private String newPassword;

    private UserService userService;
    private UserLoginService userLoginService;
    private final String LOGGED_IN = "LoggedIn";
    private final String NOT_LOGGED_IN = "NotLoggedIn";

    private UserInfo user;
    private Integer userAge;
    private Boolean isFriend;
    private String result;

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setUserLoginService(UserLoginService userLoginService) {
        this.userLoginService = userLoginService;
    }

    public UserInfo getUser() {
        return user;
    }

    public Integer getUserAge() {
        return userAge;
    }

    public Boolean getIsFriend() {
        return isFriend;
    }

    public String getResult() {
        return result;
    }

    public String viewProfile() {
        result=NOT_LOGGED_IN;
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            if(emailId == null || emailId.equals(SecurityContextHolder.getContext().getAuthentication().getName())){
                emailId = SecurityContextHolder.getContext().getAuthentication().getName();
                result = LOGGED_IN;
            }
            else{
                isFriend = userService.isUserFriend(authentication.getName(),emailId);
            }
        }
        user = userService.getUserById(emailId);
        if (user.getUserBirthdate()!=null)
            userAge = calculateAge(user.getUserBirthdate());
        return result;
    }

    private Integer calculateAge(Date dateOfBirth){
        try {
            Calendar cal1 = new GregorianCalendar();
            Calendar cal2 = new GregorianCalendar();
            int age = 0;
            int factor = 0;
            cal1.setTime(dateOfBirth);
            cal2.setTime(new Date());
            if(cal2.get(Calendar.DAY_OF_YEAR) < cal1.get(Calendar.DAY_OF_YEAR)) {
                factor = -1;
            }
            age = cal2.get(Calendar.YEAR) - cal1.get(Calendar.YEAR) + factor;
            return age;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public String viewEditProfile() {
        emailId = SecurityContextHolder.getContext().getAuthentication().getName();
        user = userService.getUserById(emailId);
        return SUCCESS;
    }

    public String addAsFriend(){

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            if(userService.addAsFriend(authentication.getName(),emailId)){
                result = "success";
            }
        }
        else {
            result = "error";
        }
        return SUCCESS;
    }

    public String unfriend(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            if(userService.unfriend(authentication.getName(),emailId)){
                result = "success";
            }
        }
        else {
            result = "error";
        }
        return SUCCESS;
    }

    public String changePassword(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            EncryptWithMd5 encryptWithMd5 = new EncryptWithMd5();
            if(userLoginService.loadUserByUsername(authentication.getName()).getPassword().equals(encryptWithMd5.encrypt(oldPassword))){
                if(userLoginService.changePassword(authentication.getName(),encryptWithMd5.encrypt(newPassword))){
                    result="success";
                } else {
                    result="error";
                }
            } else {
                result="wrong";
            }
        }
        return SUCCESS;
    }
}