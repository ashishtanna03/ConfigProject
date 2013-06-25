package com.action.share;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.Lend;
import com.service.BookService;
import com.service.LendService;
import com.service.UserService;
import org.springframework.security.core.context.SecurityContextHolder;
import sun.nio.cs.US_ASCII;

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
    private Integer conditionRating;
    private String conditionDescription;
    private Integer sharingPrice;

    private LendService lendService;
    private BookService bookService;
    private UserService userService;

    private String result;

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
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
        Lend lend = new Lend();
        lend.setConditionRating(conditionRating);
        lend.setConditionDescription(conditionDescription);
        lend.setSharingPrice(sharingPrice);
        lend.setSharingDate(new Date());
        lend.setBookInfoByBookId(bookService.getBookById(bookId));
        lend.setUserInfoByUserId(userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName()));
        lend.setLendStatus(0);

        if(lendService.lendBook(lend)){
            result="success";
        }
        else {
            result="error";
        }

        return SUCCESS;
    }
}