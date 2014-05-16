package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.Court;

public class CourtRowMapper implements RowMapper<Court> {
    
    public Court mapRow(ResultSet rs, int rowNum) throws SQLException {
        Court court = new Court();
        court.setId(rs.getInt("id"));        
        court.setCourtCategoryId(rs.getInt("courtcategoryid"));
        court.setName(rs.getString("name"));
        court.setOrderNr(rs.getInt("ordernr"));
        
        return court;
    }
}
