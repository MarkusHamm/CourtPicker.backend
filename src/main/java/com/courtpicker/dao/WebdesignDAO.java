package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Court;
import com.courtpicker.model.Webdesign;

@Component("webdesignDAO")
@Scope("prototype")
public class WebdesignDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;
    
    private WebdesignRowMapper rowMapper;
    
    public WebdesignDAO() {
        rowMapper = new WebdesignRowMapper();
    }

    public Webdesign get(Integer id) {
        String query = "select * from roger.webdesign where id=?";
        List<Webdesign> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }
    
    public Webdesign getWebdesign(int cpInstanceId) {
        Webdesign webdesign = null;
        String query = "select * from roger.webdesign where cpinstanceid=?";
        
        try {
            webdesign = jdbcTemplate.queryForObject(query, new Object[] { cpInstanceId }, rowMapper);
        }
        catch(DataAccessException e) { }
        
        return webdesign;
    }
    
    public Webdesign persist(Webdesign webdesign) {
        String query = "";

        // do an insert if id is NOT set
        if (webdesign.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('roger.webdesign_id_seq')");
            webdesign.setId(newRecordId);
            query = "insert into roger.webdesign " +
            		"(cpinstanceid, backgroundstyle, backgroundcolor, headercolor, headerbackgroundcolor, controlscolor," +
            		" controlstextcolor, contentcolor, contentbackgroundcolor, ctselectcolor, ctselectbackgroundcolor, ctselectfocuscolor," +
            		" linkcolor, reservablehourcolor, nonreservablehourcolor, footercolor, id) " +
            		"values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update roger.webdesign set cpinstanceid=?, backgroundstyle=?, backgroundcolor=?, headercolor=?, " +
            		"headerbackgroundcolor=?, controlscolor=?, controlstextcolor=?, contentcolor=?, contentbackgroundcolor=?, " +
            		"ctselectcolor=?, ctselectbackgroundcolor=?, ctselectfocuscolor=?, linkcolor=?, " +
            		"reservablehourcolor=?, nonreservablehourcolor=?, footercolor=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { webdesign.getCpInstanceId(), webdesign.getBackgroundStyle(), 
                webdesign.getBackgroundColor(), webdesign.getHeaderColor(), webdesign.getHeaderBackgroundColor(),
                webdesign.getControlsColor(), webdesign.getControlsTextColor(), webdesign.getContentColor(), webdesign.getContentBackgroundColor(),
                webdesign.getCtSelectColor(), webdesign.getCtSelectBackgroundColor(), webdesign.getCtSelectFocusColor(),
                webdesign.getLinkColor(), webdesign.getReservableHourColor(), webdesign.getNonReservableHourColor(),
                webdesign.getFooterColor(), webdesign.getId()});

        return webdesign;
    }
    
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }
}
