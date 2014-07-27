package com.courtpicker.uimodel;

import java.math.BigDecimal;
import java.util.Date;

public class SingleReservationInfo {
	private Integer id;
	private Integer instanceId;
	private String instanceName;
	private Integer courtCategoryId;
	private String courtCategoryName;
	private Integer courtId;
	private String courtName;
	private Date fromDate;
	private Date toDate;
	private Date reservationDate;
	private Integer customerId;
	private String customerUserName;
	private String customerFirstName;
	private String customerLastName;
	private BigDecimal price;
	private Boolean paid;
	private Date paymentDate;
	private Integer paymentOptionId;
	private String paymentOptionName;
	private String comment;
	
	public SingleReservationInfo() {
		id = null;
		instanceId = null;
		instanceName = "";
		courtCategoryId = null;
		courtCategoryName = "";
		courtId = null;
		courtName = "";
		fromDate = null;
		toDate = null;
		reservationDate = null;
		customerId = null;
		customerUserName = "";
		customerFirstName = "";
		customerLastName = "";
		price = null;
		paid = false;
		paymentDate = null;
		paymentOptionId = null;
		paymentOptionName = "";
		comment = "";
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getInstanceId() {
		return instanceId;
	}

	public void setInstanceId(Integer instanceId) {
		this.instanceId = instanceId;
	}

	public String getInstanceName() {
		return instanceName;
	}

	public void setInstanceName(String instanceName) {
		this.instanceName = instanceName;
	}

	public Integer getCourtCategoryId() {
		return courtCategoryId;
	}

	public void setCourtCategoryId(Integer courtCategoryId) {
		this.courtCategoryId = courtCategoryId;
	}

	public String getCourtCategoryName() {
		return courtCategoryName;
	}

	public void setCourtCategoryName(String courtCategoryName) {
		this.courtCategoryName = courtCategoryName;
	}

	public Integer getCourtId() {
		return courtId;
	}

	public void setCourtId(Integer courtId) {
		this.courtId = courtId;
	}

	public String getCourtName() {
		return courtName;
	}

	public void setCourtName(String courtName) {
		this.courtName = courtName;
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

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public String getCustomerUserName() {
		return customerUserName;
	}

	public void setCustomerUserName(String customerUserName) {
		this.customerUserName = customerUserName;
	}

	public String getCustomerFirstName() {
		return customerFirstName;
	}

	public void setCustomerFirstName(String customerFirstName) {
		this.customerFirstName = customerFirstName;
	}

	public String getCustomerLastName() {
		return customerLastName;
	}

	public void setCustomerLastName(String customerLastName) {
		this.customerLastName = customerLastName;
	}

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Boolean getPaid() {
		return paid;
	}

	public void setPaid(Boolean paid) {
		this.paid = paid;
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

	public String getPaymentOptionName() {
		return paymentOptionName;
	}

	public void setPaymentOptionName(String paymentOptionName) {
		this.paymentOptionName = paymentOptionName;
	}

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
