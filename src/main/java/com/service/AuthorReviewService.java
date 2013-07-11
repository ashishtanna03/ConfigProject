package com.service;

import com.dao.AuthorReviewDaoImpl;
import com.pojo.hibernate.AuthorReview;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/31/13
 * Time: 7:33 PM
 * To change this template use File | Settings | File Templates.
 */
public class AuthorReviewService {

    private AuthorReviewDaoImpl authorReviewDao;

    public void setAuthorReviewDao(AuthorReviewDaoImpl authorReviewDao) {
        this.authorReviewDao = authorReviewDao;
    }

    public List<AuthorReview> getAuthorReviews(Integer authorId){
        return authorReviewDao.getAuthorReviews(authorId);
    }

    public Boolean saveAuthorReview(AuthorReview authorReview) {
        return authorReviewDao.saveAuthorReview(authorReview);
    }

    public Boolean deleteComment(Integer authorId, String userEmailId) {
        return authorReviewDao.deleteComment(authorId, userEmailId);
    }
}
