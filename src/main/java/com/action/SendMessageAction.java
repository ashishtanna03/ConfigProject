package com.action;

import com.EmailService;
import com.opensymphony.xwork2.ActionSupport;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 8/2/13
 * Time: 1:50 AM
 * To change this template use File | Settings | File Templates.
 */
public class SendMessageAction extends ActionSupport {

    private String contactName;
    private String contactEmail;
    private String contactSubject;
    private String contactMessage;

    private EmailService emailService;

    private String result;

    public void setContactName(String contactName) {
        this.contactName = contactName;
    }

    public void setContactEmail(String contactEmail) {
        this.contactEmail = contactEmail;
    }

    public void setContactSubject(String contactSubject) {
        this.contactSubject = contactSubject;
    }

    public void setContactMessage(String contactMessage) {
        this.contactMessage = contactMessage;
    }

    public void setEmailService(EmailService emailService) {
        this.emailService = emailService;
    }

    public String getResult() {
        return result;
    }

    public String sendMessage() {

        if (contactName==null || contactEmail==null || contactSubject==null || contactMessage==null ||
            contactName.equals("") || contactEmail.equals("") || contactSubject.equals("") || contactMessage.equals("")) {
            result="error";
            return SUCCESS;
        }

        String subject = "Contact Form : "+contactSubject;
        String message = "Name : "+contactName+"<br/>Email : "+contactEmail+"<br/>Message :<br/>"+contactMessage;

        if(emailService.sendEmail(contactEmail,subject,message,"Admin","feedback@innovplex.com"))
            result="success";
        else
            result="error";

        return SUCCESS;
    }

}
