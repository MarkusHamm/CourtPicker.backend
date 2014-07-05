package com.courtpicker.model;

import java.math.BigDecimal;
import java.sql.Time;
import java.util.Date;

public class SubscriptionReservation {
    private Integer id;
    private Integer subscriptionId;
    private Integer customerId;
    private String customerName;
    private Integer courtId;
    // date format: DD.MM.YYYY
    private String periodStart;
    private String periodEnd;
    // time format: HH:MM
    private String fromTime;
    private String toTime;
    private Date reservationDate;
    private Integer reservingCustomerId;
    private String displayName;
    private Boolean paid;
    private Boolean deleted;
    private BigDecimal calculatedPrice;
    private BigDecimal price;
    private Date paymentDate;
    private Integer paymentOptionId;
    private String comment;    

    public SubscriptionReservation() {
        this.id = null;
        this.subscriptionId = null;
        this.customerId = null;
        this.customerName = null;
        this.courtId = null;
        this.periodStart = null;
        this.periodEnd = null;
        this.fromTime = null;
        this.toTime = null;
        this.reservationDate = null;
        this.reservingCustomerId = null;
        this.displayName = "";
        this.paid = false;
        this.deleted = false;
        this.calculatedPrice = new BigDecimal(0);
        this.price = new BigDecimal(0);
        this.paymentDate = null;
        this.paymentOptionId = null;
        this.comment = "";
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

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Integer getCourtId() {
        return courtId;
    }

    public void setCourtId(Integer courtId) {
        this.courtId = courtId;
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

    public BigDecimal getCalculatedPrice() {
        return calculatedPrice;
    }

    public void setCalculatedPrice(BigDecimal calculatedPrice) {
        this.calculatedPrice = calculatedPrice;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public Integer getPaymentOptionId() {
        return paymentOptionId;
    }

    public void setPaymentOptionId(Integer paymentOptionId) {
        this.paymentOptionId = paymentOptionId;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
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
}
