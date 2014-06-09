package com.courtpicker.model;

public class Subscription {
    private Integer id;
    private Integer courtCategoryId;
    private String name;
    // date format: DD.MM.YYYY
    private String periodStart;
    private String periodEnd;
    // date format: DD.MM.YYYY
    private String bookableFrom;
    private String bookableTo;
    private Integer orderNr;
    
    public Subscription() {
        this.id = null;
        this.courtCategoryId = null;
        this.name = "";
        this.periodStart = "";
        this.periodEnd = "";
        this.bookableFrom = "";
        this.bookableTo = "";
        this.orderNr = 1;
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

    public String getBookableFrom() {
        return bookableFrom;
    }

    public void setBookableFrom(String bookableFrom) {
        this.bookableFrom = bookableFrom;
    }

    public String getBookableTo() {
        return bookableTo;
    }

    public void setBookableTo(String bookableTo) {
        this.bookableTo = bookableTo;
    }

    public Integer getOrderNr() {
        return orderNr;
    }

    public void setOrderNr(Integer orderNr) {
        this.orderNr = orderNr;
    }
}
