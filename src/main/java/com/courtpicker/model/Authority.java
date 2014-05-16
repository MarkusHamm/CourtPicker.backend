package com.courtpicker.model;

public class Authority {
    private Integer id;
    private Integer userId;
    private Integer cpInstanceId;
    private String authority;

    public Authority() {
        this.id = null;
        this.userId = null;
        this.cpInstanceId = null;
        this.authority = "";
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getCpInstanceId() {
        return cpInstanceId;
    }

    public void setCpInstanceId(Integer cpInstanceId) {
        this.cpInstanceId = cpInstanceId;
    }

    public String getAuthority() {
        return authority;
    }

    public void setAuthority(String authority) {
        this.authority = authority;
    }
}
