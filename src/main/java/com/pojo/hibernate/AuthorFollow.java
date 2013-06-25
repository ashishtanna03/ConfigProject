package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class AuthorFollow implements Serializable {

    private AuthorInfo authorInfoByAuthorId;

    public AuthorInfo getAuthorInfoByAuthorId() {
        return authorInfoByAuthorId;
    }

    public void setAuthorInfoByAuthorId(AuthorInfo authorInfoByAuthorId) {
        this.authorInfoByAuthorId = authorInfoByAuthorId;
    }

    private UserInfo userInfoByUserId;

    public UserInfo getUserInfoByUserId() {
        return userInfoByUserId;
    }

    public void setUserInfoByUserId(UserInfo userInfoByUserId) {
        this.userInfoByUserId = userInfoByUserId;
    }
}
