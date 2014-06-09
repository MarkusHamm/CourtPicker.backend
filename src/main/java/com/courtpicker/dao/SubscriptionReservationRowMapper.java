package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.SubscriptionReservation;

public class SubscriptionReservationRowMapper implements RowMapper<SubscriptionReservation> {
    @Override
    public SubscriptionReservation mapRow(ResultSet rs, int rowNum) throws SQLException {
        SubscriptionReservation res = new SubscriptionReservation();
        res.setId(rs.getInt("id"));
        res.setCustomerId(rs.getInt("customerid"));
        res.setCustomerName(rs.getString("customername"));
        res.setCourtId(rs.getInt("courtid"));
        res.setPeriodStart(new Date(rs.getTimestamp("periodstart").getTime()));
        res.setPeriodEnd(new Date(rs.getTimestamp("periodend").getTime()));
        res.setFromTime(rs.getTime("fromtime"));
        res.setToTime(rs.getTime("totime"));
        res.setReservationDate(new Date(rs.getTimestamp("reservationdate").getTime()));
        res.setReservingCustomerId(rs.getInt("reservingcustomerid"));
        res.setDisplayName(rs.getString("displayname"));
        res.setPaid(rs.getBoolean("paid"));
        res.setDeleted(rs.getBoolean("deleted"));
        res.setCalculatedPrice(rs.getBigDecimal("calculatedprice"));
        res.setPrice(rs.getBigDecimal("price"));
        Date paymentDateTimeStamp = rs.getTimestamp("paymentdate");
        res.setPaymentDate(paymentDateTimeStamp == null ? null : new Date(paymentDateTimeStamp.getTime()));
        res.setPaymentOptionId(rs.getInt("paymentoptionid"));
        res.setComment(rs.getString("comment"));
        
        return res;
    }
}
