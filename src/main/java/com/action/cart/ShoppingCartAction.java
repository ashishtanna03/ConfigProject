package com.action.cart;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.custom.BookDetails;
import com.pojo.hibernate.BorrowBook;
import com.pojo.hibernate.Lend;
import com.pojo.hibernate.UserCart;
import com.pojo.hibernate.UserInfo;
import com.service.BookService;
import com.service.LendService;
import com.service.UserService;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.ArrayList;
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
    private Integer pincode;
    private String address;

    private UserService userService;
    private LendService lendService;
    private BookService bookService;

    private UserInfo user;
    private List<BookDetails> topTenBooks;
    private String result;


    public void setLendId(Integer lendId) {
        this.lendId = lendId;
    }

    public void setPincode(Integer pincode) {
        this.pincode = pincode;
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

    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    public UserInfo getUser() {
        return user;
    }

    public List<BookDetails> getTopTenBooks() {
        return topTenBooks;
    }

    public String getResult() {
        return result;
    }

    public String viewCart(){

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
            user = userService.getUserById(authentication.getName());
        }

        topTenBooks = bookService.getTopTenBooks();
        if(topTenBooks == null)
            topTenBooks = new ArrayList<BookDetails>(0);

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

            //Check if user has shared this book
            for(Lend userLend : userInfo.getLendsByUserId()) {
               if(userLend.getBookInfoByBookId().getBookId().equals(lend.getBookInfoByBookId().getBookId()) && userLend.getLendStatus()!=1) {
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

            if(pincode==null || pincode.toString().length()!=6 || address==null){
                return ERROR;
            }

            if(userService.checkout(authentication.getName(), pincode, address)){
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
