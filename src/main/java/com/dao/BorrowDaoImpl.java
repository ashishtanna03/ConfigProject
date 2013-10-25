package com.dao;

import com.pojo.hibernate.BorrowBook;
import com.pojo.hibernate.Lend;
import com.pojo.hibernate.OrderInfo;
import com.pojo.hibernate.UserInfo;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 9/5/13
 * Time: 6:12 PM
 * To change this template use File | Settings | File Templates.
 */
public class BorrowDaoImpl extends GenericDao<BorrowBook>{

    public BorrowBook getBorrowBookById(Integer borrowId) {
        try {
            return getById(BorrowBook.class,borrowId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public OrderInfo getOrderInfoByOrderId(Integer orderId) {
        try {
            return (OrderInfo) hibernateTemplate.get(OrderInfo.class, orderId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<BorrowBook> getListOfToBePickedUp() {
        try {
            return hibernateTemplate.find("from BorrowBook borrowBook where borrowStatus=1 order by borrowBook.lendByLendId.userInfoByUserId.userPostalCode asc");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<BorrowBook> getListOfInPickUpProcess() {
        try {
            return hibernateTemplate.find("from BorrowBook borrowBook where borrowStatus=2 order by borrowBook.lendByLendId.userInfoByUserId.userPostalCode asc");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<OrderInfo> getListOfPickedUp() {
        try {
            return hibernateTemplate.find("select distinct orderInfo from OrderInfo orderInfo inner join orderInfo.borrowBooksesByOrderId borrowBooks where borrowBooks.borrowStatus=3 or borrowBooks.borrowStatus=0 order by orderInfo.pincode asc");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<OrderInfo> getListOfInDeliveryProcess() {
        try {
            return hibernateTemplate.find("select distinct orderInfo from OrderInfo orderInfo inner join orderInfo.borrowBooksesByOrderId borrowBooks where borrowBooks.borrowStatus=4");
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<BorrowBook> printAndGetPickUpOrders() {
        try {
            List<BorrowBook> pickUpOrders = hibernateTemplate.find("from BorrowBook borrowBook where borrowBook.borrowStatus=1 order by borrowBook.lendByLendId.userInfoByUserId.userPostalCode asc ");

            for (BorrowBook borrowBook : pickUpOrders) {
                borrowBook.setBorrowStatus((short)2);
                updateObject(borrowBook);
            }

            return pickUpOrders;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Boolean markSelectedAsPickedUp(List<BorrowBook> selectedBorrowBooks) {
        try {
            //changing borrow status to picked up
            for (BorrowBook borrowBook : selectedBorrowBooks) {
                borrowBook.setBorrowStatus((short)3);
                updateObject(borrowBook);

                //sending points to sharer
                UserInfo sharer = borrowBook.getLendByLendId().getUserInfoByUserId();
                Integer sharingPrice = borrowBook.getLendByLendId().getSharingPrice();
                Integer userBalance = sharer.getUserBalance();
                sharer.setUserBalance(userBalance+sharingPrice);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean markSelectedAsNotAvailable(List<BorrowBook> selectedBorrowBooks) {
        try {
            //changing borrow status to not available
            for (BorrowBook borrowBook : selectedBorrowBooks) {
                borrowBook.setBorrowStatus((short)0);
                updateObject(borrowBook);

                //sending points back to the buyer
                UserInfo buyer = borrowBook.getUserInfoByUserId();
                Integer sharingPrice = borrowBook.getLendByLendId().getSharingPrice();
                Integer userBalance = buyer.getUserBalance();
                buyer.setUserBalance(userBalance+sharingPrice);
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<OrderInfo> printAndGetDeliveryOrders() {
        try {
            List<OrderInfo> availableOrders = hibernateTemplate.find("select distinct orderInfo from OrderInfo orderInfo inner join orderInfo.borrowBooksesByOrderId borrowBooks where borrowBooks.borrowStatus=3 or borrowBooks.borrowStatus=0 order by orderInfo.pincode asc ");
            List<OrderInfo> deliverableOrders = new ArrayList<OrderInfo>(0);

            Boolean allPickedUp;
            for(OrderInfo orderInfo : availableOrders) {
                allPickedUp=true;
                for(BorrowBook borrowBook : orderInfo.getBorrowBooksesByOrderId()) {
                    if(borrowBook.getBorrowStatus()!=3 && borrowBook.getBorrowStatus()!=0) {
                        allPickedUp=false;
                    }
                }

                //if all books are picked up then add order into the o/p list
                if(allPickedUp) {
                    deliverableOrders.add(orderInfo);

                    //setting current date as print date
                    java.util.Calendar cal = java.util.Calendar.getInstance();
                    java.util.Date utilDate = cal.getTime();
                    java.sql.Date sqlDate = new Date(utilDate.getTime());
                    orderInfo.setPrintDate(sqlDate);
                    updateObject(orderInfo);

                    for (BorrowBook borrowBook : orderInfo.getBorrowBooksesByOrderId()) {
                        if(borrowBook.getBorrowStatus()!=0) {
                            borrowBook.setBorrowStatus((short) 4);
                            updateObject(borrowBook);
                        }
                    }
                }
            }

            return deliverableOrders;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Boolean markSelectedAsDelivered(List<Integer> selectedOrderIds) {
        try {

            for (Integer orderId : selectedOrderIds) {
                OrderInfo orderInfo = getOrderInfoByOrderId(orderId);

                for (BorrowBook borrowBook : orderInfo.getBorrowBooksesByOrderId()) {
                    //changing borrow status to delivered
                    if(borrowBook.getBorrowStatus()!=0) {
                        borrowBook.setBorrowStatus((short)5);

                        //setting current date as deliver date
                        java.util.Calendar cal = java.util.Calendar.getInstance();
                        java.util.Date utilDate = cal.getTime();
                        java.sql.Date sqlDate = new Date(utilDate.getTime());
                        borrowBook.setDeliverDate(sqlDate);

                        updateObject(borrowBook);
                    }
                }
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}