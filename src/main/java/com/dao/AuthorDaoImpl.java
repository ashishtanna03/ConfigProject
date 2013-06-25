package com.dao;

import com.pojo.hibernate.AuthorFollow;
import com.pojo.hibernate.AuthorFollowPK;
import com.pojo.hibernate.AuthorInfo;
import com.pojo.hibernate.UserInfo;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.dao.DataAccessException;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/11/13
 * Time: 12:48 AM
 * To change this template use File | Settings | File Templates.
 */
public class AuthorDaoImpl extends GenericDao<AuthorInfo> {

    public AuthorInfo getAuthorById(Integer authorId) {
        try {
            return getById(AuthorInfo.class, authorId);
        } catch (HibernateException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<String> getSuggestionsByName(String fieldName, String fieldValue) {
        try {
            return getSuggestions(AuthorInfo.class,fieldName,fieldValue);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Boolean isUserFollowingAuthor(UserInfo user, AuthorInfo author) {
        try {
            DetachedCriteria detachedCriteria = DetachedCriteria.forClass(AuthorFollow.class);
            detachedCriteria.add(Restrictions.conjunction()
                    .add(Restrictions.eq("authorInfoByAuthorId",author))
                    .add(Restrictions.eq("userInfoByUserId",user))
            );
            if(hibernateTemplate.findByCriteria(detachedCriteria).size()>0)
                return true;
            else
                return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean followAuthor(AuthorInfo authorInfo, UserInfo userInfo) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {
            AuthorFollow authorFollow = new AuthorFollow();
            authorFollow.setAuthorInfoByAuthorId(authorInfo);
            authorFollow.setUserInfoByUserId(userInfo);

            saveObject(authorFollow);
            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }

    public Boolean unfollowAuthor(AuthorInfo authorInfo, UserInfo userInfo) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {
            AuthorFollow authorFollow = new AuthorFollow();
            authorFollow.setAuthorInfoByAuthorId(authorInfo);
            authorFollow.setUserInfoByUserId(userInfo);

            hibernateTemplate.delete(authorFollow);
            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }
}
