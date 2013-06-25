package com.service;

import com.dao.AuthorDaoImpl;
import com.pojo.hibernate.AuthorInfo;
import com.pojo.hibernate.UserInfo;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/11/13
 * Time: 12:48 AM
 * To change this template use File | Settings | File Templates.
 */
public class AuthorService {
    private AuthorDaoImpl authorDao;

    private UserService userService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setAuthorDao(AuthorDaoImpl authorDao) {
        this.authorDao = authorDao;
    }

    public AuthorInfo getAuthorById(Integer authorId) {
        return authorDao.getAuthorById(authorId);
    }

    public List<String> getSuggestionsByAuthorName(String authorName) {
        return authorDao.getSuggestionsByName("authorName",authorName);
    }

    public Boolean isUserFollowingAuthor(Integer userId, Integer authorId) {
        return authorDao.isUserFollowingAuthor(userService.getUserById(userId),getAuthorById(authorId));
    }

    public Boolean followAuthor(Integer authorId, Integer userId) {
        return authorDao.followAuthor(getAuthorById(authorId),userService.getUserById(userId));
    }

    public Boolean unfollowAuthor(Integer authorId, Integer userId) {
        return authorDao.unfollowAuthor(getAuthorById(authorId),userService.getUserById(userId));
    }
}
