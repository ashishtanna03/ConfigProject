package com.dao.login;


import com.pojo.hibernate.LoginInfo;

/**
 * The Interface UserLoginDAO.
 */
public interface UserLoginDao {

    LoginInfo loadUserByName(String name);

    public Boolean saveLoginInfo(LoginInfo loginInfo);

    public Boolean changePassword(String emailId, String newPassword);
}