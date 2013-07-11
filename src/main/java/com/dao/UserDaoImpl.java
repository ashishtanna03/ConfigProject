package com.dao;

import com.pojo.hibernate.*;
import org.hibernate.HibernateException;
import org.hibernate.Transaction;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;

import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/10/13
 * Time: 4:32 PM
 * To change this template use File | Settings | File Templates.
 */
public class UserDaoImpl extends GenericDao<UserInfo> {

    public List<UserInfo> getUserById(String emailId) {
        try {
            return getByFieldName(UserInfo.class, "loginInfoByEmailId.emailId", emailId);
        } catch (HibernateException e) {
            e.printStackTrace();
            return null;
        }
    }


    public List<UserInfo> getUserById(Integer userId) {
        try {
            return getByFieldName(UserInfo.class, "userId", userId);
        } catch (HibernateException e) {
            e.printStackTrace();
            return null;
        }
    }

    public Boolean update(UserInfo userInfo) {
        try {
            return updateObject(userInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean isUserFriend(UserInfo user1, UserInfo user2) {
        try {
            DetachedCriteria detachedCriteria = DetachedCriteria.forClass(FriendshipMapping.class);
            detachedCriteria.add(Restrictions.conjunction()
                    .add(Restrictions.disjunction()
                            .add(Restrictions.conjunction()
                                    .add(Restrictions.eq("userInfoByUser1", user1))
                                    .add(Restrictions.eq("userInfoByUser2", user2))
                            )
                            .add(Restrictions.conjunction()
                                    .add(Restrictions.eq("userInfoByUser1", user2))
                                    .add(Restrictions.eq("userInfoByUser2", user1))
                            )
                    )
                    .add(Restrictions.eq("status", 2))
            );
            if (hibernateTemplate.findByCriteria(detachedCriteria).size()==1){
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean addAsFriend(UserInfo user1, UserInfo user2) {
        try {
            DetachedCriteria detachedCriteria = DetachedCriteria.forClass(FriendshipMapping.class);
            detachedCriteria.add(Restrictions.disjunction()
                    .add(Restrictions.conjunction()
                            .add(Restrictions.eq("userInfoByUser1", user1))
                            .add(Restrictions.eq("userInfoByUser2", user2))
                    )
                    .add(Restrictions.conjunction()
                            .add(Restrictions.eq("userInfoByUser1", user2))
                            .add(Restrictions.eq("userInfoByUser2", user1))
                    )
            );
            List<FriendshipMapping> friendshipMappings = hibernateTemplate.findByCriteria(detachedCriteria);
            Notification notification = new Notification();
            notification.setUserInfoBySenderId(user1);
            notification.setUserInfoByReceiverId(user2);
            notification.setNotificationType(0);
            notification.setDate(new Date());
            notification.setStatus(0);

            if(friendshipMappings.size()==1){
                FriendshipMapping friendshipMapping = friendshipMappings.get(0);
                if(friendshipMapping.getUserInfoByUser1()==user1){
                    friendshipMapping.setStatus(0);
                } else{
                    friendshipMapping.setStatus(1);
                }

                updateObject(friendshipMapping);
                saveObject(notification);
                return true;
            } else{
                FriendshipMapping friendshipMapping = new FriendshipMapping();
                friendshipMapping.setUserInfoByUser1(user1);
                friendshipMapping.setUserInfoByUser2(user2);
                friendshipMapping.setStatus(0);

                saveObject(friendshipMapping);
                saveObject(notification);
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean unfriend(UserInfo user1, UserInfo user2) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {
            DetachedCriteria detachedCriteria = DetachedCriteria.forClass(FriendshipMapping.class);

            detachedCriteria.add(Restrictions.disjunction()
                    .add(Restrictions.conjunction()
                            .add(Restrictions.eq("userInfoByUser1", user1))
                            .add(Restrictions.eq("userInfoByUser2", user2))
                    )
                    .add(Restrictions.conjunction()
                            .add(Restrictions.eq("userInfoByUser1", user2))
                            .add(Restrictions.eq("userInfoByUser2", user1))
                    )
            );
            List<FriendshipMapping> friendshipMappings = hibernateTemplate.findByCriteria(detachedCriteria);
            if(friendshipMappings.size()==1){
                FriendshipMapping friendshipMapping = friendshipMappings.get(0);
                if(friendshipMapping.getUserInfoByUser1()==user1){
                    friendshipMapping.setStatus(3);
                } else if(friendshipMapping.getUserInfoByUser2()==user1) {
                    friendshipMapping.setStatus(4);
                }
                //Deleting notification if user 1 has sent friend request and user has not yet accepted
                for(Notification notification : user2.getNotificationsByUserId_0()){
                    if(notification.getUserInfoBySenderId()==user1 && notification.getNotificationType()==0){
                        hibernateTemplate.delete(notification);
                    }
                }
                updateObject(friendshipMapping);
                transaction.commit();
                return true;
            } else {
                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }

    public Boolean addToCart(UserInfo user, Lend lend) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try{
            if(lend.getLendStatus()==1){
                return false;
            }
            UserCart newUserCart = new UserCart();
            newUserCart.setUserInfoByOwnerId(user);
            newUserCart.setLendByLendId(lend);

            hibernateTemplate.saveOrUpdate(newUserCart);
            transaction.commit();
            return true;
        } catch (Exception e){
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }

    public Boolean checkout(UserInfo userInfo) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try{
            Lend lend = null;
            for(UserCart userCart:userInfo.getUserCartsByUserId()){
                lend = userCart.getLendByLendId();
                BorrowBook borrowBook = new BorrowBook();
                borrowBook.setBookInfoByBookId(lend.getBookInfoByBookId());
                borrowBook.setBorrowDate(new Date());
                borrowBook.setLendByLendId(lend);
                borrowBook.setUserInfoByUserId(userInfo);
                borrowBook.setBorrowStatus((short)1);
                if(userInfo.getUserBalance()>=lend.getSharingPrice()){
                    //Transferring points from buyer to sharer
                    //lend.getUserInfoByUserId().setUserBalance(lend.getUserInfoByUserId().getUserBalance()+lend.getSharingPrice());
                    lend.setLendStatus(1);
                    updateObject(lend);
                    saveObject(borrowBook);
                    hibernateTemplate.delete(userCart);
                    //deducting points from buyer
                    userInfo.setUserBalance(userInfo.getUserBalance() - lend.getSharingPrice());
                }
                else {
                    transaction.rollback();
                    return false;
                }
            }
            updateObject(userInfo);
            transaction.commit();
            return true;
        } catch (Exception e){
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }

    public void deleteItem(UserInfo userById, Lend lendById) {
        UserCart userCart=new UserCart();
        userCart.setLendByLendId(lendById);
        userCart.setUserInfoByOwnerId(userById);
        for(UserCart cart:userById.getUserCartsByUserId()){
            if(lendById.getLendId()==userCart.getLendByLendId().getLendId()){
                hibernateTemplate.getSessionFactory().getCurrentSession().evict(cart);
                hibernateTemplate.delete(userCart);

            }
        }
    }

    public Boolean addToWishList(UserInfo user, BookInfo book) {

        try {
            for(Shelf shelf : user.getShelfsByUserId()) {
                if(shelf.getShelfName().equals("WishList")) {
                    ShelfBooks shelfBooks = new ShelfBooks();
                    shelfBooks.setBookInfoByBookId(book);
                    shelfBooks.setShelfByShelfId(shelf);
                    hibernateTemplate.saveOrUpdate(shelfBooks);
                    return true;
                }
            }

            //If a WishList shelf is not available create new one and add book to it:
            Shelf newShelf = new Shelf();
            newShelf.setShelfName("WishList");
            newShelf.setUserInfoByOwnerId(user);
            newShelf.setIsDefault(1);

            if(saveObject(newShelf)) {
                ShelfBooks shelfBooks = new ShelfBooks();
                shelfBooks.setBookInfoByBookId(book);
                shelfBooks.setShelfByShelfId(newShelf);
                return saveObject(shelfBooks);
            }

            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean acceptRequest(UserInfo receiver, UserInfo sender) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {
            DetachedCriteria detachedCriteria = DetachedCriteria.forClass(FriendshipMapping.class);

            detachedCriteria.add(Restrictions.disjunction()
                    .add(Restrictions.conjunction()
                            .add(Restrictions.eq("userInfoByUser1", sender))
                            .add(Restrictions.eq("userInfoByUser2", receiver))
                    )
                    .add(Restrictions.conjunction()
                            .add(Restrictions.eq("userInfoByUser1", receiver))
                            .add(Restrictions.eq("userInfoByUser2", sender))
                    )
            );
            List<FriendshipMapping> friendshipMappings = hibernateTemplate.findByCriteria(detachedCriteria);
            if(friendshipMappings.size()==1){
                FriendshipMapping friendshipMapping = friendshipMappings.get(0);
                if(friendshipMapping.getStatus()!=2) {
                    friendshipMapping.setStatus(2);

                    //Generating Notification for request sender
                    Notification notification = new Notification();
                    notification.setUserInfoBySenderId(receiver);
                    notification.setUserInfoByReceiverId(sender);
                    notification.setNotificationType(1); //1 = Friend Request Accepted
                    notification.setDate(new Date());
                    notification.setStatus(0);

                    updateObject(friendshipMapping);
                    saveObject(notification);

                    //Deleting friend Request Notification of receiver
                    for(Notification receiverNotification : receiver.getNotificationsByUserId_0()){
                        if(receiverNotification.getUserInfoBySenderId()==sender && receiverNotification.getNotificationType()==0){
                            hibernateTemplate.delete(receiverNotification);
                        }
                    }
                }

                transaction.commit();
                return true;
            } else {
                return false;
            }

        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }
}