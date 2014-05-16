package com.courtpicker.dao;

import static org.junit.Assert.assertEquals;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import org.junit.Test;

import com.courtpicker.model.Rate;
import com.courtpicker.model.SingleReservation;

public class SingleReservationDAOTest extends BaseDAOTest {
    private SingleReservationDAO dao;

    public SingleReservationDAOTest() throws Exception {
        super();
        dao = new SingleReservationDAO();
        dao.setJdbcTemplate(jdbcTemplate);
    }
    
    @Test
    public void getReservationsForCourt_returnsCorrectResult() throws ParseException {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.singlereservation where courtid=-1");

        jdbcTemplate.execute("INSERT INTO roger.singlereservation(id, customerid, customername, courtid, fromdate, todate, " +
        		"reservationdate, reservingcustomerid, displayname, paid, deleted, calculatedprice, price, comment, paymentdate, paymentoptionid) VALUES " +
        		"(-1, -1, 'custname', -1, '2014-01-01 18:00:00', '2014-01-01 20:00:00', '2014-01-01 09:00:00', -1, 'name', " +
        		"false, false, 20, 10.99, 'not yet paid', null, null);");
        jdbcTemplate.execute("INSERT INTO roger.singlereservation(id, customerid, customername, courtid, fromdate, todate, " +
                "reservationdate, reservingcustomerid, displayname, paid, deleted, calculatedprice, price, comment, paymentdate, paymentoptionid) VALUES " +
                "(-2, -1, 'custname', -1, '2014-01-02 18:00:00', '2014-01-02 20:00:00', '2014-01-01 09:00:00', -1, 'name', " +
                "true, false, 20, 10.99, 'not yet paid', '2014-10-10 10:00:00', 5);");
        jdbcTemplate.execute("INSERT INTO roger.singlereservation(id, customerid, customername, courtid, fromdate, todate, " +
                "reservationdate, reservingcustomerid, displayname, paid, deleted, calculatedprice, price, comment, paymentdate, paymentoptionid) VALUES " +
                "(-3, -1, 'custname', -1, '2014-01-05 18:00:00', '2014-01-05 20:00:00', '2014-01-01 09:00:00', -1, 'name', " +
                "false, false, 20, 10.99, 'not yet paid', null, null);");

        // execute + assert
        SimpleDateFormat inputDateFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
        List<SingleReservation> resList = dao.getReservationsForCourt(-1, 
                inputDateFormat.parse("02.01.2014 09:00:00"), inputDateFormat.parse("04.01.2014 23:00:00"));
        assertEquals(1, resList.size());

        SingleReservation res = resList.get(0);
        assertEquals(res.getId(), Integer.valueOf(-2));
        assertEquals(res.getCustomerId(), Integer.valueOf(-1));
        assertEquals(res.getCustomerName(), "custname");
        assertEquals(res.getCourtId(), Integer.valueOf(-1));
        assertEquals(inputDateFormat.format(res.getFromDate()), "02.01.2014 18:00:00");
        assertEquals(inputDateFormat.format(res.getToDate()), "02.01.2014 20:00:00");
        assertEquals(inputDateFormat.format(res.getReservationDate()), "01.01.2014 09:00:00");
        assertEquals(res.getReservingCustomerId(), Integer.valueOf(-1));
        assertEquals(res.getDisplayName(), "name");
        assertEquals(res.getPaid(), true);
        assertEquals(inputDateFormat.format(res.getPaymentDate()), "10.10.2014 10:00:00");
        assertEquals(new Integer(5), res.getPaymentOptionId());
        assertEquals(res.getDeleted(), false);
        assertEquals(res.getCalculatedPrice(), new BigDecimal("20"));
        assertEquals(res.getPrice(), new BigDecimal("10.99"));
        assertEquals(res.getComment(), "not yet paid");
        
        resList = dao.getReservationsForCourt(-1, 
                inputDateFormat.parse("02.01.2014 23:00:00"), inputDateFormat.parse("04.01.2014 23:00:00"));
        assertEquals(0, resList.size());

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.singlereservation where courtid=-1");
    }
    
    @Test
    public void persist_insertsIfIdIsNull() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.singlereservation where courtid=-1");

