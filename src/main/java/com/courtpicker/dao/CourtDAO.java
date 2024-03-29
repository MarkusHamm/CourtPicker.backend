package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Court;
import com.courtpicker.model.Customer;

@Component("courtDAO")
@Scope("prototype")
public class CourtDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private CourtRowMapper rowMapper;

    public CourtDAO() {
        this.rowMapper = new CourtRowMapper();
    }

    public List<Court> getAllCourts(Integer courtCategoryId) {
        String query = "select * from cp.court where courtcategoryid=? and deleted=false order by ordernr";
        List<Court> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId }, rowMapper);
        return matches;
    }

    public Court get(Integer id) {
        String query = "select * from cp.court where id=?";
        List<Court> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }
    
    public Court persist(Court court) {
        String query = "";

        // do an insert if id is NOT set
        if (court.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.court_id_seq')");
            court.setId(newRecordId);
            query = "insert into cp.court (courtcategoryid, name, ordernr, id) values (?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update cp.court set courtcategoryid=?, name=?, ordernr=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { court.getCourtCategoryId(), court.getName(), court.getOrderNr(),
                court.getId() });

        return court;
    }
    
    public void delete(Integer id) {
        String query = "update cp.court set deleted=true where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }
    
    public Integer getNrOfCourts(Integer cpInstanceId) {
        String query = "select count(1) from cp.court where courtcategoryid in " +
        		"(select id from cp.courtcategory where cpinstanceid=?) and deleted=false";
        Integer result = jdbcTemplate.queryForObject(query, new Object[] { cpInstanceId }, Integer.class);
        return result;
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
