package com.courtpicker.dao;

import static org.junit.Assert.*;

import org.junit.Test;

public class CssFileDAOTest extends BaseDAOTest {
    private CssFileDAO dao;

    public CssFileDAOTest() throws Exception {
        super();
        dao = new CssFileDAO();
        dao.setJdbcTemplate(jdbcTemplate);
    }

    @Test
    public void getContent_returnsCorrectIfEntryExists() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.cssfile where cpinstanceid=-1");
        jdbcTemplate.execute("INSERT INTO cp.cssfile (id, cpinstanceid, content) "
                + "values (-1, -1, '#css: {it works}')");

        // execute + assert
        String content = dao.getContent(-1);
        assertEquals("#css: {it works}", content);

        // tear-down
        jdbcTemplate.execute("DELETE FROM cp.cssfile where cpinstanceid=-1");
    }

    @Test
    public void getContent_returnsNullIfNoEntryExists() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.cssfile where cpinstanceid=-1");

        // execute + assert
        String content = dao.getContent(-1);
        assertNull(content);
    }

    @Test
    public void persistContent_insertWhenNoEntryExists() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.cssfile where cpinstanceid=-1");

        // execute + assert
        String content = "test content";
        dao.persistContent(-1, content);
        
        int dbRowCount = jdbcTemplate.queryForObject("select count(1) from cp.cssfile where cpinstanceid=-1",
                Integer.class);
        String dbContent = jdbcTemplate.queryForObject("select content from cp.cssfile where cpinstanceid=-1",
                String.class);
        assertEquals(1, dbRowCount);
        assertEquals(content, dbContent);

        // tear-down
        jdbcTemplate.execute("DELETE FROM cp.cssfile where cpinstanceid=-1");
    }

    @Test
    public void persistContent_updateWhenEntryExists() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.cssfile where cpinstanceid=-1");
        jdbcTemplate.execute("INSERT INTO cp.cssfile (id, cpinstanceid, content) "
                + "values (-1, -1, 'old content')");

        // execute + assert
        String content = "test content";
        dao.persistContent(-1, content);
        
        int dbRowCount = jdbcTemplate.queryForObject("select count(1) from cp.cssfile where cpinstanceid=-1",
                Integer.class);
        String dbContent = jdbcTemplate.queryForObject("select content from cp.cssfile where cpinstanceid=-1",
                String.class);
        assertEquals(1, dbRowCount);
        assertEquals(content, dbContent);

        // tear-down
        jdbcTemplate.execute("DELETE FROM cp.cssfile where cpinstanceid=-1");
    }
}