        // execute + assert
        SingleReservation res = new SingleReservation();
        res.setCustomerId(-1);
        res.setCustomerName("custname");
        res.setCourtId(-1);
        res.setFromDate(new Date());
        res.setToDate(new Date());
        res.setReservationDate(new Date());
        res.setReservingCustomerId(-1);
        res.setDisplayName("disp");
        res.setPaid(false);
        res.setDeleted(false);
        res.setCalculatedPrice(new BigDecimal(20));
        res.setPrice(new BigDecimal(10));
        res.setComment("comment");
        res.setPaymentDate(new Date());
        res.setPaymentOptionId(5);
        dao.persist(res);
        
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.singlereservation where courtid=-1");
        SingleReservation dbRes = jdbcTemplate.query("SELECT * from roger.singlereservation where courtid=-1",
                new SingleReservationRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(res.getId(), dbRes.getId());
        assertEquals(res.getCustomerId(), dbRes.getCustomerId());
        assertEquals(res.getCustomerName(), dbRes.getCustomerName());
        assertEquals(res.getCourtId(), dbRes.getCourtId());
        assertEquals(res.getFromDate(), dbRes.getFromDate());
        assertEquals(res.getToDate(), dbRes.getToDate());
        assertEquals(res.getReservationDate(), dbRes.getReservationDate());
        assertEquals(res.getReservingCustomerId(), dbRes.getReservingCustomerId());
        assertEquals(res.getDisplayName(), dbRes.getDisplayName());
        assertEquals(res.getPaid(), dbRes.getPaid());
        assertEquals(res.getDeleted(), dbRes.getDeleted());
        assertEquals(res.getCalculatedPrice(), dbRes.getCalculatedPrice());
        assertEquals(res.getPrice(), dbRes.getPrice());
        assertEquals(res.getComment(), dbRes.getComment());
        assertEquals(res.getPaymentOptionId(), dbRes.getPaymentOptionId());
        assertEquals(res.getPaymentDate(), dbRes.getPaymentDate());
        
        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.singlereservation where courtid=-1");
    }
    
    @Test
    public void persist_updatesIfIdIsNotNull() {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.rate where id=-1");        
        jdbcTemplate.execute("INSERT INTO roger.singlereservation(id, customerid, customername, courtid, fromdate, todate, " +
                "reservationdate, reservingcustomerid, displayname, paid, deleted, calculatedprice, price, comment, paymentdate, paymentoptionid) VALUES " +
                "(-1, -2, 'xx', -2, '2014-01-01 18:00:00', '2014-01-01 20:00:00', '2014-01-01 09:00:00', -2, 'name', " +
                "false, true, 20, 10.99, 'not yet paid', null, null);");

        // execute + assert
        SingleReservation res = new SingleReservation();
        res.setId(-1);
        res.setCustomerId(-1);
        res.setCustomerName("custname");
        res.setCourtId(-1);
        res.setFromDate(new Date());
        res.setToDate(new Date());
        res.setReservationDate(new Date());
        res.setReservingCustomerId(-1);
        res.setDisplayName("disp");
        res.setPaid(false);
        res.setDeleted(false);
        res.setCalculatedPrice(new BigDecimal(15));
        res.setPrice(new BigDecimal(10));
        res.setComment("comment");
        res.setPaymentDate(new Date());
        res.setPaymentOptionId(5);
        dao.persist(res);
        
        int rowCount = jdbcTemplate.queryForInt("SELECT count(*) from roger.singlereservation where courtid=-1");
        SingleReservation dbRes = jdbcTemplate.query("SELECT * from roger.singlereservation where id=-1",
                new SingleReservationRowMapper()).get(0);

        assertEquals(1, rowCount);
        assertEquals(res.getId(), dbRes.getId());
        assertEquals(res.getCustomerId(), dbRes.getCustomerId());
        assertEquals(res.getCustomerName(), dbRes.getCustomerName());
        assertEquals(res.getCourtId(), dbRes.getCourtId());
        assertEquals(res.getFromDate(), dbRes.getFromDate());
        assertEquals(res.getToDate(), dbRes.getToDate());
        assertEquals(res.getReservationDate(), dbRes.getReservationDate());
        assertEquals(res.getReservingCustomerId(), dbRes.getReservingCustomerId());
        assertEquals(res.getDisplayName(), dbRes.getDisplayName());
        assertEquals(res.getPaid(), dbRes.getPaid());
        assertEquals(res.getDeleted(), dbRes.getDeleted());
        assertEquals(res.getCalculatedPrice(), dbRes.getCalculatedPrice());
        assertEquals(res.getPrice(), dbRes.getPrice());
        assertEquals(res.getComment(), dbRes.getComment());
        assertEquals(res.getPaymentOptionId(), dbRes.getPaymentOptionId());
        assertEquals(res.getPaymentDate(), dbRes.getPaymentDate());
        
        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.singlereservation where id=-1");
    }
}
