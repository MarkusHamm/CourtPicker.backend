package com.courtpicker.dao;

import static org.junit.Assert.*;

import java.math.BigDecimal;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.junit.Test;

import com.courtpicker.model.Rate;

public class RateDAOTest extends BaseDAOTest {

    private RateDAO dao;

    public RateDAOTest() throws Exception {
        super();
        dao = new RateDAO();
        dao.setJdbcTemplate(jdbcTemplate);
    }

    @Test
    public void getRates_returnsFilledListInCorrectOrder_forAppropriateCourtCategory() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.rate where courtcategoryid=-1");        
        jdbcTemplate.execute("INSERT INTO roger.rate (id, courtcategoryid, name, constraindate, constraintime, constrainweekday, constrainusergroup, cdatefrom, cdateto, ctimefrom, ctimeto, " +
        		             "cmon, ctue, cwed, cthu, cfri, csat, csun, cusergroupids, price, active, ordernr) " +
        		             "values (default, -1, 'name1', true, true, true, true, '01.01.', '31.12.', '08:00', '13:00', true, true, true, true, true, true, true, " +
        		             "'1,2', 11.99, true, 2)");
        jdbcTemplate.execute("INSERT INTO roger.rate (id, courtcategoryid, name, constraindate, constraintime, constrainweekday, constrainusergroup, cdatefrom, cdateto, ctimefrom, ctimeto, " +
                             "cmon, ctue, cwed, cthu, cfri, csat, csun, cusergroupids, price, active, ordernr) " +
                             "values (default, -1, 'name2', false, false, false, false, '', '', '', '', false, false, false, false, false, false, false, " +
                             "'', 11.99, true, 1)");
        
        // execute + assert
        List<Rate> rates = dao.getRates(-1);
        assertEquals(2, rates.size());
        
        Rate rate1 = rates.get(0);
        assertEquals(new Integer(-1), rate1.getCourtCategoryId());
        assertEquals("name2", rate1.getName());
        assertFalse(rate1.getConstrainDate());
        assertFalse(rate1.getConstrainTime());
        assertFalse(rate1.getConstrainWeekDay());
        assertFalse(rate1.getConstrainUserGroup());
        assertEquals("", rate1.getcDateFrom());
        assertEquals("", rate1.getcDateTo());
        assertEquals("", rate1.getcTimeFrom());
        assertEquals("", rate1.getcTimeTo());
        assertFalse(rate1.getcMon());        
        assertFalse(rate1.getcTue());
        assertFalse(rate1.getcWed());
        assertFalse(rate1.getcThu());
        assertFalse(rate1.getcFri());
        assertFalse(rate1.getcSat());
        assertFalse(rate1.getcSun());
        assertEquals(new ArrayList<Integer>(), rate1.getcUserGroupIds());
        assertEquals(new BigDecimal("11.99"), rate1.getPrice());
        assertEquals(true, rate1.getActive());
        assertEquals(new Integer(1), rate1.getOrderNr());
        
