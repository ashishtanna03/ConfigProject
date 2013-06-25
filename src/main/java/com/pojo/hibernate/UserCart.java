package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 5/3/13
 * Time: 7:46 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserCart implements Serializable {

    private Lend lendByLendId;

    public Lend getLendByLendId() {
        return lendByLendId;
    }

    public void setLendByLendId(Lend lendByLendId) {
        this.lendByLendId = lendByLendId;
    }

    private UserInfo userInfoByOwnerId;

    public UserInfo getUserInfoByOwnerId() {
        return userInfoByOwnerId;
    }

    public void setUserInfoByOwnerId(UserInfo userInfoByOwnerId) {
        this.userInfoByOwnerId = userInfoByOwnerId;
    }
}
