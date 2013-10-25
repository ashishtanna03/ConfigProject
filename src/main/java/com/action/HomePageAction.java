package com.action;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.hibernate.BookInfo;
import com.service.BookService;
import com.service.UserService;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 7/24/13
 * Time: 3:06 AM
 * To change this template use File | Settings | File Templates.
 */
public class HomePageAction extends ActionSupport {

    private BookService bookService;
    private UserService userService;

    private Integer userId;
    private List<String> genresList;
    private List<BookInfo> recentlyShared;
    private List<BookInfo> booksInDemand;
    private List<BookInfo> recentlyBought;
    private List<BookInfo> mostSharedBooks;

    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public Integer getUserId() {
        return userId;
    }

    public List<String> getGenresList() {
        return genresList;
    }

    public List<BookInfo> getRecentlyShared() {
        return recentlyShared;
    }

    public List<BookInfo> getBooksInDemand() {
        return booksInDemand;
    }

    public List<BookInfo> getRecentlyBought() {
        return recentlyBought;
    }

    public List<BookInfo> getMostSharedBooks() {
        return mostSharedBooks;
    }

    public String execute() {

        try {

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
                userId = userService.getUserById(authentication.getName()).getUserId();
            }

            genresList = bookService.getGenresList();
            if(genresList==null)
                genresList = new ArrayList<String>(0);

            recentlyShared = bookService.getRecentlySharedBooks();
            if(recentlyShared==null)
                recentlyShared = new ArrayList<BookInfo>(0);
            else if (recentlyShared.size()>16) {
                //Reduce the size of list if its greater than 16
                recentlyShared = recentlyShared.subList(0,16);
            }

            booksInDemand=bookService.getBooksInDemand();
            if (booksInDemand==null)
                booksInDemand = new ArrayList<BookInfo>(0);

            recentlyBought = bookService.getRecentlyBoughtBooks();
            if(recentlyBought==null)
                recentlyBought = new ArrayList<BookInfo>(0);
            else if(recentlyBought.size()>16) {
                recentlyBought = recentlyBought.subList(0,16);
            }

            mostSharedBooks = bookService.getMostSharedBooks();
            if(mostSharedBooks==null)
                mostSharedBooks = new ArrayList<BookInfo>(0);

            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            return ERROR;
        }
    }

}
