package com.courtpicker.dao;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.support.SqlLobValue;
import org.springframework.jdbc.support.lob.LobHandler;
import org.springframework.stereotype.Component;

import com.courtpicker.model.WebdesignFile;

@Component("webdesignFileDAO")
@Scope("prototype")
public class WebdesignFileDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;
    
    private WebdesignFileRowMapper rowMapper;
    
    public WebdesignFileDAO() {
        rowMapper = new WebdesignFileRowMapper();
    }

    public WebdesignFile getWebdesignFile(int webdesignId, String type) {
        WebdesignFile webdesignFile = null;
        String query = "select * from cp.webdesignfile where webdesignid=? and type=?";
        
        try {
            webdesignFile = jdbcTemplate.queryForObject(query, new Object[] { webdesignId, type }, rowMapper);
        }
        catch(DataAccessException e) { }
        
        return webdesignFile;
    }
    
    public WebdesignFile persist(WebdesignFile webdesignFile) {
        String query = "";

        // do an insert if id is NOT set
        if (webdesignFile.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.webdesignfile_id_seq')");
            webdesignFile.setId(newRecordId);
            query = "insert into cp.webdesignfile " +
                    "(webdesignid, type, content, id) " +
                    "values (?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update cp.webdesignfile set webdesignid=?, type=?, content=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { webdesignFile.getWebdesignId(), webdesignFile.getType(),
                webdesignFile.getContent() , webdesignFile.getId()});

        return webdesignFile;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
