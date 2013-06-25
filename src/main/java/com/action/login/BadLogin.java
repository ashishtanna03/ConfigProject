package com.action.login;

import com.opensymphony.xwork2.ActionSupport;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/9/13
 * Time: 5:08 PM
 * To change this template use File | Settings | File Templates.
 */
public class BadLogin extends ActionSupport {

    private String result;

    public String getResult() {
        return result;
    }

    public String execute() {
        result = "error";
        return SUCCESS;
    }

}
