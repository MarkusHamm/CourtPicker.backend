package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.CustomerUserGroupDetail;

public class CustomerUserGroupDetailRowMapper implements RowMapper<CustomerUserGroupDetail> {   
    @Override
    public CustomerUserGroupDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerUserGroupDetail cug = new CustomerUserGroupDetail();
        cug.setId(rs.getInt("id"));
        cug.setCustomerId(rs.getInt("customerid"));
        cug.setUserGroupId(rs.getInt("usergroupid"));
        cug.setCpInstanceId(rs.getInt("cpinstanceid"));
        
        return cug;
    }
}
