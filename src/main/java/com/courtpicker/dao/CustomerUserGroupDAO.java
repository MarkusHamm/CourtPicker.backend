package com.courtpicker.dao;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.CustomerExtract;
import com.courtpicker.model.CustomerUserGroup;

@Component("customerUserGroupDAO")
@Scope("prototype")
public class CustomerUserGroupDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private CustomerUserGroupRowMapper rowMapper;
    private CustomerExtractRowMapper customerExtractRowMapper;

    public CustomerUserGroupDAO() {
        rowMapper = new CustomerUserGroupRowMapper();
        customerExtractRowMapper = new CustomerExtractRowMapper();
    }
    
    public List<CustomerUserGroup> getAll() {
        String query = "select * from cp.customer_usergroup order by customerid";
        List<CustomerUserGroup> matches = jdbcTemplate.query(query, new Object[] {}, rowMapper);
        return matches;
    }
    
    public List<CustomerExtract> getUserGroupCustomerExtract(Integer userGroupId) {
        String query = "select * from cp.customer where id in " +
                "(select customerid from cp.customer_usergroup where usergroupid=?)";
        List<CustomerExtract> matches = jdbcTemplate.query(query, new Object[] { userGroupId }, customerExtractRowMapper);
        return matches;
    }
    
    public void addCustomerToUserGroup(Integer userGroupId, Integer customerId) {
        String query = "insert into cp.customer_usergroup (usergroupid, customerid) values (?, ?)";
        jdbcTemplate.update(query, new Object[] { userGroupId, customerId });
    }

    public void removeCustomerFromUserGroup(Integer userGroupId, Integer customerId) {
        String query = "delete from cp.customer_usergroup where usergroupid=? and customerid=?";
        jdbcTemplate.update(query, new Object[] { userGroupId, customerId });
    }

    public List<Integer> getCustomerIds(Integer userGroupId) {
        String query = "select * from cp.customer_usergroup where usergroupid=?";
        List<CustomerUserGroup> matches = jdbcTemplate.query(query, new Object[] { userGroupId }, rowMapper);
        
        List<Integer> customerIds = new ArrayList<Integer>();
        for (CustomerUserGroup cug : matches) {
            customerIds.add(cug.getCustomerId());
        }
        
        return customerIds;
    }
    
    public List<Integer> getUserGroupIds(Integer customerId) {
        String query = "select * from cp.customer_usergroup where customerid=?";
        List<CustomerUserGroup> matches = jdbcTemplate.query(query, new Object[] { customerId }, rowMapper);
        
        List<Integer> userGroupIds = new ArrayList<Integer>();
        for (CustomerUserGroup cug : matches) {
            userGroupIds.add(cug.getUserGroupId());
        }
        
        return userGroupIds;
    }
    
    public void deleteEntries(Integer userGroupId) {
        String query = "delete from cp.customer_usergroup where usergroupid=?";
        jdbcTemplate.update(query, new Object[] { userGroupId });
    }
}
