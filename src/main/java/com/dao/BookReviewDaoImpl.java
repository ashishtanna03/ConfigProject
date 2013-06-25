package com.dao;

import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.BookReview;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/31/13
 * Time: 2:56 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookReviewDaoImpl extends GenericDao<BookReview> {

    public List<BookReview> getBookReviews(Integer bookId) {
        return getByFieldName(BookReview.class,"bookInfoByBookId.bookId",bookId);
    }

    public Boolean saveBookReview(BookReview bookReview) {
        return saveObject(bookReview);
    }

    public List<BookInfo> getSuggestedBooks(Integer bookId) {
        return hibernateTemplate.find("select distinct bookReview.bookInfoBySuggestedBookId from BookReview bookReview where bookReview.bookInfoByBookId.bookId="+bookId);
    }
}
