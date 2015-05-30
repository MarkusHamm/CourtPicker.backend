package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.CPInstance;
import com.courtpicker.model.SingleRate;

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
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.cpinstance_id_seq')");
            cpInstance.setId(newRecordId);
            query = "insert into cp.cpinstance (name, shortName, licence, licencestartdate, createdate, mailatregistration, reservationlimit, reservationlabelvisibility, id) values (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update cp.cpinstance set name=?, shortName=?, licence=?, licenceStartDate=?, createdate=?, mailatregistration=?, reservationlimit=?, reservationlabelvisibility=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { cpInstance.getName(), cpInstance.getShortName(), 
                cpInstance.getLicence(), cpInstance.getLicenceStartDate(), cpInstance.getCreateDate(), 
                cpInstance.getMailAtRegistration(), cpInstance.getReservationLimit(), cpInstance.getReservationLabelVisibility(),
                cpInstance.getId() });

        return cpInstance;
    }
    
    public CPInstance persistWithoutLicenceInfo(CPInstance cpInstance) {
        String query = "";

        // do an insert if id is NOT set
        if (cpInstance.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.cpinstance_id_seq')");
            cpInstance.setId(newRecordId);
            query = "insert into cp.cpinstance (name, shortName, createdate, mailatregistration, reservationlimit, reservationlabelvisibility, id) values (?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update cp.cpinstance set name=?, shortName=?, createdate=?, mailatregistration=?, reservationlimit=?, reservationlabelvisibility=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { cpInstance.getName(), cpInstance.getShortName(), cpInstance.getCreateDate(),
                cpInstance.getMailAtRegistration(), cpInstance.getReservationLimit(), cpInstance.getReservationLabelVisibility(),
                cpInstance.getId() });

        return cpInstance;
    }

    public CPInstance get(Integer id) {
        String query = "select * from cp.cpinstance where id=?";
        List<CPInstance> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }
    
    public CPInstance getByShortName(String shortName) {
        String query = "select * from cp.cpinstance where lower(shortname)=?";
        List<CPInstance> matches = jdbcTemplate.query(query, new Object[] { shortName.toLowerCase() }, rowMapper);
        
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
