package com.action.book;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.BookReview;
import com.pojo.hibernate.Lend;
import com.service.BookReviewService;
import com.service.BookService;
import com.service.UserService;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/10/13
 * Time: 6:33 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookInfoAction extends ActionSupport {
    private Integer bookId;
    private Float rating;

    private String reviewTitle;
    private String review;
    //private Integer suggestedBookId;

    private BookService bookService;
    private BookReviewService bookReviewService;
    private UserService userService;

    private BookInfo book;
    private List<BookReview> bookReviews;
    private List<BookInfo> suggestedBooks;
    private List<Lend> lendList;
    private Float userRating;
    private String result;

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public void setRating(Float rating) {
        this.rating = rating;
    }

    public void setReviewTitle(String reviewTitle) {
        this.reviewTitle = reviewTitle;
    }

    public void setReview(String review) {
        this.review = review;
    }

   /* public void setSuggestedBookId(Integer suggestedBookId) {
        this.suggestedBookId = suggestedBookId;
    } */

    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    public void setBookReviewService(BookReviewService bookReviewService) {
        this.bookReviewService=bookReviewService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public BookInfo getBook() {
        return book;
    }

    public List<BookReview> getBookReviews() {
        return bookReviews;
    }

    public List<BookInfo> getSuggestedBooks() {
        return suggestedBooks;
    }

    public List<Lend> getLendList() {
        return lendList;
    }

    public Float getUserRating() {
        return userRating;
    }

    public String getResult() {
        return result;
    }

    public String execute() {
        try {
            book = bookService.getBookById(bookId);

            suggestedBooks = bookReviewService.getSuggestedBooks(bookId);

            bookReviews = bookReviewService.getBookReviews(bookId);

            if (suggestedBooks == null)
                suggestedBooks = new ArrayList<BookInfo>(0);

            if (bookReviews == null)
                bookReviews = new ArrayList<BookReview>(0);

            if (book.getLendsByBookId() != null && book.getLendsByBookId().size() > 0) {
                lendList = new ArrayList<Lend>();
                for(Lend lend:book.getLendsByBookId()){
                    if(lend.getLendStatus()!=1){
                        lendList.add(lend);
                    }
                }
            } else {
                lendList = new ArrayList<Lend>(0);
            }

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
                userRating = bookService.getUserRating(book,userService.getUserById(authentication.getName()));
            } else {
                userRating=new Float(0.0);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String saveBookReview(){
        try{
            BookReview bookReview = new BookReview();
            bookReview.setReviewTitle(reviewTitle);
            bookReview.setReview(review);
            bookReview.setTimeOfReview(new Date());
            bookReview.setBookInfoByBookId(bookService.getBookById(bookId));
            bookReview.setUserInfoByUserId(userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName()));
            //bookReview.setBookInfoBySuggestedBookId(bookService.getBookById(suggestedBookId));
            bookReviewService.saveBookReview(bookReview);

            execute();
        } catch (Exception e){
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String rateBook(){
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
            if(bookService.saveRating(bookId,userService.getUserById(authentication.getName()),rating)){
                result="success";
            }
            else {
                result="error";
            }
        }
        return SUCCESS;
    }
}
