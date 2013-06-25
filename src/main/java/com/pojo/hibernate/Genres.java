package com.pojo.hibernate;

import java.io.Serializable;
import java.util.Collection;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class Genres implements Serializable {
    private Integer genreId;

    public Integer getGenreId() {
        return genreId;
    }

    public void setGenreId(Integer genreId) {
        this.genreId = genreId;
    }

    private String genreName;

    public String getGenreName() {
        return genreName;
    }

    public void setGenreName(String genreName) {
        this.genreName = genreName;
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Genres genres = (Genres) o;

        if (genreId != null ? !genreId.equals(genres.genreId) : genres.genreId != null) return false;
        if (genreName != null ? !genreName.equals(genres.genreName) : genres.genreName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = genreId != null ? genreId.hashCode() : 0;
        result = 31 * result + (genreName != null ? genreName.hashCode() : 0);
        return result;
    }*/

    private Collection<AuthorGenres> authorGenresesByGenreId;

    public Collection<AuthorGenres> getAuthorGenresesByGenreId() {
        return authorGenresesByGenreId;
    }

    public void setAuthorGenresesByGenreId(Collection<AuthorGenres> authorGenresesByGenreId) {
        this.authorGenresesByGenreId = authorGenresesByGenreId;
    }

    private Collection<BookGenres> bookGenresesByGenreId;

    public Collection<BookGenres> getBookGenresesByGenreId() {
        return bookGenresesByGenreId;
    }

    public void setBookGenresesByGenreId(Collection<BookGenres> bookGenresesByGenreId) {
        this.bookGenresesByGenreId = bookGenresesByGenreId;
    }

    private Collection<UserFavGenres> userFavGenresesByGenreId;

    public Collection<UserFavGenres> getUserFavGenresesByGenreId() {
        return userFavGenresesByGenreId;
    }

    public void setUserFavGenresesByGenreId(Collection<UserFavGenres> userFavGenresesByGenreId) {
        this.userFavGenresesByGenreId = userFavGenresesByGenreId;
    }
}
