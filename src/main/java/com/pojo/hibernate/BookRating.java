package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookRating implements Serializable {

    private Float rating;

    public Float getRating() {
        return rating;
    }

    public void setRating(Float rating) {
        this.rating = rating;
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BookRating that = (BookRating) o;

        if (bookId != null ? !bookId.equals(that.bookId) : that.bookId != null) return false;
        if (rating != null ? !rating.equals(that.rating) : that.rating != null) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userId != null ? userId.hashCode() : 0;
        result = 31 * result + (bookId != null ? bookId.hashCode() : 0);
        result = 31 * result + (rating != null ? rating.hashCode() : 0);
        return result;
    }*/

    private BookInfo bookInfoByBookId;

    public BookInfo getBookInfoByBookId() {
        return bookInfoByBookId;
    }

    public void setBookInfoByBookId(BookInfo bookInfoByBookId) {
        this.bookInfoByBookId = bookInfoByBookId;
    }

    private UserInfo userInfoByUserId;

    public UserInfo getUserInfoByUserId() {
        return userInfoByUserId;
    }

    public void setUserInfoByUserId(UserInfo userInfoByUserId) {
        this.userInfoByUserId = userInfoByUserId;
    }
}
