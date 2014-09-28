package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.CourtCategory;

@Component("courtCategoryDAO")
@Scope("prototype")
public class CourtCategoryDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;
    
    private CourtCategoryRowMapper rowMapper;

    public CourtCategoryDAO() {
        rowMapper = new CourtCategoryRowMapper();
    }

    public List<CourtCategory> getAllCourtCategories(int cpInstanceId) {
        String query = "select * from cp.courtcategory where cpinstanceid=? and deleted=false order by ordernr";
        List<CourtCategory> matches = jdbcTemplate.query(query, new Object[] { cpInstanceId }, rowMapper);
        return matches;
    }
    
    public CourtCategory get(int id) {
        String query = "select * from cp.courtcategory where id=?";
        List<CourtCategory> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }

    public CourtCategory persist(CourtCategory courtCategory) {
        String query = "";

        // do an insert if id is NOT set
        if (courtCategory.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.courtcategory_id_seq')");
            courtCategory.setId(newRecordId);
            query = "insert into cp.courtcategory (cpinstanceid, ordernr, name, bookablefromtime, bookabletotime, " +
            		"bookingunit, id) values (?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update cp.courtcategory set cpinstanceid=?, ordernr=?, name=?, bookablefromtime=?, " +
            		"bookabletotime=?, bookingunit=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { courtCategory.getCpInstanceId(), courtCategory.getOrderNr(),
                courtCategory.getName(), courtCategory.getBookableFromTime(), courtCategory.getBookableToTime(),
                courtCategory.getBookingUnit(), courtCategory.getId() });

        return courtCategory;
    }
    
    public void delete(Integer id) {
        String query = "update cp.courtcategory set deleted=true where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
