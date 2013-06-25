package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class FriendshipMappingPK implements Serializable {
    private Integer user1;

    public Integer getUser1() {
        return user1;
    }

    public void setUser1(Integer user1) {
        this.user1 = user1;
    }

    private Integer user2;

    public Integer getUser2() {
        return user2;
    }

    public void setUser2(Integer user2) {
        this.user2 = user2;
    }

   /* @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        FriendshipMappingPK that = (FriendshipMappingPK) o;

        if (user1 != null ? !user1.equals(that.user1) : that.user1 != null) return false;
        if (user2 != null ? !user2.equals(that.user2) : that.user2 != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = user1 != null ? user1.hashCode() : 0;
        result = 31 * result + (user2 != null ? user2.hashCode() : 0);
        return result;
    }*/
}
