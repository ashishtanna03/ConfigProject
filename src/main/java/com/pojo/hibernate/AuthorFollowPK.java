package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class AuthorFollowPK implements Serializable {
    private Integer userId;

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    private Integer authorId;

    public Integer getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Integer authorId) {
        this.authorId = authorId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AuthorFollowPK that = (AuthorFollowPK) o;

        if (authorId != null ? !authorId.equals(that.authorId) : that.authorId != null) return false;
        if (userId != null ? !userId.equals(that.userId) : that.userId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = userId != null ? userId.hashCode() : 0;
        result = 31 * result + (authorId != null ? authorId.hashCode() : 0);
        return result;
    }
}
