package com.courtpicker.tools;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

@Component("dateHelper")
@Scope("singleton")
public class DateHelper {
    public Date getEarliestDateOfWeek(Date date) {
        Calendar cal = new GregorianCalendar(Locale.GERMANY);
        cal.setTime(date);
        
        int dayGap = cal.getFirstDayOfWeek() - cal.get(Calendar.DAY_OF_WEEK);
        // special-case sunday
        if (dayGap>0) {
            dayGap = -6;
        }
        cal.add(Calendar.DAY_OF_WEEK, dayGap);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        
        return cal.getTime();
    }
    
    public Date getLatestDateOfWeek(Date date) {
        Calendar cal = new GregorianCalendar(Locale.GERMANY);
        cal.setTime(date);
        
        int dayGap = (8 - cal.get(Calendar.DAY_OF_WEEK)) % 7;
        cal.add(Calendar.DAY_OF_WEEK, dayGap);
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        
        return cal.getTime();
    }
    
    public Date getEarliestDateOfDay(Date date) {
        Calendar cal = new GregorianCalendar(Locale.GERMANY);
        cal.setTime(date);
        
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        
        return cal.getTime();
    }
    
    public Date getLatestDateOfDay(Date date) {
        Calendar cal = new GregorianCalendar(Locale.GERMANY);
        cal.setTime(date);
        
        cal.set(Calendar.HOUR_OF_DAY, 23);
        cal.set(Calendar.MINUTE, 59);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        
        return cal.getTime();
    }
    
    public Date getNextWeekDay(Date date, int dayOfWeek) {
        Calendar cal = new GregorianCalendar(Locale.GERMANY);
        cal.setTime(date);
        
        int diff = dayOfWeek - cal.get(Calendar.DAY_OF_WEEK);
        if (diff < 0) {
            diff = diff + 7;
        }
        
        cal.add(Calendar.DAY_OF_MONTH, diff);
        
        return cal.getTime();
    }
    
    public Date getPreviousWeekDay(Date date, int dayOfWeek) {
        Calendar cal = new GregorianCalendar(Locale.GERMANY);
        cal.setTime(date);
        
        int diff = cal.get(Calendar.DAY_OF_WEEK) - dayOfWeek;
        if (diff < 0) {
            diff = diff + 7;
        }
        
        cal.add(Calendar.DAY_OF_MONTH, -diff);
        
        return cal.getTime();
    }
    
    public Date addMinutes(Date date, Integer minutes) {
        Calendar cal = new GregorianCalendar(Locale.GERMANY);
        cal.setTime(date);
        
        cal.add(Calendar.MINUTE, minutes);
        
        return cal.getTime();
    }
    
    public int getDayOfWeek(Date date) {
        Calendar cal = new GregorianCalendar(Locale.GERMANY);
        cal.setTime(date);
        
        return cal.get(Calendar.DAY_OF_WEEK);
    }
    
    public int getYear(Date date) {
        Calendar cal = new GregorianCalendar(Locale.GERMANY);
        cal.setTime(date);
        
        return cal.get(Calendar.YEAR);
    }
    
    public Date setYear(Date date, Integer year) {
        Calendar cal = new GregorianCalendar(Locale.GERMANY);
        cal.setTime(date);
        cal.set(Calendar.YEAR, year);
        
        return cal.getTime();
    }
}
