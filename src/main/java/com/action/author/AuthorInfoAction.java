package com.action.author;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.custom.AuthorDetails;
import com.pojo.custom.FollowerInfo;
import com.pojo.hibernate.AuthorInfo;
import com.pojo.hibernate.AuthorReview;
import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.UserInfo;
import com.service.AuthorReviewService;
import com.service.AuthorService;
import com.service.BookService;
import com.service.UserService;
import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/11/13
 * Time: 12:44 AM
 * To change this template use File | Settings | File Templates.
 */
public class AuthorInfoAction extends ActionSupport implements SessionAware{

    private SessionMap<String,Object> sessionMap;
    private Integer userId;  //add the user to authors followers list and if user has commented, then show the option to delete his comment.

    private Integer authorId;
    private String reviewTitle;
    private String review;

    private AuthorService authorService;
    private UserService userService;
    private BookService bookService;
    private AuthorReviewService authorReviewService;

    private AuthorInfo author;
    private List<AuthorReview> authorReviews;
    private List<BookInfo> authorBooks;
    private List<AuthorDetails> topTenAuthors;
    private Boolean following;
    private Boolean userCommented = false; //to check if user has commented or not, if yes then remove the option to add another comment.
    private String result;

    public void setAuthorId(Integer authorId) {
        this.authorId = authorId;
    }

    public void setReviewTitle(String reviewTitle) {
        this.reviewTitle = reviewTitle;
    }

    public void setReview(String review) {
        this.review = review;
    }

    public void setAuthorService(AuthorService authorService) {
        this.authorService = authorService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setAuthorReviewService(AuthorReviewService authorReviewService) {
        this.authorReviewService = authorReviewService;
    }

    public AuthorInfo getAuthor() {
        return author;
    }

    public List<AuthorReview> getAuthorReviews() {
        return authorReviews;
    }

    public List<AuthorDetails> getTopTenAuthors() {
        return topTenAuthors;
    }

    public List<BookInfo> getAuthorBooks() {
        return authorBooks;
    }

    public void setBookService(BookService bookService) {
        this.bookService=bookService;
    }

    public Boolean getFollowing() {
        return following;
    }

    public Integer getUserId() {
        return userId;
    }

    public Boolean getUserCommented() {
        return userCommented;
    }

    public String getResult() {
        return result;
    }

    public String execute() {
        try {
            author = authorService.getAuthorById(authorId);

            authorBooks = bookService.getAuthorBooks(authorId);

            authorReviews = authorReviewService.getAuthorReviews(authorId);

            topTenAuthors = authorService.getTopTenAuthors();

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()){
                UserInfo user = userService.getUserById(authentication.getName());
                userId = user.getUserId();
                following = authorService.isUserFollowingAuthor(userId, authorId);

                //Check if user has commented on the same author
                for(AuthorReview userComment : user.getAuthorReviewsByUserId()) {
                    if(userComment.getAuthorInfoByAuthorId().getAuthorId().equals(authorId)) {
                        userCommented=true;
                        break;
                    }
                }

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String viewAllFollowers() {
        if(authorId!=null) {
            author = authorService.getAuthorById(authorId);
            return SUCCESS;
        } else
            return ERROR;
    }

    public String saveComment() {
        try{
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {

                //Check if user has already commented on this author, if true then return error
                for(AuthorReview userComment : userService.getUserById(authentication.getName()).getAuthorReviewsByUserId()) {
                    if(userComment.getAuthorInfoByAuthorId().getAuthorId().equals(authorId)) {
                        return ERROR;
                    }
                }

                AuthorReview authorReview = new AuthorReview();
                authorReview.setReviewTitle(reviewTitle);
                authorReview.setReview(review);
                authorReview.setTimeOfReview(new Date());
                authorReview.setAuthorInfoByAuthorId(authorService.getAuthorById(authorId));
                authorReview.setUserInfoByUserId(userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName()));
                authorReviewService.saveAuthorReview(authorReview);

                execute();

                return SUCCESS;
            } else {
                return ERROR;
            }
        } catch (Exception e){
            e.printStackTrace();
            return ERROR;
        }
    }

    public String deleteComment() {
        try{
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
                if(authorReviewService.deleteComment(authorId, authentication.getName())) {
                    execute();
                    return SUCCESS;
                }
                else
                    return ERROR;
            } else
                return ERROR;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

    public void setSession(Map<String, Object> stringObjectMap) {
        this.sessionMap = (SessionMap<String,Object>) stringObjectMap;
    }

    public String follow() {
        userId = userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName()).getUserId();
        if(authorService.followAuthor(authorId,userId)){
            result = "success";
        }
        else {
            result = "error";
        }

        return SUCCESS;
    }

    public String unfollow(){

        userId = userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName()).getUserId();
        if(authorService.unfollowAuthor(authorId, userId)){
            result = "success";
        }
        else {
            result = "error";
        }

        return SUCCESS;
    }
}
