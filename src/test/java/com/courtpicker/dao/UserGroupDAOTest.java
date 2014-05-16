package com.courtpicker.dao;

import static org.junit.Assert.assertEquals;

import java.util.List;

import org.junit.Test;

import com.courtpicker.model.UserGroup;

public class UserGroupDAOTest extends BaseDAOTest {
    private  UserGroupDAO dao;
    
    public UserGroupDAOTest() throws Exception {
        super();
        dao = new UserGroupDAO();
        dao.setJdbcTemplate(jdbcTemplate);
    }
    
    @Test
    public void getAllUserGroups_retrievedCorrect() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.usergroup where cpinstanceid=-1");
        jdbcTemplate.execute("INSERT INTO roger.usergroup (id, cpinstanceid, name) values (default, -1, 'studenten')");
        jdbcTemplate.execute("INSERT INTO roger.usergroup (id, cpinstanceid, name) values (default, -1, 'pensionisten')");

        // execute + assert
        List<UserGroup> ugList = dao.getUserGroups(-1);
        assertEquals(2, ugList.size());

        UserGroup ug1 = ugList.get(0);
        assertEquals(ug1.getCpInstanceId(), Integer.valueOf(-1));
        assertEquals(ug1.getName(), "studenten");

        UserGroup ug2 = ugList.get(1);
        assertEquals(ug2.getCpInstanceId(), Integer.valueOf(-1));
        assertEquals(ug2.getName(), "pensionisten");

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.usergroup where cpinstanceid=-1");
    }

    @Test
    public void persist_userGroupWithoutIdIsInserted() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.usergroup where cpinstanceid=-1");

        // execute + assert
        UserGroup ug = new UserGroup();
        ug.setCpInstanceId(-1);
        ug.setName("mygroup");
        ug = dao.persist(ug);
        
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.usergroup where cpinstanceid=-1");
        UserGroup dbUG = jdbcTemplate.query("SELECT * from roger.usergroup where cpinstanceid=-1",
                new UserGroupRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(ug.getId(), dbUG.getId());
        assertEquals(ug.getCpInstanceId(), dbUG.getCpInstanceId());
        assertEquals(ug.getName(), dbUG.getName());

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.courtcategory where cpinstanceid=-1");
    }

    @Test
    public void persist_userGroupWithIdIsUpdated() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.usergroup where id=-1");
        jdbcTemplate.execute("INSERT INTO roger.usergroup (id, cpinstanceid, name) values (-1, -1, 'tennisspieler')");

        // execute + assert
        UserGroup ug = new UserGroup();
        ug.setId(-1);
        ug.setCpInstanceId(-100);
        ug.setName("fußballspieler");
        ug = dao.persist(ug);

        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.usergroup where id=-1");
        UserGroup dbUG = jdbcTemplate.query("SELECT * from usergroup where id=-1",
                new UserGroupRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(ug.getId(), dbUG.getId());
        assertEquals(ug.getCpInstanceId(), dbUG.getCpInstanceId());
        assertEquals(ug.getName(), dbUG.getName());

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.usergroup where id=-1");
    }
    
    @Test
    public void delete_nonExistingIdThrowsNoException() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.usergroup where id=-1");
        
        // execute + assert
        dao.delete(-1);
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.usergroup where id=-1");
        
        assertEquals(0, rowCount);
    }
    
    @Test
    public void delete_existingIdDeltesAsRequested() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.usergroup where id=-1");
        jdbcTemplate.execute("INSERT INTO roger.usergroup (id, cpinstanceid, name) values (-1, -1, 'tennisspieler')");
        
        // execute + assert
        dao.delete(-1);
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.usergroup where id=-1");
        
        assertEquals(0, rowCount);
    }
}
