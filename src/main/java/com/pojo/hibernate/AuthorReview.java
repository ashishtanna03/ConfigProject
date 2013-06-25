package com.pojo.hibernate;

import java.io.Serializable;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class AuthorReview implements Serializable {
    private Integer authorReviewId;

    public Integer getAuthorReviewId() {
        return authorReviewId;
    }

    public void setAuthorReviewId(Integer authorReviewId) {
        this.authorReviewId = authorReviewId;
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

   /* @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AuthorReview that = (AuthorReview) o;

        if (authorReviewId != null ? !authorReviewId.equals(that.authorReviewId) : that.authorReviewId != null)
            return false;
        if (review != null ? !review.equals(that.review) : that.review != null) return false;
        if (reviewTitle != null ? !reviewTitle.equals(that.reviewTitle) : that.reviewTitle != null) return false;
        if (timeOfReview != null ? !timeOfReview.equals(that.timeOfReview) : that.timeOfReview != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = authorReviewId != null ? authorReviewId.hashCode() : 0;
        result = 31 * result + (reviewTitle != null ? reviewTitle.hashCode() : 0);
        result = 31 * result + (review != null ? review.hashCode() : 0);
        result = 31 * result + (timeOfReview != null ? timeOfReview.hashCode() : 0);
        return result;
    }*/

    private AuthorInfo authorInfoByAuthorId;

    public AuthorInfo getAuthorInfoByAuthorId() {
        return authorInfoByAuthorId;
    }

    public void setAuthorInfoByAuthorId(AuthorInfo authorInfoByAuthorId) {
        this.authorInfoByAuthorId = authorInfoByAuthorId;
    }

    private UserInfo userInfoByUserId;

    public UserInfo getUserInfoByUserId() {
        return userInfoByUserId;
    }

    public void setUserInfoByUserId(UserInfo userInfoByUserId) {
        this.userInfoByUserId = userInfoByUserId;
    }
}
