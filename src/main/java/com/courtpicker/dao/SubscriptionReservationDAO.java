package com.courtpicker.dao;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.SingleReservation;
import com.courtpicker.model.SubscriptionReservation;
import com.courtpicker.uimodel.SingleReservationInfo;
import com.courtpicker.uimodel.SubscriptionReservationInfo;

@Component("subscriptionReservationDAO")
@Scope("prototype")
public class SubscriptionReservationDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private SubscriptionReservationRowMapper rowMapper;
    private SubscriptionReservationInfoRowMapper infoRowMapper;

    public SubscriptionReservationDAO() {
        this.rowMapper = new SubscriptionReservationRowMapper();
        this.infoRowMapper = new SubscriptionReservationInfoRowMapper();
    }
    
    public SubscriptionReservation get(Integer id) {
        String query = "select * from cp.subscriptionreservation where id=?";
        List<SubscriptionReservation> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }

    public List<SubscriptionReservation> getReservationsForCourt(Integer courtId, Date fromDate, Date toDate) {
        String query = "select * from cp.subscriptionreservation where courtid=? " +
                "and to_date(periodend, 'DD.MM.YYYY')>=? and to_date(periodstart, 'DD.MM.YYYY')<=? " +
                "and deleted=false";
        List<SubscriptionReservation> matches = jdbcTemplate.query(query, new Object[] { courtId, fromDate, toDate },
                rowMapper);
        return matches;
    }
    
    public List<SubscriptionReservation> getReservationsForCourtCategory(Integer courtCategoryId, Date fromDate, Date toDate) {
        String query = "select * from cp.subscriptionreservation r, cp.court c " +
                "where r.courtid = c.id and c.courtcategoryid=? and to_date(r.periodend, 'DD.MM.YYYY')>=? and to_date(r.periodstart, 'DD.MM.YYYY')<=? " +
                "and r.deleted=false";
        List<SubscriptionReservation> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId, fromDate, toDate },
                rowMapper);
        return matches;
    }
    
    public SubscriptionReservation persist(SubscriptionReservation reservation) {
        String query = "";

        // do an insert if id is NOT set
        if (reservation.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.subscriptionreservation_id_seq')");
            reservation.setId(newRecordId);
            query = "INSERT INTO cp.subscriptionreservation(subscriptionid, customerid, courtid, periodstart, periodend, fromtime, totime, " +
            		"reservationdate, reservingcustomerid, displayname, paid, deleted, price, comment, customername, " +
            		"calculatedprice, paymentdate, paymentoptionid, id) " +
            		"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "UPDATE cp.subscriptionreservation SET subscriptionid=?, customerid=?, courtid=?, periodstart=?, periodend=?, fromtime=?, " +
            		"totime=?, reservationdate=?, reservingcustomerid=?, displayname=?, paid=?, deleted=?, price=?, comment=?, " +
            		"customername=?, calculatedprice=?, paymentdate=?, paymentoptionid=? WHERE id=?";
        }

        jdbcTemplate.update(query, new Object[] {reservation.getSubscriptionId(), reservation.getCustomerId(), reservation.getCourtId(), 
                reservation.getPeriodStart(), reservation.getPeriodEnd(), reservation.getFromTime(), reservation.getToTime(), 
                reservation.getReservationDate(), reservation.getReservingCustomerId(), reservation.getDisplayName(), reservation.getPaid(), 
                reservation.getDeleted(), reservation.getPrice(), reservation.getComment(), reservation.getCustomerName(), 
                reservation.getCalculatedPrice(), reservation.getPaymentDate(), reservation.getPaymentOptionId(), reservation.getId()});

        return reservation;
    }
    
    public void cancelReservation(Integer id) {
        String query = "update cp.subscriptionreservation set deleted=true where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }
    
    public List<SubscriptionReservationInfo> getSubscriptionReservationInfosForCustomer(Integer customerId) {
        String query = 
                "select " +
                "sr.id, ci.id as cpinstanceid, ci.name as cpinstancename, su.id as subscriptionid, su.name as subscriptionname, " +
                "cc.id as courtcategoryid, cc.name as courtcategoryname, sr.courtid, co.name as courtname, sr.periodstart, sr.periodend, " +
                "sr.fromtime, sr.totime, sr.reservationdate, sr.customerid, cu.firstname as customerfirstname, cu.lastname as customerlastname, " +
                "cu.username as customerusername, sr.customername as reservationcustomername, sr.price, sr.paid, sr.paymentdate, sr.paymentoptionid, po.name as paymentoptionname, sr.comment " +
                "from " +
                "cp.subscriptionreservation sr " +
                "left outer join cp.subscription su on (sr.subscriptionid=su.id) " +
                "left outer join cp.courtcategory cc on (su.courtcategoryid=cc.id) " +
                "left outer join cp.cpinstance ci on (cc.cpinstanceid=ci.id) " +
                "left outer join cp.court co on (sr.courtid=co.id) " +
                "left outer join cp.customer cu on (sr.customerid=cu.id) " +
                "left outer join cp.paymentoption po on (sr.paymentoptionid=po.id) " +
                "where sr.customerid=? and sr.deleted=false " +
                "order by sr.reservationdate desc";

        List<SubscriptionReservationInfo> matches = jdbcTemplate.query(query, new Object[] { customerId }, infoRowMapper);
        return matches;
    }
    
    public List<SubscriptionReservationInfo> getSubscriptionReservationInfosForCpInstance(Integer cpInstanceId) {
        String query = 
                "select " +
                "sr.id, ci.id as cpinstanceid, ci.name as cpinstancename, su.id as subscriptionid, su.name as subscriptionname, " +
                "cc.id as courtcategoryid, cc.name as courtcategoryname, sr.courtid, co.name as courtname, sr.periodstart, sr.periodend, " +
                "sr.fromtime, sr.totime, sr.reservationdate, sr.customerid, cu.firstname as customerfirstname, cu.lastname as customerlastname, " +
                "cu.username as customerusername, sr.customername as reservationcustomername, sr.price, sr.paid, sr.paymentdate, sr.paymentoptionid, po.name as paymentoptionname, sr.comment " +
                "from " +
                "cp.subscriptionreservation sr " +
                "left outer join cp.subscription su on (sr.subscriptionid=su.id) " +
                "left outer join cp.courtcategory cc on (su.courtcategoryid=cc.id) " +
                "left outer join cp.cpinstance ci on (cc.cpinstanceid=ci.id) " +
                "left outer join cp.court co on (sr.courtid=co.id) " +
                "left outer join cp.customer cu on (sr.customerid=cu.id) " +
                "left outer join cp.paymentoption po on (sr.paymentoptionid=po.id) " +
                "where ci.id=? and sr.deleted=false " +
                "order by sr.reservationdate desc";

        List<SubscriptionReservationInfo> matches = jdbcTemplate.query(query, new Object[] { cpInstanceId }, infoRowMapper);
        return matches;
    }
}
