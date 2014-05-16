package com.courtpicker.model;

public class CustomerUserGroup {
    private Integer id;
    private Integer customerId;
    private Integer userGroupId;
    
    public CustomerUserGroup() {
        this.id = null;
        this.customerId = null;
        this.userGroupId = null;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public Integer getUserGroupId() {
        return userGroupId;
    }

    public void setUserGroupId(Integer userGroupId) {
        this.userGroupId = userGroupId;
    }
}
