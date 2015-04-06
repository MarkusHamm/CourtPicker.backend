package com.courtpicker.tools;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.courtpicker.dao.CPInstanceDAO;
import com.courtpicker.dao.CourtCategoryDAO;
import com.courtpicker.dao.CourtDAO;
import com.courtpicker.dao.CustomerDAO;
import com.courtpicker.dao.SubscriptionDAO;
import com.courtpicker.model.CPInstance;
import com.courtpicker.model.Court;
import com.courtpicker.model.CourtCategory;
import com.courtpicker.model.Customer;
import com.courtpicker.model.SingleReservation;
import com.courtpicker.model.Subscription;
import com.courtpicker.model.SubscriptionReservation;

@Component("cpMailSender")
@Scope("singleton")
public class CPMailSender {
    @Inject
    private MailEngine mailEngine;
    @Inject
    private VelocityEngine velocityEngine;
    @Inject
    private DateHelper dateHelper;
    @Inject
    private CourtDAO courtDAO;
    @Inject
    private CourtCategoryDAO courtCategoryDAO;
    @Inject
    private CPInstanceDAO cpInstanceDAO;
    @Inject
    private CustomerDAO customerDAO;
    @Inject
    private SubscriptionDAO subscriptionDAO;
    
    public void sendAccountCreatedMail(Customer user, String registerInstanceShortName) {
        Map<String,Object> model = new HashMap<String,Object>();
        model.put("user", user);
        model.put("registerInstanceShortName", registerInstanceShortName);
        String body = applyModelToTemplate("accountCreated.vm", model);
        mailEngine.sendHtmlMail(user.getEmail(), null, null, "CourtPicker Account erstellt", body);
    }

    public void sendMinimalAccountCreatedMail(Customer user, String registerInstanceShortName) {
        Map<String,Object> model = new HashMap<String,Object>();
        model.put("user", user);
        model.put("registerInstanceShortName", registerInstanceShortName);
        String body = applyModelToTemplate("minimalAccountCreated.vm", model);
        mailEngine.sendHtmlMail(user.getEmail(), null, null, "CourtPicker Account erstellt", body);
    }
    
    public void sendPasswordForgottenMail(Customer user, String newPassword) {
        Map<String,Object> model = new HashMap<String,Object>();
        model.put("user", user);
        model.put("newPassword", newPassword);
        String body = applyModelToTemplate("passwordForgotten.vm", model);
        mailEngine.sendHtmlMail(user.getEmail(), null, null, "CourtPicker Passwort vergessen", body);
    }
    
    public void sendSingleReservationDoneMail(SingleReservation reservation) {
        Map<String, Object> model = getSingleReservationTemplateModel(reservation);
        Customer reservationUser = customerDAO.get(reservation.getCustomerId());
        
        if (reservationUser != null) {
            String body = applyModelToTemplate("singleReservationDone.vm", model);
            mailEngine.sendHtmlMail(reservationUser.getEmail(), null, null, "CourtPicker Reservierung", body);
        }
    }
    
    public void sendSingleReservationCancelMail(SingleReservation reservation) {
        Map<String, Object> model = getSingleReservationTemplateModel(reservation);
        Customer reservationUser = customerDAO.get(reservation.getCustomerId());

        if (reservationUser != null) {
            String body = applyModelToTemplate("singleReservationCancelled.vm", model);
            mailEngine.sendHtmlMail(reservationUser.getEmail(), null, null, "CourtPicker Stornierung", body);
        }
    }

    public void sendSubscriptionReservationDoneMail(SubscriptionReservation reservation) throws ParseException {
        Map<String, Object> model = getSubscriptionReservationTemplateModel(reservation);        
        Customer reservationUser = customerDAO.get(reservation.getCustomerId());
        
        if (reservationUser != null) {
            String body = applyModelToTemplate("subscriptionReservationDone.vm", model);
            mailEngine.sendHtmlMail(reservationUser.getEmail(), null, null, "CourtPicker Abo Reservierung", body);
        }
    }

    public void sendSubscriptionReservationCancelMail(SubscriptionReservation reservation) throws ParseException {
        Map<String, Object> model = getSubscriptionReservationTemplateModel(reservation);        
        Customer reservationUser = customerDAO.get(reservation.getCustomerId());

        if (reservationUser != null) {
            String body = applyModelToTemplate("subscriptionReservationCancelled.vm", model);
            mailEngine.sendHtmlMail(reservationUser.getEmail(), null, null, "CourtPicker Abo Stornierung", body);
        }
    }
    
    public void sendInstanceCreatedMail() {
        mailEngine.sendHtmlMail("info@courtpicker.com", null, null, "AUTO: Instance Created", "new instance created");
    }
    
    private Map<String, Object> getSubscriptionReservationTemplateModel(SubscriptionReservation reservation)
            throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        Map<String,Object> model = new HashMap<String,Object>();
        
        model.put("reservationId", reservation.getId());
        model.put("price", reservation.getPrice());
        model.put("fromTime", reservation.getFromTime());
        model.put("toTime", reservation.getToTime());
        model.put("fromToDate", reservation.getPeriodStart() + " - " + reservation.getPeriodEnd());
        Date periodStartDate = dateFormat.parse(reservation.getPeriodStart());
        model.put("weekDay", dateHelper.getDayOfWeekString(periodStartDate));
        
        Court court = courtDAO.get(reservation.getCourtId());
        Subscription subscription = subscriptionDAO.get(reservation.getSubscriptionId());
        CourtCategory courtCategory = courtCategoryDAO.get(subscription.getCourtCategoryId());
        CPInstance cpInstance = cpInstanceDAO.get(courtCategory.getCpInstanceId());
        
        model.put("subscriptionName", subscription.getName());
        model.put("cpInstanceName", cpInstance.getName());
        model.put("courtName", court.getName());
        return model;
    }
   
    private String applyModelToTemplate(String templateName, Map<String,Object> model) {
        return VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, templateName, "UTF-8", model);
    }
    
    private Map<String, Object> getSingleReservationTemplateModel(SingleReservation reservation) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm");
        Map<String,Object> model = new HashMap<String,Object>();
        
        model.put("date", dateFormat.format(reservation.getFromDate()));
        model.put("fromTime", timeFormat.format(reservation.getFromDate()));
        model.put("toTime", timeFormat.format(reservation.getToDate()));
        model.put("reservationId", reservation.getId());
        model.put("price", reservation.getPrice());
        
        Court court = courtDAO.get(reservation.getCourtId());
        CourtCategory courtCategory = courtCategoryDAO.get(court.getCourtCategoryId());
        CPInstance cpInstance = cpInstanceDAO.get(courtCategory.getCpInstanceId());
        model.put("courtName", court.getName());
        model.put("cpInstanceName", cpInstance.getName());
        return model;
    }
}
