package com.courtpicker.dao;

import java.util.List;

import javax.inject.Inject;

import org.springframework.context.annotation.Scope;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

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

    public List<UserGroup> getUserGroups(Integer cpInstanceId) {
        String query = "select * from roger.usergroup where cpinstanceid=?";
        List<UserGroup> matches = jdbcTemplate.query(query, new Object[] { cpInstanceId }, rowMapper);
        return matches;
    }

    public UserGroup persist(UserGroup userGroup) {
        String query = "";

        // do an insert if id is NOT set
        if (userGroup.getId() == null) {
            int newRecordId = jdbcTemplate.queryForInt("select nextval('roger.usergroup_id_seq')");
            userGroup.setId(newRecordId);
            query = "insert into roger.usergroup (cpinstanceid, name, id) values (?, ?, ?)";
        }
        // do an update if id is set
        else {
            query = "update roger.usergroup set cpinstanceid=?, name=? where id=?";
        }

        jdbcTemplate.update(query, new Object[] { userGroup.getCpInstanceId(), userGroup.getName(), userGroup.getId() });

        return userGroup;
    }
    
    public void delete(Integer id) {
        String query = "delete from roger.usergroup where id=?";
        jdbcTemplate.update(query, new Object[] { id });
    }
    
    public JdbcTemplate getJdbcTemplate() {
        return jdbcTemplate;
    }

    public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }
}