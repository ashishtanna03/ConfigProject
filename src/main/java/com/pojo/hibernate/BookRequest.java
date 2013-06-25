package com.pojo.hibernate;

import java.io.Serializable;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookRequest implements Serializable {
    private Integer userId;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    private Integer bookId;

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    private Date requestDateTime;

    public Date getRequestDateTime() {
        return requestDateTime;
    }

    public void setRequestDateTime(Date requestDateTime) {
        this.requestDateTime = requestDateTime;
    }

    private Short requestStatus;

    public Short getRequestStatus() {
        return requestStatus;
    }

    public void setRequestStatus(Short requestStatus) {
        this.requestStatus = requestStatus;
    }

   /* @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BookRequest that = (BookRequest) o;

        if (bookId != null ? !bookId.equals(that.bookId) : that.bookId != null) return false;
        if (requestDateTime != null ? !requestDateTime.equals(that.requestDateTime) : that.requestDateTime != null)
            return false;
        if (requestStatus != null ? !requestStatus.equals(that.requestStatus) : that.requestStatus != null)
            return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userId != null ? userId.hashCode() : 0;
        result = 31 * result + (bookId != null ? bookId.hashCode() : 0);
        result = 31 * result + (requestDateTime != null ? requestDateTime.hashCode() : 0);
        result = 31 * result + (requestStatus != null ? requestStatus.hashCode() : 0);
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
