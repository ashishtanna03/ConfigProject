package com.dao;

import com.pojo.hibernate.Lend;
import com.pojo.hibernate.Notification;
import com.pojo.hibernate.UserInfo;
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
            for (UserInfo friend : friends){
                Notification notification = new Notification();
                notification.setUserInfoBySenderId(lend.getUserInfoByUserId());
                notification.setUserInfoByReceiverId(friend);
                notification.setObjectId(lend.getBookInfoByBookId().getBookId());
                notification.setNotificationType(4);
                notification.setDate(new Date());
                notification.setStatus(0);
                saveObject(notification);
            }
            saveObject(lend);
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
}
