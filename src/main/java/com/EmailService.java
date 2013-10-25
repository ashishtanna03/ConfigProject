package com;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;
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

    private Template template;

    public void setConfigurer(FreeMarkerConfigurer configurer) {
        try {
            template = configurer.getConfiguration().getTemplate("template.ftl");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Boolean sendEmail(final String fromAddress,final String subject,final String sendMessage,final String toName,final String toAddress) {

        Thread thread = new Thread(new Runnable() {
            String fromAdd = fromAddress;
            String sub = subject;
            String sendMsg = sendMessage;
            String toNam = toName;
            String toAdd = toAddress;
            public void run() {

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

                    Address[] addresses = new Address[1];
                    addresses[0] = new InternetAddress(fromAddress);
                    message.setReplyTo(addresses);

                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
                    message.setSubject(subject);

                    //To set template using freemarker

                    BodyPart bodyPart = new MimeBodyPart();

                    // freemarker stuff.
                    Map<String, String> rootMap = new HashMap<String, String>();
                    rootMap.put("toName", toName);
                    rootMap.put("message", sendMessage);
                    Writer out = new StringWriter();
                    template.process(rootMap, out);
                    // freemarker stuff ends.

            /* you can add html tags in your text to decorate it. */
                    bodyPart.setContent(out.toString(), "text/html");

                    Multipart multipart = new MimeMultipart();
                    multipart.addBodyPart(bodyPart);

                    message.setContent(multipart,"text/html; charset=ISO-8859-1");

                    Transport.send(message);

                } catch (MessagingException e) {
                    throw new RuntimeException(e);
                } catch (TemplateException e) {
                    e.printStackTrace();
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        });
        thread.start();

        return true;
    }
}
