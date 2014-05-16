package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.uimodel.SingleReservationInfo;

public class SingleReservationInfoRowMapper implements RowMapper<SingleReservationInfo> {

    @Override
    public SingleReservationInfo mapRow(ResultSet rs, int rowNum) throws SQLException {
        SingleReservationInfo res = new SingleReservationInfo();
        res.setId(rs.getInt("id"));
        res.setInstanceId(rs.getInt("cpinstanceid"));
        res.setInstanceName(rs.getString("cpinstancename"));
        res.setCourtCategoryId(rs.getInt("courtcategoryid"));
        res.setCourtCategoryName(rs.getString("courtcategoryname"));
        res.setCourtId(rs.getInt("courtid"));
        res.setCourtName(rs.getString("courtname"));
        res.setFromDate(new Date(rs.getTimestamp("fromdate").getTime()));
        res.setToDate(new Date(rs.getTimestamp("todate").getTime()));
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
