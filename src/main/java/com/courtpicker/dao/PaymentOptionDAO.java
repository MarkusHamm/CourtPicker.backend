package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.PaymentOption;
import com.courtpicker.model.Rate;

@Component("paymentOptionDAO")
@Scope("prototype")
public class PaymentOptionDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private PaymentOptionRowMapper rowMapper;

    public PaymentOptionDAO() {
        rowMapper = new PaymentOptionRowMapper();
    }
    
    public List<PaymentOption> getPaymentOptions(Integer courtCategoryId) {
        String query = "select * from roger.paymentoption where cpinstanceid=? and deleted=false order by id";
        List<PaymentOption> matches = jdbcTemplate.query(query, new Object[] { courtCategoryId }, rowMapper);
        return matches;
    }
    
    public PaymentOption persist(PaymentOption paymentOption) {
        String query = "";

        // do an insert if id is NOT set
        if (paymentOption.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('roger.paymentoption_id_seq')");
            paymentOption.setId(newRecordId);
            query = "insert into roger.paymentoption (cpinstanceid, name, active, deleted, id) " +
            		"values (?, ?, ?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update roger.paymentoption set cpinstanceid=?, name=?, active=?, deleted=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { paymentOption.getCpInstanceId(), paymentOption.getName(), 
                paymentOption.getActive(), paymentOption.getDeleted(), paymentOption.getId() });

        return paymentOption;
    }
    
    public void delete(Integer id) {
        String query = "update roger.paymentoption set deleted=true where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }

    public PaymentOptionRowMapper getRowMapper() {
        return rowMapper;
    }

    public void setRowMapper(PaymentOptionRowMapper rowMapper) {
        this.rowMapper = rowMapper;
    }
}
