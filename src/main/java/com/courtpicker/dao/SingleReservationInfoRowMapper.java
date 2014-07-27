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
        res.setPrice(rs.getBigDecimal("price"));
        res.setPaid(rs.getBoolean("paid"));
        Date paymentDateTimeStamp = rs.getTimestamp("paymentdate");
        res.setPaymentDate(paymentDateTimeStamp == null ? null : new Date(paymentDateTimeStamp.getTime()));
        res.setPaymentOptionId(rs.getInt("paymentoptionid"));
        res.setPaymentOptionName(rs.getString("paymentoptionname"));
        res.setComment(rs.getString("comment"));
        setCustomerInfo(rs, res);
        
        return res;
    }

    private void setCustomerInfo(ResultSet rs, SingleReservationInfo res) throws SQLException {
        Integer customerId = rs.getInt("customerid");
        res.setCustomerId(customerId);
        
        // Attention: If db-column value is null 0 is returend from rs.getInt(...)
        if (customerId != 0) {
            res.setCustomerFirstName(rs.getString("customerfirstname"));
            res.setCustomerLastName(rs.getString("customerlastname"));
            res.setCustomerUserName(rs.getString("customerusername"));            
        }
        else {
            res.setCustomerUserName(null);
            String reservationCustomerName = rs.getString("reservationcustomername");
            
            if (reservationCustomerName != null && reservationCustomerName.length() > 0) {
                String[] splittedReservationCustomerName = reservationCustomerName.split(" ", 2);
                
                if (splittedReservationCustomerName.length == 1) {
                    res.setCustomerLastName(splittedReservationCustomerName[0]);
                }
                else {
                    res.setCustomerFirstName(splittedReservationCustomerName[0]);
                    res.setCustomerLastName(splittedReservationCustomerName[1]);
                }
            }
            else {
                res.setCustomerFirstName("");
                res.setCustomerLastName("");
            }
        }
    }
}
