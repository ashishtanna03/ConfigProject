package com.service;

import org.hibernate.FlushMode;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.dao.DataAccessResourceFailureException;
import org.springframework.orm.hibernate3.support.OpenSessionInViewFilter;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/16/13
 * Time: 12:28 AM
 * To change this template use File | Settings | File Templates.
 */
public class CustomHibernateSessionFilter extends OpenSessionInViewFilter {

    public Session getSession(SessionFactory sessionFactory) throws DataAccessResourceFailureException {
        Session session = super.getSession(sessionFactory);
        session.setFlushMode(FlushMode.COMMIT);
        return session;

    }

    protected void closeSession(Session session, SessionFactory sessionFactory) {
        session.flush();
        super.closeSession(session, sessionFactory);
    }
}
