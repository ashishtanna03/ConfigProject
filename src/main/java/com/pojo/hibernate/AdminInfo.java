package com.pojo.hibernate;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:47 PM
 * To change this template use File | Settings | File Templates.
 */
public class AdminInfo implements Serializable {
    private Integer adminId;

    public Integer getAdminId() {
        return adminId;
    }

    public void setAdminId(Integer adminId) {
        this.adminId = adminId;
    }

    private String adminName;

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    private String adminInfo;

    public String getAdminInfo() {
        return adminInfo;
    }

    public void setAdminInfo(String adminInfo) {
        this.adminInfo = adminInfo;
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        AdminInfo adminInfo1 = (AdminInfo) o;

        if (adminId != null ? !adminId.equals(adminInfo1.adminId) : adminInfo1.adminId != null) return false;
        if (adminInfo != null ? !adminInfo.equals(adminInfo1.adminInfo) : adminInfo1.adminInfo != null) return false;
        if (adminName != null ? !adminName.equals(adminInfo1.adminName) : adminInfo1.adminName != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = adminId != null ? adminId.hashCode() : 0;
        result = 31 * result + (adminName != null ? adminName.hashCode() : 0);
        result = 31 * result + (adminInfo != null ? adminInfo.hashCode() : 0);
        return result;
    }
*/
    private LoginInfo loginInfoByEmailId;

    public LoginInfo getLoginInfoByEmailId() {
        return loginInfoByEmailId;
    }

    public void setLoginInfoByEmailId(LoginInfo loginInfoByEmailId) {
        this.loginInfoByEmailId = loginInfoByEmailId;
    }
}
