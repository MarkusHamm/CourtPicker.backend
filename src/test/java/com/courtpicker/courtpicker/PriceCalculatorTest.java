package com.courtpicker.courtpicker;

import static org.junit.Assert.*;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Test;

import com.courtpicker.model.Rate;
import com.courtpicker.model.SingleRate;
import com.courtpicker.tools.DateHelper;

public class PriceCalculatorTest {
    private PriceCalculator calc;
    private List<Rate> rates;
    private SimpleDateFormat dateTimeFormat;    
    
    public PriceCalculatorTest() {
        DateHelper dateHelper = new DateHelper();
        calc = new PriceCalculator();
        calc.setDateHelper(dateHelper);
        rates = createTestRates();
        dateTimeFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
    }

    @Test
    public void calculateReservationPrice_baseRate() throws ParseException {
        Date fromDate = dateTimeFormat.parse("05.02.2014 18:00");
        Date toDate = dateTimeFormat.parse("05.02.2014 19:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(10), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_timeConstraintMorning() throws ParseException {
        Date fromDate = dateTimeFormat.parse("05.02.2014 08:00");
        Date toDate = dateTimeFormat.parse("05.02.2014 09:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(9), calcPrice);
    }

    @Test
    public void calculateReservationPrice_timeConstraintAfternoon() throws ParseException {
        Date fromDate = dateTimeFormat.parse("05.02.2014 13:00");
        Date toDate = dateTimeFormat.parse("05.02.2014 14:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(11), calcPrice);
    }

    @Test
    public void calculateReservationPrice_timeConstraintStartAtBorder() throws ParseException {
        Date fromDate = dateTimeFormat.parse("05.02.2014 12:00");
        Date toDate = dateTimeFormat.parse("05.02.2014 13:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(11), calcPrice);
    }

    @Test
    public void calculateReservationPrice_timeConstraintEndAtBorder() throws ParseException {
        Date fromDate = dateTimeFormat.parse("05.02.2014 11:00");
        Date toDate = dateTimeFormat.parse("05.02.2014 12:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(9), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_weekDayConstraint() throws ParseException {
        Date fromDate = dateTimeFormat.parse("22.03.2014 16:00");
        Date toDate = dateTimeFormat.parse("22.03.2014 17:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(15), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_weekDayConstraintAndTimeContsraintMorning() throws ParseException {
        Date fromDate = dateTimeFormat.parse("22.03.2014 08:00");
        Date toDate = dateTimeFormat.parse("22.03.2014 09:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(14), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_weekDayConstraintAndTimeConstraintAfternoon() throws ParseException {
        Date fromDate = dateTimeFormat.parse("23.03.2014 13:00");
        Date toDate = dateTimeFormat.parse("23.03.2014 14:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(16), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_dateConstraintBorderBegin() throws ParseException {
        Date fromDate = dateTimeFormat.parse("01.04.2014 00:00");
        Date toDate = dateTimeFormat.parse("01.04.2014 01:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(20), calcPrice);
        
        fromDate = dateTimeFormat.parse("31.03.2014 23:00");
        toDate = dateTimeFormat.parse("01.04.2014 00:00");
        calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(10), calcPrice);        
    }
    
    @Test
    public void calculateReservationPrice_dateConstraintBorderEnd() throws ParseException {
        Date fromDate = dateTimeFormat.parse("30.06.2014 23:00");
        Date toDate = dateTimeFormat.parse("01.07.2014 00:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(20), calcPrice);
        
        fromDate = dateTimeFormat.parse("01.07.2014 00:00");
        toDate = dateTimeFormat.parse("01.07.2014 01:00");
        calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(10), calcPrice);
    }


    @Test
    public void calculateReservationPrice_dateConstraintAndTimeConstraint() throws ParseException {
        Date fromDate = dateTimeFormat.parse("10.04.2014 09:00");
        Date toDate = dateTimeFormat.parse("10.04.2014 10:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(18), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_dateConstraintAndWeekDayConstraintWithinTimeConstraint() throws ParseException {
        Date fromDate = dateTimeFormat.parse("12.04.2014 09:00");
        Date toDate = dateTimeFormat.parse("12.04.2014 10:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(22), calcPrice);
    }

    @Test
    public void calculateReservationPrice_dateConstraintAndWeekDayConstraintWithoutTimeConstraint() throws ParseException {
        Date fromDate = dateTimeFormat.parse("12.04.2014 14:00");
        Date toDate = dateTimeFormat.parse("12.04.2014 15:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(22), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_dateConstraintSpanningTwoYears() throws ParseException {
        Date fromDate = dateTimeFormat.parse("30.12.2014 18:00");
        Date toDate = dateTimeFormat.parse("30.12.2014 19:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(30), calcPrice);
        
        fromDate = dateTimeFormat.parse("02.01.2015 18:00");
        toDate = dateTimeFormat.parse("02.01.2015 19:00");
        calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(30), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_userGroupConstraint() throws ParseException {
        Date fromDate = dateTimeFormat.parse("10.03.2014 06:00");
        Date toDate = dateTimeFormat.parse("10.03.2014 07:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        userGroupIds.add(1);
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(5), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_userGroupAndTimeConstraint() throws ParseException {
        Date fromDate = dateTimeFormat.parse("10.03.2014 13:00");
        Date toDate = dateTimeFormat.parse("10.03.2014 14:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        userGroupIds.add(1);
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(7), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_userGroupAndWeekDayConstraint() throws ParseException {
        Date fromDate = dateTimeFormat.parse("08.03.2014 13:00");
        Date toDate = dateTimeFormat.parse("08.03.2014 14:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        userGroupIds.add(1);
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(8), calcPrice);
    }

    @Test
    public void calculateReservationPrice_userGroupAndDateConstraint() throws ParseException {
        Date fromDate = dateTimeFormat.parse("02.04.2014 13:00");
        Date toDate = dateTimeFormat.parse("02.04.2014 14:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        userGroupIds.add(3);
        userGroupIds.add(1);
        userGroupIds.add(2);
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(6), calcPrice);
    }

    @Test
    public void calculateReservationPrice_twoSubsequentHoursCalculatedCorrectly() throws ParseException {
        Date fromDate = dateTimeFormat.parse("05.03.2014 11:00");
        Date toDate = dateTimeFormat.parse("05.03.2014 13:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(20), calcPrice);
    }
    
    @Test
    public void calculateReservationPrice_threeSubsequentHoursCalculatedCorrectly() throws ParseException {
        Date fromDate = dateTimeFormat.parse("01.03.2014 14:00");
        Date toDate = dateTimeFormat.parse("01.03.2014 17:00");
        List<Integer> userGroupIds = new ArrayList<Integer>();
        BigDecimal calcPrice = calc.calculateReservationPrice(fromDate, toDate, new Date(), userGroupIds, 60, rates);
        assertEquals(new BigDecimal(47), calcPrice);
    }
        
    private List<Rate> createTestRates() {
        List<Rate> rates = new ArrayList<Rate>();
        // base rate
        rates.add(createSingleRate(false, false, false, false, "", "", false, false, false, false, false, false, false, "", "", new ArrayList<Integer>(), 10));
        // time constraint
        rates.add(createSingleRate(true, false, false, false, "08:00", "12:00", false, false, false, false, false, false, false, "", "", new ArrayList<Integer>(), 9));
        rates.add(createSingleRate(true, false, false, false, "12:00", "16:00", false, false, false, false, false, false, false, "", "", new ArrayList<Integer>(), 11));
        // week day constraint
        rates.add(createSingleRate(false, true, false, false, "", "", false, false, false, false, false, true, true, "", "", new ArrayList<Integer>(), 15));
        rates.add(createSingleRate(true, true, false, false, "08:00", "12:00", false, false, false, false, false, true, true, "", "", new ArrayList<Integer>(), 14));
        rates.add(createSingleRate(true, true, false, false, "12:00", "16:00", false, false, false, false, false, true, true, "", "", new ArrayList<Integer>(), 16));
        // date constraint
        rates.add(createSingleRate(false, false, true, false, "", "", false, false, false, false, false, false, false, "01.04.", "30.06.", new ArrayList<Integer>(), 20));
        rates.add(createSingleRate(true, false, true, false, "08:00", "12:00", false, false, false, false, false, false, false, "01.04.", "30.06.", new ArrayList<Integer>(), 18));
        rates.add(createSingleRate(false, true, true, false, "", "", false, false, false, false, false, true, true, "01.04.", "30.06.", new ArrayList<Integer>(), 22));
        // date constraint from one year to the next
        rates.add(createSingleRate(false, false, true, false, "", "", false, false, false, false, false, false, false, "25.12.", "05.01.", new ArrayList<Integer>(), 30));
        // user group constraint
        List<Integer> userGroups = new ArrayList<Integer>();
        userGroups.add(1);
        rates.add(createSingleRate(false, false, false, true, "", "", false, false, false, false, false, false, false, "", "", userGroups, 5));
        rates.add(createSingleRate(true, false, false, true, "12:00", "16:00", false, false, false, false, false, false, false, "", "", userGroups, 7));
        rates.add(createSingleRate(false, true, false, true, "", "", false, false, false, false, false, true, true, "", "", userGroups, 8));
        rates.add(createSingleRate(false, false, true, true, "", "", false, false, false, false, false, false, false, "01.04.", "30.06.", userGroups, 6));
        
        return rates;
    }
    
    private SingleRate createSingleRate(boolean constrainTime, boolean constrainWeekDay, boolean constrainDate, boolean constrainUserGroup,
            String cTimeFrom, String cTimeTo, boolean cMon, boolean cTue, boolean cWed, boolean cThu, boolean cFri, boolean cSat, boolean cSun,
            String cDateFrom, String cDateTo, List<Integer> cUserGroupIds, Integer price) {
        SingleRate rate = new SingleRate();
        rate.setId(1);
        rate.setCourtCategoryId(1);
        rate.setName("name");
        rate.setActive(true);
        rate.setOrderNr(1);
        
        rate.setConstrainTime(constrainTime);
        rate.setConstrainWeekDay(constrainWeekDay);
        rate.setConstrainDate(constrainDate);
        rate.setConstrainUserGroup(constrainUserGroup);

        rate.setcTimeFrom(cTimeFrom);
        rate.setcTimeTo(cTimeTo);
        rate.setcMon(cMon);
        rate.setcTue(cTue);
        rate.setcWed(cWed);
        rate.setcThu(cThu);
        rate.setcFri(cFri);
        rate.setcSat(cSat);
        rate.setcSun(cSun);
        rate.setcDateFrom(cDateFrom);
        rate.setcDateTo(cDateTo);
        rate.setcUserGroupIds(cUserGroupIds);
        
        rate.setPrice(new BigDecimal(price));
        
        return rate;
    }
}
