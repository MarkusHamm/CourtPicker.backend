package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.SubscriptionRate;
import com.courtpicker.model.SubscriptionRatePeriod;

@Component("subscriptionRateDAO")
@Scope("prototype")
public class SubscriptionRateDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private SubscriptionRateRowMapper rowMapper;

    public SubscriptionRateDAO() {
        rowMapper = new SubscriptionRateRowMapper();
    }

    public List<SubscriptionRate> getAll(Integer subscriptionId) {
        String query = "select * from roger.subscriptionrate where subscriptionid=?";
        List<SubscriptionRate> matches = jdbcTemplate.query(query, new Object[] { subscriptionId }, rowMapper);
        return matches;
    }

    public SubscriptionRate persist(SubscriptionRate sRate) {
        String query = "";

        // do an insert if id is NOT set
        if (sRate.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('roger.subscriptionrate_id_seq')");
            sRate.setId(newRecordId);
            query = "insert into roger.subscriptionrate (subscriptionid, name, price, " +
                    "constraintime, constrainweekday, constrainusergroup, ctimefrom, ctimeto, cmon, ctue, cwed, cthu, cfri, csat, csun, " +
                    "cusergroupids, id) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update roger.subscriptionrate set subscriptionid=?, name=?, price=?, " +
                    "constraintime=?, constrainweekday=?, constrainusergroup=?, ctimefrom=?, ctimeto=?, cmon=?, ctue=?, cwed=?, " +
                    "cthu=?, cfri=?, csat=?, csun=?, cusergroupids=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { sRate.getSubscriptionId(), sRate.getName(),
                sRate.getPrice(), sRate.getConstrainTime(), sRate.getConstrainWeekDay(),
                sRate.getConstrainUserGroup(), sRate.getcTimeFrom(), sRate.getcTimeTo(), sRate.getcMon(), sRate.getcTue(), sRate.getcWed(), 
                sRate.getcThu(), sRate.getcFri(), sRate.getcSat(), sRate.getcSun(), sRate.convertcUserGroupIdsToString(), sRate.getId()});

        return sRate;
    }
    
    public void delete(Integer id) {
        String query = "delete from roger.subscriptionrate where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}