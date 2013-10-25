package com.action.login;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.custom.AuthorDetails;
import com.pojo.custom.NotificationDetails;
import com.pojo.custom.UserDetails;
import com.pojo.hibernate.*;
import com.service.AuthorService;
import com.service.BookService;
import com.service.UserService;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;


/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 2/9/13
 * Time: 6:44 PM
 * To change this template use File | Settings | File Templates.
 */
public class LoginAction extends ActionSupport implements SessionAware {

    private String emailId;
    private UserInfo userInfo;

    private UserService userService;
    private BookService bookService;
    private AuthorService authorService;
    private SessionMap sessionMap;

    private UserDetails user;
    private String result;
    private String resultHeader; // for account activation error msg
    private String resultMessage;  //   "

    public UserDetails getUser() {
        return user;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    public void setAuthorService(AuthorService authorService) {
        this.authorService = authorService;
    }

    public void setSession(Map<String, Object> stringObjectMap) {
        this.sessionMap = (SessionMap) stringObjectMap;
    }

    public String getResult() {
        return result;
    }

    public String getResultMessage() {
        return resultMessage;
    }

    public String getResultHeader() {
        return resultHeader;
    }

    //First Log In Request
    public String logIn() {

//        System.out.println("Login Action called");
        emailId = SecurityContextHolder.getContext().getAuthentication().getName();
//        System.out.println(emailId);
        userInfo = userService.getUserById(emailId);

        if(userInfo!=null){
            //checking if email is verified or not
            if (!userInfo.getEmailVerified()) {
                result = "inactive";
                resultHeader = "Account not Active";
                resultMessage = "You haven't activated your account yet." +
                        "<br/>To active your account, click on the link provided in the mail sent by us (at the time of Registration)." +
                        "<br/>If you can't see the mail in your Inbox, check in Spam/Junk folder. If it is in Spam/Junk folder move it in your Inbox, to get future e-mails in your Inbox directly." +
                        "<br/>You must activate yor account to complete registration." +
                        "<br/>If you haven't received the mail yet, <a id=\"resend-mail-btn\" href=\"/lightbox-pages/resend-activation-mail.jsp?lightbox[width]=200&lightbox[height]=100\">Click Here</a> to get it." +
                        "<script type=\"text/javascript\">" +
                        "$(document).ready(function(){ " +
                        "$('#resend-mail-btn').lightbox();" +
                        "});</script>";
                return SUCCESS;
            } else
                this.setUserDetails(userInfo);
        }

        result = null;
        sessionMap.put("isLoggedIn", "true");
//        System.out.println(user.getLoginInfo().getEmailId());
        return SUCCESS;
    }

    //If UserName or Password Is Wrong.
    public String badLogIn() {
        user = null;
        result = "error";
        return SUCCESS;
    }

    public String isLoggedIn(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            result="success";
        } else {
            result="error";
        }
        return SUCCESS;
    }

    //If User is Logged in..!!
    public String loggedIn() {
        if (sessionMap.isEmpty() || !sessionMap.get("isLoggedIn").equals("true")) {
            result = "error";
        } else {
            userInfo = userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName());
            if(userInfo!=null){
                this.setUserDetails(userInfo);
            }
        }
        return SUCCESS;
    }

    private void setUserDetails(UserInfo userInfo){

        final SimpleDateFormat sdf = new SimpleDateFormat("d MMMM, yyyy");

        user = new UserDetails();
        user.setFirstName(userInfo.getFirstName());
        user.setLastName(userInfo.getLastName());
        user.setUserImg(userInfo.getUserImg());
        user.setUserBalance(userInfo.getUserBalance());

        List<NotificationDetails> notificationList = new ArrayList<NotificationDetails>(0);
        //setting notifications
        for (Notification notification : userInfo.getNotificationsByUserId_0()){
            NotificationDetails notificationDetails = new NotificationDetails();

            notificationDetails.setDate(sdf.format(notification.getDate()));
            notificationDetails.setNotificationType(notification.getNotificationType());

            if(notification.getNotificationType()<6){
                notificationDetails.setUserName(notification.getUserInfoBySenderId().getFirstName()+" "+notification.getUserInfoBySenderId().getLastName());
                notificationDetails.setUserId(notification.getUserInfoBySenderId().getUserId());
            }

            if (notification.getNotificationType()>=2 && notification.getNotificationType()<7) {

                notificationDetails.setObjectId(notification.getObjectId());
                BookInfo book = bookService.getBookById(notification.getObjectId());
                if (notification.getNotificationType()==6){
                    notificationDetails.setObjectImg(book.getBookImgUrl());
                } else{
                    notificationDetails.setObjectImg(notification.getUserInfoBySenderId().getUserImg());
                }

                notificationDetails.setBookTitle(book.getBookTitle());
                List<AuthorDetails> authors = new ArrayList<AuthorDetails>(0);
                for(BookAuthors bookAuthors:book.getBookAuthorsesByBookId()){
                    AuthorDetails authorDetails = new AuthorDetails();
                    authorDetails.setAuthorId(bookAuthors.getAuthorInfoByAuthorId().getAuthorId());
                    authorDetails.setAuthorName(bookAuthors.getAuthorInfoByAuthorId().getAuthorName());
                    authors.add(authorDetails);
                }
                notificationDetails.setAuthors(authors);
            } else if(notification.getNotificationType()==7) {
                notificationDetails.setObjectId(notification.getObjectId());
                AuthorInfo authorInfo = authorService.getAuthorById(notification.getObjectId());
                notificationDetails.setObjectImg(authorInfo.getAuthorImg());
                notificationDetails.setBookTitle(authorInfo.getAuthorName());
            }
            notificationList.add(notificationDetails);
            Collections.sort(notificationList, new Comparator<NotificationDetails>() {
                public int compare(NotificationDetails notification1, NotificationDetails notification2) {

                    try {
                        return sdf.parse(notification1.getDate()).compareTo(sdf.parse(notification2.getDate()));
                    } catch (Exception e) {
                        e.printStackTrace();
                        return 0;
                    }
                }
            });
        }
        user.setNotificationList(notificationList);

        if(userInfo.getUserCartsByUserId()!=null)
            user.setNoOfItems(userInfo.getUserCartsByUserId().size());
        else {
            user.setNoOfItems(0);
        }

    }
}