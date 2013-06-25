package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 6/23/13
 * Time: 4:17 PM
 * To change this template use File | Settings | File Templates.
 */
public class ShelfBooks implements Serializable {

    private BookInfo bookInfoByBookId;

    public BookInfo getBookInfoByBookId() {
        return bookInfoByBookId;
    }

    public void setBookInfoByBookId(BookInfo bookInfoByBookId) {
        this.bookInfoByBookId = bookInfoByBookId;
    }

    private Shelf shelfByShelfId;

    public Shelf getShelfByShelfId() {
        return shelfByShelfId;
    }

    public void setShelfByShelfId(Shelf shelfByShelfId) {
        this.shelfByShelfId = shelfByShelfId;
    }
}
