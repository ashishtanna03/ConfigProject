package com.pojo.hibernate;

import java.io.Serializable;
import java.util.Date;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 4/13/13
 * Time: 8:48 PM
 * To change this template use File | Settings | File Templates.
 */
public class Notification implements Serializable {
    private Integer notificationId;

    public Integer getNotificationId() {
        return notificationId;
    }

    public void setNotificationId(Integer notificationId) {
        this.notificationId = notificationId;
    }

    private Integer notificationType;

    public Integer getNotificationType() {
        return notificationType;
    }

    public void setNotificationType(Integer notificationType) {
        this.notificationType = notificationType;
    }

    private Integer objectId;

    public Integer getObjectId() {
        return objectId;
    }

    public void setObjectId(Integer objectId) {
        this.objectId = objectId;
    }

    private Date date;

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    private Integer status;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    /*@Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Notification that = (Notification) o;

        if (date != null ? !date.equals(that.date) : that.date != null) return false;
        if (notificationId != null ? !notificationId.equals(that.notificationId) : that.notificationId != null)
            return false;
        if (notificationText != null ? !notificationText.equals(that.notificationText) : that.notificationText != null)
            return false;
        if (notificationType != null ? !notificationType.equals(that.notificationType) : that.notificationType != null)
            return false;
        if (status != null ? !status.equals(that.status) : that.status != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = notificationId != null ? notificationId.hashCode() : 0;
        result = 31 * result + (notificationType != null ? notificationType.hashCode() : 0);
        result = 31 * result + (notificationText != null ? notificationText.hashCode() : 0);
        result = 31 * result + (date != null ? date.hashCode() : 0);
        result = 31 * result + (status != null ? status.hashCode() : 0);
        return result;
    }
*/
    private UserInfo userInfoByReceiverId;

    public UserInfo getUserInfoByReceiverId() {
        return userInfoByReceiverId;
    }

    public void setUserInfoByReceiverId(UserInfo userInfoByReceiverId) {
        this.userInfoByReceiverId = userInfoByReceiverId;
    }

    private UserInfo userInfoBySenderId;

    public UserInfo getUserInfoBySenderId() {
        return userInfoBySenderId;
    }

    public void setUserInfoBySenderId(UserInfo userInfoBySenderId) {
        this.userInfoBySenderId = userInfoBySenderId;
    }
}
