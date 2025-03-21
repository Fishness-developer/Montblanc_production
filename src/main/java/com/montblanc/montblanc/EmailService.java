package com.montblanc.montblanc;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendMultipartMessage(String to, String subject, String messageBody) {
        MimeMessage message = javaMailSender.createMimeMessage();

        try {
            System.out.println("Attempting to send email to: " + to + " with subject: " + subject);
            System.out.println("Message body: " + messageBody);
            MimeMessageHelper helper = new MimeMessageHelper(message, true);
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(messageBody, true);
            helper.setFrom("webmechanik@gmail.com");
            javaMailSender.send(message);
            System.out.println("Email sent successfully to: " + to);
        } catch (MessagingException e) {
            System.err.println("Failed to send email: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
}