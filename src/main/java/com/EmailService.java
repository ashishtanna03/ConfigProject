package com;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/16/13
 * Time: 11:29 PM
 * To change this template use File | Settings | File Templates.
 */
public class EmailService {

    final String username = "miteshthakkar99@gmail.com";
    final String password = "aspirine99";

    public Boolean sendEmail(String fromAddress,String subject,String sendMessage,String toAddress) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });
        try {
            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(fromAddress));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
            message.setSubject(subject);
//            message.setText(sendMessage);
            message.setContent(sendMessage,"text/html; charset=ISO-8859-1");

            Transport.send(message);

            System.out.println("Mail Sent");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
        return true;
    }
}
