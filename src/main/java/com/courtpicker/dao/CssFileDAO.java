package com.courtpicker.dao;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component("cssFileDAO")
@Scope("prototype")
public class CssFileDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    public String getContent(int cpInstanceId) {
        String content = null;
        String query = "select content from roger.cssfile where cpinstanceid=?";
        
        try {
            content = jdbcTemplate.queryForObject(query, new Object[] { cpInstanceId }, String.class);
        }
        catch(DataAccessException e) { }

        return content;
    }

    public void persistContent(int cpInstanceId, String content) {
        String query = "";
        String checkQuery = "select count(1) from roger.cssfile where cpinstanceid=?";
        Integer existingRows = jdbcTemplate.queryForObject(checkQuery, new Object[] { cpInstanceId }, Integer.class);
        
        // update
        if (existingRows > 0) {
            query = "update roger.cssfile set content=? where cpinstanceid=?";
        }
        // create
        else {
            query = "insert into roger.cssfile (id, content, cpinstanceid) values (default, ?, ?)";
        }
        
        jdbcTemplate.update(query, new Object[] { content, cpInstanceId });
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
