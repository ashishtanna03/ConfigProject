package com.service;

import com.dao.BookReviewDaoImpl;
import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.BookReview;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/31/13
 * Time: 2:55 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookReviewService {

    private BookReviewDaoImpl bookReviewDao;

    public void setBookReviewDao(BookReviewDaoImpl bookReviewDao) {
        this.bookReviewDao = bookReviewDao;
    }

    public List<BookReview> getBookReviews(Integer bookId){
        return bookReviewDao.getBookReviews(bookId);
    }

    public Boolean saveBookReview(BookReview bookReview) {
        return bookReviewDao.saveBookReview(bookReview);
    }

    public List<BookInfo> getSuggestedBooks(Integer bookId){
        return bookReviewDao.getSuggestedBooks(bookId);
    }

}
