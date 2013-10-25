package com.dao.login;

import com.dao.GenericDao;
import com.pojo.hibernate.LoginInfo;

import java.util.List;

public class UserLoginDaoImpl extends GenericDao<LoginInfo> implements UserLoginDao {

    private LoginInfo loginInfo;

    public LoginInfo loadUserByName(String emailId) {
        try {
            if (emailId != null && !emailId.equals("")) {
                List<LoginInfo> user = getByFieldName(LoginInfo.class, "emailId", emailId);
                if(user!=null && user.size()!=0)
                    loginInfo = user.get(0);
                return loginInfo;
            } else
                return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
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
