package com.dao;

import com.pojo.hibernate.*;
import org.hibernate.Transaction;

import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/21/13
 * Time: 3:26 PM
 * To change this template use File | Settings | File Templates.
 */
public class LendDaoImpl extends GenericDao<Lend> {

    public Boolean lendBook(Lend lend,List<UserInfo> friends){
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try{
            //sending notification to user's friend that user has shared the book
            for (UserInfo friend : friends){
                Notification notification = new Notification();
                notification.setUserInfoBySenderId(lend.getUserInfoByUserId());
                notification.setUserInfoByReceiverId(friend);
                notification.setObjectId(lend.getBookInfoByBookId().getBookId());
                notification.setNotificationType(4); //friend has shared a book
                notification.setDate(new Date());
                notification.setStatus(0);
                saveObject(notification);
            }
            saveObject(lend);

            //sending notification to the users who requested the book
            for(RequestedBooks requestedBook : lend.getBookInfoByBookId().getRequestedBooksesByBookId()) {
                Notification notification = new Notification();
                notification.setUserInfoBySenderId(lend.getUserInfoByUserId());
                notification.setUserInfoByReceiverId(requestedBook.getUserInfoByUserId());
                notification.setObjectId(lend.getBookInfoByBookId().getBookId());
                notification.setNotificationType(6); //user's requested book is now available
                notification.setDate(new Date());
                notification.setStatus(0);
                saveObject(notification);
            }
            transaction.commit();
            return true;
        } catch (Exception e){
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }

    public Lend getLendById(Integer lendId) {
        try {
            return getById(Lend.class,lendId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public Boolean unshareBook(Lend lend, List<UserInfo> friends) {
        try {
            //unsharing book
            hibernateTemplate.delete(lend);

            //deleting notification set for this shared book
            for (UserInfo friend : friends){
                for(Notification notification : friend.getNotificationsByUserId()) {
                    //if notification type is 4 (friend has shared book)
                    // and notification sender is sharer and shared book id is same as object id then delete it
                    if(notification.getNotificationType()==4
                            && notification.getUserInfoBySenderId().getUserId().equals(lend.getUserInfoByUserId().getUserId())
                            && notification.getObjectId().equals(lend.getBookInfoByBookId().getBookId())
                            ) {
                        hibernateTemplate.delete(notification);
                    }
                }
            }

            //deleting notification set for this shared book
            for(RequestedBooks requestedBook : lend.getBookInfoByBookId().getRequestedBooksesByBookId()) {
                for (Notification notification : requestedBook.getUserInfoByUserId().getNotificationsByUserId()) {
                    //if notification type is 6 (your requested book is now available)
                    // and notification sender is sharer and shared book id is same as object id then delete it
                    if(notification.getNotificationType()==6
                            && notification.getUserInfoBySenderId().getUserId().equals(lend.getUserInfoByUserId().getUserId())
                            && notification.getObjectId().equals(lend.getBookInfoByBookId().getBookId())
                            ) {
                        hibernateTemplate.delete(notification);
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
