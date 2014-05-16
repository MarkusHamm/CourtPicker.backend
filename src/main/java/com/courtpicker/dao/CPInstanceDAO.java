package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.CPInstance;
import com.courtpicker.model.Rate;

@Component("cpInstanceDAO")
@Scope("prototype")
public class CPInstanceDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;
    
    private CPInstanceRowMapper rowMapper;
    
    public CPInstanceDAO() {
        this.rowMapper = new CPInstanceRowMapper();
    }
    
    public CPInstance persist(CPInstance cpInstance) {
        String query = "";

        // do an insert if id is NOT set
        if (cpInstance.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('roger.cpinstance_id_seq')");
            cpInstance.setId(newRecordId);
            query = "insert into roger.cpinstance (name, shortName, licence, licencestartdate, id) values (?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update roger.cpinstance set name=?, shortName=?, licence=?, licenceStartDate=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { cpInstance.getName(), cpInstance.getShortName(), 
                cpInstance.getLicence(), cpInstance.getLicenceStartDate(), cpInstance.getId() });

        return cpInstance;
    }
    
    public CPInstance getByShortName(String shortName) {
        String query = "select * from roger.cpinstance where lower(shortname)=?";
        List<CPInstance> matches = jdbcTemplate.query(query, new Object[] { shortName }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }
    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
