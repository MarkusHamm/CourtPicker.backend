package com.courtpicker.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public abstract class Rate {
    private BigDecimal price;
    // properties
    private Boolean constrainDate;
    private Boolean constrainTime;
    private Boolean constrainWeekDay;
    private Boolean constrainUserGroup;
    // constraints
    // date format: DD.MM.
    private String cDateFrom;
    private String cDateTo;
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

    public Rate() {
        this.constrainDate = false;
        this.constrainTime = false;
        this.constrainWeekDay = false;
        this.constrainUserGroup = false;
        this.cDateFrom = "";
        this.cDateTo = "";
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

    public List<Integer> getcUserGroupIds() {
        return cUserGroupIds;
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

    public void setcUserGroupIds(List<Integer> cUserGroupIds) {
        this.cUserGroupIds = cUserGroupIds;
    }

    public Boolean getConstrainDate() {
        return constrainDate;
    }

    public void setConstrainDate(Boolean constrainDate) {
        this.constrainDate = constrainDate;
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

    public void setConstrainWeekDay(Boolean constrainWeekDay) {
        this.constrainWeekDay = constrainWeekDay;
    }

    public Boolean getConstrainUserGroup() {
        return constrainUserGroup;
    }

    public void setConstrainUserGroup(Boolean constrainUserGroup) {
        this.constrainUserGroup = constrainUserGroup;
    }

    public String getcDateFrom() {
        return cDateFrom;
    }

    public void setcDateFrom(String cDateFrom) {
        this.cDateFrom = cDateFrom;
    }

    public String getcDateTo() {
        return cDateTo;
    }

    public void setcDateTo(String cDateTo) {
        this.cDateTo = cDateTo;
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

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }    
}
