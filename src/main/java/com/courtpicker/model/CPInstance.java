package com.courtpicker.model;

import java.util.Date;

public class CPInstance {
    private Integer id;
    private String name;
    private String shortName;
    private String licence;
    private Date licenceStartDate;
    private Date createDate;
    private Boolean mailAtRegistration;
    private Integer reservationLimit;
    private String reservationLabelVisibility;

    public CPInstance() {
        id = null;
        name = "";
        shortName = "";
        licence = "";
        licenceStartDate = null;
        createDate = null;
        mailAtRegistration = false;
        reservationLimit = -1;
        reservationLabelVisibility = "ADMIN";
    }
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLicence() {
        return licence;
    }

    public void setLicence(String licence) {
        this.licence = licence;
    }

    public String getShortName() {
        return shortName;
    }

    public void setShortName(String shortName) {
        this.shortName = shortName;
    }

    public Date getLicenceStartDate() {
        return licenceStartDate;
    }

    public void setLicenceStartDate(Date licenceStartDate) {
        this.licenceStartDate = licenceStartDate;
    }

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

    public Boolean getMailAtRegistration() {
        return mailAtRegistration;
    }

    public void setMailAtRegistration(Boolean mailAtRegistration) {
        this.mailAtRegistration = mailAtRegistration;
    }

    public Integer getReservationLimit() {
        return reservationLimit;
    }

    public void setReservationLimit(Integer reservationLimit) {
        this.reservationLimit = reservationLimit;
    }

    public String getReservationLabelVisibility() {
        return reservationLabelVisibility;
    }

    public void setReservationLabelVisibility(String reservationLabelVisibility) {
        this.reservationLabelVisibility = reservationLabelVisibility;
    }
}
