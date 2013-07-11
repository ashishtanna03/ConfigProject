package com.dao;

import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.BookReview;
import com.pojo.hibernate.UserInfo;
import org.hibernate.Transaction;

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

    public Boolean deleteBookReview(Integer bookId, String userEmailId) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {

            List<BookReview> usersBookReviews = hibernateTemplate.find("from BookReview bookReview where bookReview.bookInfoByBookId.bookId="+bookId+" AND bookReview.userInfoByUserId.loginInfoByEmailId.emailId='"+userEmailId+"'");

            if(usersBookReviews.size()==1) {
                hibernateTemplate.delete(usersBookReviews.get(0));
                transaction.commit();
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }
}
