package com.action.shelf;

import com.opensymphony.xwork2.ActionSupport;
import com.service.UserService;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 6/23/13
 * Time: 3:20 PM
 * To change this template use File | Settings | File Templates.
 */
public class WishListAction extends ActionSupport {

    private Integer bookId;

    private UserService userService;

    private String result;

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public String getResult() {
        return result;
    }

    public String addToWishList() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
            if(userService.addToWishList(authentication.getName(), bookId)){
                result="success";
            } else {
                result="error";
            }
        } else {
            result="error";
        }

        return SUCCESS;
    }

    public String removeBook() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
            if(userService.removeBookFromWishList(authentication.getName(), bookId)){
                return SUCCESS;
            } else {
                return ERROR;
            }
        } else {
            return ERROR;
        }
    }

}
