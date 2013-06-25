package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class FriendshipMapping implements Serializable {

    private Integer status;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    private UserInfo userInfoByUser1;

    public UserInfo getUserInfoByUser1() {
        return userInfoByUser1;
    }

    public void setUserInfoByUser1(UserInfo userInfoByUser1) {
        this.userInfoByUser1 = userInfoByUser1;
    }

    private UserInfo userInfoByUser2;

    public UserInfo getUserInfoByUser2() {
        return userInfoByUser2;
    }

    public void setUserInfoByUser2(UserInfo userInfoByUser2) {
        this.userInfoByUser2 = userInfoByUser2;
    }
}
