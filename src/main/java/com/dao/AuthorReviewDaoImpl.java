package com.dao;

import com.pojo.hibernate.AuthorReview;
import org.hibernate.Transaction;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/31/13
 * Time: 7:43 PM
 * To change this template use File | Settings | File Templates.
 */
public class AuthorReviewDaoImpl extends GenericDao<AuthorReview>{
    public List<AuthorReview> getAuthorReviews(Integer authorId) {
        return getByFieldName(AuthorReview.class,"authorInfoByAuthorId.authorId",authorId);
    }

    public Boolean saveAuthorReview(AuthorReview authorReview) {
        return saveObject(authorReview);
    }

    public Boolean deleteComment(Integer authorId, String userEmailId) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {

            List<AuthorReview> usersComments = hibernateTemplate.find("from AuthorReview authorReview where authorReview.authorInfoByAuthorId.authorId="+authorId+" AND authorReview.userInfoByUserId.loginInfoByEmailId.emailId='"+userEmailId+"'");

            if(usersComments.size()==1) {
                hibernateTemplate.delete(usersComments.get(0));
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
