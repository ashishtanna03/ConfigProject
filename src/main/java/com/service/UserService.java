package com.service;

import com.dao.UserDaoImpl;
import com.pojo.hibernate.AuthorInfo;
import com.pojo.hibernate.Genres;
import com.pojo.hibernate.UserInfo;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/10/13
 * Time: 4:31 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserService {

    private UserDaoImpl userDao;
    private LendService lendService;
    private BookService bookService;

    public void setUserDao(UserDaoImpl userDao) {
        this.userDao = userDao;
    }

    public void setLendService(LendService lendService) {
        this.lendService = lendService;
    }

    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    public UserInfo getUserById(String emailId) {
        List<UserInfo> users = userDao.getUserById(emailId);
        if (users != null && users.size() != 0)
            return users.get(0);
        else
            return null;
    }

    public Boolean isContactNoExists(String contactNo) {
        return userDao.isContactNoExists(contactNo);
    }

    public Boolean saveUserInfo(UserInfo userInfo) {
        return userDao.saveObject(userInfo);
    }

    public Boolean update(UserInfo userInfo) {
        return userDao.update(userInfo);
    }

    public Boolean update(UserInfo userInfo, List<Genres> userGenres) {
        return userDao.update(userInfo, userGenres);
    }

    public Boolean changeContactNo(String emailId, String contactNo) {
        return userDao.changeContactNo(getUserById(emailId), contactNo);
    }

    public UserInfo getUserById(Integer userId) {
        return userDao.getUserById(userId);
    }

    public Boolean isUserFriend(String user1EmailId,String user2EmailId) {
        return userDao.isUserFriend(getUserById(user1EmailId),getUserById(user2EmailId));
    }

    public Boolean addAsFriend(String user1EmailId, Integer user2UserId) {
        return userDao.addAsFriend(getUserById(user1EmailId),getUserById(user2UserId));
    }

    public Boolean cancelFriendRequest(String user1EmailId, Integer user2UserId) {
        return userDao.cancelFriendRequest(getUserById(user1EmailId),getUserById(user2UserId));
    }

    public Boolean unfriend(String user1EmailId, Integer user2UserId) {
        return userDao.unfriend(getUserById(user1EmailId),getUserById(user2UserId));
    }

    public Boolean addToCart(String emailId, Integer lendId) {
        return userDao.addToCart(getUserById(emailId),lendService.getLendById(lendId));
    }

    public Boolean checkout(String emailId, Integer pincode, String address) {
        return userDao.checkout(getUserById(emailId), pincode, address);
    }

    public void deleteItem(String emailId, Integer lendId) {
        userDao.deleteItem(getUserById(emailId),lendService.getLendById(lendId));
    }

    public Boolean addToWishList(String emailId, Integer bookId) {
        return userDao.addToWishList(getUserById(emailId), bookService.getBookById(bookId));
    }

    public Boolean acceptRequest(String receiverEmailId, Integer senderId) {
        return userDao.acceptRequest(getUserById(receiverEmailId), getUserById(senderId));
    }

    public Boolean removeBookFromWishList(String emailId, Integer bookId) {
        return userDao.removeBookFromWishList(getUserById(emailId), bookService.getBookById(bookId));
    }

    public Boolean removeRequestedBook(String emailId, Integer bookId) {
        return userDao.removeRequestedBook(getUserById(emailId), bookId);
    }

    public Boolean setUserReputation(Integer lendId, Integer reputation) {
        return userDao.setUserReputation(lendService.getLendById(lendId), reputation);
    }

    public Boolean changeProfilePicture(Integer userId,String imageUrl) {
        return userDao.changeProfilePicture(getUserById(userId),imageUrl);
    }

    public Boolean cancelOrder(String emailId, Integer borrowId) {
        return userDao.cancelOrder(getUserById(emailId), borrowId);
    }
}
