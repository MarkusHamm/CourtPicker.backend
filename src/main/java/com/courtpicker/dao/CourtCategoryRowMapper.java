package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.CourtCategory;

public class CourtCategoryRowMapper implements RowMapper<CourtCategory> {
    
    public CourtCategory mapRow(ResultSet rs, int rowNum) throws SQLException {
        CourtCategory courtCategory = new CourtCategory();
        courtCategory.setId(rs.getInt("id"));
        courtCategory.setCpInstanceId(rs.getInt("cpinstanceid"));
        courtCategory.setOrderNr(rs.getInt("ordernr"));
        courtCategory.setName(rs.getString("name"));
        courtCategory.setBookableFromTime(rs.getString("bookablefromtime"));
        courtCategory.setBookableToTime(rs.getString("bookabletotime"));
        courtCategory.setBookingUnit(rs.getInt("bookingunit"));
        
        return courtCategory;
    }
}
