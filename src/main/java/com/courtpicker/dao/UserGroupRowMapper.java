package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.UserGroup;

public class UserGroupRowMapper implements RowMapper<UserGroup> {
    
    public UserGroup mapRow(ResultSet rs, int rowNum) throws SQLException {
        UserGroup userGroup = new UserGroup();
        userGroup.setId(rs.getInt("id"));
        userGroup.setCpInstanceId(rs.getInt("cpinstanceid"));
        userGroup.setName(rs.getString("name"));
        
        return userGroup;
    }
}
