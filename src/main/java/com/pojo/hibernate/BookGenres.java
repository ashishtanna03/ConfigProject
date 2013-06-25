package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class BookGenres implements Serializable {
    private Integer bookId;

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    private Integer genreId;

    public Integer getGenreId() {
        return genreId;
    }

    public void setGenreId(Integer genreId) {
        this.genreId = genreId;
    }

   /* @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        BookGenres that = (BookGenres) o;

        if (bookId != null ? !bookId.equals(that.bookId) : that.bookId != null) return false;
        if (genreId != null ? !genreId.equals(that.genreId) : that.genreId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = bookId != null ? bookId.hashCode() : 0;
        result = 31 * result + (genreId != null ? genreId.hashCode() : 0);
        return result;
    }
*/
    private BookInfo bookInfoByBookId;

    public BookInfo getBookInfoByBookId() {
        return bookInfoByBookId;
    }

    public void setBookInfoByBookId(BookInfo bookInfoByBookId) {
        this.bookInfoByBookId = bookInfoByBookId;
    }

    private Genres genresByGenreId;

    public Genres getGenresByGenreId() {
        return genresByGenreId;
    }

    public void setGenresByGenreId(Genres genresByGenreId) {
        this.genresByGenreId = genresByGenreId;
    }
}
