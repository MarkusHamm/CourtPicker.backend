package com.courtpicker.model;

public class Court {
    private Integer id;
    private Integer courtCategoryId;
    private String name;
    private Integer orderNr;

    public Court() {
        this.id = null;
        this.courtCategoryId = null;
        this.name = "";
        this.orderNr = null;
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

    public Integer getOrderNr() {
        return orderNr;
    }

    public void setOrderNr(Integer orderNr) {
        this.orderNr = orderNr;
    }
}
