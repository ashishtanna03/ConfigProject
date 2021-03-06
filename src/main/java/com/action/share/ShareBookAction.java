package com.action.share;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.Lend;
import com.pojo.hibernate.UserCart;
import com.pojo.hibernate.UserInfo;
import com.service.BookService;
import com.service.LendService;
import com.service.UserService;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/21/13
 * Time: 3:06 PM
 * To change this template use File | Settings | File Templates.
 */
public class ShareBookAction extends ActionSupport {

    private Integer bookId;
    private Integer lendId;
    private Integer conditionRating;
    private String conditionDescription;
    private Integer sharingPrice;
    private Integer userPostalCode;
    private String userAddress;

    private LendService lendService;
    private BookService bookService;
    private UserService userService;

    private String result;

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public void setLendId(Integer lendId) {
        this.lendId = lendId;
    }

    public void setConditionRating(Integer conditionRating) {
        this.conditionRating = conditionRating;
    }

    public void setConditionDescription(String conditionDescription) {
        this.conditionDescription = conditionDescription;
    }

    public void setSharingPrice(Integer sharingPrice) {
        this.sharingPrice = sharingPrice;
    }

    public void setUserPostalCode(Integer userPostalCode) {
        this.userPostalCode = userPostalCode;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public void setLendService(LendService lendService) {
        this.lendService = lendService;
    }

    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public String getResult() {
        return result;
    }

    public String shareBook(){

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            UserInfo user = userService.getUserById(authentication.getName());
            result="";
            for (Lend userShared : user.getLendsByUserId()) {
                //Check if user has shared the same book before, if shared check status of it , it should be delivered.
                if (userShared.getBookInfoByBookId().getBookId().equals(bookId) && userShared.getLendStatus()==0 ) {
                    result = "shared";
                    break;
                }
            }

            for(UserCart userCart : user.getUserCartsByUserId()) {
                //Check if user has added the book in his cart, if yes then he can't share the book.
                if(userCart.getLendByLendId().getBookInfoByBookId().getBookId().equals(bookId)) {
                    result="inCart";
                    break;
                }
            }

            if(!result.equals("shared") && !result.equals("inCart")) {

                if(userAddress!=null && !userAddress.equals("") && userPostalCode!=null && userPostalCode.toString().length()==6) {
                    user.setUserAddress(userAddress);
                    user.setUserPostalCode(userPostalCode);
                } else {
                    result="error";
                    return SUCCESS;
                }

                userService.update(user);

                Lend lend = new Lend();
                lend.setConditionRating(conditionRating);
                lend.setConditionDescription(conditionDescription);
                lend.setSharingPrice(sharingPrice);
                lend.setSharingDate(new Date());
                lend.setBookInfoByBookId(bookService.getBookById(bookId));
                lend.setUserInfoByUserId(userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName()));
                lend.setLendStatus(0);

                if (lendService.lendBook(lend)) {
                    result = "success";
                } else {
                    result = "error";
                }
            }

        } else {
            result = "error";
        }

        return SUCCESS;
    }

    public String unshareBook() {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            UserInfo user = userService.getUserById(authentication.getName());
            result="notShared";
            for (Lend userShared : user.getLendsByUserId()) {
                //Check if user has shared or not .
                if (userShared.getLendId().equals(lendId) && userShared.getLendStatus()==0 ) {
                    if(lendService.unshareBook(lendId))
                        result="success";
                    else
                        result="error";
                    break;
                }
            }
        } else {
            result="error";
        }

        return SUCCESS;
    }

}