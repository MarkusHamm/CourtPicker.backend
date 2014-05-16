package com.courtpicker.tools;

import static org.junit.Assert.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.junit.Test;

public class DateHelperTest {
    private DateHelper dateHelper;
    private SimpleDateFormat dateFormat;
    
    public DateHelperTest() {
        this.dateHelper = new DateHelper();
        this.dateFormat = new SimpleDateFormat("dd.MM.yyyy HH:mm");
    }
    
    @Test
    public void getEarliestDateOfWeek_returnsCorrectResultForSunday2359h() throws ParseException {
        Date result = dateHelper.getEarliestDateOfWeek(dateFormat.parse("19.01.2014 23:59"));
        assertEquals("13.01.2014 00:00", dateFormat.format(result));
    }
    
    @Test
    public void getEarliestDateOfWeek_returnsCorrectResultForWednesday1200h() throws ParseException {
        Date result = dateHelper.getEarliestDateOfWeek(dateFormat.parse("15.01.2014 12:00"));
        assertEquals("13.01.2014 00:00", dateFormat.format(result));
    }
    
    @Test
    public void getEarliestDateOfWeek_returnsCorrectResultForMonday0000h() throws ParseException {
        Date result = dateHelper.getEarliestDateOfWeek(dateFormat.parse("13.01.2014 00:00"));
        assertEquals("13.01.2014 00:00", dateFormat.format(result));        
    }
    
    @Test
    public void getLatestDateOfWeek_returnsCorrectResultForSunday2359h() throws ParseException {
        Date result = dateHelper.getLatestDateOfWeek(dateFormat.parse("19.01.2014 23:59"));
        assertEquals("19.01.2014 23:59", dateFormat.format(result));                
    }

    @Test
    public void getLatestDateOfWeek_returnsCorrectResultForWednesday1200h() throws ParseException {
        Date result = dateHelper.getLatestDateOfWeek(dateFormat.parse("15.01.2014 12:00"));
        assertEquals("19.01.2014 23:59", dateFormat.format(result));                
    }

    @Test
    public void getLatestDateOfWeek_returnsCorrectResultForMonday0000h() throws ParseException {
        Date result = dateHelper.getLatestDateOfWeek(dateFormat.parse("13.01.2014 00:00"));
        assertEquals("19.01.2014 23:59", dateFormat.format(result));                        
    }
    
    @Test 
    public void getEarliestDateOfDay_returnsCorrectResult() throws ParseException {
        Date result = dateHelper.getEarliestDateOfDay(dateFormat.parse("16.03.2014 11:35"));
        assertEquals("16.03.2014 00:00", dateFormat.format(result));
    }
    
    @Test 
    public void getLatestDateOfDay_returnsCorrectResult() throws ParseException {
        Date result = dateHelper.getLatestDateOfDay(dateFormat.parse("16.03.2014 11:35"));
        assertEquals("16.03.2014 23:59", dateFormat.format(result));        
    }
    
    @Test
    public void addMinutes_returnsCorrectResultWhenNoHourSwitchNecessary() throws ParseException {
        Date result = dateHelper.addMinutes(dateFormat.parse("16.03.2014 11:35"), 20);
        assertEquals("16.03.2014 11:55", dateFormat.format(result));                
    }
    
    @Test
    public void addMinutes_returnsCorrectResultWhenHourSwitchNecessary() throws ParseException {
        Date result = dateHelper.addMinutes(dateFormat.parse("16.03.2014 11:35"), 130);
        assertEquals("16.03.2014 13:45", dateFormat.format(result));        
    }
    
    @Test
    public void general_objectMethodsDoNotModifyPassedDate() throws ParseException {
        Date passedDate = dateFormat.parse("16.03.2014 11:35");
        Date resultDate = dateHelper.addMinutes(passedDate, 20);
        assertFalse(passedDate == resultDate);
    }
    
    @Test
    public void getDayOfWeek_returnsCorrectResult() throws ParseException {
        Date monday = dateFormat.parse("24.03.2014 11:35");
        Date tuesday = dateFormat.parse("25.03.2014 11:35");
        Date sunday = dateFormat.parse("23.03.2014 11:35");
        
        assertEquals(Calendar.MONDAY, dateHelper.getDayOfWeek(monday));
        assertEquals(Calendar.TUESDAY, dateHelper.getDayOfWeek(tuesday));
        assertEquals(Calendar.SUNDAY, dateHelper.getDayOfWeek(sunday));
    }
    
    @Test
    public void getYear_returnsCorrectResult() throws ParseException {
        Date y2012 = dateFormat.parse("24.03.2012 11:35");
        Date y2014 = dateFormat.parse("25.03.2014 11:35");
        
        assertEquals(2012, dateHelper.getYear(y2012));
        assertEquals(2014, dateHelper.getYear(y2014));
    }
    
    @Test
    public void setYear_returnsCorrectResult() throws ParseException {
        Date year2014 = dateFormat.parse("24.03.2014 11:35");
        Date year2012 = dateHelper.setYear(year2014, 2012);
        assertEquals("24.03.2012 11:35", dateFormat.format(year2012));
    }
}
