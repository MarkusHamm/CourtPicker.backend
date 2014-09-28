package com.courtpicker.dao;

import java.util.List;

import static org.junit.Assert.*;
import org.junit.Test;

import com.courtpicker.model.CourtCategory;

public class CourtCategoryDAOTest extends BaseDAOTest {
    private CourtCategoryDAO dao;

    public CourtCategoryDAOTest() throws Exception {
        super();
        dao = new CourtCategoryDAO();
        dao.setJdbcTemplate(jdbcTemplate);
    }

    @Test
    public void getAllCourtCategories_retrievedInCorrectOrder() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.courtcategory where cpinstanceid=-1");
        jdbcTemplate.execute("INSERT INTO cp.courtcategory (id, cpinstanceid, ordernr, bookablefromtime, " +
        		"bookabletotime, bookingunit, name) values (default, -1, 2, '06:00', '23:00', 30, 'tennis')");
        jdbcTemplate.execute("INSERT INTO cp.courtcategory (id, cpinstanceid, ordernr, bookablefromtime, " +
                "bookabletotime, bookingunit, name) values (default, -1, 1, '05:00', '24:00', 60, 'fußball')");

        // execute + assert
        List<CourtCategory> catList = dao.getAllCourtCategories(-1);
        assertEquals(2, catList.size());

        CourtCategory cat1 = catList.get(0);
        assertEquals(cat1.getCpInstanceId(), Integer.valueOf(-1));
        assertEquals(cat1.getOrderNr(), Integer.valueOf(1));
        assertEquals(cat1.getName(), "fußball");
        assertEquals(cat1.getBookableFromTime(), "05:00");
        assertEquals(cat1.getBookableToTime(), "24:00");
        assertEquals(cat1.getBookingUnit(), Integer.valueOf(60));

        CourtCategory cat2 = catList.get(1);
        assertEquals(cat2.getCpInstanceId(), Integer.valueOf(-1));
        assertEquals(cat2.getOrderNr(), Integer.valueOf(2));
        assertEquals(cat2.getName(), "tennis");
        assertEquals(cat2.getBookableFromTime(), "06:00");
        assertEquals(cat2.getBookableToTime(), "23:00");
        assertEquals(cat2.getBookingUnit(), Integer.valueOf(30));

        // tear-down
        jdbcTemplate.execute("DELETE FROM cp.courtcategory where cpinstanceid=-1");
    }

    @Test
    public void persist_courtCategoryWithoutIdIsInserted() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.courtcategory where cpinstanceid=-1");

        // execute + assert
        CourtCategory cc = new CourtCategory();
        cc.setCpInstanceId(-1);
        cc.setName("name");
        cc.setOrderNr(1);
        cc.setBookableFromTime("06:00");
        cc.setBookableToTime("22:00");
        cc.setBookingUnit(30);
        cc = dao.persist(cc);

        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from cp.courtcategory where cpinstanceid=-1");
        CourtCategory dbCC = jdbcTemplate.query("SELECT * from cp.courtcategory where cpinstanceid=-1",
                new CourtCategoryRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(cc.getId(), dbCC.getId());
        assertEquals(cc.getCpInstanceId(), dbCC.getCpInstanceId());
        assertEquals(cc.getOrderNr(), dbCC.getOrderNr());
        assertEquals(cc.getName(), dbCC.getName());
        assertEquals(cc.getBookableFromTime(), dbCC.getBookableFromTime());
        assertEquals(cc.getBookableToTime(), dbCC.getBookableToTime());
        assertEquals(cc.getBookingUnit(), dbCC.getBookingUnit());

        // tear-down
        jdbcTemplate.execute("DELETE FROM cp.courtcategory where cpinstanceid=-1");
    }

    @Test
    public void persist_courtCategoryWithIdIsUpdated() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.courtcategory where id=-1");
        jdbcTemplate.execute("INSERT INTO cp.courtcategory (id, cpinstanceid, ordernr, bookablefromtime, " +
                "bookabletotime, bookingunit, name) values (-1, -1, 2, '10:00', '12:00', 30, 'tennis')");

        // execute + assert
        CourtCategory cc = new CourtCategory();
        cc.setId(-1);
        cc.setCpInstanceId(-100);
        cc.setName("name");
        cc.setOrderNr(1);
        cc.setBookableFromTime("04:00");
        cc.setBookableToTime("23:30");
        cc.setBookingUnit(60);
        cc = dao.persist(cc);

        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from cp.courtcategory where id=-1");
        CourtCategory dbCC = jdbcTemplate.query("SELECT * from cp.courtcategory where id=-1",
                new CourtCategoryRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(cc.getId(), dbCC.getId());
        assertEquals(cc.getCpInstanceId(), dbCC.getCpInstanceId());
        assertEquals(cc.getOrderNr(), dbCC.getOrderNr());
        assertEquals(cc.getName(), dbCC.getName());
        assertEquals(cc.getBookableFromTime(), dbCC.getBookableFromTime());
        assertEquals(cc.getBookableToTime(), dbCC.getBookableToTime());
        assertEquals(cc.getBookingUnit(), dbCC.getBookingUnit());

        // tear-down
        jdbcTemplate.execute("DELETE FROM cp.courtcategory where id=-1");
    }
    
    @Test
    public void delete_nonExistingIdThrowsNoException() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.courtcategory where id=-1");
        
        // execute + assert
        dao.delete(-1);
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from cp.courtcategory where id=-1");
        
        assertEquals(0, rowCount);
    }
    
    /*
    @Test
    public void delete_existingIdDeltesAsRequested() {
        // set-up
        jdbcTemplate.execute("DELETE FROM cp.courtcategory where id=-1");
        jdbcTemplate.execute("INSERT INTO cp.courtcategory (id, cpinstanceid, ordernr, name) values (-1, -1, 2, 'tennis')");
        
        // execute + assert
        dao.delete(-1);
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from cp.courtcategory where id=-1");
        
        assertEquals(0, rowCount);
    }
    */
}
