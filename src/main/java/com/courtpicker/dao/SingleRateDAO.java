package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Court;
import com.courtpicker.model.CourtCategory;
import com.courtpicker.model.Rate;
import com.courtpicker.model.SingleRate;

@Component("singleRateDAO")
@Scope("prototype")
public class SingleRateDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private SingleRateRowMapper rowMapper;

    public SingleRateDAO() {
        rowMapper = new SingleRateRowMapper();
    }
    
    public SingleRate get(Integer id) {
        String query = "select * from cp.singlerate where id=?";
        List<SingleRate> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }

    public List<SingleRate> getRates(Integer courtCategoryId) {
        String query = "select * from cp.singlerate where courtcategoryid=? order by ordernr";
        List<SingleRate> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId }, rowMapper);
        return matches;
    }

    public SingleRate persist(SingleRate rate) {
        String query = "";

        // do an insert if id is NOT set
        if (rate.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.singlerate_id_seq')");
            rate.setId(newRecordId);
            query = "insert into cp.singlerate (courtcategoryid, name, constraindate, constraintime, constrainweekday, constrainusergroup, " +
            		"cdatefrom, cdateto, ctimefrom, ctimeto, cmon, ctue, cwed, cthu, cfri, csat, csun, " +
            		"cusergroupids, price, active, ordernr, id) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update cp.singlerate set courtcategoryid=?, name=?, constraindate=?, constraintime=?, constrainweekday=?, constrainusergroup=?, " +
            		"cdatefrom=?, cdateto=?, ctimefrom=?, ctimeto=?, cmon=?, ctue=?, cwed=?, cthu=?, cfri=?, csat=?, csun=?, " +
            		"cusergroupids=?, price=?, active=?, ordernr=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { rate.getCourtCategoryId(), rate.getName(), rate.getConstrainDate(), rate.getConstrainTime(),
                rate.getConstrainWeekDay(), rate.getConstrainUserGroup(), rate.getcDateFrom(), rate.getcDateTo(), rate.getcTimeFrom(),
                rate.getcTimeTo(), rate.getcMon(), rate.getcTue(), rate.getcWed(), rate.getcThu(), rate.getcFri(), rate.getcSat(), rate.getcSun(),
                rate.convertcUserGroupIdsToString(), rate.getPrice(), rate.getActive(), rate.getOrderNr(), rate.getId()});

        return rate;
    }
    
    public void delete(Integer id) {
        String query = "delete from cp.singlerate where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
