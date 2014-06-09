package com.courtpicker.model;

import java.math.BigDecimal;

public class SingleRate extends Rate {
    // properties
    private Integer id;
    private Integer courtCategoryId;
    private String name;
    private Boolean active;
    private Integer orderNr;

    public SingleRate() {
        super();
        this.id = null;
        this.courtCategoryId = null;
        this.name = "";
        this.active = true;
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
}
