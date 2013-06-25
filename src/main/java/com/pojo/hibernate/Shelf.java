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
public class Shelf implements Serializable {
    private Integer shelfId;

    public Integer getShelfId() {
        return shelfId;
    }

    public void setShelfId(Integer shelfId) {
        this.shelfId = shelfId;
    }

    private String shelfName;

    public String getShelfName() {
        return shelfName;
    }

    public void setShelfName(String shelfName) {
        this.shelfName = shelfName;
    }

    private Integer isDefault;

    public Integer getIsDefault() {
        return isDefault;
    }

    public void setIsDefault(Integer aDefault) {
        isDefault = aDefault;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Shelf shelf = (Shelf) o;

        if (shelfId != null ? !shelfId.equals(shelf.shelfId) : shelf.shelfId != null) return false;
        if (shelfName != null ? !shelfName.equals(shelf.shelfName) : shelf.shelfName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = shelfId != null ? shelfId.hashCode() : 0;
        result = 31 * result + (shelfName != null ? shelfName.hashCode() : 0);
        return result;
    }

    private UserInfo userInfoByOwnerId;

    public UserInfo getUserInfoByOwnerId() {
        return userInfoByOwnerId;
    }

    public void setUserInfoByOwnerId(UserInfo userInfoByOwnerId) {
        this.userInfoByOwnerId = userInfoByOwnerId;
    }

    private Collection<ShelfBooks> shelfBooksessByShelfId;

    public Collection<ShelfBooks> getShelfBooksessByShelfId() {
        return shelfBooksessByShelfId;
    }

    public void setShelfBooksessByShelfId(Collection<ShelfBooks> shelfBooksessByShelfId) {
        this.shelfBooksessByShelfId = shelfBooksessByShelfId;
    }
}
