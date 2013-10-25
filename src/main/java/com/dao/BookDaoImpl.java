package com.dao;

import com.pojo.custom.BookDetails;
import com.pojo.hibernate.*;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Transaction;
import org.hibernate.criterion.*;

import java.sql.*;
import java.util.*;
import java.util.Date;

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

    public List<BookInfo> getSearchResults(String query) {
        SQLQuery sqlQuery = hibernateTemplate.getSessionFactory().getCurrentSession().createSQLQuery(query);
        sqlQuery.addEntity(BookInfo.class);
//        Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery("select bookInfo from BookInfo bookInfo INNER JOIN BookAuthors as bookAuthors   ");
        try {
            return (List<BookInfo>)sqlQuery.list();
        } catch (HibernateException e) {
            e.printStackTrace();
            return null;
        }
//        return hibernateTemplate.findByCriteria(detachedCriteria);
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
//        DetachedCriteria detachedCriteria = DetachedCriteria.forClass(BookInfo.class)
//                .createAlias("bookAuthorsesByBookId","bookAuthorsesByBookId")
//                .createAlias("bookAuthorsesByBookId.authorInfoByAuthorId","authorInfoByAuthorId");
//        detachedCriteria.add(Property.forName("authorInfoByAuthorId.authorId").eq(authorId));

        String query = "SELECT bookinfo.* FROM book.book_info bookinfo" +
                " INNER JOIN book.book_authors bookauthors" +
                " ON bookinfo.book_id=bookauthors.book_id" +
                " INNER JOIN book.author_info authorinfo" +
                " ON bookauthors.author_id=authorinfo.author_id" +
                " WHERE authorinfo.author_id="+authorId ;
        SQLQuery sqlQuery = hibernateTemplate.getSessionFactory().getCurrentSession().createSQLQuery(query);
        sqlQuery.addEntity(BookInfo.class);
        return sqlQuery.list();
//        return hibernateTemplate.findByCriteria(detachedCriteria);
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

        String filterQuery = " ( ";

        String query= "SELECT DISTINCT bookinfo.* " +
                "FROM   book.book_info bookinfo" +
                "   INNER JOIN book.book_authors bookauthors" +
                "           ON bookinfo.book_id = bookauthors.book_id" +
                "   INNER JOIN book.author_info authorinfo" +
                "           ON bookauthors.author_id = authorinfo.author_id" +
                "   INNER JOIN book.book_genres bookgenres" +
                "           ON bookinfo.book_id = bookgenres.book_id" +
                "   INNER JOIN book.genres genre" +
                "           ON bookgenres.genre_id = genre.genre_id " +
                "WHERE  ( ";

        /*DetachedCriteria detachedCriteria = DetachedCriteria.forClass(BookInfo.class)
                .createAlias("bookGenresesByBookId","genres")
                .createAlias("genres.genresByGenreId", "genre")
                .createAlias("bookAuthorsesByBookId","authors")
                .createAlias("authors.authorInfoByAuthorId", "author");

        Disjunction disjunction = Restrictions.disjunction();*/

        for(BookAuthors bookAuthors : book.getBookAuthorsesByBookId()) {
//            disjunction.add(Restrictions.eq("author.authorId", bookAuthors.getAuthorInfoByAuthorId().getAuthorId()));
            filterQuery += " authorinfo.author_id="+bookAuthors.getAuthorInfoByAuthorId().getAuthorId()+" OR";
        }

        for(BookGenres bookGenres : book.getBookGenresesByBookId()) {
//            disjunction.add(Restrictions.eq("genre.genreId", bookGenres.getGenresByGenreId().getGenreId()));
            filterQuery += " genre.genre_id="+bookGenres.getGenresByGenreId().getGenreId()+" OR";
        }

        filterQuery += " 1=2 )";//ending filter

        /*detachedCriteria.add(Restrictions.conjunction()
                .add(Restrictions.eq("bookLanguage", book.getBookLanguage()))
                .add(disjunction)
                .add(Restrictions.ne("bookId",book.getBookId()))
        );*/

        query += "bookinfo.book_id!="+book.getBookId()+" AND bookinfo.book_language='"+book.getBookLanguage()+"' AND"+filterQuery+") LIMIT 0, 6";

//        detachedCriteria.setResultTransformer(DetachedCriteria.DISTINCT_ROOT_ENTITY);

        SQLQuery sqlQuery = hibernateTemplate.getSessionFactory().getCurrentSession().createSQLQuery(query);
        sqlQuery.addEntity(BookInfo.class);

        List<BookDetails> relatedBooks = new ArrayList<BookDetails>(0);
        List<BookInfo> resultList = sqlQuery.list();//hibernateTemplate.findByCriteria(detachedCriteria, 0, 6);
        for(BookInfo relatedBookInfo : resultList) {
            BookDetails relatedBookDetails = new BookDetails();
            relatedBookDetails.setBookId(relatedBookInfo.getBookId());
            relatedBookDetails.setBookTitle(relatedBookInfo.getBookTitle());
            relatedBookDetails.setBookImgUrl(relatedBookInfo.getBookImgUrl());

            relatedBooks.add(relatedBookDetails);
        }

        return relatedBooks;
    }

    public Boolean requestBook(BookInfo book, UserInfo user, List<UserInfo> friends) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {
            RequestedBooks requestedBooks = new RequestedBooks();
            requestedBooks.setBookInfoByBookId(book);
            requestedBooks.setUserInfoByUserId(user);
            hibernateTemplate.saveOrUpdate(requestedBooks);

            //sending notification to user's friend that user has requested the book
            for (UserInfo friend : friends){
                Notification notification = new Notification();
                notification.setUserInfoBySenderId(user);
                notification.setUserInfoByReceiverId(friend);
                notification.setObjectId(book.getBookId());
                notification.setNotificationType(3); //friend has requested a book
                notification.setDate(new Date());
                notification.setStatus(0);
                saveObject(notification);
            }

            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }

    public List<BookInfo> getRecentlySharedBooks() {
        try {
            Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery("select lend.bookInfoByBookId from Lend lend where lend.lendStatus!=1 order by lend.lendId desc");
            query.setMaxResults(32);

            //to get distinct book infos, because using query changes the order
            List<BookInfo> uniqueBooks = new ArrayList<BookInfo>(0);
            for (BookInfo bookInfo : (List<BookInfo>)query.list()) {
                if(!uniqueBooks.contains(bookInfo))
                    uniqueBooks.add(bookInfo);
            }
            return uniqueBooks;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<BookInfo> getBooksInDemand() {
        try{
            Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery("select distinct booksInDemand.bookInfoByBookId from BooksInDemand booksInDemand order by booksInDemand.id");
            query.setMaxResults(16);

            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<BookInfo> getRecentlyBoughtBooks() {
        try {
            Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery("select borrowBook.bookInfoByBookId from BorrowBook borrowBook order by borrowBook.borrowId desc");
            query.setMaxResults(32);

            //to get distinct book infos, because using query changes the order
            List<BookInfo> uniqueBooks = new ArrayList<BookInfo>(0);
            for (BookInfo bookInfo : (List<BookInfo>)query.list()) {
                if(!uniqueBooks.contains(bookInfo))
                    uniqueBooks.add(bookInfo);
            }
            return uniqueBooks;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<BookInfo> getMostSharedBooks() {
        try{
            Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery("select book from BookInfo book, Lend lend where book.bookId=lend.bookInfoByBookId.bookId group by book.bookId order by count (lend.lendId) desc, book.bookId ");
            query.setMaxResults(16);

            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<String> getGenresList() {
        try{
            return hibernateTemplate.find("select genre.genreName from Genres genre order by genre.genreName");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<BookDetails> getTopTenBooks() {
        try{
            Query query = hibernateTemplate.getSessionFactory().getCurrentSession().createQuery("select topTenBooks.bookInfoByBookId.bookId, topTenBooks.bookInfoByBookId.bookTitle from TopTenBooks topTenBooks order by topTenBooks.id");
            List<BookDetails> topTenBooks = new ArrayList<BookDetails>(0);
            for(Object[] obj : (List<Object[]>)query.list()) {
                BookDetails bookDetails = new BookDetails();
                bookDetails.setBookId((Integer) obj[0]);
                bookDetails.setBookTitle((String) obj[1]);
                topTenBooks.add(bookDetails);
            }
            return topTenBooks;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // method used before adding a book
    public Boolean checkIfBookExists(String isbn) {
        try {
            List<BookInfo> existingBooks = (List<BookInfo>)hibernateTemplate.find("from BookInfo book where book.isbn10="+isbn+" or book.isbn13="+isbn);
            return existingBooks != null && existingBooks.size() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean addBook(BookInfo bookInfo) {
        try {
            return saveObject(bookInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Boolean addNewBook(BookInfo bookInfo, List<AuthorInfo> bookAuthors, List<Genres> bookGenres, Integer publisherId) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {
            //setting publisher of book
            bookInfo.setPublisherInfoByPublisherId(hibernateTemplate.get(PublisherInfo.class, publisherId));

            //saving book's object before adding authors and genres
            saveObject(bookInfo);

            //setting authors of the book
            for(AuthorInfo authorInfo : bookAuthors) {
                BookAuthors bookAuthor = new BookAuthors();
                bookAuthor.setBookInfoByBookId(bookInfo);
                bookAuthor.setAuthorInfoByAuthorId(authorInfo);
                saveObject(bookAuthor);

                //setting notification to the users who are following this author that new book added of the author
                for(AuthorFollow authorFollow : authorInfo.getAuthorFollowsByAuthorId()) {
                    Notification notification = new Notification();
                    notification.setUserInfoBySenderId(null);
                    notification.setUserInfoByReceiverId(authorFollow.getUserInfoByUserId());
                    notification.setObjectId(authorInfo.getAuthorId());
                    notification.setNotificationType(7); //new book of the author you are following
                    notification.setDate(new Date());
                    notification.setStatus(0);
                    saveObject(notification);
                }
            }

            //setting Genres of the book
            for(Genres genre : bookGenres) {
                BookGenres bookGenre = new BookGenres();
                bookGenre.setGenresByGenreId(genre);
                bookGenre.setBookInfoByBookId(bookInfo);
                saveObject(bookGenre);
            }

            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }

    public Boolean saveBookImage(BookInfo book) {
        try {
            return updateObject(book);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public PublisherInfo getPublisherInfoById(Integer publisherId) {
        try {
            return hibernateTemplate.get(PublisherInfo.class, 1);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}