package com.courtpicker.model;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

public class SingleRateTest {
    @Test
    public void convertcUserGroupIdsToString_nullValueReturnsNull() {
        SingleRate rate = new SingleRate();
        rate.setcUserGroupIds(null);
        
        assertNull(rate.convertcUserGroupIdsToString());
    }

    @Test
    public void convertcUserGroupIdsToString_emptyListReturnsEmptyString() {
        SingleRate rate = new SingleRate();
        rate.setcUserGroupIds(new ArrayList<Integer>());
        
        assertEquals("", rate.convertcUserGroupIdsToString());        
    }

    @Test
    public void convertcUserGroupIdsToString_oneItemListReturnsItemAsString() {
        SingleRate rate = new SingleRate();
        List<Integer> cUserGroupIds = new ArrayList<Integer>();
        cUserGroupIds.add(1);
        rate.setcUserGroupIds(cUserGroupIds);
        
        assertEquals("1", rate.convertcUserGroupIdsToString());
    }

    @Test
    public void convertcUserGroupIdsToString_threeItemListReturnsItemAsCommaSeparatedString() {
        SingleRate rate = new SingleRate();
        List<Integer> cUserGroupIds = new ArrayList<Integer>();
        cUserGroupIds.add(1);
        cUserGroupIds.add(2);
        cUserGroupIds.add(3);
        rate.setcUserGroupIds(cUserGroupIds);
        
        assertEquals("1,2,3", rate.convertcUserGroupIdsToString());        
    }
    
    /*
    @Test
    public void getWeekDaysAsString_nullValueReturnsNull() {
        Rate rate = new Rate();
        rate.setWeekDays(null);
        
        assertNull(rate.getWeekDaysAsString());
    }

    @Test
    public void getWeekDaysAsString_emptyListReturnsNull() {
        Rate rate = new Rate();
        rate.setWeekDays(new ArrayList<String>());
        
        assertNull(rate.getWeekDaysAsString());        
    }

    @Test
    public void getWeekDaysAsString_oneItemListReturnsItemAsString() {
        Rate rate = new Rate();
        List<String> weekDays = new ArrayList<String>();
        weekDays.add("saturday");
        rate.setWeekDays(weekDays);
        
        assertEquals("saturday", rate.getWeekDaysAsString());
    }

    @Test
    public void getWeekDaysAsString_threeItemListReturnsItemAsCommaSeparatedString() {
        Rate rate = new Rate();
        List<String> weekDays = new ArrayList<String>();
        weekDays.add("monday");
        weekDays.add("tuesday");
        weekDays.add("wednesday");
        rate.setWeekDays(weekDays);
        
        assertEquals("monday,tuesday,wednesday", rate.getWeekDaysAsString());        
    }
    */
}
