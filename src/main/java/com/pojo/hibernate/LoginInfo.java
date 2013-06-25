package com.pojo.hibernate;

import java.io.Serializable;
import java.util.Collection;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class LoginInfo implements Serializable {
    private String emailId;

    public String getEmailId() {
        return emailId;
    }

    public void setEmailId(String emailId) {
        this.emailId = emailId;
    }

    private String password;

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    private Integer role;

    public Integer getRole() {
        return role;
    }

    public void setRole(Integer role) {
        this.role = role;
    }

    private Boolean active;

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        LoginInfo loginInfo = (LoginInfo) o;

        if (active != null ? !active.equals(loginInfo.active) : loginInfo.active != null) return false;
        if (emailId != null ? !emailId.equals(loginInfo.emailId) : loginInfo.emailId != null) return false;
        if (password != null ? !password.equals(loginInfo.password) : loginInfo.password != null) return false;
        if (role != null ? !role.equals(loginInfo.role) : loginInfo.role != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = emailId != null ? emailId.hashCode() : 0;
        result = 31 * result + (password != null ? password.hashCode() : 0);
        result = 31 * result + (role != null ? role.hashCode() : 0);
        result = 31 * result + (active != null ? active.hashCode() : 0);
        return result;
    }*/

    private Collection<AdminInfo> adminInfosByEmailId;

    public Collection<AdminInfo> getAdminInfosByEmailId() {
        return adminInfosByEmailId;
    }

    public void setAdminInfosByEmailId(Collection<AdminInfo> adminInfosByEmailId) {
        this.adminInfosByEmailId = adminInfosByEmailId;
    }

    private Collection<UserInfo> userInfosByEmailId;

    public Collection<UserInfo> getUserInfosByEmailId() {
        return userInfosByEmailId;
    }

    public void setUserInfosByEmailId(Collection<UserInfo> userInfosByEmailId) {
        this.userInfosByEmailId = userInfosByEmailId;
    }
}
