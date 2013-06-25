package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class AuthorGenres implements Serializable {
    private Integer authorId;

    public Integer getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Integer authorId) {
        this.authorId = authorId;
    }

    private Integer genreId;

    public Integer getGenreId() {
        return genreId;
    }

    public void setGenreId(Integer genreId) {
        this.genreId = genreId;
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AuthorGenres that = (AuthorGenres) o;

        if (authorId != null ? !authorId.equals(that.authorId) : that.authorId != null) return false;
        if (genreId != null ? !genreId.equals(that.genreId) : that.genreId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = authorId != null ? authorId.hashCode() : 0;
        result = 31 * result + (genreId != null ? genreId.hashCode() : 0);
        return result;
    }*/

    private Genres genresByGenreId;

    public Genres getGenresByGenreId() {
        return genresByGenreId;
    }

    public void setGenresByGenreId(Genres genresByGenreId) {
        this.genresByGenreId = genresByGenreId;
    }

    private AuthorInfo authorInfoByAuthorId;

    public AuthorInfo getAuthorInfoByAuthorId() {
        return authorInfoByAuthorId;
    }

    public void setAuthorInfoByAuthorId(AuthorInfo authorInfoByAuthorId) {
        this.authorInfoByAuthorId = authorInfoByAuthorId;
    }
}
