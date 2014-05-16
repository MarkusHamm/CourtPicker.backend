package com.courtpicker.model;

public class PaymentOption {
    private Integer id;
    private Integer cpInstanceId;
    private String name;
    private Boolean active;
    private Boolean deleted;
    
    public PaymentOption() {
        this.id = null;
        this.cpInstanceId = null;
        this.name = "";
        this.active = true;
        this.deleted = false;
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

    public Boolean getDeleted() {
        return deleted;
    }

    public void setDeleted(Boolean deleted) {
        this.deleted = deleted;
    }
}
