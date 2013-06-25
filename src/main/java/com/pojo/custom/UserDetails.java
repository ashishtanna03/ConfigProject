package com.pojo.custom;

import com.pojo.hibernate.Notification;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/15/13
 * Time: 1:42 AM
 * To change this template use File | Settings | File Templates.
 */
public class UserDetails {
    private String firstName;
    private String lastName;
    private Integer userBalance;
    private String userImg;
    private List<NotificationDetails> notificationList;
    private Integer noOfItems;

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Integer getUserBalance() {
        return userBalance;
    }

    public void setUserBalance(Integer userBalance) {
        this.userBalance = userBalance;
    }

    public String getUserImg() {
        return userImg;
    }

    public void setUserImg(String userImg) {
        this.userImg = userImg;
    }

    public List<NotificationDetails> getNotificationList() {
        return notificationList;
    }

    public void setNotificationList(List<NotificationDetails> notificationList) {
        this.notificationList = notificationList;
    }

    public Integer getNoOfItems() {
        return noOfItems;
    }

    public void setNoOfItems(Integer noOfItems) {
        this.noOfItems = noOfItems;
    }
}