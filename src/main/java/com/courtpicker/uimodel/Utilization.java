package com.courtpicker.uimodel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Utilization {
    private String name;
    private String date;
    private Boolean isCurrentDate;
    private List<TimeSlot> timeSlots;

    public Utilization() {
        this.name = "";
        this.date = "";
        this.isCurrentDate = false;
        this.timeSlots = new ArrayList<TimeSlot>();
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }
    
    public Boolean getIsCurrentDate() {
        return isCurrentDate;
    }

    public void setIsCurrentDate(Boolean isCurrentDate) {
        this.isCurrentDate = isCurrentDate;
    }

    public List<TimeSlot> getTimeSlots() {
        return timeSlots;
    }

    public void setTimeSlots(List<TimeSlot> timeSlots) {
        this.timeSlots = timeSlots;
    }
}
