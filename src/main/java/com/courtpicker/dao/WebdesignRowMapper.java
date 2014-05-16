package com.courtpicker.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.courtpicker.model.Webdesign;

public class WebdesignRowMapper implements RowMapper<Webdesign> {
    
    public Webdesign mapRow(ResultSet rs, int rowNum) throws SQLException {
        Webdesign webdesign = new Webdesign();
        webdesign.setId(rs.getInt("id"));
        webdesign.setCpInstanceId(rs.getInt("cpinstanceid"));
        webdesign.setBackgroundStyle(rs.getString("backgroundstyle"));
        webdesign.setBackgroundColor(rs.getString("backgroundcolor"));
        webdesign.setHeaderColor(rs.getString("headercolor"));
        webdesign.setHeaderBackgroundColor(rs.getString("headerbackgroundcolor"));
        webdesign.setControlsColor(rs.getString("controlscolor"));
        webdesign.setControlsTextColor(rs.getString("controlstextcolor"));
        webdesign.setContentColor(rs.getString("contentcolor"));
        webdesign.setContentBackgroundColor(rs.getString("contentbackgroundcolor"));
        webdesign.setCtSelectColor(rs.getString("ctselectcolor"));
        webdesign.setCtSelectBackgroundColor(rs.getString("ctselectbackgroundcolor"));
        webdesign.setCtSelectFocusColor(rs.getString("ctselectfocuscolor"));
        webdesign.setLinkColor(rs.getString("linkcolor"));
        webdesign.setReservableHourColor(rs.getString("reservablehourcolor"));
        webdesign.setNonReservableHourColor(rs.getString("nonreservablehourcolor"));
        webdesign.setFooterColor(rs.getString("footercolor"));
        
        return webdesign;
    }
}
