package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.Subscription;

public class SubscriptionRowMapper implements RowMapper<Subscription> {
    public Subscription mapRow(ResultSet rs, int rowNum) throws SQLException {
        Subscription subscription = new Subscription();
        subscription.setId(rs.getInt("id"));
        subscription.setCourtCategoryId(rs.getInt("courtcategoryid"));
        subscription.setName(rs.getString("name"));
        subscription.setPeriodStart(rs.getString("periodstart"));
        subscription.setPeriodEnd(rs.getString("periodend"));
        subscription.setBookableFrom(rs.getString("bookablefrom"));
        subscription.setBookableTo(rs.getString("bookableto"));       
        subscription.setOrderNr(rs.getInt("ordernr"));
        
        return subscription;
    }
}
