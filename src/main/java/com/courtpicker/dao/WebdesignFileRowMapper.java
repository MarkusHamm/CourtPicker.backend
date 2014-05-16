package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.WebdesignFile;

public class WebdesignFileRowMapper implements RowMapper<WebdesignFile> {
    
    public WebdesignFile mapRow(ResultSet rs, int rowNum) throws SQLException {
        WebdesignFile wdf = new WebdesignFile();
        wdf.setId(rs.getInt("id"));
        wdf.setWebdesignId(rs.getInt("webdesignid"));
        wdf.setType(rs.getString("type"));
        wdf.setContent(rs.getBytes("content"));
        
        return wdf;
    }

}
