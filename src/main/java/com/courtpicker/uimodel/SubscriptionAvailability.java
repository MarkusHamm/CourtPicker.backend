package com.courtpicker.uimodel;

import java.util.ArrayList;
import java.util.List;

public class SubscriptionAvailability {
    private String weekDay;
    private List<SubscriptionAvailabilityDetail> detail;

    public SubscriptionAvailability() {
        this.weekDay = "";
        this.detail = new ArrayList<SubscriptionAvailabilityDetail>();
    }
    
    public String getWeekDay() {
        return weekDay;
    }

    public void setWeekDay(String weekDay) {
        this.weekDay = weekDay;
    }

    public List<SubscriptionAvailabilityDetail> getDetail() {
        return detail;
    }

    public void setDetail(List<SubscriptionAvailabilityDetail> detail) {
        this.detail = detail;
    }
}
