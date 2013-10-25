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
public class BorrowBook implements Serializable {
    private Integer borrowId;

    public Integer getBorrowId() {
        return borrowId;
    }

    public void setBorrowId(Integer borrowId) {
        this.borrowId = borrowId;
    }

    private Date borrowDate;

    public Date getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }

    private Date deliverDate;

    public Date getDeliverDate() {
        return deliverDate;
    }

    public void setDeliverDate(Date deliverDate) {
        this.deliverDate = deliverDate;
    }

    private Short borrowStatus;

    public Short getBorrowStatus() {
        return borrowStatus;
    }

    public void setBorrowStatus(Short borrowStatus) {
        this.borrowStatus = borrowStatus;
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BorrowBook that = (BorrowBook) o;

        if (borrowDate != null ? !borrowDate.equals(that.borrowDate) : that.borrowDate != null) return false;
        if (borrowId != null ? !borrowId.equals(that.borrowId) : that.borrowId != null) return false;
        if (borrowStatus != null ? !borrowStatus.equals(that.borrowStatus) : that.borrowStatus != null) return false;
        if (deliverDate != null ? !deliverDate.equals(that.deliverDate) : that.deliverDate != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = borrowId != null ? borrowId.hashCode() : 0;
        result = 31 * result + (borrowDate != null ? borrowDate.hashCode() : 0);
        result = 31 * result + (deliverDate != null ? deliverDate.hashCode() : 0);
        result = 31 * result + (borrowStatus != null ? borrowStatus.hashCode() : 0);
        return result;
    }*/

    private BookInfo bookInfoByBookId;

    public BookInfo getBookInfoByBookId() {
        return bookInfoByBookId;
    }

    public void setBookInfoByBookId(BookInfo bookInfoByBookId) {
        this.bookInfoByBookId = bookInfoByBookId;
    }

    private Lend lendByLendId;

    public Lend getLendByLendId() {
        return lendByLendId;
    }

    public void setLendByLendId(Lend lendByLendId) {
        this.lendByLendId = lendByLendId;
    }

    private Lend lendByNewLendId;

    public Lend getLendByNewLendId() {
        return lendByNewLendId;
    }

    public void setLendByNewLendId(Lend lendByNewLendId) {
        this.lendByNewLendId = lendByNewLendId;
    }

    private UserInfo userInfoByUserId;

    public UserInfo getUserInfoByUserId() {
        return userInfoByUserId;
    }

    public void setUserInfoByUserId(UserInfo userInfoByUserId) {
        this.userInfoByUserId = userInfoByUserId;
    }

    private OrderInfo orderInfoByOrderId;

    public OrderInfo getOrderInfoByOrderId() {
        return orderInfoByOrderId;
    }

    public void setOrderInfoByOrderId(OrderInfo orderInfoByOrderId) {
        this.orderInfoByOrderId = orderInfoByOrderId;
    }

}
