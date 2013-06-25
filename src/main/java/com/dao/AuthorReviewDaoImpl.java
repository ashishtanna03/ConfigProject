package com.dao;

import com.pojo.hibernate.AuthorReview;

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
}
