package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.PaymentOption;

public class PaymentOptionRowMapper implements RowMapper<PaymentOption> {
    @Override
    public PaymentOption mapRow(ResultSet rs, int rowNum) throws SQLException {
        PaymentOption po = new PaymentOption();
        po.setId(rs.getInt("id"));
        po.setCpInstanceId(rs.getInt("cpinstanceid"));
        po.setName(rs.getString("name"));
        po.setActive(rs.getBoolean("active"));
        po.setDeleted(rs.getBoolean("deleted"));
        
        return po;
    }
}
