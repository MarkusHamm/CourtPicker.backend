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
        String query = "select * from roger.court where courtcategoryid=? order by ordernr";
        List<Court> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId }, rowMapper);
        return matches;
    }

    public Court get(Integer id) {
        String query = "select * from roger.court where id=?";
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
            int newRecordId = jdbcTemplate.queryForInt("select nextval('court_id_seq')");
            court.setId(newRecordId);
            query = "insert into roger.court (courtcategoryid, name, ordernr, id) values (?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update roger.court set courtcategoryid=?, name=?, ordernr=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { court.getCourtCategoryId(), court.getName(), court.getOrderNr(),
                court.getId() });

        return court;
    }
    
    public void delete(Integer id) {
        String query = "delete from roger.court where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
