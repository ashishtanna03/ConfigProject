package com.pojo.custom;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 8/28/13
 * Time: 2:43 PM
 * To change this template use File | Settings | File Templates.
 */
public class LendDetails {

    private Integer bookId;
    private String bookTitle;
    private String bookImgUrl;
    private Integer sharingPrice;
    private Integer userId;
    private String userName;

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public String getBookImgUrl() {
        return bookImgUrl;
    }

    public void setBookImgUrl(String bookImgUrl) {
        this.bookImgUrl = bookImgUrl;
    }

    public Integer getSharingPrice() {
        return sharingPrice;
    }

    public void setSharingPrice(Integer sharingPrice) {
        this.sharingPrice = sharingPrice;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
