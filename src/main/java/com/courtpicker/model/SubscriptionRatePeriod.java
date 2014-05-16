package com.courtpicker.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class SubscriptionRatePeriod {
    private Integer id;
    private Integer courtCategoryId;
    private String name;
    // date format: DD.MM.YYYY
    private String periodStart;
    private String periodEnd;
    private BigDecimal price;
    private Boolean active;
    private Integer orderNr;
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
    
    public SubscriptionRatePeriod() {
        this.id = null;
        this.courtCategoryId = null;
        this.name = "";
        this.periodStart = "";
        this.periodEnd = "";
        this.price = null;
        this.active = false;
        this.orderNr = null;
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

    public Integer getCourtCategoryId() {
        return courtCategoryId;
    }

    public void setCourtCategoryId(Integer courtCategoryId) {
        this.courtCategoryId = courtCategoryId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPeriodStart() {
        return periodStart;
    }

    public void setPeriodStart(String periodStart) {
        this.periodStart = periodStart;
    }

    public String getPeriodEnd() {
        return periodEnd;
    }

    public void setPeriodEnd(String periodEnd) {
        this.periodEnd = periodEnd;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Integer getOrderNr() {
        return orderNr;
    }

    public void setOrderNr(Integer orderNr) {
        this.orderNr = orderNr;
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
