package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.Authority;

public class AuthorityRowMapper implements RowMapper<Authority> {

    @Override
    public Authority mapRow(ResultSet rs, int rowNum) throws SQLException {
        Authority authority = new Authority();
        authority.setId(rs.getInt("id"));
        authority.setUserId(rs.getInt("userid"));
        authority.setCpInstanceId(rs.getInt("cpinstanceid"));
        authority.setAuthority(rs.getString("authority"));

        return authority;
    }

}
