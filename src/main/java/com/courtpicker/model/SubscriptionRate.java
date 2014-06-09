package com.courtpicker.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class SubscriptionRate {
    private Integer id;
    private Integer subscriptionId;
    private String name;
    private BigDecimal price;
    private Boolean constrainTime;
    private Boolean constrainWeekDay;
    private Boolean constrainUserGroup;
    // time format: HH:MM
    private String cTimeFrom;
    private String cTimeTo;
    private Boolean cMon;
    private Boolean cTue;
    private Boolean cWed;
    private Boolean cThu;
    private Boolean cFri;
    private Boolean cSat;
    private Boolean cSun;
    /**
     * List of applying user groups ids.
     */
    private List<Integer> cUserGroupIds;
    
    public SubscriptionRate() {
        this.id = null;
        this.subscriptionId = null;
        this.name = "";
        this.price = null;
        this.constrainTime = false;
        this.constrainUserGroup = false;
        this.constrainWeekDay = false;
        this.cTimeFrom = "";
        this.cTimeTo = "";
        this.cMon = false;
        this.cTue = false;
        this.cWed = false;
        this.cThu = false;
        this.cFri = false;
        this.cSat = false;
        this.cSun = false;
        this.cUserGroupIds = new ArrayList<Integer>();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSubscriptionId() {
        return subscriptionId;
    }

    public void setSubscriptionId(Integer subscriptionId) {
        this.subscriptionId = subscriptionId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Boolean getConstrainTime() {
        return constrainTime;
    }

    public void setConstrainTime(Boolean constrainTime) {
        this.constrainTime = constrainTime;
    }

    public Boolean getConstrainWeekDay() {
        return constrainWeekDay;
    }

    public void setConstrainWeekDay(Boolean constrainWeekday) {
        this.constrainWeekDay = constrainWeekday;
    }

    public Boolean getConstrainUserGroup() {
        return constrainUserGroup;
    }

    public void setConstrainUserGroup(Boolean constrainUserGroup) {
        this.constrainUserGroup = constrainUserGroup;
    }

    public String getcTimeFrom() {
        return cTimeFrom;
    }

    public void setcTimeFrom(String cTimeFrom) {
        this.cTimeFrom = cTimeFrom;
    }

    public String getcTimeTo() {
        return cTimeTo;
    }

    public void setcTimeTo(String cTimeTo) {
        this.cTimeTo = cTimeTo;
    }

    public Boolean getcMon() {
        return cMon;
    }

    public void setcMon(Boolean cMon) {
        this.cMon = cMon;
    }

    public Boolean getcTue() {
        return cTue;
    }

    public void setcTue(Boolean cTue) {
        this.cTue = cTue;
    }

    public Boolean getcWed() {
        return cWed;
    }

    public void setcWed(Boolean cWed) {
        this.cWed = cWed;
    }

    public Boolean getcThu() {
        return cThu;
    }

    public void setcThu(Boolean cThu) {
        this.cThu = cThu;
    }

    public Boolean getcFri() {
        return cFri;
    }

    public void setcFri(Boolean cFri) {
        this.cFri = cFri;
    }

    public Boolean getcSat() {
        return cSat;
    }

    public void setcSat(Boolean cSat) {
        this.cSat = cSat;
    }

    public Boolean getcSun() {
        return cSun;
    }

    public void setcSun(Boolean cSun) {
        this.cSun = cSun;
    }

    public List<Integer> getcUserGroupIds() {
        return cUserGroupIds;
    }

    public void setcUserGroupIds(List<Integer> cUserGroupIds) {
        this.cUserGroupIds = cUserGroupIds;
    }
    
    public String convertcUserGroupIdsToString() {
        if (cUserGroupIds == null) {
            return null;
        }
        
        String result = "";
        int count = 0;
        for (Integer userGroupId : cUserGroupIds) {
            if (count == 0) {
                result += userGroupId;
            }
            else {
                result += "," + userGroupId;
            }
            count++;
        }
        
        return result;
    }
}
