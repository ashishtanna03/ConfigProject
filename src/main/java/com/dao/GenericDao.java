package com.dao;

import com.pojo.hibernate.BookInfo;
import com.service.CustomHibernateSessionFilter;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/16/13
 * Time: 12:41 AM
 * To change this template use File | Settings | File Templates.
 */
public class GenericDao<T> {
    protected static HibernateTemplate hibernateTemplate;
    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
        hibernateTemplate = new HibernateTemplate(this.sessionFactory);
    }

    public List<T> getAll(Class t) {
        return hibernateTemplate.loadAll(t);
    }

    public T getById(Class t, Integer id) {
        return (T) hibernateTemplate.get(t, id);
    }

    public List<T> getByFieldName(Class t, String fieldName, Object field) {
        return hibernateTemplate.find("from " + t.getName() + " where " + fieldName + "=?", field);
    }

    public List<T> getByQuery(String queryString, Object... values) {
        return hibernateTemplate.find(queryString, values);
    }

    public Boolean saveObject(Object obj) {
        hibernateTemplate.save(obj);
        return true;
    }

    public Boolean updateObject(Object obj) {
        hibernateTemplate.update(obj);
        return true;
    }

    public List<String> getSuggestions(Class t,String fieldName,String fieldValue){
        return hibernateTemplate.find("select DISTINCT "+fieldName+" from "+t.getName()+" where ("+fieldName+" like '"+fieldValue+"%') or ("+fieldName+" like '%"+fieldValue+"%')");
    }
/*
    public List<T> getSearchResultsByName(Class t,String fieldValue){
        return hibernateTemplate.find("from "+t.getName()+" where (bookTitle like '"+fieldValue+"%') or (authorInfo.authorName like '%"+fieldValue+"%')");
    }*/
}
