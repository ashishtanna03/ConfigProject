package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookAuthorsPK implements Serializable {
    private Integer bookId;

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    private Integer authorId;

    public Integer getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Integer authorId) {
        this.authorId = authorId;
    }

  /*  @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BookAuthorsPK that = (BookAuthorsPK) o;

        if (authorId != null ? !authorId.equals(that.authorId) : that.authorId != null) return false;
        if (bookId != null ? !bookId.equals(that.bookId) : that.bookId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = bookId != null ? bookId.hashCode() : 0;
        result = 31 * result + (authorId != null ? authorId.hashCode() : 0);
        return result;
    }*/
}
