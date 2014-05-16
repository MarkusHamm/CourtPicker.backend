package com.courtpicker.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;

import org.junit.Test;

import com.courtpicker.model.CPInstance;

public class CPInstanceDAOTest extends BaseDAOTest {
    private CPInstanceDAO dao;

    public CPInstanceDAOTest() throws Exception {
        super();
        dao = new CPInstanceDAO();
        dao.setJdbcTemplate(jdbcTemplate);
    }    
    
    @Test
    public void persist_cpInstanceWithoutIdIsInserted() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.cpinstance where licence='mytestlicence'");
        
        // execute + assert
        CPInstance cpi = new CPInstance();
        cpi.setName("name");
        cpi.setShortName("shortName");
        cpi.setLicence("mytestlicence");
        Calendar calendar = new GregorianCalendar();
        calendar.set(2014, 1, 1);
        cpi.setLicenceStartDate(calendar.getTime());
        cpi = dao.persist(cpi);

        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.cpinstance where licence='mytestlicence'");
        CPInstance dbCpi = jdbcTemplate.query("SELECT * from roger.cpinstance where licence='mytestlicence'",
                new CPInstanceRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(cpi.getId(), dbCpi.getId());
        assertEquals(cpi.getName(), dbCpi.getName());
        assertEquals(cpi.getShortName(), dbCpi.getShortName());
        assertEquals(cpi.getLicence(), dbCpi.getLicence());
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        assertEquals(df.format(cpi.getLicenceStartDate()), df.format(dbCpi.getLicenceStartDate()));

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.cpinstance where licence='mytestlicence'");
    }

    @Test
    public void persist_cpInstanceWithIdIsUpdated() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.cpinstance where id=-1");
        jdbcTemplate.execute("INSERT INTO roger.cpinstance (id, name, shortname, licence, licencestartdate) " +
                             "values (-1, 'xxx', 'yyy', 'ccc', '1980-12-12')");

        // execute + assert
        CPInstance cpi = new CPInstance();
        cpi.setId(-1);
        cpi.setName("name");
        cpi.setShortName("shortname");
        cpi.setLicence("licence");
        Calendar calendar = new GregorianCalendar();
        calendar.set(2014, 1, 1);
        cpi.setLicenceStartDate(calendar.getTime());
        cpi = dao.persist(cpi);

        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.cpinstance where id=-1");
        CPInstance dbCpi = jdbcTemplate.query("SELECT * from roger.cpinstance where id=-1",
                new CPInstanceRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(cpi.getId(), dbCpi.getId());
        assertEquals(cpi.getName(), dbCpi.getName());
        assertEquals(cpi.getShortName(), dbCpi.getShortName());
        assertEquals(cpi.getLicence(), dbCpi.getLicence());
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        assertEquals(df.format(cpi.getLicenceStartDate()), df.format(dbCpi.getLicenceStartDate()));

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.cpinstance where id=-1");
    }
    
    @Test
    public void getByShortName_returnsNullAtNoMatch() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.cpinstance where shortname='daounittest'");

        CPInstance result = dao.getByShortName("daounittest");

        assertNull(result);
    }

    @Test
    public void getByShortName_returnsMatchingInstanceIngoringCase() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.cpinstance where lower(shortname)='daounittest'");
        jdbcTemplate.execute("INSERT INTO roger.cpinstance (id, name, shortname, licence, licencestartdate) " +
        		             "values (-1, 'testname', 'DAOUnitTest', 'ccc', '2014-01-01')");

        // execute + assert
        CPInstance result = dao.getByShortName("daounittest");

        assertEquals(new Integer(-1), result.getId());
        assertEquals("testname", result.getName());
        assertEquals("DAOUnitTest", result.getShortName());
        assertEquals("ccc", result.getLicence());
        Calendar calendar = new GregorianCalendar();
        calendar.set(2014, 0, 1);
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        assertEquals(df.format(calendar.getTime()), df.format(result.getLicenceStartDate()));

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.cpinstance where lower(shortname)='daounittest'");
    }
}
