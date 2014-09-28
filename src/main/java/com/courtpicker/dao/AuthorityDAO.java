package com.courtpicker.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Authority;

@Component("authorityDAO")
@Scope("prototype")
public class AuthorityDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private AuthorityRowMapper rowMapper;

    public AuthorityDAO() {
        rowMapper = new AuthorityRowMapper();
    }

    public void authorizeUser(Integer cpInstanceId, Integer userId, String authority) {
        int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.authority_id_seq')");
        String insert = "insert into cp.authority (id, userid, cpinstanceid, authority) values (?, ?, ?, ?)";
        jdbcTemplate.update(insert, new Object[] { newRecordId, userId, cpInstanceId, authority });
    }
    
    public void deAuthorizeUser(Integer cpInstanceId, Integer userId, String authority) {
        String delete = "delete from cp.authority where userid=? and cpinstanceid=? and authority=?";
        jdbcTemplate.update(delete, new Object[] { userId, cpInstanceId, authority });
    }    
    
    public List<Authority> getCpInstanceAuthorities(Integer cpInstanceId) {
        String query = "select * from cp.authority where cpinstanceid=?";
        List<Authority> matches = jdbcTemplate.query(query, new Object[] { cpInstanceId }, rowMapper);
        return matches;
    }
    
    public List<String> getAuthorities(Integer userId, Integer cpInstanceId) {
        String query = "select * from cp.authority where userid=? and cpinstanceid=?";
        List<Authority> matches = jdbcTemplate.query(query, new Object[] { userId, cpInstanceId }, rowMapper);
        
        List<String> authorities = new ArrayList<String>();
        for (Authority auth : matches) {
            authorities.add(auth.getAuthority());
        }
        
        return authorities;
    }
        
    public Map<Integer, List<String>> getAllAuthorities(Integer userId) {
        String query = "select * from cp.authority where userid=?";
        List<Authority> matches = jdbcTemplate.query(query, new Object[] { userId }, rowMapper);
        
        Map<Integer, List<String>> result = new HashMap<Integer, List<String>>();
        
        for (Authority auth : matches) {
            List<String> instanceAuthorities;
            if (!result.containsKey(auth.getCpInstanceId())) {
                instanceAuthorities = new ArrayList<String>();
                instanceAuthorities.add(auth.getAuthority());
            }
            else {
                instanceAuthorities = result.get(auth.getCpInstanceId());
                instanceAuthorities.add(auth.getAuthority());
            }
            result.put(auth.getCpInstanceId(), instanceAuthorities);
        }
        
        return result;
    }
}
