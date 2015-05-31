package com.courtpicker.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.CustomerExtract;
import com.courtpicker.model.CustomerUserGroup;
import com.courtpicker.model.CustomerUserGroupDetail;

@Component("customerUserGroupDAO")
@Scope("prototype")
public class CustomerUserGroupDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private CustomerUserGroupRowMapper rowMapper;
    private CustomerUserGroupDetailRowMapper detailRowMapper;
    private CustomerExtractRowMapper customerExtractRowMapper;

    public CustomerUserGroupDAO() {
        rowMapper = new CustomerUserGroupRowMapper();
        detailRowMapper = new CustomerUserGroupDetailRowMapper();
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
    
    public Map<Integer, List<Integer>> getAllUserGroupsPerInstance(Integer customerId) {
        String query = "select cu.*, u.cpinstanceid from cp.customer_usergroup cu, cp.usergroup u where cu.usergroupid=u.id and cu.customerid=?";
        List<CustomerUserGroupDetail> matches = jdbcTemplate.query(query, new Object[] { customerId }, detailRowMapper);
        
        Map<Integer, List<Integer>> result = new HashMap<Integer, List<Integer>>();
        for (CustomerUserGroupDetail match : matches) {
            Integer cpInstanceId = match.getCpInstanceId();
            List<Integer> userGroups;
            if (result.containsKey(cpInstanceId)) {
                userGroups = result.get(cpInstanceId);
            }
            else {
                userGroups = new ArrayList<Integer>();
            }
            userGroups.add(match.getUserGroupId());
            result.put(cpInstanceId, userGroups);
        }
        
        return result;        
    }
    
    public List<Integer> getUserGroupsPerInstance(Integer customerId, Integer cpInstanceId) {
        String query = "select cu.*, u.cpinstanceid from cp.customer_usergroup cu, cp.usergroup u where cu.usergroupid=u.id and cu.customerid=? and u.cpinstanceid=?";
        List<CustomerUserGroupDetail> matches = jdbcTemplate.query(query, new Object[] { customerId, cpInstanceId }, detailRowMapper);
        
        List<Integer> result = new ArrayList<Integer>();
        for (CustomerUserGroupDetail match : matches) {
            result.add(match.getUserGroupId());
        }
        
        return result;        
    }
    
    public void deleteEntries(Integer userGroupId) {
        String query = "delete from cp.customer_usergroup where usergroupid=?";
        jdbcTemplate.update(query, new Object[] { userGroupId });
    }
}
