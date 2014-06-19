package com.courtpicker.uimodel;

import java.util.ArrayList;
import java.util.List;

public class SubscriptionAvailabilityDetail {
    private String startTime;
    private List<Integer> freeCourtIds;

    public SubscriptionAvailabilityDetail() {
        this.startTime ="";
        this.freeCourtIds = new ArrayList<Integer>();
    }
    
    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public List<Integer> getFreeCourtIds() {
        return freeCourtIds;
    }

    public void setFreeCourtIds(List<Integer> freeCourtIds) {
        this.freeCourtIds = freeCourtIds;
    }
}
