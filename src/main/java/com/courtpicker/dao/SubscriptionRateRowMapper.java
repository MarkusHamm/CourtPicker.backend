package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.SubscriptionRate;

public class SubscriptionRateRowMapper implements RowMapper<SubscriptionRate> {

    @Override
    public SubscriptionRate mapRow(ResultSet rs, int rowNum) throws SQLException {
        SubscriptionRate rate = new SubscriptionRate();
        rate.setId(rs.getInt("id"));
        rate.setSubscriptionId(rs.getInt("subscriptionid"));
        rate.setName(rs.getString("name"));
        rate.setPrice(rs.getBigDecimal("price"));
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
