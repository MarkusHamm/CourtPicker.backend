package com.courtpicker.dao;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.SingleReservation;
import com.courtpicker.model.SubscriptionReservation;

@Component("subscriptionReservationDAO")
@Scope("prototype")
public class SubscriptionReservationDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private SubscriptionReservationRowMapper rowMapper;

    public SubscriptionReservationDAO() {
        this.rowMapper = new SubscriptionReservationRowMapper();
    }

    public List<SubscriptionReservation> getReservationsForCourt(Integer courtId, Date fromDate, Date toDate) {
        String query = "select * from roger.subscriptionreservation where courtid=? "
                + "and periodend>=? and periodstart<=?";
        List<SubscriptionReservation> matches = jdbcTemplate.query(query, new Object[] { courtId, fromDate, toDate },
                rowMapper);
        return matches;
    }
    
    public List<SubscriptionReservation> getReservationsForCourtCategory(Integer courtCategoryId, Date fromDate, Date toDate) {
        String query = "select * from roger.subscriptionreservation r, roger.court c " +
                "where r.courtid = c.id and c.courtcategoryid=? and r.periodend>=? and r.periodstart<=?";
        List<SubscriptionReservation> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId, fromDate, toDate },
                rowMapper);
        return matches;
    }
    
    public SubscriptionReservation persist(SubscriptionReservation reservation) {
        String query = "";

        // do an insert if id is NOT set
        if (reservation.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('roger.subscriptionreservation_id_seq')");
            reservation.setId(newRecordId);
            query = "INSERT INTO roger.subscriptionreservation(customerid, courtid, periodstart, periodend, fromtime, totime, " +
            		"reservationdate, reservingcustomerid, displayname, paid, deleted, price, comment, customername, " +
            		"calculatedprice, paymentdate, paymentoptionid, id) " +
            		"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "UPDATE roger.subscriptionreservation SET customerid=?, courtid=?, periodstart=?, periodend=?, fromtime=?, " +
            		"totime=?, reservationdate=?, reservingcustomerid=?, displayname=?, paid=?, deleted=?, price=?, comment=?, " +
            		"customername=?, calculatedprice=?, paymentdate=?, paymentoptionid=? WHERE id=?";
        }

        jdbcTemplate.update(query, new Object[] {reservation.getCustomerId(), reservation.getCourtId(), reservation.getPeriodStart(),
                reservation.getPeriodEnd(), reservation.getFromTime(), reservation.getToTime(), reservation.getReservationDate(),
                reservation.getReservingCustomerId(), reservation.getDisplayName(), reservation.getPaid(), reservation.getDeleted(),
                reservation.getPrice(), reservation.getComment(), reservation.getCustomerName(), reservation.getCalculatedPrice(),
                reservation.getPaymentDate(), reservation.getPaymentOptionId(), reservation.getId()});

        return reservation;
    }
}
