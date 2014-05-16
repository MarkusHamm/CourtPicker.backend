package com.courtpicker.uimodel;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

public class TimeSlot {
    private String fromTime;
    private String toTime;
    private Boolean isPast;
    private Boolean occupied;
    private String occupyType;
    private String caption;
    List<Integer> freeCourtIds;
    private Integer maxSlots;
    private Double utilization; 
    private Map<Integer, Integer> maxSlotsPerCourt;

    public TimeSlot() {
        this.fromTime = "";
        this.toTime = "";
        this.isPast = false;
        this.occupied = false;
        this.occupyType = "";
        this.caption = "";
        this.freeCourtIds = new ArrayList<Integer>();
        this.maxSlots = 0;
        this.utilization = 0d;
        this.maxSlotsPerCourt = new HashMap<Integer, Integer>();
    }
    
    public TimeSlot(String fromTime, String toTime) {
        this.fromTime = fromTime;
        this.toTime = toTime;
        this.isPast = false;
        this.occupied = false;
        this.occupyType = "";
        this.caption = "";
        this.freeCourtIds = new ArrayList<Integer>();        
        this.maxSlots = 0;
        this.utilization = 0d;
        this.maxSlotsPerCourt = new HashMap<Integer, Integer>();
    }

    public String getFromTime() {
        return fromTime;
    }

    public void setFromTime(String fromTime) {
        this.fromTime = fromTime;
    }

    public String getToTime() {
        return toTime;
    }

    public void setToTime(String toTime) {
        this.toTime = toTime;
    }

    public Boolean getIsPast() {
        return isPast;
    }

    public void setIsPast(Boolean isPast) {
        this.isPast = isPast;
    }
    
    public Boolean getOccupied() {
        return occupied;
    }

    public void setOccupied(Boolean occupied) {
        this.occupied = occupied;
    }

    public String getOccupyType() {
        return occupyType;
    }

    public void setOccupyType(String occupyType) {
        this.occupyType = occupyType;
    }

    public List<Integer> getFreeCourtIds() {
        return freeCourtIds;
    }

    public void setFreeCourtIds(List<Integer> freeCourtIds) {
        this.freeCourtIds = freeCourtIds;
    }

    public String getCaption() {
        return caption;
    }

    public void setCaption(String caption) {
        this.caption = caption;
    }
    
    public Integer getMaxSlots() {
        return maxSlots;
    }

    public void setMaxSlots(Integer maxSlots) {
        this.maxSlots = maxSlots;
    }

    public Map<Integer, Integer> getMaxSlotsPerCourt() {
        return maxSlotsPerCourt;
    }

    public void setMaxSlotsPerCourt(Map<Integer, Integer> maxSlotsPerCourt) {
        this.maxSlotsPerCourt = maxSlotsPerCourt;
    }
    
    public Double getUtilization() {
        return utilization;
    }

    public void setUtilization(Double utilization) {
        this.utilization = utilization;
    }
    
    public int hashCode() {
        return new HashCodeBuilder(17, 31). // two randomly chosen prime numbers
            append(fromTime).
            append(toTime).
            append(isPast).
            append(occupied).
            append(occupyType).
            append(caption).
            append(freeCourtIds).
            append(maxSlots).
            append(maxSlotsPerCourt).
            toHashCode();
    }

    public boolean equals(Object obj) {
        if (obj == null)
            return false;
        if (obj == this)
            return true;
        if (!(obj instanceof TimeSlot))
            return false;

        TimeSlot rhs = (TimeSlot) obj;
        return new EqualsBuilder().
            append(fromTime, rhs.fromTime).
            append(toTime, rhs.toTime).
            append(isPast, rhs.isPast).
            append(fromTime, rhs.fromTime).
            append(occupied, rhs.occupied).
            append(caption, rhs.caption).
            append(freeCourtIds, rhs.freeCourtIds).
            append(maxSlots, rhs.maxSlots).
            append(maxSlotsPerCourt, rhs.maxSlotsPerCourt).
            isEquals();
    }
}
