package com.dao.login;

import com.dao.GenericDao;
import com.pojo.hibernate.LoginInfo;

import java.util.List;

public class UserLoginDaoImpl extends GenericDao<LoginInfo> implements UserLoginDao {

    private LoginInfo loginInfo;

    public LoginInfo loadUserByName(String emailId) {
        try {
            if (emailId != null && !emailId.equals("")) {
                System.out.println("Executing");
                List<LoginInfo> user = getByFieldName(LoginInfo.class, "emailId", emailId);
                System.out.println("After query" + user);
                loginInfo = user.get(0);
                System.out.println("loginimpl : " + loginInfo.getRole());
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            return loginInfo;
        }
    }

    public Boolean saveLoginInfo(LoginInfo loginInfo) {
        try {
            return saveObject(loginInfo);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Boolean changePassword(String emailId, String newPassword) {
        try {
            LoginInfo userLogin = getByFieldName(LoginInfo.class, "emailId", emailId).get(0);
            userLogin.setPassword(newPassword);
            return updateObject(userLogin);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
