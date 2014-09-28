package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.SubscriptionRatePeriod;

@Component("subscriptionRatePeriodDAO")
@Scope("prototype")
public class SubscriptionRatePeriodDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private SubscriptionRatePeriodRowMapper rowMapper;

    public SubscriptionRatePeriodDAO() {
        rowMapper = new SubscriptionRatePeriodRowMapper();
    }

    public List<SubscriptionRatePeriod> getSubscriptionPeriodRates(Integer courtCategoryId) {
        String query = "select * from cp.subscriptionrateperiod where courtcategoryid=? order by ordernr";
        List<SubscriptionRatePeriod> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId }, rowMapper);
        return matches;
    }

    public SubscriptionRatePeriod persist(SubscriptionRatePeriod sRate) {
        String query = "";

        // do an insert if id is NOT set
        if (sRate.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.subscriptionrateperiod_id_seq')");
            sRate.setId(newRecordId);
            query = "insert into cp.subscriptionrateperiod (courtcategoryid, name, periodstart, periodend, price, active, ordernr, " +
                    "constraintime, constrainweekday, constrainusergroup, ctimefrom, ctimeto, cmon, ctue, cwed, cthu, cfri, csat, csun, " +
                    "cusergroupids, id) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update cp.subscriptionrateperiod set courtcategoryid=?, name=?, periodstart=?, periodend=?, price=?, active=?, " +
                    "ordernr=?, constraintime=?, constrainweekday=?, constrainusergroup=?, ctimefrom=?, ctimeto=?, cmon=?, ctue=?, cwed=?, " +
                    "cthu=?, cfri=?, csat=?, csun=?, cusergroupids=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { sRate.getCourtCategoryId(), sRate.getName(), sRate.getPeriodStart(), sRate.getPeriodEnd(),
                sRate.getPrice(), sRate.getActive(), sRate.getOrderNr(), sRate.getConstrainTime(), sRate.getConstrainWeekDay(),
                sRate.getConstrainUserGroup(), sRate.getcTimeFrom(), sRate.getcTimeTo(), sRate.getcMon(), sRate.getcTue(), sRate.getcWed(), 
                sRate.getcThu(), sRate.getcFri(), sRate.getcSat(), sRate.getcSun(), sRate.convertcUserGroupIdsToString(), sRate.getId()});

        return sRate;
    }
    
    public void delete(Integer id) {
        String query = "delete from cp.subscriptionrateperiod where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }

    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
