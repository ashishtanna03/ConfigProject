package com.service;

import com.dao.AuthorDaoImpl;
import com.pojo.custom.AuthorDetails;
import com.pojo.hibernate.AuthorInfo;
import com.pojo.hibernate.Genres;
import com.pojo.hibernate.PublisherInfo;
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

    public List<AuthorDetails> getTopTenAuthors() {
        return authorDao.getTopTenAuthors();
    }

    /*--------Admin Panel Mathods---------*/
    public List<AuthorDetails> getAuthorList() {
        return authorDao.getAuthorList();
    }

    public List<PublisherInfo> getPublisherList() {
        return authorDao.getPublisherList();
    }

    public List<Genres> getGenreList() {
        return authorDao.getGenreList();
    }

    public Genres getGenreById(Integer genreId) {
        return authorDao.getGenreById(genreId);
    }

    public Boolean addNewAuthor(AuthorInfo authorInfo, List<Genres> authorGenres) {
        return authorDao.addNewAuthor(authorInfo, authorGenres);
    }

    public Boolean addNewPublisher(PublisherInfo publisher) {
        return authorDao.addNewPublisher(publisher);
    }

    public Boolean addNewGenre(Genres genre) {
        return authorDao.addNewGenre(genre);
    }

    public Boolean saveAuthorImage(AuthorInfo author) {
        return authorDao.saveAuthorImage(author);
    }
    /*-------/Admin Panel Methods---------*/
}
