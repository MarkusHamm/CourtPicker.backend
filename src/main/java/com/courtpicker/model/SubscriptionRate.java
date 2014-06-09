package com.courtpicker.model;

import java.math.BigDecimal;

public class SubscriptionRate extends Rate {
    private Integer id;
    private Integer subscriptionId;
    private String name;
    
    public SubscriptionRate() {
        super();
        this.id = null;
        this.subscriptionId = null;
        this.name = "";
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
