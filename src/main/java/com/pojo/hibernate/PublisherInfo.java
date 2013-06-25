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
public class PublisherInfo implements Serializable {
    private Integer publisherId;

    public Integer getPublisherId() {
        return publisherId;
    }

    public void setPublisherId(Integer publisherId) {
        this.publisherId = publisherId;
    }

    private String publisherName;

    public String getPublisherName() {
        return publisherName;
    }

    public void setPublisherName(String publisherName) {
        this.publisherName = publisherName;
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        PublisherInfo that = (PublisherInfo) o;

        if (publisherId != null ? !publisherId.equals(that.publisherId) : that.publisherId != null) return false;
        if (publisherName != null ? !publisherName.equals(that.publisherName) : that.publisherName != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = publisherId != null ? publisherId.hashCode() : 0;
        result = 31 * result + (publisherName != null ? publisherName.hashCode() : 0);
        return result;
    }*/

    private Collection<BookInfo> bookInfosByPublisherId;

    public Collection<BookInfo> getBookInfosByPublisherId() {
        return bookInfosByPublisherId;
    }

    public void setBookInfosByPublisherId(Collection<BookInfo> bookInfosByPublisherId) {
        this.bookInfosByPublisherId = bookInfosByPublisherId;
    }
}
