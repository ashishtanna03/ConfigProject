package com.action.user;

import com.EncryptWithMd5;
import com.action.admin.AdminPanelAction;
import com.opensymphony.xwork2.ActionSupport;
import com.pojo.custom.AuthorDetails;
import com.pojo.custom.FriendInfo;
import com.pojo.hibernate.AuthorInfo;
import com.pojo.hibernate.FriendshipMapping;
import com.pojo.hibernate.Genres;
import com.pojo.hibernate.UserInfo;
import com.service.AuthorService;
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
    private Integer userId;
    private Integer bookId;
    private String oldPassword;     //For changing password
    private String newPassword;     //    "           and for reset password
    private String emailId;         //for reset password
    private String contactNo;       //For changing contact no.
    private Integer lendId;         //For setting user Reputation
    private Integer reputation;     //For setting user Reputation
    private Integer borrowId;       //Fore cancelling Order

    private UserService userService;
    private UserLoginService userLoginService;
    private AuthorService authorService;
    private final String LOGGED_IN = "LoggedIn";
    private final String NOT_LOGGED_IN = "NotLoggedIn";

    private UserInfo user;
    private Integer totalFriends=0;
    private Integer userAge;
    private Integer friendshipStatus;
    private List<Genres> genresList;  //for edit profile page
    private String result;
    private String resultHeader;        //for change contact no, result
    private String resultMessage;       //     "

    //set the user id of the user's profile
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public void setOldPassword(String oldPassword) {
        this.oldPassword = oldPassword;
    }

    public void setNewPassword(String newPassword) {
        this.newPassword = newPassword;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public void setLendId(Integer lendId) {
        this.lendId = lendId;
    }

    public void setReputation(Integer reputation) {
        this.reputation = reputation;
    }

    public void setBorrowId(Integer borrowId) {
        this.borrowId = borrowId;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setUserLoginService(UserLoginService userLoginService) {
        this.userLoginService = userLoginService;
    }

    public void setAuthorService(AuthorService authorService) {
        this.authorService = authorService;
    }

    //Get logged in user's ID
    public Integer getUserId() {
        return userId;
    }

    public UserInfo getUser() {
        return user;
    }

    public Integer getTotalFriends() {
        return totalFriends;
    }

    public Integer getUserAge() {
        return userAge;
    }

    public Integer getFriendshipStatus() {
        return friendshipStatus;
    }

    public List<Genres> getGenresList() {
        return genresList;
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

    public String viewProfile() {
        result=NOT_LOGGED_IN;
        if(userId!=null)
            user = userService.getUserById(userId);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            if(userId == null || user.getLoginInfoByEmailId().getEmailId().equals(SecurityContextHolder.getContext().getAuthentication().getName())){
                if(userId==null)
                    user = userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName());
                result = LOGGED_IN;
            }
            else{
                //isFriend = userService.isUserFriend(authentication.getName(),user.getLoginInfoByEmailId().getEmailId());

                for(FriendshipMapping friendshipMapping : userService.getUserById(authentication.getName()).getFriendshipMappingsByUserId()) {
                    if(friendshipMapping.getUserInfoByUser2().getUserId().equals(user.getUserId())) {
                        friendshipStatus = friendshipMapping.getStatus();
                        break;
                    }
                }
                if(friendshipStatus==null) {
                    for (FriendshipMapping friendshipMapping : userService.getUserById(authentication.getName()).getFriendshipMappingsByUserId_0()) {
                        if(friendshipMapping.getUserInfoByUser1().getUserId().equals(user.getUserId())) {
                            friendshipStatus = friendshipMapping.getStatus();
                            if(friendshipStatus==1) {
                                friendshipStatus=0;
                            } else if(friendshipStatus==0) {
                                friendshipStatus=1;
                            }
                            break;
                        }
                    }
                }

            }
            //id of logged in user
            userId = user.getUserId();
        } else {
            //Id of logged in user
            userId = null;
        }
        if (user.getUserBirthdate()!=null)
            userAge = calculateAge(user.getUserBirthdate());

        //counting user's total friends (who has accepted friend request (status=2) )
        for (FriendshipMapping friendshipMapping : user.getFriendshipMappingsByUserId()) {
            if(friendshipMapping.getStatus()==2)
                totalFriends += 1;
        }
        for (FriendshipMapping friendshipMapping : user.getFriendshipMappingsByUserId_0()) {
            if(friendshipMapping.getStatus()==2)
                totalFriends += 1;
        }

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
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            user = userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName());
            genresList = authorService.getGenreList();
            return SUCCESS;
        } else {
            return ERROR;
        }
    }

    public String viewAllFriendsAndFollows() {
        if(userId!=null && userId!=0) {
            user = userService.getUserById(userId);
            return SUCCESS;
        }
        else
            return ERROR;
    }

    public String viewOrderHistory() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            user = userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName());
            return SUCCESS;
        } else {
            return ERROR;
        }
    }

    public String cancelOrder() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            if(borrowId!=null) {
                if(userService.cancelOrder(authentication.getName(), borrowId))
                    return SUCCESS;
                else
                    return ERROR;
            } else
                return ERROR;
        } else
            return ERROR;

    }

    public String addAsFriend(){
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
                if(userId!=null && !userId.equals(userService.getUserById(authentication.getName()).getUserId())) {
                    if (userService.addAsFriend(authentication.getName(), userId)) {
                        result = "success";
                    }
                }
            }
            else {
                result = "error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            result = "error";
        }
        return SUCCESS;
    }

    public String cancelFriendRequest() {
        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
                if(userId!=null && !userId.equals(userService.getUserById(authentication.getName()).getUserId())) {
                    if(userService.cancelFriendRequest(authentication.getName(),userId)){
                        result = "success";
                    }
                }
            }
            else {
                result = "error";
            }
        } catch (Exception e) {
            e.printStackTrace();
            result = "error";
        }
        return SUCCESS;
    }

    public String unfriend(){

        try {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
                if(userId!=null && !userId.equals(userService.getUserById(authentication.getName()).getUserId())) {
                    if (userService.unfriend(authentication.getName(), userId)) {
                        result = "success";
                    }
                }
            }
            else {
                result = "error";
            }
        } catch (Exception e) {
            e.printStackTrace();
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

    public String resetPassword(){

        EncryptWithMd5 encryptWithMd5 = new EncryptWithMd5();

        if (userLoginService.changePassword(emailId, encryptWithMd5.encrypt(newPassword))) {
            resultHeader = "Your password is reset";
            resultMessage = "Your password is reset. Now, login with your new password to access your account.";
            return SUCCESS;
        } else {
            return ERROR;
        }
    }

    public String changeContactNo() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            if(contactNo==null || contactNo.length()!=10) {
                return ERROR;
            } else if(userService.isContactNoExists(contactNo)) {
                resultHeader = "Contact No. already exists";
                resultMessage = "The Contact No. you provided already exists in our database.";
                return "exists";
            } else if(userService.changeContactNo(authentication.getName(), contactNo)){
                return SUCCESS;
            } else {
                return ERROR;
            }
        } else {
            return ERROR;
        }
    }

    public String acceptRequest(){

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            if(userId!=null && !userId.equals(userService.getUserById(authentication.getName()).getUserId())) {
                if(userService.acceptRequest(authentication.getName(), userId)) {
                    return SUCCESS;
                }
                else
                    return ERROR;
            } else
                return ERROR;
        }
        return SUCCESS;
    }

    public String setUserReputation() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            if(userService.setUserReputation(lendId, reputation)) {
                result = "success";
            } else {
                result = "error";
            }
        }

        return SUCCESS;
    }

    public String removeRequestedBook() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            if(userService.removeRequestedBook(authentication.getName() , bookId))
                return SUCCESS;
            else
                return ERROR;
        } else {
            return ERROR;
        }
    }

}