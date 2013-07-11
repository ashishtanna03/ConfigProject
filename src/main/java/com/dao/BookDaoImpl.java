package com.dao;

import com.pojo.custom.BookDetails;
import com.pojo.hibernate.*;
import org.hibernate.HibernateException;
import org.hibernate.Transaction;
import org.hibernate.criterion.*;

import java.util.ArrayList;
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

    public List<BookDetails> getRelatedBooks(BookInfo book) {

        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(BookInfo.class)
                .createAlias("bookAuthorsesByBookId","authors")
                .createAlias("authors.authorInfoByAuthorId", "author")
                .createAlias("bookGenresesByBookId","genres")
                .createAlias("genres.genresByGenreId", "genre");

        Disjunction disjunction = Restrictions.disjunction();

        for(BookAuthors bookAuthors : book.getBookAuthorsesByBookId()) {
            disjunction.add(Restrictions.eq("author.authorId", bookAuthors.getAuthorId()));
        }

        for(BookGenres bookGenres : book.getBookGenresesByBookId()) {
            disjunction.add(Restrictions.eq("genre.genreId", bookGenres.getGenreId()));
        }

        detachedCriteria.add(Restrictions.conjunction()
                .add(Restrictions.eq("bookLanguage", book.getBookLanguage()))
                .add(disjunction)
                .add(Restrictions.ne("bookId",book.getBookId()))
        );

        detachedCriteria.setResultTransformer(DetachedCriteria.DISTINCT_ROOT_ENTITY);

        List<BookDetails> relatedBooks = new ArrayList<BookDetails>(0);
        List<BookInfo> resultList = hibernateTemplate.findByCriteria(detachedCriteria, 0, 6);
        for(BookInfo relatedBookInfo : resultList) {
            BookDetails relatedBookDetails = new BookDetails();
            relatedBookDetails.setBookId(relatedBookInfo.getBookId());
            relatedBookDetails.setBookTitle(relatedBookInfo.getBookTitle());
            relatedBookDetails.setBookImgUrl(relatedBookInfo.getBookImgUrl());

            relatedBooks.add(relatedBookDetails);
        }

        return relatedBooks;
    }

    public Boolean requestBook(BookInfo book, UserInfo user) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {
            RequestedBooks requestedBooks = new RequestedBooks();
            requestedBooks.setBookInfoByBookId(book);
            requestedBooks.setUserInfoByUserId(user);
            hibernateTemplate.saveOrUpdate(requestedBooks);
            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }
}