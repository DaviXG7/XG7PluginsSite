package com.xg7plugins.xg7plguinssite.emails;

import jakarta.mail.Authenticator;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import lombok.Getter;

import java.util.Properties;

public class EmailManager {

    @Getter
    private static Session session;

    public static void loadSession() {

        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");
        properties.put("mail.smtp.socketFactory.port", "465");
        properties.put("mail.smtp.socketFactory.class",
                "javax.net.ssl.SSLSocketFactory");
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.trust", "*");

        String mail = "xg7mails@gmail.com";
        String senha = "ibmd udou virw krvr";

        session = Session.getDefaultInstance(properties,
                new Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication()
                    {
                        return new PasswordAuthentication(mail,senha);
                    }
                });

        session.setDebug(true);
    }

}