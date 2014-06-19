package com.courtpicker.dao;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

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
}
