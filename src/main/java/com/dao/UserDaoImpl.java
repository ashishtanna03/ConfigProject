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


    public UserInfo getUserById(Integer userId) {
        try {
            return getById(UserInfo.class, userId);
        } catch (HibernateException e) {
            e.printStackTrace();
            return null;
        }
    }

    public Boolean isContactNoExists(String contactNo) {
        try {
            List<UserInfo> userInfos = hibernateTemplate.find("from UserInfo user where user.userContact='"+contactNo+"'");
            return  userInfos!= null && userInfos.size()>0;
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

    public Boolean update(UserInfo userInfo, List<Genres> userGenres) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {

            //delete all favourite genres of user
            for(UserFavGenres oldFavGenre : userInfo.getUserFavGenresesByUserId()) {
                hibernateTemplate.delete(oldFavGenre);
            }

            //add current favourite genres of user
            for (Genres genre : userGenres) {
                UserFavGenres userFavGenres = new UserFavGenres();
                userFavGenres.setGenresByGenreId(genre);
                userFavGenres.setUserInfoByUserId(userInfo);

                hibernateTemplate.saveOrUpdate(userFavGenres);
            }

            updateObject(userInfo);
            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
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
            return hibernateTemplate.findByCriteria(detachedCriteria).size() == 1;
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

    public Boolean cancelFriendRequest(UserInfo user1, UserInfo user2) {
        try {

            for(FriendshipMapping friendshipMapping : user1.getFriendshipMappingsByUserId()) {
                if(friendshipMapping.getUserInfoByUser2().getUserId().equals(user2.getUserId()) && friendshipMapping.getStatus()==0) {
                    hibernateTemplate.delete(friendshipMapping);

                    //Deleting notification if user 1 has sent friend request and user has not yet accepted
                    for(Notification notification : user2.getNotificationsByUserId_0()){
                        if(notification.getUserInfoBySenderId()!=null && notification.getUserInfoBySenderId().getUserId().equals(user1.getUserId()) && notification.getNotificationType()==0){
                            hibernateTemplate.delete(notification);
                            break;
                        }
                    }

                    return true;
                }
            }
            for(FriendshipMapping friendshipMapping : user1.getFriendshipMappingsByUserId_0()) {
                if(friendshipMapping.getUserInfoByUser1().getUserId().equals(user2.getUserId()) && friendshipMapping.getStatus()==1) {
                    hibernateTemplate.delete(friendshipMapping);

                    //Deleting notification if user 1 has sent friend request and user has not yet accepted
                    for(Notification notification : user2.getNotificationsByUserId_0()){
                        if(notification.getUserInfoBySenderId()!=null && notification.getUserInfoBySenderId().getUserId().equals(user1.getUserId()) && notification.getNotificationType()==0){
                            hibernateTemplate.delete(notification);
                            break;
                        }
                    }

                    return true;
                }
            }

            return false;
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

    public Boolean checkout(UserInfo userInfo, Integer pincode, String address) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try{

            OrderInfo orderInfo = new OrderInfo();
            orderInfo.setShippingAddress(address);
            orderInfo.setPincode(pincode);
            orderInfo.setUserInfoByBuyerId(userInfo);
            if(!saveObject(orderInfo)) {
                return false;
            }

            Lend lend = null;
            for(UserCart userCart:userInfo.getUserCartsByUserId()){
                lend = userCart.getLendByLendId();

                //if book is not available then remove it from cart and skip this iteration of loop
                if(lend.getLendStatus()==1) {
                    hibernateTemplate.delete(userCart);
                    break;
                }

                BorrowBook borrowBook = new BorrowBook();
                borrowBook.setBookInfoByBookId(lend.getBookInfoByBookId());
                borrowBook.setBorrowDate(new Date());
                borrowBook.setLendByLendId(lend);
                borrowBook.setUserInfoByUserId(userInfo);
                borrowBook.setBorrowStatus((short)1);

                //mapping borrow with order
                borrowBook.setOrderInfoByOrderId(orderInfo);

                if(userInfo.getUserBalance()>=lend.getSharingPrice()){
                    //Transferring points from buyer to sharer
                    //lend.getUserInfoByUserId().setUserBalance(lend.getUserInfoByUserId().getUserBalance()+lend.getSharingPrice());
                    lend.setLendStatus(1);
                    updateObject(lend);
                    saveObject(borrowBook);
                    hibernateTemplate.delete(userCart);

                    //deducting points from buyer
                    userInfo.setUserBalance(userInfo.getUserBalance() - lend.getSharingPrice());

                    //Sending notifications to seller that his/her book is bought
                    Notification notification = new Notification();
                    notification.setUserInfoBySenderId(userInfo);
                    notification.setUserInfoByReceiverId(lend.getUserInfoByUserId());
                    notification.setObjectId(lend.getBookInfoByBookId().getBookId());
                    notification.setNotificationType(5); //your shared book got bought
                    notification.setDate(new Date());
                    notification.setStatus(0);
                    saveObject(notification);
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
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {
            for (UserCart cart : userById.getUserCartsByUserId()) {
                if (lendById.getLendId().equals(cart.getLendByLendId().getLendId())) {
                    hibernateTemplate.delete(cart);
                }
            }
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
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

    public Boolean removeBookFromWishList(UserInfo user, BookInfo book) {
        try {
            for(Shelf shelf : user.getShelfsByUserId()) {
                if(shelf.getShelfName().equals("WishList")) {
                    for(ShelfBooks shelfBook : shelf.getShelfBooksessByShelfId()) {
                        if(shelfBook.getBookInfoByBookId().equals(book)) {
                            hibernateTemplate.delete(shelfBook);
                            return true;
                        }
                    }
                }
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean removeRequestedBook(UserInfo user, Integer bookId) {
        try {
            for(RequestedBooks requestedBook : user.getRequestedBooksesByUserId()) {
                if (requestedBook.getBookInfoByBookId().getBookId().equals(bookId)) {
                    hibernateTemplate.delete(requestedBook);
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean setUserReputation(Lend lend, Integer reputation) {
        try {
            lend.setReputation(reputation);
            return updateObject(lend);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean changeProfilePicture(UserInfo user, String imageUrl) {
        try {
            user.setUserImg(imageUrl);
            return updateObject(user);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean changeContactNo(UserInfo user, String contactNo) {
        try {
            user.setUserContact(contactNo);
            return updateObject(user);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean cancelOrder(UserInfo userInfo, Integer borrowId) {
        Transaction transaction = hibernateTemplate.getSessionFactory().getCurrentSession().beginTransaction();
        try {
            for(BorrowBook borrowBook : userInfo.getBorrowBooksByUserId()) {
                if(borrowBook.getBorrowId().equals(borrowId)) {

                    //transferring points back to the user
                    Integer currentBalance = userInfo.getUserBalance();
                    currentBalance +=  borrowBook.getLendByLendId().getSharingPrice();
                    userInfo.setUserBalance(currentBalance);
                    updateObject(userInfo);

                    hibernateTemplate.delete(borrowBook);
                    break;
                }
            }
            transaction.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
    }
}