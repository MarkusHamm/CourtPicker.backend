package com.courtpicker.model;

import java.math.BigDecimal;
import java.util.Date;

public class SubscriptionReservationPeriod {
    private Integer id;
    private Integer customerId;
    private Integer courtId;
    private Date periodStart;
    private Date periodEnd;
    private String fromTime;
    private String toTime;
    private String frequency;
    private Date reservationDate;
    private Integer reservingCustomerId;
    private String displayName;
    private Boolean paid;
    private Boolean deleted;
    private BigDecimal price;
    private String comment;

    public SubscriptionReservationPeriod() {
        this.id = null;
        this.customerId = null;
        this.courtId = null;
        this.periodStart = null;
        this.periodEnd = null;
        this.fromTime = "";
        this.toTime = "";
        this.reservationDate = null;
        this.reservingCustomerId = null;
        this.displayName = "";
        this.paid = false;
        this.deleted = false;
        this.price = new BigDecimal(0);
        this.comment = "";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public Integer getCourtId() {
        return courtId;
    }

    public void setCourtId(Integer courtId) {
        this.courtId = courtId;
    }

    public Date getPeriodStart() {
        return periodStart;
    }

    public void setPeriodStart(Date periodStart) {
        this.periodStart = periodStart;
    }

    public Date getPeriodEnd() {
        return periodEnd;
    }

    public void setPeriodEnd(Date periodEnd) {
        this.periodEnd = periodEnd;
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

    public String getFrequency() {
        return frequency;
    }

    public void setFrequency(String frequency) {
        this.frequency = frequency;
    }

    public Date getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(Date reservationDate) {
        this.reservationDate = reservationDate;
    }

    public Integer getReservingCustomerId() {
        return reservingCustomerId;
    }

    public void setReservingCustomerId(Integer reservingCustomerId) {
        this.reservingCustomerId = reservingCustomerId;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public Boolean getPaid() {
        return paid;
    }

    public void setPaid(Boolean paid) {
        this.paid = paid;
    }

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
