package com.service;

import com.dao.LendDaoImpl;
import com.pojo.hibernate.FriendshipMapping;
import com.pojo.hibernate.Lend;
import com.pojo.hibernate.UserInfo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/21/13
 * Time: 3:15 PM
 * To change this template use File | Settings | File Templates.
 */
public class LendService {

    private LendDaoImpl lendDao;
    private UserService userService;

    public void setLendDao(LendDaoImpl lendDao) {
        this.lendDao = lendDao;
    }

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public Boolean lendBook(Lend lend) {
        List<UserInfo> friends = new ArrayList<UserInfo>(0);
        for (FriendshipMapping friendshipMapping : lend.getUserInfoByUserId().getFriendshipMappingsByUserId()) {
            friends.add(friendshipMapping.getUserInfoByUser2());
        }
        for (FriendshipMapping friendshipMapping : lend.getUserInfoByUserId().getFriendshipMappingsByUserId_0()) {
            friends.add(friendshipMapping.getUserInfoByUser1());
        }
        return lendDao.lendBook(lend, friends);
    }

    public Lend getLendById(Integer lendId) {
        return lendDao.getLendById(lendId);
    }

    public Boolean unshareBook(Integer lendId) {
        Lend lend = getLendById(lendId);
        List<UserInfo> friends = new ArrayList<UserInfo>(0);
        for (FriendshipMapping friendshipMapping : lend.getUserInfoByUserId().getFriendshipMappingsByUserId()) {
            friends.add(friendshipMapping.getUserInfoByUser2());
        }
        for (FriendshipMapping friendshipMapping : lend.getUserInfoByUserId().getFriendshipMappingsByUserId_0()) {
            friends.add(friendshipMapping.getUserInfoByUser1());
        }
        return lendDao.unshareBook(lend, friends);
    }

}
