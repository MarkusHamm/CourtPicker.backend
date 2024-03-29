package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Court;
import com.courtpicker.model.PaymentOption;
import com.courtpicker.model.SingleRate;

@Component("paymentOptionDAO")
@Scope("prototype")
public class PaymentOptionDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private PaymentOptionRowMapper rowMapper;

    public PaymentOptionDAO() {
        rowMapper = new PaymentOptionRowMapper();
    }
    
    public PaymentOption get(Integer id) {
        String query = "select * from cp.paymentoption where id=?";
        List<PaymentOption> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }
    
    public List<PaymentOption> getPaymentOptions(Integer courtCategoryId) {
        String query = "select * from cp.paymentoption where cpinstanceid=? and deleted=false order by id";
        List<PaymentOption> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId }, rowMapper);
        return matches;
    }
    
    public PaymentOption persist(PaymentOption paymentOption) {
        String query = "";

        // do an insert if id is NOT set
        if (paymentOption.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.paymentoption_id_seq')");
            paymentOption.setId(newRecordId);
            query = "insert into cp.paymentoption (cpinstanceid, name, active, deleted, id) " +
            		"values (?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update cp.paymentoption set cpinstanceid=?, name=?, active=?, deleted=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { paymentOption.getCpInstanceId(), paymentOption.getName(), 
                paymentOption.getActive(), paymentOption.getDeleted(), paymentOption.getId() });

        return paymentOption;
    }
    
    public void delete(Integer id) {
        String query = "update cp.paymentoption set deleted=true where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }

    public PaymentOptionRowMapper getRowMapper() {
        return rowMapper;
    }

    public void setRowMapper(PaymentOptionRowMapper rowMapper) {
        this.rowMapper = rowMapper;
    }
}
