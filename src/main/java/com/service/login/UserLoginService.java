package com.service.login;

import com.dao.login.CustomUser;
import com.dao.login.UserLoginDao;
import com.dao.login.UserLoginDaoImpl;
import com.pojo.hibernate.LoginInfo;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;

public class UserLoginService implements UserDetailsService {

    private UserLoginDao userLoginDao;

    public void setUserLoginDao(UserLoginDao u) {
        userLoginDao = u;
    }

    public UserDetails loadUserByUsername(String emailId) {
        if (emailId != null && !emailId.equals("")) {
            LoginInfo user = userLoginDao.loadUserByName(emailId);
//            System.out.println("UserLoginService , " + user);
            if (user == null) {
                return null;
            }

            GrantedAuthority grantedAuth = new UserGrantedAuthority("" + user.getRole());
            CustomUser cu = new CustomUser(user.getEmailId(), user.getPassword(),
                    new GrantedAuthority[]{grantedAuth});
//            System.out.println(cu);
            return cu;
        } else {
            return null;
        }
    }

    public Boolean saveLoginInfo(LoginInfo loginInfo) {
        return userLoginDao.saveLoginInfo(loginInfo);
    }

    public Boolean changePassword(String emailId, String newPassword) {
        return userLoginDao.changePassword(emailId,newPassword);
    }
}