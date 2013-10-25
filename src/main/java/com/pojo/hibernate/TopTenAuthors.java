package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 7/26/13
 * Time: 12:55 AM
 * To change this template use File | Settings | File Templates.
 */
public class TopTenAuthors implements Serializable{

    private Integer id;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    private AuthorInfo authorInfoByAuthorId;

    public AuthorInfo getAuthorInfoByAuthorId() {
        return authorInfoByAuthorId;
    }

    public void setAuthorInfoByAuthorId(AuthorInfo authorInfoByAuthorId) {
        this.authorInfoByAuthorId = authorInfoByAuthorId;
    }
}
