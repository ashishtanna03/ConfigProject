package com.pojo.hibernate;

import java.io.Serializable;
import java.sql.Date;
import java.util.Collection;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 9/6/13
 * Time: 4:08 PM
 * To change this template use File | Settings | File Templates.
 */
public class OrderInfo implements Serializable {

    private Integer orderId;

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    private Date printDate;

    public Date getPrintDate() {
        return printDate;
    }

    public void setPrintDate(Date printDate) {
        this.printDate = printDate;
    }

    private String shippingAddress;

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    private Integer pincode;

    public Integer getPincode() {
        return pincode;
    }

    public void setPincode(Integer pincode) {
        this.pincode = pincode;
    }

    private UserInfo userInfoByBuyerId;

    public UserInfo getUserInfoByBuyerId() {
        return userInfoByBuyerId;
    }

    public void setUserInfoByBuyerId(UserInfo userInfoByBuyerId) {
        this.userInfoByBuyerId = userInfoByBuyerId;
    }

    private Collection<BorrowBook> borrowBooksesByOrderId;

    public Collection<BorrowBook> getBorrowBooksesByOrderId() {
        return borrowBooksesByOrderId;
    }

    public void setBorrowBooksesByOrderId(Collection<BorrowBook> borrowBooksesByOrderId) {
        this.borrowBooksesByOrderId = borrowBooksesByOrderId;
    }
}
