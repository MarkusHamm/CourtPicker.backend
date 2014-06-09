package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Subscription;

@Component("subscriptionDAO")
@Scope("prototype")
public class SubscriptionDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;
    
    private SubscriptionRowMapper rowMapper;

    public SubscriptionDAO() {
        rowMapper = new SubscriptionRowMapper();
    }

    public List<Subscription> getAll(int courtCategoryId) {
        String query = "select * from roger.subscription where courtcategoryid=? order by ordernr";
        List<Subscription> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId }, rowMapper);
        return matches;
    }

    public Subscription get(int id) {
        String query = "select * from roger.subscription where id=?";
        List<Subscription> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        return matches.get(0);
    }
    
    public Subscription persist(Subscription subscription) {
        String query = "";

        // do an insert if id is NOT set
        if (subscription.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('roger.subscription_id_seq')");
            subscription.setId(newRecordId);
            query = "insert into roger.subscription (courtcategoryid, name, periodstart, periodend, bookablefrom, " +
                    "bookableto, ordernr, id) values (?, ?, ?, ?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update roger.subscription set courtcategoryid=?, name=?, periodstart=?, periodend=?, " +
            		"bookablefrom=?, bookableto=?, ordernr=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { subscription.getCourtCategoryId(), subscription.getName(), 
                subscription.getPeriodStart(), subscription.getPeriodEnd(), subscription.getBookableFrom(), 
                subscription.getBookableTo(), subscription.getOrderNr(), subscription.getId() });

        return subscription;
    }
    
    public void delete(Integer id) {
        String query = "delete from roger.subscription where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
