package com.courtpicker.model;

import java.math.BigDecimal;
import java.util.Date;

public class SingleReservation {
    private Integer id;
    private Integer customerId;
    private String customerName;
    private Integer courtId;
    private Date fromDate;
    private Date toDate;
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

    public SingleReservation() {
        this.id = null;
        this.customerId = null;
        this.customerName = null;
        this.courtId = null;
        this.fromDate = null;
        this.toDate = null;
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

    public Date getFromDate() {
        return fromDate;
    }

    public void setFromDate(Date fromDate) {
        this.fromDate = fromDate;
    }

    public Date getToDate() {
        return toDate;
    }

    public void setToDate(Date toDate) {
        this.toDate = toDate;
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

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public BigDecimal getCalculatedPrice() {
        return calculatedPrice;
    }

    public void setCalculatedPrice(BigDecimal calculatedPrice) {
        this.calculatedPrice = calculatedPrice;
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
}
