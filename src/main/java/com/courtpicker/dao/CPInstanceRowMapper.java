package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.CPInstance;

public class CPInstanceRowMapper implements RowMapper<CPInstance> {
    public CPInstance mapRow(ResultSet rs, int rowNum) throws SQLException {
        CPInstance cpInstance = new CPInstance();
        cpInstance.setId(rs.getInt("id"));
        cpInstance.setName(rs.getString("name"));
        cpInstance.setShortName(rs.getString("shortname"));
        cpInstance.setLicence(rs.getString("licence"));
        cpInstance.setLicenceStartDate(rs.getDate("licencestartdate"));
        cpInstance.setCreateDate(rs.getDate("createdate"));
        cpInstance.setMailAtRegistration(rs.getBoolean("mailatregistration"));
        cpInstance.setReservationLimit(rs.getInt("reservationlimit"));
        cpInstance.setReservationLabelVisibility(rs.getString("reservationlabelvisibility"));
        return cpInstance;
    }
}
