package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.uimodel.SubscriptionReservationInfo;

public class SubscriptionReservationInfoRowMapper implements RowMapper<SubscriptionReservationInfo> {

    @Override
    public SubscriptionReservationInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
        SubscriptionReservationInfo res = new SubscriptionReservationInfo();
        res.setId(rs.getInt("id"));
        res.setInstanceId(rs.getInt("cpinstanceid"));
        res.setInstanceName(rs.getString("cpinstancename"));
        res.setSubscriptionId(rs.getInt("subscriptionid"));
        res.setSubscriptionName(rs.getString("subscriptionname"));
        res.setCourtCategoryId(rs.getInt("courtcategoryid"));
        res.setCourtCategoryName(rs.getString("courtcategoryname"));
        res.setCourtId(rs.getInt("courtid"));
        res.setCourtName(rs.getString("courtname"));
        res.setPeriodStart(rs.getString("periodstart"));
        res.setPeriodEnd(rs.getString("periodend"));
        res.setFromTime(rs.getString("fromtime"));
        res.setToTime(rs.getString("totime"));
        res.setReservationDate(new Date(rs.getTimestamp("reservationdate").getTime()));        
        res.setCustomerId(rs.getInt("customerid"));
        res.setCustomerFirstName(rs.getString("customerfirstname"));
        res.setCustomerLastName(rs.getString("customerlastname"));
        res.setCustomerUserName(rs.getString("customerusername"));
        res.setPrice(rs.getBigDecimal("price"));
        res.setPaid(rs.getBoolean("paid"));
        Date paymentDateTimeStamp = rs.getTimestamp("paymentdate");
        res.setPaymentDate(paymentDateTimeStamp == null ? null : new Date(paymentDateTimeStamp.getTime()));
        res.setPaymentOptionId(rs.getInt("paymentoptionid"));
        res.setPaymentOptionName(rs.getString("paymentoptionname"));
        res.setComment(rs.getString("comment"));
        
        return res;    
    }
}
