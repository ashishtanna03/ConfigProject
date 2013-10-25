package com.service;

import com.dao.BookDaoImpl;
import com.pojo.custom.BookDetails;
import com.pojo.hibernate.*;
import org.hibernate.criterion.DetachedCriteria;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/10/13
 * Time: 6:34 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookService {

    private UserService userService;

    private BookDaoImpl bookDao;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public void setBookDao(BookDaoImpl bookDao) {
        this.bookDao = bookDao;
    }

    public BookInfo getBookById(Integer bookId) {
        return bookDao.getBookById(bookId);
    }

    /*-----Suggestions----*/
    public List<String> getSuggestionsByBookName(String fieldValue) {
        return bookDao.getSuggestionsByName("bookTitle", fieldValue);
    }

    public List<String> getSuggestionsByIsbn10(String fieldValue) {
        return bookDao.getSuggestionsByName("isbn10",fieldValue);
    }

    public List<String> getSuggestionsByIsbn13(String fieldValue) {
        return bookDao.getSuggestionsByName("isbn13",fieldValue);
    }

    public List<String> getSuggestionsByPublisherName(String fieldValue) {
        return bookDao.getSuggestionsByName("publisherInfoByPublisherId.publisherName",fieldValue);
    }
    /*-----/Suggestions----*/

    public List<BookInfo> getSearchResults(String query) {
        return bookDao.getSearchResults(query);
    }

    /*public Integer getNoOfPossibleResults(DetachedCriteria detachedCriteria) {
        return bookDao.getNoOfPossibleResults(detachedCriteria);
    }*/

    public List<BookInfo> getAuthorBooks(Integer authorId) {
        return bookDao.getAuthorBooks(authorId);
    }

    public Boolean saveRating(Integer bookId, UserInfo user, Float rating) {
        return bookDao.saveRating(getBookById(bookId),user,rating);
    }

    public Float getUserRating(BookInfo book, UserInfo user) {
        return bookDao.getUserRating(book,user);
    }

    public List<BookDetails> getRelatedBooks(Integer bookId) {
        return bookDao.getRelatedBooks(getBookById(bookId));
    }

    public Boolean requestBook(Integer bookId, UserInfo user) {

        List<UserInfo> friends = new ArrayList<UserInfo>(0);
        for (FriendshipMapping friendshipMapping : user.getFriendshipMappingsByUserId()) {
            friends.add(friendshipMapping.getUserInfoByUser2());
        }
        for (FriendshipMapping friendshipMapping : user.getFriendshipMappingsByUserId_0()) {
            friends.add(friendshipMapping.getUserInfoByUser1());
        }

        return bookDao.requestBook(getBookById(bookId), user, friends);
    }

    /*----------Methods For Home Page-----------*/
    public List<BookInfo> getRecentlySharedBooks() {
        return bookDao.getRecentlySharedBooks();
    }

    public List<BookInfo> getBooksInDemand() {
        return bookDao.getBooksInDemand();
    }

    public List<BookInfo> getRecentlyBoughtBooks() {
        return bookDao.getRecentlyBoughtBooks();
    }

    public List<BookInfo> getMostSharedBooks() {
        return bookDao.getMostSharedBooks();
    }

    public List<String> getGenresList() {
        return bookDao.getGenresList();
    }
    /*----------/Methods For Home Page-----------*/

    public List<BookDetails> getTopTenBooks() {
        return bookDao.getTopTenBooks();
    }

    // method used before adding a book
    public Boolean checkIfBookExists(String isbn) {
        return bookDao.checkIfBookExists(isbn);
    }

    public Boolean addBook(BookInfo bookInfo) {
        return bookDao.addBook(bookInfo);
    }

    public Boolean addNewBook(BookInfo bookInfo, List<AuthorInfo> bookAuthors, List<Genres> bookGenres, Integer publisherId) {
        return bookDao.addNewBook(bookInfo, bookAuthors, bookGenres, publisherId);
    }

    public Boolean saveBookImage(BookInfo book) {
        return bookDao.saveBookImage(book);
    }

    public PublisherInfo getPublisherInfoById(Integer publisherId) {
        return bookDao.getPublisherInfoById(publisherId);
    }
}
