package com.courtpicker.dao;

import static org.junit.Assert.assertEquals;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.junit.Test;

import com.courtpicker.model.SubscriptionReservationPeriod;

public class SubscriptionReservationPeriodDAOTest extends BaseDAOTest {
    private SubscriptionReservationPeriodDAO dao;

    public SubscriptionReservationPeriodDAOTest() throws Exception {
        super();
        dao = new SubscriptionReservationPeriodDAO();
        dao.setJdbcTemplate(jdbcTemplate);
    }
    
    @Test
    public void getReservationsForCourt_returnsCorrectResult() throws ParseException {
        // set-up
        jdbcTemplate.execute("DELETE FROM roger.subscriptionperiodreservation where courtid=-1");

        jdbcTemplate.execute("INSERT INTO roger.subscriptionperiodreservation(id, customerid, courtid, periodstart, " +
        		"periodend, fromtime, totime, frequency, reservationdate, reservingcustomerid, displayname, paid, " +
        		"deleted, price, comment) VALUES " +
                "(-1, -1, -1, '2013-01-01', '2013-03-01', '12:00', '14:00', 'WEEK', '2013-01-01 08:00:00', -1, 'name', " +
                "false, false, 10.99, 'not yet paid');");

        // execute + assert - within timeframe
        SimpleDateFormat inputDateFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm:ss");
        List<SubscriptionReservationPeriod> resList = dao.getReservationsForCourt(-1, 
                inputDateFormat.parse("02.01.2013 00:00:00"), inputDateFormat.parse("04.01.2013 23:59:00"));
        assertEquals(1, resList.size());

        SubscriptionReservationPeriod res = resList.get(0);
        assertEquals(res.getId(), Integer.valueOf(-1));
        assertEquals(res.getCustomerId(), Integer.valueOf(-1));
        assertEquals(res.getCourtId(), Integer.valueOf(-1));
        assertEquals(inputDateFormat.format(res.getPeriodStart()), "01.01.2013 00:00:00");
        assertEquals(inputDateFormat.format(res.getPeriodEnd()), "01.03.2013 00:00:00");
        //assertEquals(res.getFromTime(), "12:00:00+01");
        //assertEquals(res.getToTime(), "14:00:00+01");
        assertEquals(res.getFrequency(), "WEEK");
        assertEquals(inputDateFormat.format(res.getReservationDate()), "01.01.2013 08:00:00");
        assertEquals(res.getReservingCustomerId(), Integer.valueOf(-1));
        assertEquals(res.getDisplayName(), "name");
        assertEquals(res.getPaid(), false);
        assertEquals(res.getDeleted(), false);
        assertEquals(res.getPrice(), new BigDecimal("10.99"));
        assertEquals(res.getComment(), "not yet paid");
        
        // without timeframe
        resList = dao.getReservationsForCourt(-1, 
                inputDateFormat.parse("20.12.2012 23:00:00"), inputDateFormat.parse("31.12.2012 23:00:00"));
        assertEquals(0, resList.size());
        
        // only enddate in timeframe
        resList = dao.getReservationsForCourt(-1, 
                inputDateFormat.parse("20.12.2012 23:00:00"), inputDateFormat.parse("02.01.2013 23:00:00"));
        assertEquals(1, resList.size());

        // only startdate in timeframe
        resList = dao.getReservationsForCourt(-1, 
                inputDateFormat.parse("20.02.2013 23:00:00"), inputDateFormat.parse("31.12.2013 23:00:00"));
        assertEquals(1, resList.size());

        // tear-down
        jdbcTemplate.execute("DELETE FROM roger.subscriptionperiodreservation where courtid=-1");
    }    
}
