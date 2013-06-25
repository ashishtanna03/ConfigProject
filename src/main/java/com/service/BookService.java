package com.service;

import com.dao.BookDaoImpl;
import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.UserInfo;
import org.hibernate.criterion.DetachedCriteria;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/10/13
 * Time: 6:34 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookService {
    private BookDaoImpl bookDao;

    public void setBookDao(BookDaoImpl bookDao) {
        this.bookDao = bookDao;
    }

    public BookInfo getBookById(Integer bookId) {
        return bookDao.getBookById(bookId);
    }

    /*-----Suggestions----*/
    public List<String> getSuggestionsByBookName(String fieldValue) {
        return bookDao.getSuggestionsByName("bookTitle", fieldValue);
    }

    public List<String> getSuggestionsByIsbn10(String fieldValue) {
        return bookDao.getSuggestionsByName("isbn10",fieldValue);
    }

    public List<String> getSuggestionsByIsbn13(String fieldValue) {
        return bookDao.getSuggestionsByName("isbn13",fieldValue);
    }

    public List<String> getSuggestionsByPublisherName(String fieldValue) {
        return bookDao.getSuggestionsByName("publisherInfoByPublisherId.publisherName",fieldValue);
    }
    /*-----/Suggestions----*/

    public List<BookInfo> getSearchResults(DetachedCriteria detachedCriteria) {
        return bookDao.getSearchResults(detachedCriteria);
    }

    /*public Integer getNoOfPossibleResults(DetachedCriteria detachedCriteria) {
        return bookDao.getNoOfPossibleResults(detachedCriteria);
    }*/

    public List<BookInfo> getAuthorBooks(Integer authorId) {
        return bookDao.getAuthorBooks(authorId);
    }

    public Boolean saveRating(Integer bookId, UserInfo user, Float rating) {
        return bookDao.saveRating(getBookById(bookId),user,rating);
    }

    public Float getUserRating(BookInfo book, UserInfo user) {
        return bookDao.getUserRating(book,user);
    }
}
