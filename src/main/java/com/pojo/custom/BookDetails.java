package com.pojo.custom;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 6/29/13
 * Time: 7:26 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookDetails {

    private Integer bookId;
    private String bookTitle;
    private String bookImgUrl;

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public String getBookImgUrl() {
        return bookImgUrl;
    }

    public void setBookImgUrl(String bookImgUrl) {
        this.bookImgUrl = bookImgUrl;
    }
}
