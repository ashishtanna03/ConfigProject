package com.dao;

import com.pojo.hibernate.BookInfo;
import com.pojo.hibernate.BookRating;
import com.pojo.hibernate.UserInfo;
import org.hibernate.HibernateException;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/10/13
 * Time: 6:35 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookDaoImpl extends GenericDao<BookInfo> {

    public BookInfo getBookById(Integer bookId) {
        try {
            return getById(BookInfo.class, bookId);
        } catch (HibernateException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<String> getSuggestionsByName(String fieldName,String fieldValue) {
        return getSuggestions(BookInfo.class,fieldName,fieldValue);
    }

    public List<BookInfo> getSearchResults(DetachedCriteria detachedCriteria) {

        return hibernateTemplate.findByCriteria(detachedCriteria);
//        return hibernateTemplate.findByCriteria(detachedCriteria,firstResult,maxResults);
        /*        .find("from BookInfo where "+
                "(bookTitle like '"+fieldValue+"%') or (bookTitle like '%"+fieldValue+"%') or "+
                "(authorInfo.authorName like '"+fieldValue+"%') or (authorInfo.authorName like '%"+fieldValue+"%') or " +
                "(publisherInfo.publisherName like '"+fieldValue+"%') or (publisherInfo.publisherName like '%"+fieldValue+"%') or " +
                "(isbn10 like '"+fieldValue+"%') or (isbn10 like '%"+fieldValue+"%') or "+
                "(isbn13 like '"+fieldValue+"%') or (isbn13 like '%"+fieldValue+"%')"
        );*/
    }

    /*public Integer getNoOfPossibleResults(DetachedCriteria detachedCriteria) {
        return hibernateTemplate.findByCriteria(detachedCriteria).size();
    }*/

    public List<BookInfo> getAuthorBooks(Integer authorId) {
        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(BookInfo.class)
                .createAlias("bookAuthorsesByBookId","bookAuthorsesByBookId")
                .createAlias("bookAuthorsesByBookId.authorInfoByAuthorId","authorInfoByAuthorId");
        detachedCriteria.add(Property.forName("authorInfoByAuthorId.authorId").eq(authorId));
        return hibernateTemplate.findByCriteria(detachedCriteria);
//        return getByFieldName(BookInfo.class,"bookAuthorsesByBookId.authorInfoByAuthorId.authorId",authorId);
    }

    public Boolean saveRating(BookInfo book, UserInfo user, Float rating) {
        try {
            BookRating bookRating = new BookRating();
            bookRating.setBookInfoByBookId(book);
            bookRating.setUserInfoByUserId(user);
            bookRating.setRating(rating);
            hibernateTemplate.saveOrUpdate(bookRating);
            return true;
        } catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public Float getUserRating(BookInfo book, UserInfo user) {
        try {
            DetachedCriteria detachedCriteria = DetachedCriteria.forClass(BookRating.class);
            detachedCriteria.add(Restrictions.conjunction()
                    .add(Restrictions.eq("bookInfoByBookId",book))
                    .add(Restrictions.eq("userInfoByUserId",user))
            );
            List<BookRating> bookRatings = hibernateTemplate.findByCriteria(detachedCriteria);
            if(bookRatings.size()==1)
                return bookRatings.get(0).getRating();
            else
                return new Float(0.0);
        } catch (Exception e) {
            e.printStackTrace();
            return new Float(0.0);
        }
    }
}
