package com.action.book;

import com.opensymphony.xwork2.ActionSupport;
import com.pojo.custom.BookDetails;
import com.pojo.hibernate.*;
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
//    private List<BookInfo> suggestedBooks;
    private List<BookDetails> relatedBooks;
    private List<Lend> lendList;
    private List<BookDetails> topTenBooks;
    private Float userRating;
    private String userAddress;
    private String userContact;
    private Integer userId; // to check if user is logged in
    private Boolean userReviewed = false; // To check if the user's review is already available
    private Boolean inUsersCart = false; // To check if the user has added the book in his cart, if yes then remove the option for sharing.
    private String averageRating;
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

    /*public List<BookInfo> getSuggestedBooks() {
        return suggestedBooks;
    }*/

    public List<BookDetails> getRelatedBooks() {
        return relatedBooks;
    }

    public List<Lend> getLendList() {
        return lendList;
    }

    public List<BookDetails> getTopTenBooks() {
        return topTenBooks;
    }

    public Float getUserRating() {
        return userRating;
    }

    public String getUserContact() {
        return userContact;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public Integer getUserId() {
        return userId;
    }

    public Boolean getUserReviewed() {
        return userReviewed;
    }

    public Boolean getInUsersCart() {
        return inUsersCart;
    }

    public String getAverageRating() {
        return averageRating;
    }

    public String getResult() {
        return result;
    }

    public String execute() {
        try {
            book = bookService.getBookById(bookId);

//            suggestedBooks = bookReviewService.getSuggestedBooks(bookId);

            bookReviews = bookReviewService.getBookReviews(bookId);

            relatedBooks = bookService.getRelatedBooks(bookId);

//            if (suggestedBooks == null)
//                suggestedBooks = new ArrayList<BookInfo>(0);

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

            topTenBooks = bookService.getTopTenBooks();
            if(topTenBooks == null)
                topTenBooks = new ArrayList<BookDetails>(0);

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
                UserInfo user = userService.getUserById(authentication.getName());
                userId = user.getUserId();
                userRating = bookService.getUserRating(book,user);
                userAddress = user.getUserAddress();
                userContact = user.getUserContact();

                for (BookReview bookReview : user.getBookReviewsByUserId()) {
                    if(bookReview.getBookInfoByBookId().equals(book)) {
                        userReviewed = true;
                        break;
                    }
                }

                for(UserCart userCart : user.getUserCartsByUserId()) {
                    if(userCart.getLendByLendId().getBookInfoByBookId().equals(book)) {
                        inUsersCart = true;
                        break;
                    }
                }

            } else {
                userRating=new Float(0.0);
            }

            Float totalRating = (float) 0;
            if(book!=null && book.getBookRatingsByBookId()!=null && book.getBookRatingsByBookId().size()>0) {
                for(BookRating bookRating : book.getBookRatingsByBookId()) {
                    if(bookRating.getRating()!=null && bookRating.getRating()!=0) {
                        totalRating += bookRating.getRating();
                    }
                }
                if(totalRating>0) {
                    totalRating = totalRating/book.getBookRatingsByBookId().size();
                    averageRating = String.format("%.1f",totalRating);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String saveBookReview(){
        try{
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {

                //checking if user has already written review for this book, if yes return error.
                for(BookReview usersBookReview : userService.getUserById(authentication.getName()).getBookReviewsByUserId()) {
                    if(usersBookReview.getBookInfoByBookId().getBookId().equals(bookId))
                        return ERROR;
                }

                BookReview bookReview = new BookReview();
                bookReview.setReviewTitle(reviewTitle);
                bookReview.setReview(review);
                bookReview.setTimeOfReview(new Date());
                bookReview.setBookInfoByBookId(bookService.getBookById(bookId));
                bookReview.setUserInfoByUserId(userService.getUserById(SecurityContextHolder.getContext().getAuthentication().getName()));
                //bookReview.setBookInfoBySuggestedBookId(bookService.getBookById(suggestedBookId));
                bookReviewService.saveBookReview(bookReview);

                execute();
                return SUCCESS;
            } else
                return ERROR;

        } catch (Exception e){
            e.printStackTrace();
            return ERROR;
        }
    }

    public String deleteReview() {
        try{
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {
                if(bookReviewService.deleteBookReview(bookId, authentication.getName())) {
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

    public String requestBook(){

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && !(authentication instanceof AnonymousAuthenticationToken) && authentication.isAuthenticated()) {

            UserInfo user = userService.getUserById(authentication.getName());

            //check if user has already requested the book
            for(RequestedBooks requestedBook : user.getRequestedBooksesByUserId()) {
                if(requestedBook.getBookInfoByBookId().getBookId().equals(bookId)) {
                    result="requested";
                    return SUCCESS;
                }
            }

            //check if user has shared this book
            for(Lend userLend : user.getLendsByUserId()) {
                if(userLend.getBookInfoByBookId().getBookId().equals(bookId) && userLend.getLendStatus()!=1) {
                    result="shared";
                    return SUCCESS;
                }
            }

            for(UserCart userCart : user.getUserCartsByUserId()) {
                //Check if user has added the book in his cart, if yes then he can't request the book.
                if(userCart.getLendByLendId().getBookInfoByBookId().getBookId().equals(bookId)) {
                    result="inCart";
                    break;
                }
            }

            if(bookService.requestBook(bookId, userService.getUserById(authentication.getName()))) {
                result="success";
            } else {
                result="error";
            }
        } else {
            result="error";
        }

        return SUCCESS;
    }
}
