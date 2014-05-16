package com.courtpicker.dao;

import org.junit.Test;
import org.springframework.jdbc.support.lob.DefaultLobHandler;

import static org.junit.Assert.*;

import com.courtpicker.model.Webdesign;
import com.courtpicker.model.WebdesignFile;

public class WebdesignFileDAOTest extends BaseDAOTest {
    private WebdesignFileDAO dao;
    
    public WebdesignFileDAOTest() throws Exception {
        super();
        dao = new WebdesignFileDAO();
        dao.setJdbcTemplate(jdbcTemplate);
    }

    @Test
    public void getWebdesignFile_foundEntryIsReturned() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.webdesignfile where webdesignid=-1");
        jdbcTemplate.execute("INSERT INTO roger.webdesignfile (id, webdesignid, type, content) " +
        		             "values (-1, -1, 'logo', E'\\x78\\x78')");
        
        // execute + test
        WebdesignFile wdf = dao.getWebdesignFile(-1, "logo");
        assertEquals(-1, (int) wdf.getId());
        assertEquals(-1, (int) wdf.getWebdesignId());
        assertEquals("logo", wdf.getType());
        assertEquals("xx", new String(wdf.getContent()));
        
        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.webdesignfile where webdesignid=-1");
    }

    @Test
    public void getWebdesignFile_notFoundEntryReturnsNull() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.webdesignfile where webdesignid=-1");
        
        // execute + test
        WebdesignFile wdf = dao.getWebdesignFile(-1, "logo");
        assertNull(wdf);
    }

    @Test
    public void persist_entryWithNullIdIsInserted() {
        // execute + test
        WebdesignFile wdf = new WebdesignFile();
        wdf.setWebdesignId(-1);
        wdf.setType("logo");
        wdf.setContent("xx".getBytes());
        wdf = dao.persist(wdf);
        
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.webdesignfile where webdesignid=-1");
        WebdesignFile dbWdf = jdbcTemplate.query("SELECT * from roger.webdesignfile where webdesignid=-1",
                new WebdesignFileRowMapper()).get(0);
       
        assertEquals(1, rowCount);
        assertEquals(wdf.getId(), dbWdf.getId());
        assertEquals(wdf.getWebdesignId(), dbWdf.getWebdesignId());
        assertEquals(wdf.getType(), dbWdf.getType());
        assertEquals(new String(wdf.getContent()), new String(dbWdf.getContent()));

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.webdesignfile where webdesignid=-1");
    }
    
    @Test
    public void persist_entryWithGivenIdIsUpdated() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.webdesignfile where id=-1");
        jdbcTemplate.execute("INSERT INTO roger.webdesignfile (id, webdesignid, type, content) " +
                "values (-1, -1, 'logo', E'\\x78\\x78')");
        
        // execute + test
        WebdesignFile wdf = new WebdesignFile();
        wdf.setId(-1);
        wdf.setWebdesignId(-11);
        wdf.setType("logologo");
        wdf.setContent("xxxx".getBytes());
        wdf = dao.persist(wdf);
        
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.webdesignfile where id=-1");
        WebdesignFile dbWdf = jdbcTemplate.query("SELECT * from roger.webdesignfile where id=-1",
                new WebdesignFileRowMapper()).get(0);
       
        assertEquals(1, rowCount);
        assertEquals(wdf.getId(), dbWdf.getId());
        assertEquals(wdf.getWebdesignId(), dbWdf.getWebdesignId());
        assertEquals(wdf.getType(), dbWdf.getType());
        assertEquals(new String(wdf.getContent()), new String(dbWdf.getContent()));

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.webdesignfile where id=-1");
    }
}
