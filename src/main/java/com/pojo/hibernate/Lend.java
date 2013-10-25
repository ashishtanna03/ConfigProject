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
public class Lend implements Serializable {
    private Integer lendId;

    public Integer getLendId() {
        return lendId;
    }

    public void setLendId(Integer lendId) {
        this.lendId = lendId;
    }

    private Integer sharingPrice;

    public Integer getSharingPrice() {
        return sharingPrice;
    }

    public void setSharingPrice(Integer sharingPrice) {
        this.sharingPrice = sharingPrice;
    }

    private Date sharingDate;

    public Date getSharingDate() {
        return sharingDate;
    }

    public void setSharingDate(Date sharingDate) {
        this.sharingDate = sharingDate;
    }

    private Integer lendStatus;

    public Integer getLendStatus() {
        return lendStatus;
    }

    public void setLendStatus(Integer lendStatus) {
        this.lendStatus = lendStatus;
    }

    private Integer conditionRating;

    public Integer getConditionRating() {
        return conditionRating;
    }

    public void setConditionRating(Integer conditionRating) {
        this.conditionRating = conditionRating;
    }

    private String conditionDescription;

    public String getConditionDescription() {
        return conditionDescription;
    }

    public void setConditionDescription(String conditionDescription) {
        this.conditionDescription = conditionDescription;
    }

    private Integer reputation;

    public Integer getReputation() {
        return reputation;
    }

    public void setReputation(Integer reputation) {
        this.reputation = reputation;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Lend lend = (Lend) o;

        if (conditionDescription != null ? !conditionDescription.equals(lend.conditionDescription) : lend.conditionDescription != null)
            return false;
        if (conditionRating != null ? !conditionRating.equals(lend.conditionRating) : lend.conditionRating != null)
            return false;
        if (reputation != null ? !reputation.equals(lend.reputation) : lend.reputation != null)
            return false;
        if (lendId != null ? !lendId.equals(lend.lendId) : lend.lendId != null) return false;
        if (lendStatus != null ? !lendStatus.equals(lend.lendStatus) : lend.lendStatus != null) return false;
        if (sharingDate != null ? !sharingDate.equals(lend.sharingDate) : lend.sharingDate != null) return false;
        if (sharingPrice != null ? !sharingPrice.equals(lend.sharingPrice) : lend.sharingPrice != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = lendId != null ? lendId.hashCode() : 0;
        result = 31 * result + (sharingPrice != null ? sharingPrice.hashCode() : 0);
        result = 31 * result + (sharingDate != null ? sharingDate.hashCode() : 0);
        result = 31 * result + (lendStatus != null ? lendStatus.hashCode() : 0);
        result = 31 * result + (conditionRating != null ? conditionRating.hashCode() : 0);
        result = 31 * result + (conditionDescription != null ? conditionDescription.hashCode() : 0);
        return result;
    }

    private Collection<BorrowBook> borrowBooksByLendId;

    public Collection<BorrowBook> getBorrowBooksByLendId() {
        return borrowBooksByLendId;
    }

    public void setBorrowBooksByLendId(Collection<BorrowBook> borrowBooksByLendId) {
        this.borrowBooksByLendId = borrowBooksByLendId;
    }

    private Collection<BorrowBook> borrowBooksByLendId_0;

    public Collection<BorrowBook> getBorrowBooksByLendId_0() {
        return borrowBooksByLendId_0;
    }

    public void setBorrowBooksByLendId_0(Collection<BorrowBook> borrowBooksByLendId_0) {
        this.borrowBooksByLendId_0 = borrowBooksByLendId_0;
    }

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

    private Collection<UserCart> userCartsByLendId;

    public Collection<UserCart> getUserCartsByLendId() {
        return userCartsByLendId;
    }

    public void setUserCartsByLendId(Collection<UserCart> userCartsByLendId) {
        this.userCartsByLendId = userCartsByLendId;
    }
}
