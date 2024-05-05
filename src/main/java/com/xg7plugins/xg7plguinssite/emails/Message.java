package com.xg7plugins.xg7plguinssite.emails;

import jakarta.mail.Address;
import jakarta.mail.MessagingException;
import jakarta.mail.Multipart;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;

import java.io.File;
import java.io.UnsupportedEncodingException;

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

        } catch (Exception e) {}

        return this;

    }



    public void enviarEmail(String destinatarios) throws UnsupportedEncodingException, MessagingException {
            Address[] to = InternetAddress.parse(destinatarios);

            jakarta.mail.Message message = new MimeMessage(EmailManager.getSession());
            message.setFrom(new InternetAddress("xg7mails@gmail.com", "XG7Plugins"));
            message.setRecipients(jakarta.mail.Message.RecipientType.TO, to);
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
