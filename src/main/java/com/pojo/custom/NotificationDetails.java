package com.pojo.custom;

import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 5/3/13
 * Time: 12:20 AM
 * To change this template use File | Settings | File Templates.
 */
public class NotificationDetails {
    private Integer userId;
    private String userName;
    private String objectImg;
    private Integer notificationType;
    private Integer objectId;
    private String bookTitle;
    private List<AuthorDetails> authors;
    private String date;

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

    public String getObjectImg() {
        return objectImg;
    }

    public void setObjectImg(String objectImg) {
        this.objectImg = objectImg;
    }

    public Integer getNotificationType() {
        return notificationType;
    }

    public void setNotificationType(Integer notificationType) {
        this.notificationType = notificationType;
    }

    public Integer getObjectId() {
        return objectId;
    }

    public void setObjectId(Integer objectId) {
        this.objectId = objectId;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public List<AuthorDetails> getAuthors() {
        return authors;
    }

    public void setAuthors(List<AuthorDetails> authors) {
        this.authors = authors;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
}
