package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.courtpicker.model.Court;
import com.courtpicker.model.UserGroup;

@Component("userGroupDAO")
@Scope("prototype")
public class UserGroupDAO {
    @Inject
    private JdbcTemplate jdbcTemplate;

    private UserGroupRowMapper rowMapper;    

    public UserGroupDAO() {
        rowMapper = new UserGroupRowMapper();
    }

    public UserGroup get(Integer id) {
        String query = "select * from cp.usergroup where id=? and deleted=false";
        List<UserGroup> matches = jdbcTemplate.query(query, new Object[] { id }, rowMapper);
        
        if (matches.size() == 0) {
            return null;
        }
        
        return matches.get(0);
    }

    public List<UserGroup> getUserGroups(Integer cpInstanceId) {
        String query = "select * from cp.usergroup where cpinstanceid=? and deleted=false";
        List<UserGroup> matches = jdbcTemplate.query(query, new Object[] { cpInstanceId }, rowMapper);
        return matches;
    }

    public UserGroup persist(UserGroup userGroup) {
        String query = "";

        // do an insert if id is NOT set
        if (userGroup.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('cp.usergroup_id_seq')");
            userGroup.setId(newRecordId);
            query = "insert into cp.usergroup (cpinstanceid, name, id) values (?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update cp.usergroup set cpinstanceid=?, name=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { userGroup.getCpInstanceId(), userGroup.getName(), userGroup.getId() });

        return userGroup;
    }
    
    public void delete(Integer id) {
        String query = "update cp.usergroup set deleted=true where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }
    
    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}
