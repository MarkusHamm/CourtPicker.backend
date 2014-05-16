package com.courtpicker.model;

public class UserGroup {
    private Integer id;
    private Integer cpInstanceId;
    private String name;
    
    public UserGroup() {
        this.id = null;
        this.cpInstanceId = null;
        this.name = "";
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
}
