package com.action.cart;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.BorrowBook;
import com.pojo.hibernate.Lend;
import com.pojo.hibernate.UserCart;
import com.pojo.hibernate.UserInfo;
import com.service.LendService;
import com.service.UserService;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 5/3/13
 * Time: 7:25 PM
 * To change this template use File | Settings | File Templates.
 */
public class ShoppingCartAction extends ActionSupport {

    private Integer lendId;
    private String contactNo;
    private String address;

    private UserService userService;
    private LendService lendService;

    private UserInfo user;
    private String result;


    public void setLendId(Integer lendId) {
        this.lendId = lendId;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setLendService(LendService lendService) {
        this.lendService = lendService;
    }

    public UserInfo getUser() {
        return user;
    }

    public String getResult() {
        return result;
    }

    public String viewCart(){

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
            user = userService.getUserById(authentication.getName());
        }
        return SUCCESS;
    }

    public String addToCart(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){

            Lend lend = lendService.getLendById(lendId);
            UserInfo userInfo = userService.getUserById(authentication.getName());

            //Checking if user has already added this book in Cart
            for(UserCart userCart : userInfo.getUserCartsByUserId()) {
                if(userCart.getLendByLendId().getBookInfoByBookId().getBookId().equals(lend.getBookInfoByBookId().getBookId())) {
                    result="inCart";
                    return SUCCESS;
                }
            }

            for(Lend userLend : userInfo.getLendsByUserId()) {
               if(userLend.getBookInfoByBookId().getBookId().equals(lend.getBookInfoByBookId().getBookId())) {
                   result="shared";
                   return SUCCESS;
               }
            }

            if(userService.addToCart(authentication.getName(),lendId)){
                result="success";
            } else {
                result="error";
            }
        } else {
            result="error";
        }
        user = null;
        return SUCCESS;
    }

    public String checkout(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
            UserInfo userInfo=userService.getUserById(authentication.getName());
            if(contactNo!=null){
                userInfo.setUserContact(contactNo);
            }
            if(address!=null){
                userInfo.setUserAddress(address);
                userService.update(userInfo);
            }
            else{
                return ERROR;
            }
            if(userService.checkout(authentication.getName())){
                return SUCCESS;
            } else {
                return ERROR;
            }

        } else {
            return ERROR;
        }
    }

    public String deleteItem(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
            user=userService.getUserById(authentication.getName());
            userService.deleteItem(authentication.getName(),lendId);
        }
        return SUCCESS;
    }
}
