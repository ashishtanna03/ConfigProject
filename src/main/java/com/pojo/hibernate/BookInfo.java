package com.pojo.hibernate;

import java.io.Serializable;
import java.sql.Date;
import java.util.*;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookInfo implements Serializable {
    private Integer bookId;

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    private String isbn10;

    public String getIsbn10() {
        return isbn10;
    }

    public void setIsbn10(String isbn10) {
        this.isbn10 = isbn10;
    }

    private String isbn13;

    public String getIsbn13() {
        return isbn13;
    }

    public void setIsbn13(String isbn13) {
        this.isbn13 = isbn13;
    }

    private String bookTitle;

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    private String bookSubtitle;

    public String getBookSubtitle() {
        return bookSubtitle;
    }

    public void setBookSubtitle(String bookSubtitle) {
        this.bookSubtitle = bookSubtitle;
    }

    private String bookDescription;

    public String getBookDescription() {
        return bookDescription;
    }

    public void setBookDescription(String bookDescription) {
        this.bookDescription = bookDescription;
    }

    private Integer noOfPages;

    public Integer getNoOfPages() {
        return noOfPages;
    }

    public void setNoOfPages(Integer noOfPages) {
        this.noOfPages = noOfPages;
    }

    private Integer bookMrp;

    public Integer getBookMrp() {
        return bookMrp;
    }

    public void setBookMrp(Integer bookMrp) {
        this.bookMrp = bookMrp;
    }

    private String bookLanguage;

    public String getBookLanguage() {
        return bookLanguage;
    }

    public void setBookLanguage(String bookLanguage) {
        this.bookLanguage = bookLanguage;
    }

    private String bookFormat;

    public String getBookFormat() {
        return bookFormat;
    }

    public void setBookFormat(String bookFormat) {
        this.bookFormat = bookFormat;
    }

    private String bookImgUrl;

    public String getBookImgUrl() {
        return bookImgUrl;
    }

    public void setBookImgUrl(String bookImgUrl) {
        this.bookImgUrl = bookImgUrl;
    }

    private Date publishingDate;

    public Date getPublishingDate() {
        return publishingDate;
    }

    public void setPublishingDate(Date publishingDate) {
        this.publishingDate = publishingDate;
    }

    private Boolean verified;

    public Boolean getVerified() {
        return verified;
    }

    public void setVerified(Boolean verified) {
        this.verified = verified;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BookInfo bookInfo = (BookInfo) o;

        if (bookDescription != null ? !bookDescription.equals(bookInfo.bookDescription) : bookInfo.bookDescription != null)
            return false;
        if (bookFormat != null ? !bookFormat.equals(bookInfo.bookFormat) : bookInfo.bookFormat != null) return false;
        if (bookId != null ? !bookId.equals(bookInfo.bookId) : bookInfo.bookId != null) return false;
        if (bookImgUrl != null ? !bookImgUrl.equals(bookInfo.bookImgUrl) : bookInfo.bookImgUrl != null) return false;
        if (bookLanguage != null ? !bookLanguage.equals(bookInfo.bookLanguage) : bookInfo.bookLanguage != null)
            return false;
        if (bookMrp != null ? !bookMrp.equals(bookInfo.bookMrp) : bookInfo.bookMrp != null) return false;
        if (bookSubtitle != null ? !bookSubtitle.equals(bookInfo.bookSubtitle) : bookInfo.bookSubtitle != null)
            return false;
        if (bookTitle != null ? !bookTitle.equals(bookInfo.bookTitle) : bookInfo.bookTitle != null) return false;
        if (isbn10 != null ? !isbn10.equals(bookInfo.isbn10) : bookInfo.isbn10 != null) return false;
        if (isbn13 != null ? !isbn13.equals(bookInfo.isbn13) : bookInfo.isbn13 != null) return false;
        if (noOfPages != null ? !noOfPages.equals(bookInfo.noOfPages) : bookInfo.noOfPages != null) return false;
        if (publishingDate != null ? !publishingDate.equals(bookInfo.publishingDate) : bookInfo.publishingDate != null)
            return false;
        if (verified != null ? !verified.equals(bookInfo.verified) : bookInfo.verified != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = bookId != null ? bookId.hashCode() : 0;
        result = 31 * result + (isbn10 != null ? isbn10.hashCode() : 0);
        result = 31 * result + (isbn13 != null ? isbn13.hashCode() : 0);
        result = 31 * result + (bookTitle != null ? bookTitle.hashCode() : 0);
        result = 31 * result + (bookSubtitle != null ? bookSubtitle.hashCode() : 0);
        result = 31 * result + (bookDescription != null ? bookDescription.hashCode() : 0);
        result = 31 * result + (noOfPages != null ? noOfPages.hashCode() : 0);
        result = 31 * result + (bookMrp != null ? bookMrp.hashCode() : 0);
        result = 31 * result + (bookLanguage != null ? bookLanguage.hashCode() : 0);
        result = 31 * result + (bookFormat != null ? bookFormat.hashCode() : 0);
        result = 31 * result + (bookImgUrl != null ? bookImgUrl.hashCode() : 0);
        result = 31 * result + (publishingDate != null ? publishingDate.hashCode() : 0);
        result = 31 * result + (verified != null ? verified.hashCode() : 0);
        return result;
    }

    private Collection<BookAuthors> bookAuthorsesByBookId;

    public Collection<BookAuthors> getBookAuthorsesByBookId() {
        return bookAuthorsesByBookId;
    }

    public void setBookAuthorsesByBookId(Collection<BookAuthors> bookAuthorsesByBookId) {
        this.bookAuthorsesByBookId = bookAuthorsesByBookId;
    }

    private Collection<BookGenres> bookGenresesByBookId;

    public Collection<BookGenres> getBookGenresesByBookId() {
        return bookGenresesByBookId;
    }

    public void setBookGenresesByBookId(Collection<BookGenres> bookGenresesByBookId) {
        this.bookGenresesByBookId = bookGenresesByBookId;
    }

    private PublisherInfo publisherInfoByPublisherId;

    public PublisherInfo getPublisherInfoByPublisherId() {
        return publisherInfoByPublisherId;
    }

    public void setPublisherInfoByPublisherId(PublisherInfo publisherInfoByPublisherId) {
        this.publisherInfoByPublisherId = publisherInfoByPublisherId;
    }

    private Collection<BookRating> bookRatingsByBookId;

    public Collection<BookRating> getBookRatingsByBookId() {
        return bookRatingsByBookId;
    }

    public void setBookRatingsByBookId(Collection<BookRating> bookRatingsByBookId) {
        this.bookRatingsByBookId = bookRatingsByBookId;
    }

    private Collection<BookRequest> bookRequestsByBookId;

    public Collection<BookRequest> getBookRequestsByBookId() {
        return bookRequestsByBookId;
    }

    public void setBookRequestsByBookId(Collection<BookRequest> bookRequestsByBookId) {
        this.bookRequestsByBookId = bookRequestsByBookId;
    }

    private Collection<BookReview> bookReviewsByBookId;

    public Collection<BookReview> getBookReviewsByBookId() {
        return bookReviewsByBookId;
    }

    public void setBookReviewsByBookId(Collection<BookReview> bookReviewsByBookId) {
        this.bookReviewsByBookId = bookReviewsByBookId;
    }

    private Collection<BookReview> bookReviewsByBookId_0;

    public Collection<BookReview> getBookReviewsByBookId_0() {
        return bookReviewsByBookId_0;
    }

    public void setBookReviewsByBookId_0(Collection<BookReview> bookReviewsByBookId_0) {
        this.bookReviewsByBookId_0 = bookReviewsByBookId_0;
    }

    private Collection<BorrowBook> borrowBooksByBookId;

    public Collection<BorrowBook> getBorrowBooksByBookId() {
        return borrowBooksByBookId;
    }

    public void setBorrowBooksByBookId(Collection<BorrowBook> borrowBooksByBookId) {
        this.borrowBooksByBookId = borrowBooksByBookId;
    }

    private List<Lend> lendsByBookId;

    public List<Lend> getLendsByBookId() {
        return this.lendsByBookId;
    }

    public void setLendsByBookId(List<Lend> lendsByBookId) {
        this.lendsByBookId = lendsByBookId;
    }

    private Collection<ShelfBooks> shelfBooksesByBookId;

    public Collection<ShelfBooks> getShelfBooksesByBookId() {
        return shelfBooksesByBookId;
    }

    public void setShelfBooksesByBookId(Collection<ShelfBooks> shelfBooksesByBookId) {
        this.shelfBooksesByBookId = shelfBooksesByBookId;
    }

    private Collection<RequestedBooks> requestedBooksesByBookId;

    public Collection<RequestedBooks> getRequestedBooksesByBookId() {
        return requestedBooksesByBookId;
    }

    public void setRequestedBooksesByBookId(Collection<RequestedBooks> requestedBooksesByBookId) {
        this.requestedBooksesByBookId = requestedBooksesByBookId;
    }
}
