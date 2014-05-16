package com.courtpicker.tools;

import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.context.annotation.Scope;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Component;

@Component("mailEngine")
@Scope("singleton")
public class MailEngine {
    @Inject
    private MailSender mailSender;
    
    public void sendMail(String from, String to, String cc, String bcc, String subject, String text) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(from);
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
    
    public void sendTemplateBasedMail(String to, String cc, String bcc, String subject, String templateName, Map<String, String> templateVars) {
        // TODO
        throw new NotImplementedException();
    }

    public MailSender getMailSender() {
        return mailSender;
    }

    public void setMailSender(MailSender mailSender) {
        this.mailSender = mailSender;
    }
}
