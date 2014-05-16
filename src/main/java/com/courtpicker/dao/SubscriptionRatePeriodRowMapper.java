package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.SubscriptionRatePeriod;

public class SubscriptionRatePeriodRowMapper implements RowMapper<SubscriptionRatePeriod> {

    @Override
    public SubscriptionRatePeriod mapRow(ResultSet rs, int rowNum) throws SQLException {
        SubscriptionRatePeriod rate = new SubscriptionRatePeriod();
        rate.setId(rs.getInt("id"));
        rate.setCourtCategoryId(rs.getInt("courtcategoryid"));
        rate.setName(rs.getString("name"));
        rate.setPeriodStart(rs.getString("periodstart"));
        rate.setPeriodEnd(rs.getString("periodend"));
        rate.setPrice(rs.getBigDecimal("price"));
        rate.setActive(rs.getBoolean("active"));
        rate.setOrderNr(rs.getInt("ordernr"));
        rate.setConstrainTime(rs.getBoolean("constraintime"));
        rate.setConstrainWeekDay(rs.getBoolean("constrainweekday"));
        rate.setConstrainUserGroup(rs.getBoolean("constrainusergroup"));
        rate.setcTimeFrom(rs.getString("ctimefrom"));
        rate.setcTimeTo(rs.getString("ctimeto"));
        rate.setcMon(rs.getBoolean("cmon"));
        rate.setcTue(rs.getBoolean("ctue"));
        rate.setcWed(rs.getBoolean("cwed"));
        rate.setcThu(rs.getBoolean("cthu"));
        rate.setcFri(rs.getBoolean("cfri"));
        rate.setcSat(rs.getBoolean("csat"));
        rate.setcSun(rs.getBoolean("csun"));
        rate.setcUserGroupIds(convertUsergroupIdsStringToList(rs.getString("cusergroupids")));
        
        return rate;
    }
    
    private List<Integer> convertUsergroupIdsStringToList(String usergroupidsString) {
        if (usergroupidsString == null) {
            return null;
        }
        if (usergroupidsString.length() == 0) {
            return new ArrayList<Integer>();
        }
        
        List<Integer> result = new ArrayList<Integer>();
        String[] usergroupidsStringArray = usergroupidsString.split(",");
        
        for (String usergroupid : usergroupidsStringArray) {
            result.add(Integer.parseInt(usergroupid));
        }
        
        return result;
    }
}
