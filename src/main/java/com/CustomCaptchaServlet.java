package com;

import nl.captcha.Captcha;
import nl.captcha.backgrounds.FlatColorBackgroundProducer;
import nl.captcha.servlet.CaptchaServletUtil;
import nl.captcha.servlet.SimpleCaptchaServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;

/**
 * Created with IntelliJ IDEA.
 * User: Ashish
 * Date: 3/16/13
 * Time: 11:08 PM
 * To change this template use File | Settings | File Templates.
 */
public class CustomCaptchaServlet extends SimpleCaptchaServlet {

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Captcha captcha = new Captcha.Builder(120,40)
                .addText()
                .addBackground(new FlatColorBackgroundProducer(Color.WHITE))
                .build();

        CaptchaServletUtil.writeImage(resp, captcha.getImage());

        req.getSession().setAttribute(Captcha.NAME, captcha);
    }
}
