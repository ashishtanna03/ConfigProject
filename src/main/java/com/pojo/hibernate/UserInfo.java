package com.pojo.hibernate;

import java.io.Serializable;
import java.util.Date;
import java.util.Collection;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserInfo implements Serializable{
    private Integer userId;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    private String firstName;

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    private String lastName;

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    private String userGender;

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    private String userImg;

    public String getUserImg() {
        return userImg;
    }

    public void setUserImg(String userImg) {
        this.userImg = userImg;
    }

    private Date userBirthdate;

    public Date getUserBirthdate() {
        return userBirthdate;
    }

    public void setUserBirthdate(Date userBirthdate) {
        this.userBirthdate = userBirthdate;
    }

    private String userOccupation;

    public String getUserOccupation() {
        return userOccupation;
    }

    public void setUserOccupation(String userOccupation) {
        this.userOccupation = userOccupation;
    }

    private String userQualification;

    public String getUserQualification() {
        return userQualification;
    }

    public void setUserQualification(String userQualification) {
        this.userQualification = userQualification;
    }

    private Integer userPostalCode;

    public Integer getUserPostalCode() {
        return userPostalCode;
    }

    public void setUserPostalCode(Integer userPostalCode) {
        this.userPostalCode = userPostalCode;
    }

    private String userAddress;

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    private String userCity;

    public String getUserCity() {
        return userCity;
    }

    public void setUserCity(String userCity) {
        this.userCity = userCity;
    }

    private String userContact;

    public String getUserContact() {
        return userContact;
    }

    public void setUserContact(String userContact) {
        this.userContact = userContact;
    }

    private Integer userBalance;

    public Integer getUserBalance() {
        return userBalance;
    }

    public void setUserBalance(Integer userBalance) {
        this.userBalance = userBalance;
    }

    private String userWebsite;

    public String getUserWebsite() {
        return userWebsite;
    }

    public void setUserWebsite(String userWebsite) {
        this.userWebsite = userWebsite;
    }

    private Boolean emailVerified;

    public Boolean getEmailVerified() {
        return emailVerified;
    }

    public void setEmailVerified(Boolean emailVerified) {
        this.emailVerified = emailVerified;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserInfo userInfo = (UserInfo) o;

        if (emailVerified != null ? !emailVerified.equals(userInfo.emailVerified) : userInfo.emailVerified != null)
            return false;
        if (firstName != null ? !firstName.equals(userInfo.firstName) : userInfo.firstName != null) return false;
        if (lastName != null ? !lastName.equals(userInfo.lastName) : userInfo.lastName != null) return false;
        if (userAddress != null ? !userAddress.equals(userInfo.userAddress) : userInfo.userAddress != null)
            return false;
        if (userBalance != null ? !userBalance.equals(userInfo.userBalance) : userInfo.userBalance != null)
            return false;
        if (userBirthdate != null ? !userBirthdate.equals(userInfo.userBirthdate) : userInfo.userBirthdate != null)
            return false;
        if (userCity != null ? !userCity.equals(userInfo.userCity) : userInfo.userCity != null) return false;
        if (userContact != null ? !userContact.equals(userInfo.userContact) : userInfo.userContact != null)
            return false;
        if (userGender != null ? !userGender.equals(userInfo.userGender) : userInfo.userGender != null) return false;
        if (userId != null ? !userId.equals(userInfo.userId) : userInfo.userId != null) return false;
        if (userImg != null ? !userImg.equals(userInfo.userImg) : userInfo.userImg != null) return false;
        if (userOccupation != null ? !userOccupation.equals(userInfo.userOccupation) : userInfo.userOccupation != null)
            return false;
        if (userPostalCode != null ? !userPostalCode.equals(userInfo.userPostalCode) : userInfo.userPostalCode != null)
            return false;
        if (userQualification != null ? !userQualification.equals(userInfo.userQualification) : userInfo.userQualification != null)
            return false;
        if (userWebsite != null ? !userWebsite.equals(userInfo.userWebsite) : userInfo.userWebsite != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userId != null ? userId.hashCode() : 0;
        result = 31 * result + (firstName != null ? firstName.hashCode() : 0);
        result = 31 * result + (lastName != null ? lastName.hashCode() : 0);
        result = 31 * result + (userGender != null ? userGender.hashCode() : 0);
        result = 31 * result + (userImg != null ? userImg.hashCode() : 0);
        result = 31 * result + (userBirthdate != null ? userBirthdate.hashCode() : 0);
        result = 31 * result + (userOccupation != null ? userOccupation.hashCode() : 0);
        result = 31 * result + (userQualification != null ? userQualification.hashCode() : 0);
        result = 31 * result + (userPostalCode != null ? userPostalCode.hashCode() : 0);
        result = 31 * result + (userAddress != null ? userAddress.hashCode() : 0);
        result = 31 * result + (userCity != null ? userCity.hashCode() : 0);
        result = 31 * result + (userContact != null ? userContact.hashCode() : 0);
        result = 31 * result + (userBalance != null ? userBalance.hashCode() : 0);
        result = 31 * result + (userWebsite != null ? userWebsite.hashCode() : 0);
        result = 31 * result + (emailVerified != null ? emailVerified.hashCode() : 0);
        return result;
    }

    private Collection<AuthorFollow> authorFollowsByUserId;

    public Collection<AuthorFollow> getAuthorFollowsByUserId() {
        return authorFollowsByUserId;
    }

    public void setAuthorFollowsByUserId(Collection<AuthorFollow> authorFollowsByUserId) {
        this.authorFollowsByUserId = authorFollowsByUserId;
    }

    private Collection<AuthorReview> authorReviewsByUserId;

    public Collection<AuthorReview> getAuthorReviewsByUserId() {
        return authorReviewsByUserId;
    }

    public void setAuthorReviewsByUserId(Collection<AuthorReview> authorReviewsByUserId) {
        this.authorReviewsByUserId = authorReviewsByUserId;
    }

    private Collection<BookRating> bookRatingsByUserId;

    public Collection<BookRating> getBookRatingsByUserId() {
        return bookRatingsByUserId;
    }

    public void setBookRatingsByUserId(Collection<BookRating> bookRatingsByUserId) {
        this.bookRatingsByUserId = bookRatingsByUserId;
    }

    private Collection<BookRequest> bookRequestsByUserId;

    public Collection<BookRequest> getBookRequestsByUserId() {
        return bookRequestsByUserId;
    }

    public void setBookRequestsByUserId(Collection<BookRequest> bookRequestsByUserId) {
        this.bookRequestsByUserId = bookRequestsByUserId;
    }

    private Collection<BookReview> bookReviewsByUserId;

    public Collection<BookReview> getBookReviewsByUserId() {
        return bookReviewsByUserId;
    }

    public void setBookReviewsByUserId(Collection<BookReview> bookReviewsByUserId) {
        this.bookReviewsByUserId = bookReviewsByUserId;
    }

    private Collection<BookReviewLike> bookReviewLikesByUserId;

    public Collection<BookReviewLike> getBookReviewLikesByUserId() {
        return bookReviewLikesByUserId;
    }

    public void setBookReviewLikesByUserId(Collection<BookReviewLike> bookReviewLikesByUserId) {
        this.bookReviewLikesByUserId = bookReviewLikesByUserId;
    }

    private Collection<BorrowBook> borrowBooksByUserId;

    public Collection<BorrowBook> getBorrowBooksByUserId() {
        return borrowBooksByUserId;
    }

    public void setBorrowBooksByUserId(Collection<BorrowBook> borrowBooksByUserId) {
        this.borrowBooksByUserId = borrowBooksByUserId;
    }

    private Collection<FriendshipMapping> friendshipMappingsByUserId;

    public Collection<FriendshipMapping> getFriendshipMappingsByUserId() {
        return friendshipMappingsByUserId;
    }

    public void setFriendshipMappingsByUserId(Collection<FriendshipMapping> friendshipMappingsByUserId) {
        this.friendshipMappingsByUserId = friendshipMappingsByUserId;
    }

    private Collection<FriendshipMapping> friendshipMappingsByUserId_0;

    public Collection<FriendshipMapping> getFriendshipMappingsByUserId_0() {
        return friendshipMappingsByUserId_0;
    }

    public void setFriendshipMappingsByUserId_0(Collection<FriendshipMapping> friendshipMappingsByUserId_0) {
        this.friendshipMappingsByUserId_0 = friendshipMappingsByUserId_0;
    }

    private Collection<Lend> lendsByUserId;

    public Collection<Lend> getLendsByUserId() {
        return lendsByUserId;
    }

    public void setLendsByUserId(Collection<Lend> lendsByUserId) {
        this.lendsByUserId = lendsByUserId;
    }

    private Collection<Notification> notificationsByUserId;

    public Collection<Notification> getNotificationsByUserId() {
        return notificationsByUserId;
    }

    public void setNotificationsByUserId(Collection<Notification> notificationsByUserId) {
        this.notificationsByUserId = notificationsByUserId;
    }

    private Collection<Notification> notificationsByUserId_0;

    public Collection<Notification> getNotificationsByUserId_0() {
        return notificationsByUserId_0;
    }

    public void setNotificationsByUserId_0(Collection<Notification> notificationsByUserId_0) {
        this.notificationsByUserId_0 = notificationsByUserId_0;
    }

    private Collection<Shelf> shelfsByUserId;

    public Collection<Shelf> getShelfsByUserId() {
        return shelfsByUserId;
    }

    public void setShelfsByUserId(Collection<Shelf> shelfsByUserId) {
        this.shelfsByUserId = shelfsByUserId;
    }

    private Collection<UserFavGenres> userFavGenresesByUserId;

    public Collection<UserFavGenres> getUserFavGenresesByUserId() {
        return userFavGenresesByUserId;
    }

    public void setUserFavGenresesByUserId(Collection<UserFavGenres> userFavGenresesByUserId) {
        this.userFavGenresesByUserId = userFavGenresesByUserId;
    }

    private LoginInfo loginInfoByEmailId;

    public LoginInfo getLoginInfoByEmailId() {
        return loginInfoByEmailId;
    }

    public void setLoginInfoByEmailId(LoginInfo loginInfoByEmailId) {
        this.loginInfoByEmailId = loginInfoByEmailId;
    }

    private Collection<UserCart> userCartsByUserId;

    public Collection<UserCart> getUserCartsByUserId() {
        return userCartsByUserId;
    }

    public void setUserCartsByUserId(Collection<UserCart> userCartsByUserId) {
        this.userCartsByUserId = userCartsByUserId;
    }
}
