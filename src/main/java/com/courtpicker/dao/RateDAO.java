package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.CourtCategory;
import com.courtpicker.model.Rate;

@Component("rateDAO")
@Scope("prototype")
public class RateDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private RateRowMapper rowMapper;

    public RateDAO() {
        rowMapper = new RateRowMapper();
    }

    public List<Rate> getRates(Integer courtCategoryId) {
        String query = "select * from roger.rate where courtcategoryid=? order by ordernr";
        List<Rate> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId }, rowMapper);
        return matches;
    }

    public Rate persist(Rate rate) {
        String query = "";

        // do an insert if id is NOT set
        if (rate.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('roger.rate_id_seq')");
            rate.setId(newRecordId);
            query = "insert into roger.rate (courtcategoryid, name, constraindate, constraintime, constrainweekday, constrainusergroup, " +
            		"cdatefrom, cdateto, ctimefrom, ctimeto, cmon, ctue, cwed, cthu, cfri, csat, csun, " +
            		"cusergroupids, price, active, ordernr, id) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update roger.rate set courtcategoryid=?, name=?, constraindate=?, constraintime=?, constrainweekday=?, constrainusergroup=?, " +
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
        String query = "delete from roger.rate where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
