package com.service;

import com.dao.BorrowDaoImpl;
import com.pojo.hibernate.BorrowBook;
import com.pojo.hibernate.OrderInfo;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 9/5/13
 * Time: 6:11 PM
 * To change this template use File | Settings | File Templates.
 */
public class BorrowService {

    private BorrowDaoImpl borrowDao;

    public void setBorrowDao(BorrowDaoImpl borrowDao) {
        this.borrowDao = borrowDao;
    }

    public BorrowBook getBorrowBookById(Integer borrowId) {
        return borrowDao.getBorrowBookById(borrowId);
    }

    public List<BorrowBook> getListOfToBePickedUp() {
        return borrowDao.getListOfToBePickedUp();
    }

    public List<BorrowBook> getListOfInPickUpProcess() {
        return borrowDao.getListOfInPickUpProcess();
    }

    public List<OrderInfo> getListOfPickedUp() {
        return borrowDao.getListOfPickedUp();
    }

    public List<OrderInfo> getListOfInDeliveryProcess() {
        return borrowDao.getListOfInDeliveryProcess();
    }

    public List<BorrowBook> printAndGetPickUpOrders() {
        return borrowDao.printAndGetPickUpOrders();
    }

    public Boolean markSelectedAsPickedUp(List<BorrowBook> selectedBorrowBooks) {
        return borrowDao.markSelectedAsPickedUp(selectedBorrowBooks);
    }

    public Boolean markSelectedAsNotAvailable(List<BorrowBook> selectedBorrowBooks) {
        return borrowDao.markSelectedAsNotAvailable(selectedBorrowBooks);
    }

    public List<OrderInfo> printAndGetDeliveryOrders() {
        return borrowDao.printAndGetDeliveryOrders();
    }

    public Boolean markSelectedAsDelivered(List<Integer> selectedOrderIds) {
        return borrowDao.markSelectedAsDelivered(selectedOrderIds);
    }
}
