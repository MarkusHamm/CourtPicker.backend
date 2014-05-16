package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.SubscriptionReservationPeriod;

public class SubscriptionReservationPeriodRowMapper implements RowMapper<SubscriptionReservationPeriod> {
    @Override
    public SubscriptionReservationPeriod mapRow(ResultSet rs, int rowNum) throws SQLException {
        SubscriptionReservationPeriod res = new SubscriptionReservationPeriod();
        res.setId(rs.getInt("id"));
        res.setCustomerId(rs.getInt("customerid"));
        res.setCourtId(rs.getInt("courtid"));
        res.setPeriodStart(new Date(rs.getTimestamp("periodstart").getTime()));
        res.setPeriodEnd(new Date(rs.getTimestamp("periodend").getTime()));
        res.setFromTime(rs.getString("fromtime"));
        res.setToTime(rs.getString("totime"));
        res.setFrequency(rs.getString("frequency"));
        res.setReservationDate(new Date(rs.getTimestamp("reservationdate").getTime()));
        res.setReservingCustomerId(rs.getInt("reservingcustomerid"));
        res.setDisplayName(rs.getString("displayname"));
        res.setPaid(rs.getBoolean("paid"));
        res.setDeleted(rs.getBoolean("deleted"));
        res.setPrice(rs.getBigDecimal("price"));
        res.setComment(rs.getString("comment"));
        
        return res;
    }
}
