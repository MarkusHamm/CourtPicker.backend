package com.courtpicker.dao;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.SubscriptionReservationPeriod;

@Component("subscriptionReservationPeriodDAO")
@Scope("prototype")
public class SubscriptionReservationPeriodDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private SubscriptionReservationPeriodRowMapper rowMapper;

    public SubscriptionReservationPeriodDAO() {
        this.rowMapper = new SubscriptionReservationPeriodRowMapper();
    }

    public List<SubscriptionReservationPeriod> getReservationsForCourt(Integer courtId, Date fromDate, Date toDate) {
        String query = "select * from cp.subscriptionperiodreservation where courtid=? "
                + "and periodend>=? and periodstart<=?";
        List<SubscriptionReservationPeriod> matches = jdbcTemplate.query(query, new Object[] { courtId, fromDate, toDate },
                rowMapper);
        return matches;
    }
    
    public List<SubscriptionReservationPeriod> getReservationsForCourtCategory(Integer courtCategoryId, Date fromDate, Date toDate) {
        String query = "select * from cp.subscriptionperiodreservation r, cp.court c " +
                "where r.courtid = c.id and c.courtcategoryid=? and r.periodend>=? and r.periodstart<=?";
        List<SubscriptionReservationPeriod> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId, fromDate, toDate },
                rowMapper);
        return matches;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
