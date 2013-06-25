package com.pojo.hibernate;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookReview implements Serializable {
    private Integer bookReviewId;

    public Integer getBookReviewId() {
        return bookReviewId;
    }

    public void setBookReviewId(Integer bookReviewId) {
        this.bookReviewId = bookReviewId;
    }

    private String reviewTitle;

    public String getReviewTitle() {
        return reviewTitle;
    }

    public void setReviewTitle(String reviewTitle) {
        this.reviewTitle = reviewTitle;
    }

    private String review;

    public String getReview() {
        return review;
    }

    public void setReview(String review) {
        this.review = review;
    }

    private Date timeOfReview;

    public Date getTimeOfReview() {
        return timeOfReview;
    }

    public void setTimeOfReview(Date timeOfReview) {
        this.timeOfReview = timeOfReview;
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BookReview that = (BookReview) o;

        if (bookReviewId != null ? !bookReviewId.equals(that.bookReviewId) : that.bookReviewId != null) return false;
        if (review != null ? !review.equals(that.review) : that.review != null) return false;
        if (reviewTitle != null ? !reviewTitle.equals(that.reviewTitle) : that.reviewTitle != null) return false;
        if (timeOfReview != null ? !timeOfReview.equals(that.timeOfReview) : that.timeOfReview != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = bookReviewId != null ? bookReviewId.hashCode() : 0;
        result = 31 * result + (reviewTitle != null ? reviewTitle.hashCode() : 0);
        result = 31 * result + (review != null ? review.hashCode() : 0);
        result = 31 * result + (timeOfReview != null ? timeOfReview.hashCode() : 0);
        return result;
    }
*/
    private BookInfo bookInfoByBookId;

    public BookInfo getBookInfoByBookId() {
        return bookInfoByBookId;
    }

    public void setBookInfoByBookId(BookInfo bookInfoByBookId) {
        this.bookInfoByBookId = bookInfoByBookId;
    }

    private BookInfo bookInfoBySuggestedBookId;

    public BookInfo getBookInfoBySuggestedBookId() {
        return bookInfoBySuggestedBookId;
    }

    public void setBookInfoBySuggestedBookId(BookInfo bookInfoBySuggestedBookId) {
        this.bookInfoBySuggestedBookId = bookInfoBySuggestedBookId;
    }

    private UserInfo userInfoByUserId;

    public UserInfo getUserInfoByUserId() {
        return userInfoByUserId;
    }

    public void setUserInfoByUserId(UserInfo userInfoByUserId) {
        this.userInfoByUserId = userInfoByUserId;
    }

    private Collection<BookReviewLike> bookReviewLikesByBookReviewId;

    public Collection<BookReviewLike> getBookReviewLikesByBookReviewId() {
        return bookReviewLikesByBookReviewId;
    }

    public void setBookReviewLikesByBookReviewId(Collection<BookReviewLike> bookReviewLikesByBookReviewId) {
        this.bookReviewLikesByBookReviewId = bookReviewLikesByBookReviewId;
    }
}
