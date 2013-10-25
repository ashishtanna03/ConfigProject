package com.dao;

import com.pojo.custom.AuthorDetails;
import com.pojo.hibernate.*;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Transaction;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.dao.DataAccessException;

import java.util.ArrayList;
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

    public List<AuthorDetails> getTopTenAuthors() {
        try{
            Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery("select topTenAuthors.authorInfoByAuthorId.authorId, topTenAuthors.authorInfoByAuthorId.authorName from TopTenAuthors topTenAuthors order by topTenAuthors.id");
            List<AuthorDetails> topTenAuthors = new ArrayList<AuthorDetails>(0);
            for(Object[] obj : (List<Object[]>)query.list()) {
                AuthorDetails authorDetails = new AuthorDetails();
                authorDetails.setAuthorId((Integer) obj[0]);
                authorDetails.setAuthorName((String) obj[1]);
                topTenAuthors.add(authorDetails);
            }
            return topTenAuthors;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<AuthorDetails> getAuthorList() {
        List<AuthorDetails> authorList = new ArrayList<AuthorDetails>(0);
        try {
            for(AuthorInfo authorInfo : getAll(AuthorInfo.class)) {
                AuthorDetails authorDetails = new AuthorDetails();
                authorDetails.setAuthorId(authorInfo.getAuthorId());
                authorDetails.setAuthorName(authorInfo.getAuthorName());
                authorList.add(authorDetails);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return authorList;
    }

    public List<PublisherInfo> getPublisherList() {
        try {
            return hibernateTemplate.loadAll(PublisherInfo.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Genres> getGenreList() {
        try {
            return hibernateTemplate.loadAll(Genres.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Genres getGenreById(Integer genreId) {
        try {
            return hibernateTemplate.get(Genres.class, genreId);
        } catch (HibernateException e) {
            e.printStackTrace();
            return null;
        }
    }

    public Boolean addNewAuthor(AuthorInfo author, List<Genres> authorGenres) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {

            //saving author's object before adding genres
            saveObject(author);

            //setting Genres of the author
            for(Genres genre : authorGenres) {
                AuthorGenres authorGenre = new AuthorGenres();
                authorGenre.setGenresByGenreId(genre);
                authorGenre.setAuthorInfoByAuthorId(author);
                saveObject(authorGenre);
            }

            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }

    public Boolean addNewPublisher(PublisherInfo publisher) {
        try {
            return saveObject(publisher);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean addNewGenre(Genres genre) {
        try {
            return saveObject(genre);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean saveAuthorImage(AuthorInfo author) {
        try {
            return updateObject(author);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
