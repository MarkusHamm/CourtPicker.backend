package com.courtpicker.model;

public class CustomerUserGroupDetail extends CustomerUserGroup {
    private Integer cpInstanceId;

    public CustomerUserGroupDetail() {
        super();
        this.cpInstanceId = null;
    }

    public Integer getCpInstanceId() {
        return cpInstanceId;
    }

    public void setCpInstanceId(Integer cpInstanceId) {
        this.cpInstanceId = cpInstanceId;
    }
}
