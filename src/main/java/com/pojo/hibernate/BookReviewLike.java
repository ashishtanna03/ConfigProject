package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookReviewLike implements Serializable {
    private Integer bookReviewId;

    public Integer getBookReviewId() {
        return bookReviewId;
    }

    public void setBookReviewId(Integer bookReviewId) {
        this.bookReviewId = bookReviewId;
    }

    private Integer userId;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    private Boolean likedReview;

    public Boolean getLikedReview() {
        return likedReview;
    }

    public void setLikedReview(Boolean likedReview) {
        this.likedReview = likedReview;
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BookReviewLike that = (BookReviewLike) o;

        if (bookReviewId != null ? !bookReviewId.equals(that.bookReviewId) : that.bookReviewId != null) return false;
        if (likedReview != null ? !likedReview.equals(that.likedReview) : that.likedReview != null) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = bookReviewId != null ? bookReviewId.hashCode() : 0;
        result = 31 * result + (userId != null ? userId.hashCode() : 0);
        result = 31 * result + (likedReview != null ? likedReview.hashCode() : 0);
        return result;
    }*/

    private BookReview bookReviewByBookReviewId;

    public BookReview getBookReviewByBookReviewId() {
        return bookReviewByBookReviewId;
    }

    public void setBookReviewByBookReviewId(BookReview bookReviewByBookReviewId) {
        this.bookReviewByBookReviewId = bookReviewByBookReviewId;
    }

    private UserInfo userInfoByUserId;

    public UserInfo getUserInfoByUserId() {
        return userInfoByUserId;
    }

    public void setUserInfoByUserId(UserInfo userInfoByUserId) {
        this.userInfoByUserId = userInfoByUserId;
    }
}
