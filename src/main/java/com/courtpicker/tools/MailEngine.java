package com.courtpicker.tools;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;

import org.springframework.context.annotation.Scope;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component("mailEngine")
@Scope("singleton")
public class MailEngine {
    @Inject
    private JavaMailSender mailSender;
    // has to match with the mailSender server settings (in config file)
    private final String fromEmail = "markus.hamm@gmx.at";
            
    @Async
    public void sendHtmlMail(final String to, final String cc, final String bcc, final String subject, final String text) {
        MimeMessagePreparator preparator = new MimeMessagePreparator() {
            public void prepare(MimeMessage mimeMessage) throws Exception {
                MimeMessageHelper message = new MimeMessageHelper(mimeMessage);
                message.setFrom(fromEmail);
                message.setTo(to);
                message.setSubject(subject);
                message.setText(text, true);
                
                if (cc != null && cc.length() > 0) {
                    message.setCc(cc);
                }
                if (bcc != null && bcc.length() > 0) {
                    message.setBcc(bcc);
                }
            }
        };
        
        mailSender.send(preparator);
    }
    
    @Async
    public void sendTextMail(String to, String cc, String bcc, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(fromEmail);
        message.setTo(to);
        message.setSubject(subject);
        message.setText(text);
        
        if (cc != null && cc.length() > 0) {
            message.setCc(cc);
        }
        if (bcc != null && bcc.length() > 0) {
            message.setBcc(bcc);
        }
        
        mailSender.send(message);
    }
        
    public JavaMailSender getMailSender() {
        return mailSender;
    }

    public void setMailSender(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }
}
