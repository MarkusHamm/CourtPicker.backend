package com.courtpicker.model;

import java.io.Serializable;

public class CourtCategory implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private Integer cpInstanceId;
    private Integer orderNr;
    private String name;
    private String bookableFromTime;
    private String bookableToTime;
    private Integer bookingUnit;

    public CourtCategory() {
        id = null;
        cpInstanceId = null;
        orderNr = null;
        name = "";
        bookableFromTime = "";
        bookableToTime = "";
        bookingUnit = null;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCpInstanceId() {
        return cpInstanceId;
    }

    public void setCpInstanceId(Integer cpInstanceId) {
        this.cpInstanceId = cpInstanceId;
    }

    public Integer getOrderNr() {
        return orderNr;
    }

    public void setOrderNr(Integer orderNr) {
        this.orderNr = orderNr;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBookableFromTime() {
        return bookableFromTime;
    }

    public void setBookableFromTime(String bookableFromTime) {
        this.bookableFromTime = bookableFromTime;
    }

    public String getBookableToTime() {
        return bookableToTime;
    }

    public void setBookableToTime(String bookableToTime) {
        this.bookableToTime = bookableToTime;
    }

    public Integer getBookingUnit() {
        return bookingUnit;
    }

    public void setBookingUnit(Integer bookingUnit) {
        this.bookingUnit = bookingUnit;
    }
}
