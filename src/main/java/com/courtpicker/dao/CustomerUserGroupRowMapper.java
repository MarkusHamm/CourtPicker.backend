package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.CustomerUserGroup;

public class CustomerUserGroupRowMapper implements RowMapper<CustomerUserGroup> {

    @Override
    public CustomerUserGroup mapRow(ResultSet rs, int rowNum) throws SQLException {
        CustomerUserGroup cug = new CustomerUserGroup();
        cug.setId(rs.getInt("id"));
        cug.setCustomerId(rs.getInt("customerid"));
        cug.setUserGroupId(rs.getInt("usergroupid"));
        
        return cug;
    }
}