        Rate rate2 = rates.get(1);
        assertEquals(new Integer(-1), rate2.getCourtCategoryId());
        assertEquals("name1", rate2.getName());
        assertTrue(rate2.getConstrainDate());
        assertTrue(rate2.getConstrainTime());
        assertTrue(rate2.getConstrainWeekDay());
        assertTrue(rate2.getConstrainUserGroup());
        assertEquals("01.01.", rate2.getcDateFrom());
        assertEquals("31.12.", rate2.getcDateTo());
        assertEquals("08:00", rate2.getcTimeFrom());
        assertEquals("13:00", rate2.getcTimeTo());
        assertTrue(rate2.getcMon());        
        assertTrue(rate2.getcTue());
        assertTrue(rate2.getcWed());
        assertTrue(rate2.getcThu());
        assertTrue(rate2.getcFri());
        assertTrue(rate2.getcSat());
        assertTrue(rate2.getcSun());        
        assertEquals(new ArrayList<Integer>(Arrays.asList(1, 2)), rate2.getcUserGroupIds());
        assertEquals(new BigDecimal("11.99"), rate2.getPrice());
        assertEquals(true, rate2.getActive());
        assertEquals(new Integer(2), rate2.getOrderNr());

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.rate where courtcategoryid=-1");
    }

    @Test
    public void getRates_returnsEmptyList_forNotExistingCourtCategory() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.rate where courtcategoryid=-1");        

        // execute + assert
        List<Rate> rates = dao.getRates(-1);
        assertEquals(0, rates.size());
    }
    
    @Test
    public void persist_insertsIfIdIsNull() throws ParseException {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.rate where courtcategoryid=-1");        

        // execute + assert
        Rate rate = new Rate();
        rate.setCourtCategoryId(-1);
        rate.setName("name");
        rate.setActive(true);
        rate.setPrice(new BigDecimal("100.50"));
        rate.setOrderNr(1);
        rate.setConstrainDate(true);
        rate.setConstrainTime(true);
        rate.setConstrainUserGroup(true);
        rate.setConstrainWeekDay(true);
        rate.setcDateFrom("01.01.");
        rate.setcDateTo("31.12.");
        rate.setcTimeFrom("12:00");
        rate.setcTimeTo("18:00");
        rate.setcMon(true);
        rate.setcTue(true);
        rate.setcWed(true);
        rate.setcThu(true);
        rate.setcFri(true);
        rate.setcSat(false);
        rate.setcSun(false);
        rate.setcUserGroupIds(new ArrayList<Integer>(Arrays.asList(2,3)));
        rate = dao.persist(rate);
        
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.rate where courtcategoryid=-1");
        Rate dbRate = jdbcTemplate.query("SELECT * from roger.rate where courtcategoryid=-1",
                new RateRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(rate.getId(), dbRate.getId());
        assertEquals(rate.getCourtCategoryId(), dbRate.getCourtCategoryId());
        assertEquals(rate.getName(), dbRate.getName());
        assertEquals(rate.getActive(), dbRate.getActive());
        assertEquals(rate.getPrice(), dbRate.getPrice());
        assertEquals(rate.getOrderNr(), dbRate.getOrderNr());
        assertEquals(rate.getConstrainDate(), dbRate.getConstrainDate());
        assertEquals(rate.getConstrainTime(), dbRate.getConstrainTime());
        assertEquals(rate.getConstrainWeekDay(), dbRate.getConstrainWeekDay());
        assertEquals(rate.getConstrainUserGroup(), dbRate.getConstrainUserGroup());
        assertEquals(rate.getcDateFrom(), dbRate.getcDateFrom());
        assertEquals(rate.getcDateTo(), dbRate.getcDateTo());
        assertEquals(rate.getcTimeFrom(), dbRate.getcTimeFrom());
        assertEquals(rate.getcTimeTo(), dbRate.getcTimeTo());
        assertEquals(rate.getcMon(), dbRate.getcMon());
        assertEquals(rate.getcTue(), dbRate.getcTue());
        assertEquals(rate.getcWed(), dbRate.getcWed());
        assertEquals(rate.getcThu(), dbRate.getcThu());
        assertEquals(rate.getcFri(), dbRate.getcFri());
        assertEquals(rate.getcSat(), dbRate.getcSat());
        assertEquals(rate.getcSun(), dbRate.getcSun());
        assertEquals(rate.getcUserGroupIds(), dbRate.getcUserGroupIds());        
        
        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.rate where courtcategoryid=-1");
    }
    
    @Test
    public void persist_updatesIfIdIsNotNull() throws ParseException {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.rate where id=-1");        
        jdbcTemplate.execute("INSERT INTO roger.rate (id, courtcategoryid, name, constraindate, constraintime, constrainweekday, constrainusergroup, cdatefrom, cdateto, ctimefrom, ctimeto, " +
                "cmon, ctue, cwed, cthu, cfri, csat, csun, cusergroupids, price, active, ordernr) " +
                "values (-1, -1, 'name1', true, true, true, true, '01.01.', '31.12.', '08:00', '13:00', true, true, true, true, true, true, true, " +
                "'1,2', 11.99, true, 2)");        
        
        // execute + assert
        Rate rate = new Rate();
        rate.setId(-1);
        rate.setCourtCategoryId(-2);
        rate.setName("name");
        rate.setActive(true);
        rate.setPrice(new BigDecimal("100.50"));
        rate.setOrderNr(1);
        rate.setConstrainDate(true);
        rate.setConstrainTime(true);
        rate.setConstrainUserGroup(true);
        rate.setConstrainWeekDay(true);
        rate.setcDateFrom("01.01.");
        rate.setcDateTo("31.12.");
        rate.setcTimeFrom("12:00");
        rate.setcTimeTo("18:00");
        rate.setcMon(true);
        rate.setcTue(true);
        rate.setcWed(true);
        rate.setcThu(true);
        rate.setcFri(true);
        rate.setcSat(false);
        rate.setcSun(false);
        rate.setcUserGroupIds(new ArrayList<Integer>(Arrays.asList(2,3)));
        rate = dao.persist(rate);
        
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.rate where id=-1");
        Rate dbRate = jdbcTemplate.query("SELECT * from roger.rate where id=-1",
                new RateRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(rate.getId(), dbRate.getId());
        assertEquals(rate.getCourtCategoryId(), dbRate.getCourtCategoryId());
        assertEquals(rate.getName(), dbRate.getName());
        assertEquals(rate.getActive(), dbRate.getActive());
        assertEquals(rate.getPrice(), dbRate.getPrice());
        assertEquals(rate.getOrderNr(), dbRate.getOrderNr());
        assertEquals(rate.getConstrainDate(), dbRate.getConstrainDate());
        assertEquals(rate.getConstrainTime(), dbRate.getConstrainTime());
        assertEquals(rate.getConstrainWeekDay(), dbRate.getConstrainWeekDay());
        assertEquals(rate.getConstrainUserGroup(), dbRate.getConstrainUserGroup());
        assertEquals(rate.getcDateFrom(), dbRate.getcDateFrom());
        assertEquals(rate.getcDateTo(), dbRate.getcDateTo());
        assertEquals(rate.getcTimeFrom(), dbRate.getcTimeFrom());
        assertEquals(rate.getcTimeTo(), dbRate.getcTimeTo());
        assertEquals(rate.getcMon(), dbRate.getcMon());
        assertEquals(rate.getcTue(), dbRate.getcTue());
        assertEquals(rate.getcWed(), dbRate.getcWed());
        assertEquals(rate.getcThu(), dbRate.getcThu());
        assertEquals(rate.getcFri(), dbRate.getcFri());
        assertEquals(rate.getcSat(), dbRate.getcSat());
        assertEquals(rate.getcSun(), dbRate.getcSun());
        assertEquals(rate.getcUserGroupIds(), dbRate.getcUserGroupIds());        
        
        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.rate where id=-1");
    }
    
    @Test
    public void delete_nonExistingIdThrowsNoException() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.rate where id=-1");
        
        // execute + assert
        dao.delete(-1);
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.rate where id=-1");
        
        assertEquals(0, rowCount);
    }
    
    @Test
    public void delete_existingIdDeltesAsRequested() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.rate where id=-1");
        jdbcTemplate.execute("INSERT INTO roger.rate (id, courtcategoryid, name, constraindate, constraintime, constrainweekday, constrainusergroup, cdatefrom, cdateto, ctimefrom, ctimeto, " +
                "cmon, ctue, cwed, cthu, cfri, csat, csun, cusergroupids, price, active, ordernr) " +
                "values (-1, -1, 'name1', true, true, true, true, '01.01.', '31.12.', '08:00', '13:00', true, true, true, true, true, true, true, " +
                "'1,2', 11.99, true, 2)");        
        
        // execute + assert
        dao.delete(-1);
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.rate where id=-1");
        
        assertEquals(0, rowCount);
    }
}
