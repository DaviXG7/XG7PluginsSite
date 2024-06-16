package com.xg7plugins.xg7plguinssite.utils.emails;

import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import java.io.File;
import java.io.UnsupportedEncodingException;

//A parte de email ainda não foi implementada ao site!

public class Message {

    private String assunto;
    private String mensagem;
    private Multipart multipart;

    public Message(String assunto, String mensagem) {
        this.assunto = assunto;
        this.mensagem = mensagem;
    }

    public Message anexarArquivo(String path) {
        try {
            Multipart multipart = new MimeMultipart();

            MimeBodyPart bodyPart = new MimeBodyPart();

            File file = new File(path);

            bodyPart.attachFile(file);
            multipart.addBodyPart(bodyPart);

            this.multipart = multipart;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return this;

    }



    public void enviarEmail(String destinatarios) throws UnsupportedEncodingException, MessagingException {
        Address[] to = InternetAddress.parse(destinatarios);

        javax.mail.Message message = new MimeMessage(EmailManager.getSession());
            message.setFrom(new InternetAddress("xg7mails@gmail.com", "XG7Plugins"));
            message.setRecipients(javax.mail.Message.RecipientType.TO, to);
            message.setSubject(assunto);
            if (multipart != null) {

                MimeBodyPart bodyPart = new MimeBodyPart();
                bodyPart.setContent(mensagem, "text/html; charset=utf-8");
                multipart.addBodyPart(bodyPart);
                message.setContent(multipart);
                Transport.send(message);
            }
            message.setContent(mensagem, "text/html; charset=utf-8");

            Transport.send(message);
    }
}
